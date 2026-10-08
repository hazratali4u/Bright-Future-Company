using System;
using System.Data;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

using System.Collections.Generic;

/// <summary>
/// Form To Take Order, Invoice And Sale Return(Step2)
/// </summary>
public partial class Forms_frmCustomerWisePrice : System.Web.UI.Page
{
    #region Variables

    DataTable PurchaseSKU;
    DataTable dtFreeSKU;
    private static int mCustomerTypeId;
    private static int mCustomerVolClassId;
    private int mTownId;
    private static int RowId;
    private static int UnitType;
    private static int OrderNo;

    #endregion

    /// <summary>
    /// Page_Load Function Populates All Combos, Grids And ListBox On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            this.LoadGroup();
            this.LoadSKUDetail();
            this.CreatTable();
            // this.LoadDistributor();
            this.txtDateEfected.Text = System.DateTime.Now.ToString("dd-MMM-yyyy");
            btnSave.Attributes.Add("onclick", "return ValidateForm();");
        }
    }

    /// <summary>
    /// Creates Datatable For Order, Invoice And Sale Return
    /// </summary>
    private void CreatTable()
    {
        PurchaseSKU = new DataTable();
        PurchaseSKU.Columns.Add("SKU_ID", typeof(int));
        PurchaseSKU.Columns.Add("SKU_Code", typeof(string));
        PurchaseSKU.Columns.Add("SKU_Name", typeof(string));
        PurchaseSKU.Columns.Add("UNIT_PRICE", typeof(decimal));
        PurchaseSKU.Columns.Add("SKU_ARTICAL_NO", typeof(string));
        PurchaseSKU.Columns.Add("GST_RATE", typeof(decimal));
        PurchaseSKU.Columns.Add("DATE_EFFECTED", typeof(string));

        this.Session.Add("PurchaseSKU", PurchaseSKU);
    }

    /// <summary>
    /// Loads SKU Data To SKU ListBox
    /// </summary>
    private void LoadSKUDetail()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable Dtsku_Price = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["DISTRIBUTOR_ID"].ToString()), Constants.IntNullValue, Constants.IntNullValue, 5, Constants.DateNullValue);
        clsWebFormUtil.FillDropDownList(this.ddlSKuCde, Dtsku_Price, "SKU_ID", "SkuDetail", true);
        this.Session.Add("Dtsku_Price", Dtsku_Price);
    }

    /// <summary>
    /// Loads Order To Order Grid
    /// </summary>
    private void LoadGird()
    {
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        GrdPurchase.DataSource = PurchaseSKU;
        GrdPurchase.DataBind();
    }

    /// <summary>
    /// Sets Order SKU For Edit. This Function Runs When An Existing Order SKU Needs To Be Edited
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowEditing(object sender, GridViewEditEventArgs e)
    {
        RowId = e.NewEditIndex;
        // txtskuCode.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[1].Text;
        ddlSKuCde.SelectedValue = GrdPurchase.Rows[e.NewEditIndex].Cells[0].Text;
        txtUnitPrice.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[4].Text;
        hfBatchValue.Value = GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text;
        txtArticalNO.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[3].Text;
        txtGst.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[5].Text;
    
        txtDateEfected.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[6].Text;
        //txtskuCode.Enabled = false;
        hfSKUID.Value = GrdPurchase.Rows[e.NewEditIndex].Cells[0].Text;
        btnSave.Text = "Update SKU";
    }

    /// <summary>
    /// Deletes An SKU From Order Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        PurchaseSKU.Rows.RemoveAt(e.RowIndex);
        this.Session.Add("PurchaseSKU", PurchaseSKU);
        this.LoadGird();
    }

    /// <summary>
    /// Checks SKU in Order Grid
    /// </summary>
    /// <returns>True On Success And False On Failure</returns>
    private bool CheckDublicateSKU()
    {
        DataTable Dtsku_Price = (DataTable)this.Session["Dtsku_Price"];
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        DataRow[] foundRows = PurchaseSKU.Select("SKU_ID  = '" + ddlSKuCde.SelectedValue + "'");
        if (foundRows.Length == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    /// <summary>
    /// Enables/Disables Controls
    /// </summary>
    /// <param name="CValue">Value</param>
    private void EnableDisableController(bool CValue)
    {


    }

    /// <summary>
    /// Clears Session Variables And Redircts To Step1
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        this.CreatTable();
        this.LoadGird();
        this.ClearAll();
        this.Session.Remove("PurchaseSKU");
        txtGroupPrice.Text = "";
        txtDateEfected.Text = "";

    }

    /// <summary>
    /// Adds/Updates Row To Order Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnSave_Click(object sender, EventArgs e)
    {

        DataControl dc = new DataControl();
        DataTable Dtsku_Price = (DataTable)this.Session["Dtsku_Price"];
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        DataRow[] foundRows = Dtsku_Price.Select("SKU_ID  = '" + ddlSKuCde.SelectedValue + "'");

        if (btnSave.Text == "Add Sku")
        {
            if (CheckDublicateSKU())
            {
                DataRow dr = PurchaseSKU.NewRow();
                dr["SKU_ID"] = foundRows[0]["SKU_ID"];
                dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
                dr["SKU_Name"] = foundRows[0]["SKU_NAME"];
                dr["UNIT_PRICE"] = decimal.Parse(dc.chkNull_0(txtUnitPrice.Text));
                dr["SKU_ARTICAL_NO"] = int.Parse(dc.chkNull_0(txtArticalNO.Text));
                dr["GST_RATE"] =decimal.Parse(dc.chkNull_0( txtGst.Text));
                dr["DATE_EFFECTED"] = txtDateEfected.Text;
                PurchaseSKU.Rows.Add(dr);

                this.Session.Add("PurchaseSKU", PurchaseSKU);
                this.EnableDisableController(false);
                this.LoadGird();
                this.ClearAll();                

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('SKU Already Exists')", true);
            }
        }
        else
        {
            DataRow dr = PurchaseSKU.Rows[RowId];
            dr["SKU_ID"] = foundRows[0]["SKU_ID"];
            dr["SKU_Code"] = foundRows[0]["SKU_CODE"];
            dr["SKU_Name"] = foundRows[0]["SKU_NAME"];
            dr["UNIT_PRICE"] = decimal.Parse(dc.chkNull_0(txtUnitPrice.Text));
            dr["SKU_ARTICAL_NO"] =int.Parse(dc.chkNull_0 (txtArticalNO.Text));
            dr["GST_RATE"] = decimal.Parse(dc.chkNull_0(txtGst.Text));
            dr["DATE_EFFECTED"] = txtDateEfected.Text;
            this.Session.Add("PurchaseSKU", PurchaseSKU);
            this.EnableDisableController(false);
            this.LoadGird();
            this.ClearAll();            
        }

        ScriptManager.GetCurrent(Page).SetFocus(ddlSKuCde);
        

    }

    /// <summary>
    /// Saves/Updates Order, Invoice And Sale Return
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnSaveOrder_Click(object sender, EventArgs e)
    {

        DataControl DC = new DataControl();
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        OrderEntryController mOrderController = new OrderEntryController();
        bool IsValidInsert = true;

        if (btnSaveOrder.ToolTip.Equals("Save Group"))
        {
            IsValidInsert = mOrderController.Add_CustomerWisePrice(PurchaseSKU, int.Parse(this.Session["UserId"].ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtGroupPrice.Text, Constants.DateNullValue,ChbIsActive.Checked);
        }
        else if (btnSaveOrder.ToolTip.Equals("Update Group"))
        {            
            IsValidInsert = mOrderController.Update_CustomerWisePrice(PurchaseSKU, int.Parse(this.Session["UserId"].ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtGroupPrice.Text, Convert.ToInt32(drpAddEditGroup.SelectedValue), Constants.DateNullValue,ChbIsActive .Checked );           
        }
        if (IsValidInsert)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Record Updated !')", true);
            ClearMasterALL();
            this.LoadGroup();
            txtGroupPrice.Text = "";
            txtDateEfected.Text = "";
            txtGst.Text = "";
            btnSaveOrder.ToolTip = "Save Group";
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Please Try Again !')", true);
        }
    }

    /// <summary>
    /// Clears Some Of Controls
    /// </summary>
    private void ClearAll()
    {
        //txtskuCode.Text = "";
        //txtskuName.Text = "";
        txtUnitPrice.Text = "";
        btnSave.Text = "Add Sku";
        txtArticalNO.Text = "";
    //    txtGst.Text = "";
     //   txtDateEfected.Text = "";
      //  txtGroupPrice.Text = "";

        //txtskuCode.Enabled = true;

    }

    /// <summary>
    /// Clears All Controls
    /// </summary>
    private void ClearMasterALL()
    {
        this.EnableDisableController(true);
        this.Session.Remove("PurchaseSKU");
        this.Session.Remove("dtFreeSKU");
        ChbIsActive.Checked = false;
        this.CreatTable();
        this.LoadGird();
    }

    protected void drpAddEditGroup_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (long.Parse(drpAddEditGroup.SelectedValue.ToString()) != Constants.LongNullValue)
        {
            DataTable dtGroup = (DataTable)this.Session["dtGroup"];
            DataRow[] foundRows = dtGroup.Select("CUST_WISE_PRISE_MASTER_ID   = '" + drpAddEditGroup.SelectedValue + "'");
            if (foundRows.Length > 0)
            {
                if (bool.Parse(foundRows[0]["IS_DELETED"].ToString()))
                {
                    ChbIsActive.Checked = true;
                }
                else
                {
                    ChbIsActive.Checked = false;
                }
            }
            this.ClearAll();
            string strtemp = drpAddEditGroup.SelectedItem.ToString();
            string[] words = strtemp.Split('-');
            txtGroupPrice.Text = words[1];
            btnSaveOrder.ToolTip = "Update Group";
            int temp = Convert.ToInt32(drpAddEditGroup.SelectedValue);
            DistributorController DController = new DistributorController();
            DataTable dt = DController.SelectGroupDetail(Convert.ToInt32(drpAddEditGroup.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                GrdPurchase.DataSource = dt;
                GrdPurchase.DataBind();
                Session.Add("PurchaseSKU", dt);
                txtDateEfected.Text = Convert.ToDateTime(dt.Rows[0]["DATE_EFFECTED"]).ToString("dd-MMM-yyyy");
                EnableDisableController(false);
                ScriptManager.GetCurrent(Page).SetFocus(ddlSKuCde);
            }
        }
        else
        {
            this.CreatTable();
            this.LoadGird();
            btnSaveOrder.ToolTip = "Save Group";
            this.ClearAll();
            ClearMasterALL();
            this.txtDateEfected.Text = System.DateTime.Now.ToString("dd-MMM-yyyy");
        }
    }

    private void LoadGroup()
    {
        this.drpAddEditGroup.Items.Clear();
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectGroup(0);
        drpAddEditGroup.Items.Add(new clsListItems("New", Constants.LongNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(this.drpAddEditGroup, dt, 0, 1);
        this.Session.Add("dtGroup", dt);
    }
}