using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;    

public partial class Forms_frmPysicalStockteken : System.Web.UI.Page
{
    DataTable PurchaseSKU;
    DataControl dc = new DataControl();
    private static int RowNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.LoadPrincipal();
            this.LoadDistributor();
            this.LoadSKUDetail();
        }
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
    /// Loads Principals To Principal Combo
    /// </summary>
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList(this.drpPrincipal, m_dt, 0, 1, true);
    }

    /// <summary>
    /// Loads Document Detail To Document Detail Grid And SKU Detail To ListBox
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadGird();
        this.LoadSKUDetail();
    }

    /// <summary>
    /// Loads SKU Detail To ListBox
    /// </summary>
    private void LoadSKUDetail()
    {
        if (drpPrincipal.Items.Count > 0)
        {
            SKUPriceDetailController PController = new SKUPriceDetailController();
            DataTable Dtsku_Price = PController.SelectDataPrice(int.Parse(drpPrincipal.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["DISTRIBUTOR_ID"].ToString()), int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 1, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
            clsWebFormUtil.FillDropDownList(this.ddlSKuCde , Dtsku_Price, 0, 10, true);
            this.Session.Add("Dtsku_Price", Dtsku_Price);
            
        }
    }

    /// <summary>
    ///  Loads Document Detail To Document Detail Grid
    /// </summary>
    private void LoadGird()
    {
        PhaysicalStockController MController = new PhaysicalStockController();
        DataTable dt = MController.SelectPysicalStock(int.Parse(drpDistributor.SelectedValue.ToString()),0,int.Parse(drpPrincipal.SelectedValue.ToString()));
        GrdPurchase.DataSource = dt;
        GrdPurchase.DataBind();  
    }

    /// <summary>
    /// Deletes A Document Detail
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        PhaysicalStockController MController = new PhaysicalStockController();
        MController.DELETEPysicalStock(int.Parse(drpDistributor.SelectedValue.ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), int.Parse(GrdPurchase.Rows[e.RowIndex].Cells[0].Text));
        this.LoadGird();
    }

    /// <summary>
    /// Sets Document Detail Data For Edit. This Function Runs When An Existing Document Detail Needs To Be Edited
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowEditing(object sender, GridViewEditEventArgs e)
    {
        RowNo = e.NewEditIndex;
        ddlSKuCde .Text = GrdPurchase.Rows[e.NewEditIndex].Cells[0].Text;
 
        txtCtn.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[4].Text;
        txtQuantity.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[5].Text;
        txtusaleableCtn.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[6].Text;        
        txtusaleableqty.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[7].Text;
        txtUnitRate.Text = GrdPurchase.Rows[e.NewEditIndex].Cells[8].Text;
        txtQuantity.Focus();
        btnSave.Text = "Update";
    }
        
    /// <summary>
    /// Checks Duplicate SKU in Document Detail Grid
    /// </summary>
    /// <returns></returns>
    private bool CheckDublicateSKU()
    {
       
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        DataRow[] foundRows = PurchaseSKU.Select("SKU_ID  = '" + ddlSKuCde .SelectedValue  + "'");
        if (foundRows.Length == 0)
        {
            return true;
        }
        
            return false;
       
    }
    
    /// <summary>
    /// Saves/Updates Document
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EvemtArgs</param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataTable Dtsku_Price = (DataTable)this.Session["Dtsku_Price"];
        PurchaseSKU = (DataTable)this.Session["PurchaseSKU"];
        DataRow[] foundRows = Dtsku_Price.Select("SKU_ID  = '" + ddlSKuCde .SelectedValue  + "'");
        DataControl dc = new DataControl();
 
        if (foundRows.Length > 0)
        {
            int SaleQty = 0;
            int UnSaleQty = 0;

            SaleQty = (int.Parse(dc.chkNull_0(txtCtn.Text)) * int.Parse(foundRows[0]["UNITS_IN_CASE"].ToString())) + int.Parse(dc.chkNull_0(txtQuantity.Text));
            UnSaleQty = (int.Parse(dc.chkNull_0(txtusaleableCtn.Text)) * int.Parse(foundRows[0]["UNITS_IN_CASE"].ToString())) + int.Parse(dc.chkNull_0(txtusaleableqty.Text));

            PhaysicalStockController MController = new PhaysicalStockController();
            if (btnSave.Text == "Save")
            {
                MController.InsertPysicalStock(int.Parse(drpDistributor.SelectedValue.ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), int.Parse(foundRows[0]["SKU_ID"].ToString()), SaleQty,UnSaleQty,decimal.Parse(txtUnitRate.Text), 0, int.Parse(drpPrincipal.SelectedValue.ToString()));
            }
            else
            {
                MController.UpdatePysicalStock(int.Parse(drpDistributor.SelectedValue.ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), int.Parse(foundRows[0]["SKU_ID"].ToString()),SaleQty, UnSaleQty, decimal.Parse(txtUnitRate.Text), 0, int.Parse(drpPrincipal.SelectedValue.ToString()));
                
            }
            this.LoadGird();
            this.ClearAll();
            ScriptManager.GetCurrent(Page).SetFocus(ddlSKuCde );
        }
    }

    /// <summary>
    /// Clears Form Controls
    /// </summary>
    private void ClearAll()
    {
       
        txtQuantity.Text = "";
        txtusaleableqty.Text = "";
        txtCtn.Text = "";
        txtusaleableCtn.Text = "";
        txtUnitRate.Text = "0";
        ddlSKuCde.Enabled = true;
        btnSave.Text = "Save";
    }
    
}
