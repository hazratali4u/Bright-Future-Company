using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form To Add Targets
/// </summary>
public partial class Forms_frmTargetEntry : System.Web.UI.Page
{
    private static long TargetId;

    /// <summary>
    /// Page_Load Function Populates All Combos And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadDistributor();
            this.LoadTargetForId();
            this.LoadPrincipal();
            this.Populate_drpSKUCategory();
            btnTarget.Attributes.Add("onclick", "return ValidateForm();");
            SAMSCommon.Classes.Configuration.SystemCurrentDateTime = (DateTime)this.Session["CurrentWorkDate"];
            txtFromdate.Text = SAMSCommon.Classes.Configuration.SystemCurrentDateTime.ToString("MMM-yyyy");
            txtTodate.Text = SAMSCommon.Classes.Configuration.SystemCurrentDateTime.AddMonths(2).ToString("MMM-yyyy");
            this.LoadGird();
        }
    }

    /// <summary>
    /// Loads Sale Forces To TargetFor Combo
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpTargetType_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadTargetForId();
        this.LoadGird();
    }

    /// <summary>
    /// Loads Locations To Location Combo
    /// </summary>
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(this.drpDistributor, dt, 0, 2, true);
    }

    /// <summary>
    /// Loads Sale Forces To TargetFor Combo And Targets To Target Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadTargetForId();
        this.LoadGird();
    }

    /// <summary>
    /// Loads Principals To Prinicpal Combo
    /// </summary>
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(this.drpPrincipal, m_dt, 0, 1, true);
    }

    /// <summary>
    /// Loads Targets To Target Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadGird();
    }

    /// <summary>
    /// Loads Sale Forces To TargetFor 
    /// </summary>
    private void LoadTargetForId()
    {              
        if (DrpTargetType.SelectedIndex == 0)
        {
            if (drpDistributor.Items.Count > 0)
            {
                Distributor_UserController Du = new Distributor_UserController();
                DataTable dt = Du.SelectDistributorUser(Constants.SALES_FORCE_ORDERBOOKER, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(this.Session["CompanyId"].ToString()));
                clsWebFormUtil.FillDropDownList(DrpTargetFor, dt, 0, 6, true);
            }
        }
        else if (DrpTargetType.SelectedIndex == 1)
        {
            if (drpDistributor.Items.Count > 0)
            {

                Distributor_UserController Du = new Distributor_UserController();
                DataTable dt = Du.SelectDistributorUser(Constants.SALES_FORCE_SALESPERSON, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(this.Session["CompanyId"].ToString()));
                clsWebFormUtil.FillDropDownList(DrpTargetFor, dt, 0, 6, true);
            }
        }
        else
        {
            if (drpDistributor.Items.Count > 0)
            {

                DistributorTownController gController = new DistributorTownController();
                DataTable dt = gController.SelectAssignTown(Constants.IntNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), 1);
                clsWebFormUtil.FillDropDownList(DrpTargetFor, dt, 0, 1, true);
            }
        }
    }

    /// <summary>
    /// Loads Targets To Target Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpTargetFor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadGird();
    }
    
    /// <summary>
    /// Loads Targets To Target Grid
    /// </summary>
    private void LoadGird()
    {
        if (txtFromdate.Text.Length > 1 && drpDistributor.Items.Count > 0 && DrpTargetFor.Items.Count > 0 && drpPrincipal.Items.Count > 0)
        {
            TargetController TG = new TargetController();
            DataTable dt = TG.SelectTarget(DateTime.Parse(txtFromdate.Text), int.Parse(DrpTargetType.SelectedValue.ToString()), int.Parse(DrpTargetFor.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(drpPrincipal.SelectedValue.ToString()));
            GrdPurchase.DataSource = dt;
            GrdPurchase.DataBind();           
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Some Selection is Wrong');", true); 
        }
    }

    /// <summary>
    /// Deletes Target For Sale Froce
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        TargetController TG = new TargetController();
        TG.UpdateTarget(long.Parse(GrdPurchase.Rows[e.RowIndex].Cells[0].Text), int.Parse(drpDistributor.SelectedValue.ToString()), Constants.DecimalNullValue, Constants.IntNullValue, false);
        this.LoadGird();         
    }

    /// <summary>
    /// Sets Target For Edit. This Function Runs When An Existing Target Needs To Be Edited
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowEditing(object sender, GridViewEditEventArgs e)
    {
        TargetId = long.Parse(GrdPurchase.Rows[e.NewEditIndex].Cells[0].Text);
        DrpTargetFor.SelectedValue = GrdPurchase.Rows[e.NewEditIndex].Cells[1].Text;
        txtAmount.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[6].Text;
        btnTarget.Text = "Update";
     }
       
    /// <summary>
    /// Saves/Update Target
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnTarget_Click(object sender, EventArgs e)
    {
        TargetController TG = new TargetController();
        
        if (btnTarget.Text == "Save")
        {
            TG.InsertTarget(int.Parse(drpDistributor.SelectedValue.ToString()), DateTime.Parse(txtFromdate.Text), DateTime.Parse(txtTodate.Text), int.Parse(DrpTargetType.SelectedValue.ToString()), int.Parse(DrpTargetFor.SelectedValue.ToString()),
                Convert.ToInt32(ddlCategory.SelectedValue), decimal.Parse(txtAmount.Text),0, int.Parse(drpPrincipal.SelectedValue.ToString()), int.Parse(this.Session["UserId"].ToString()));
        }
        else
        {
            TG.UpdateTarget(TargetId, int.Parse(drpDistributor.SelectedValue.ToString()),decimal.Parse(txtAmount.Text),0, true);
        }        
        this.LoadGird();
        txtAmount.Text = "0";
        btnTarget.Text = "Save"; 
    }

    /// <summary>
    /// Loads Categories To Category Combo
    /// </summary>
    private void Populate_drpSKUCategory()
    {
        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable m_dt = mHer_Controller.GetAssignedSKUHierarchy(Constants.SKUCategory, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserID"].ToString()));
        clsWebFormUtil.FillDropDownList(this.ddlCategory, m_dt, 0, 3);
    }
}