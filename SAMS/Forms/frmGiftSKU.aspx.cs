using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form To Gift SKU
/// </summary>
public partial class Forms_frmGiftSKU : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function Populates All Combos, ListBox And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadDistributor();
            LoadSKUDetail();
           
          //  LoadCustomerDetail();
            LoadFreeSKU();
        }
    }

    /// <summary>
    /// Loads Locations To Location Combo
    /// </summary>
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 2, true);
        LoadSaleForce();
    }

    /// <summary>
    /// Loads Sale Forces To Sale Force Combo
    /// </summary>
    private void LoadSaleForce()
    {        
        if (drpDistributor.Items.Count > 0)
        {
            DrpSaleForce.Items.Clear();
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(Session["CompanyId"].ToString()));
            DrpSaleForce.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(DrpSaleForce, m_dt, 0, 3, false);
        }
        LoadInvoiceNo();
    }

    /// <summary>
    /// Loads Invoice Nos To Invoice No Combo
    /// </summary>
    private void LoadInvoiceNo()
    {
        OrderEntryController DOrder = new OrderEntryController();
        drpDocumentNo.Items.Clear();
        DataTable dtOrder = DOrder.SelectDocumentforView(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue,
                       DateTime.Parse(Session["CurrentWorkDate"].ToString()), DateTime.Parse(Session["CurrentWorkDate"].ToString()),0,Constants.IntNullValue,Convert.ToInt32(DrpSaleForce.SelectedValue));
                 
        clsWebFormUtil.FillDropDownList(drpDocumentNo, dtOrder, 9, 8);
        Session.Add("dtOrder", dtOrder);  
    }


    //private void LoadCustomerDetail()
    //{
    //    if (drpDocumentNo.Items.Count > 0)
    //    {
    //        DataTable dt = (DataTable)Session["dtOrder"];
    //        DataRow[] foundRows = dt.Select("DocumentNo  = '" + drpDocumentNo.SelectedItem.Text + "'");
    //        if (foundRows.Length > 0)
    //        {
    //            drpCustomer.SelectedValue = foundRows[0]["SOLD_TO"].ToString();
               
    //           // HfOrderbooker_id.Value  = foundRows[0]["Orderbooker_id"].ToString();
    //           // HfDELIVERYMAN_ID.Value = foundRows[0]["DELIVERYMAN_ID"].ToString();
    //           // HfCUSTOMER_ID.Value = foundRows[0]["CUSTOMER_ID"].ToString();
    //           // Hflegend_id.Value = foundRows[0]["legend_id"].ToString();
    //            ScriptManager.GetCurrent(Page).SetFocus(ddlSKuCde );
    //        }
    //    }
    //}
    
    /// <summary>
    /// Loads SKU Detail To ListBox
    /// </summary>
    private void LoadSKUDetail()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable Dtsku_Price = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 1, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillDropDownList( ddlSKuCde , Dtsku_Price, 0, 10, true);
        Session.Add("Dtsku_Price", Dtsku_Price);
    }
    
    /// <summary>
    /// Loads Free SKUS To Grid
    /// </summary>
    private void LoadFreeSKU()
    {
        if (drpDocumentNo.Items.Count > 0)
        {
            OrderEntryController or = new OrderEntryController();
            DataTable dt = or.SelectOrderPromotion(int.Parse(drpDistributor.SelectedValue.ToString()), long.Parse(drpDocumentNo.SelectedValue.ToString()));
            GrdPurchase.DataSource = dt;
            GrdPurchase.DataBind();  
        }
    }
    
    /// <summary>
    /// Saves Gift SKU
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (drpDocumentNo.Items.Count > 0)
        {
            OrderEntryController _oeCtrl = new OrderEntryController();
            DataControl dc = new DataControl();

            DataTable Dtsku_Price = (DataTable)Session["Dtsku_Price"];
            DataRow[] foundRows = Dtsku_Price.Select("SKU_Id  = '" + ddlSKuCde .SelectedValue  + "'");

            if (foundRows.Length > 0)
            {
                decimal mTradePrice = decimal.Parse(dc.chkNull_0(foundRows[0]["TRADE_PRICE"].ToString()));
                float mTaxPrice = float.Parse(dc.chkNull_0(foundRows[0]["GST_RATE_TP"].ToString()));
                float mSEDPrice = float.Parse(dc.chkNull_0(foundRows[0]["SED_PRICE"].ToString()));
                decimal mAmount = mTradePrice * int.Parse(txtQuantity.Text);
                decimal mTaxAmt = 0;
                decimal mTSTAmt = 0;
                decimal mSEDAmt = 0;
                if (ChbAllTax.Checked == true)
                {
                    if (foundRows[0]["GST_ON"].ToString().Trim() == "T")
                    {
                        mTaxAmt = (decimal.Parse(mTaxPrice.ToString()) / 100) * mAmount;
                        mSEDAmt = (decimal.Parse(mSEDPrice.ToString()) / 100) * mAmount;

                    }
                    else if (foundRows[0]["GST_ON"].ToString().Trim() == "R")
                    {
                        mTSTAmt = (decimal.Parse(mTaxPrice.ToString())) * int.Parse(txtQuantity.Text);
                        mSEDAmt = 0;
                    }
                                    
                }
                //PhaysicalStockController mController = new PhaysicalStockController();
                //DataTable dtstock = mController.SelectSKUClosingStock(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(foundRows[0]["SKU_ID"].ToString()), txtBatchNo.Text, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
                
                //if (dtstock.Rows.Count > 0)
                //{
                //    if (int.Parse(dtstock.Rows[0][0].ToString()) < int.Parse(txtQuantity.Text))
                //    {
                //        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + ddlSKuCde .SelectedItem .Text   + " Current Stock is " + dtstock.Rows[0][0].ToString() + "');", true);
                //        return;
                //    }
                //}
                if (_oeCtrl.InsertFreeOrderSKU(int.Parse(drpDistributor.SelectedValue.ToString()), long.Parse(drpDocumentNo.SelectedValue.ToString()), int.Parse(foundRows[0]["SKU_ID"].ToString()), int.Parse(txtQuantity.Text)
                , mTradePrice, mAmount, mTaxPrice, mTaxAmt, mTSTAmt, mSEDAmt))
                {
                    LoadFreeSKU();
                    txtQuantity.Text = "";
                    txtUnitRate.Text = "";

                    ScriptManager.GetCurrent(Page).SetFocus(ddlSKuCde);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Some error occurred');", true);
                    
                }
            }
        }                
    }
    
    /// <summary>
    /// Loads Sale Forces To Sale Force Combo
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSaleForce();
    }

    /// <summary>
    /// Loads Free SKUS To Grid And Customer Code To Code TextBox And Name To Name TextBox
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDocumentNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadFreeSKU();
        
    }

    /// <summary>
    /// Deletes Gift SKU
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        OrderEntryController or = new OrderEntryController();
        or.DeleteFreeSKUFromPromotion(int.Parse(drpDistributor.SelectedValue.ToString()), long.Parse(drpDocumentNo.SelectedValue.ToString()), long.Parse(GrdPurchase.Rows[e.RowIndex].Cells[0].Text), int.Parse(GrdPurchase.Rows[e.RowIndex].Cells[1].Text), int.Parse(GrdPurchase.Rows[e.RowIndex].Cells[4].Text),0);
        LoadFreeSKU(); 
    }

    /// <summary>
    /// Loads Invoice Nos To Invoice No Combo, Free SKUS To Grid And Customer Code To Code TextBox And Name To Name TextBox
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpSaleForce_SelectedIndexChanged(object sender, EventArgs e)
    { 
        LoadInvoiceNo();
        LoadFreeSKU();
      //  LoadCustomerDetail();
    }
}
