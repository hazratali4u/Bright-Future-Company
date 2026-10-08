using System;
using System.Data;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// From To Add, Edit, Delete SKU
/// </summary>
public partial class Forms_frmSKUData : System.Web.UI.Page
{
    readonly SkuController mController = new SkuController();
    readonly DataControl dc = new DataControl();
    readonly SkuHierarchyController mHer_Controller = new SkuHierarchyController();
    private  DataTable m_dt,m_SKUDt;
    private static int m_sku_id;
    private static string OldCode = string.Empty;

    /// <summary>
    /// Page_Load Function Populates All Combos And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Populate_drpSKUCompany();
            Populate_drpSKUDivisions();
            Populate_drpSKUCategory();
            Populate_drpSKUBrand();
            LoadData();
            LoadGrid();
        }
    }

    /// <summary>
    /// Loads Principal To Principal Combo
    /// </summary>
    private void Populate_drpSKUCompany()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();

      //  m_dt = mHer_Controller.SelectSkuHierarchy(Constants.SKUPrincipal, Constants.IntNullValue, Constants.IntNullValue, null, null, true, int.Parse(Session["CompanyId"].ToString()));
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(ddskuPrincipal, m_dt, 0, 1, true);
   //    clsWebFormUtil.FillDropDownList(ddskuPrincipal, m_dt, 0, 3, true);
    }

    /// <summary>
    /// Loads Divisions To Division Combo, Categories To Category Combo, Brands To Brand Combo And SKUS To SKU Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void ddskuPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        Populate_drpSKUDivisions();
        Populate_drpSKUCategory();
        Populate_drpSKUBrand();
        LoadData();
        LoadGrid();
    }

    /// <summary>
    /// Loads Divisions To Division Combo
    /// </summary>
    private void Populate_drpSKUDivisions()
    {
        if (ddskuPrincipal.Items.Count > 0)
        {
            if (ddskuPrincipal.Items.Count > 0)
            {
                m_dt = mHer_Controller.SelectSkuHierarchy(Constants.SKUDivision, Constants.IntNullValue, int.Parse(ddskuPrincipal.SelectedValue.ToString()), null, null, true, int.Parse(Session["CompanyId"].ToString()));
                clsWebFormUtil.FillDropDownList(ddskudivision, m_dt, 0, 3, true);
            }
        }
        else
        {
            ddskudivision.Items.Clear();   
        }
    }

    /// <summary>
    /// Loads Categories To Category Combo, Brands To Brand Combo And SKUS To SKU Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void ddskudivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Populate_drpSKUCategory();
        Populate_drpSKUBrand();
        LoadData();
        LoadGrid();
    }

    /// <summary>
    /// Loads Categories To Category Combo
    /// </summary>
    private void Populate_drpSKUCategory()
    {
        if (ddskudivision.Items.Count > 0)
        {
            if (ddskudivision.Items.Count   > 0)
            {
                m_dt = mHer_Controller.SelectSkuHierarchy(Constants.SKUCategory, Constants.IntNullValue, int.Parse(ddskudivision.SelectedValue.ToString()), null, null, true, int.Parse(Session["CompanyId"].ToString()));
                clsWebFormUtil.FillDropDownList(ddskucategory, m_dt, 0, 3, true);
            }
        }
        else
        {
            ddskucategory.Items.Clear();   
        }
    }

    /// <summary>
    /// Loads Brands To Brand Combo And SKUS To SKU Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void ddskucategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        Populate_drpSKUBrand();
        LoadData();
        LoadGrid();
    }

    /// <summary>
    /// Loads Brands To Brand Combo
    /// </summary>
    private void Populate_drpSKUBrand()
    {
        if (ddskucategory.Items.Count > 0)
        {
            string strSKUCategoryID = ddskucategory.SelectedItem.Value;

            if (ddskucategory.Items.Count   > 0)
            {
                m_dt = mHer_Controller.SelectSkuHierarchy(Constants.SKUBrand, Constants.IntNullValue, int.Parse(ddskucategory.SelectedValue.ToString()), null, null, true, int.Parse(Session["CompanyId"].ToString()));
                clsWebFormUtil.FillDropDownList(ddskuBrand, m_dt, 0, 3, true);
            }
        }
        else
        {
            ddskuBrand.Items.Clear();   
        }
    }
 
    private void Populate_drpSKUBrand2()
    {

        if (ddskucategory.Items.Count > 0)
        {
            m_dt = mHer_Controller.SelectSkuHierarchy(Constants.SKUBrand, Constants.IntNullValue, Constants.IntNullValue, null, null, true, int.Parse(Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(ddskuBrand, m_dt, 0, 3, true);
        }

        else
        {
            ddskuBrand.Items.Clear();
        }
    }

    /// <summary>
    /// Loads SKU Data To Session
    /// </summary>
    private void LoadData()
    {
        SkuController mSKUController = new SkuController();
        m_SKUDt = mSKUController.SelectSkuInfo(int.Parse(ddskuPrincipal.SelectedValue.ToString()), int.Parse(ddskudivision.SelectedValue.ToString()), int.Parse(ddskucategory.SelectedValue.ToString()), Convert.ToInt32(ddskuBrand.SelectedValue), int.Parse(Session["CompanyId"].ToString()));
        Session.Add("m_SKUDt", m_SKUDt);
    }

    /// <summary>
    /// Loads Data From Session To Grid
    /// </summary>
    private void LoadGrid()
    {
        m_SKUDt = (DataTable)Session["m_SKUDt"];

        switch (ddSearchType.SelectedIndex)
        {
            
            case 1:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 2:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 3:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 4:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 5:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 6:
                m_SKUDt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            default:
                m_SKUDt.DefaultView.RowFilter = "SKU_CODE" + " like '%" + "" + "%'";
                break; 
        }
        grdSKUData.DataSource = m_SKUDt.DefaultView;   
        grdSKUData.DataBind();
       }

   /// <summary>
   /// Sets SKU Data For Edit. This Function Runs When An Existing SKU Needs To Be Edited
   /// </summary>
   /// <param name="sender">object</param>
   /// <param name="e">GridViewEditEventArgs</param>
    protected void grdSKUData_RowEditing(object sender, GridViewEditEventArgs e)
   {
       ddskuPrincipal.SelectedValue = grdSKUData.Rows[e.NewEditIndex].Cells[0].Text;
       Populate_drpSKUDivisions();
       ddskudivision.SelectedValue = grdSKUData.Rows[e.NewEditIndex].Cells[1].Text;
       Populate_drpSKUCategory();
       ddskucategory.SelectedValue = grdSKUData.Rows[e.NewEditIndex].Cells[2].Text;
       Populate_drpSKUBrand2();
       ddskuBrand.SelectedValue = grdSKUData.Rows[e.NewEditIndex].Cells[3].Text;
       m_sku_id = int.Parse(grdSKUData.Rows[e.NewEditIndex].Cells[4].Text);
       txtskucode.Text = grdSKUData.Rows[e.NewEditIndex].Cells[9].Text;
       OldCode = txtskucode.Text;
       txtskuname.Text = grdSKUData.Rows[e.NewEditIndex].Cells[10].Text;
       txtpacksize.Text = grdSKUData.Rows[e.NewEditIndex].Cells[11].Text;
       txtunitincase.Text = grdSKUData.Rows[e.NewEditIndex].Cells[12].Text;       
       btnSave.Text = "Update";
   }

   /// <summary>
   /// Deletes A SKU
   /// </summary>
   /// <param name="sender">object</param>
   /// <param name="e">GridViewEditEventArgs</param>
    protected void grdSKUData_RowDeleting(object sender, GridViewDeleteEventArgs e)
   {

       bool IsExemted = bool.Parse(grdSKUData.Rows[e.RowIndex].Cells[14].Text);
       string result = mController.UpdateSKUS(IsExemted, false, Constants.CharNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue,
       Constants.DecimalNullValue, Constants.DecimalNullValue, Constants.ShortNullValue, int.Parse(grdSKUData.Rows[e.RowIndex].Cells[4].Text), null, null, null, null, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
       LoadData();
       LoadGrid();
   }

   /// <summary>
   /// Sets PageIndex Of SKU Grid
   /// </summary>
   /// <param name="sender">object</param>
   /// <param name="e">GridViewPageEventArgs</param>
    protected void grdSKUData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdSKUData.PageIndex = e.NewPageIndex;
        LoadGrid();

    }

   /// <summary>
   /// Save Or Updates an SKU
   /// </summary>
   /// <param name="sender">object</param>
   /// <param name="e">EventArgs</param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        bool IsExemted = true;
        char Gst_On = 'E';
        lblErrorMsg.Text = string.Empty;
        if (txtpacksize.Text.Length <= 0)
        {
            lblErrorMsg.Text = "Must Enter SKU Packsize";
            return;
        }
        if (txtskucode.Text.Length <= 0)
        {
            lblErrorMsg.Text = "Must Enter SKU Code";
            return;
        }
        if (txtskuname.Text.Length <= 0)
        {
            lblErrorMsg.Text = "Must Enter SKU Name";
            return;
        }

        if (txtunitincase.Text.Length <= 0)
        {
            lblErrorMsg.Text = "Must Enter Units in Case";
            return;
        }

        if (short.Parse(dc.chkNull_0(txtunitincase.Text)) < 1)
        {
            lblErrorMsg.Text = "Units in Case Must be Greater than Zero";
            return;
        }
        DataTable dtSKUS = mController.GetSKUByCode(txtskucode.Text.Trim().ToLower());

        if (btnSave.Text == "Save")
        {
            if (dtSKUS.Rows.Count > 0)
            {
                lblErrorMsg.Text = "SKU Code " + txtskucode.Text.Trim() + " already exists.";
                return;
            }
            mController.InsertSKUS(IsExemted, true, char.Parse(DrpSKUTaxType.SelectedValue.ToString()), int.Parse(ddskuPrincipal.SelectedValue.ToString()), int.Parse(ddskudivision.SelectedValue.ToString()), int.Parse(ddskucategory.SelectedValue.ToString()),
            int.Parse(ddskuBrand.SelectedValue.ToString()), Constants.IntNullValue, 0, 0, short.Parse(dc.chkNull_0(txtunitincase.Text)),
            txtskucode.Text.ToUpper(), txtskuname.Text, null, txtpacksize.Text, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
            CLearAll();
        }
        else if (btnSave.Text == "Update")
        {
            if (txtskucode.Text != OldCode)
            {
                if (dtSKUS.Rows.Count > 0)
                {
                    lblErrorMsg.Text = "SKU Code " + txtskucode.Text.Trim() + " already exists.";
                    return;
                }
            }
            mController.UpdateSKUS(IsExemted, true, char.Parse(DrpSKUTaxType.SelectedValue.ToString()), int.Parse(ddskuPrincipal.SelectedValue.ToString()), int.Parse(ddskudivision.SelectedValue.ToString()),
            int.Parse(ddskucategory.SelectedValue.ToString()), int.Parse(ddskuBrand.SelectedValue.ToString()), Constants.IntNullValue, 0
            , 0, short.Parse(dc.chkNull_0(txtunitincase.Text)), m_sku_id, txtskucode.Text.ToUpper(), txtskuname.Text, null, txtpacksize.Text, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
            CLearAll();
        }
        LoadData();        
    }
  
    /// <summary>
    /// Filters SKU From SKU Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }

    /// <summary>
    /// Clears Form Controls
    /// </summary>
    private void CLearAll()
    {
        txtpacksize.Text = "";
        txtskucode.Text = "";
        txtunitincase.Text = "";
        txtskuname.Text = "";
        btnSave.Text = "Save";
        LoadData();
        LoadGrid();
    }
    
    protected void ddskuBrand_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData();
        LoadGrid();
    }
}