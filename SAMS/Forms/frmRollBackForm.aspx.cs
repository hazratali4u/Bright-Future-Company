using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form To Rollback Order, Invoice, Sale Return And Realized Cheque
/// </summary>
public partial class Forms_frmRollBackForm : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function Populates All Combos And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadDistributor();
            LoadOrderBooker();
            LoadLegend();
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
    }
        
    /// <summary>
    /// Loads Legends To Legend Combo
    /// </summary>
    private void LoadLegend()
    {
        OrderEntryController or = new OrderEntryController();
        DataTable m_dt = or.SelectLegend(); 
        clsWebFormUtil.FillDropDownList(DrpLenged, m_dt, 0, 2, true);
    }
    
    /// <summary>
    /// Load OrderBookers To OrderBooker Combo
    /// </summary>
    private void LoadOrderBooker()
    {
        int type=0;
        if (int.Parse(DrpDocumentType.SelectedValue.ToString()) == 3)
        {// to add Order booker with sale force in DRP for realize cheques
            type = 5;
            lblSaleForce.Text ="Order Booker";
        }
        else
        {
            type = int.Parse(DrpDocumentType.SelectedValue.ToString());
            lblSaleForce.Text = "Sale Force";
        }


        if (drpDistributor.Items.Count > 0)
        {
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectRollBackInvoiceSaleForce(type,Constants.IntNullValue,int.Parse(drpDistributor.SelectedValue.ToString()));
            clsWebFormUtil.FillDropDownList(DrpOrderBooker, m_dt, 0, 1, true);
        }
        else
        {
            DrpOrderBooker.Items.Clear();
        }
    }
    
    /// <summary>
    /// Loads Rollback Order, Invoice And Sale Return Data To Grid
    /// </summary>
    private void LoadRollbackDocument()
    {
        if (DrpOrderBooker.Items.Count > 0 && drpDistributor.Items.Count > 0)
        {
            OrderEntryController or = new OrderEntryController();
            DataTable dtOrder = or.SelectRollBackDocument(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue,
                int.Parse(DrpOrderBooker.SelectedValue.ToString()), int.Parse(DrpDocumentType.SelectedValue.ToString()), DateTime.Parse(Session["CurrentWorkDate"].ToString()));
            GrdOrder.DataSource = dtOrder;
            GrdOrder.DataBind();
        }
    }
    
    /// <summary>
    /// Loads Rollback Cheques Data To Grid
    /// </summary>
    private void LoadRollbackCheque()
    {
        if (drpDistributor.Items.Count > 0)
        {
            ChequeEntryController CController = new ChequeEntryController();
            DataTable dt = CController.SelectChequeEntry(Constants.Cheque_Clear, DateTime.Parse(Session["CurrentWorkDate"].ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, 0);
            GrdCheque.DataSource = dt;
            GrdCheque.DataBind();
        }
    }
    
    /// <summary>
    /// Loads OrderBookers To OrderBooker Combo
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpDocumentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadOrderBooker();
    }

    /// <summary>
    /// Loads OrderBookers To OrderBooker Combo And Principals To Principal Combo
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadOrderBooker();         
    }

    /// <summary>
    /// Rollbacks Order, Invoice, Sale Return And Realized Cheque
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (DrpDocumentType.SelectedIndex == 3)
        {
            foreach (GridViewRow dr in GrdCheque.Rows)
            {
                CheckBox ChbInvoice = (CheckBox)dr.FindControl("ChbInvoice");
                if (ChbInvoice.Checked == true)
                {
                    ChequeEntryController CController = new ChequeEntryController();
                    DataControl dc = new DataControl();
                    CController.RollbackChequeEntry(Convert.ToInt64(dr.Cells[1].Text), int.Parse(drpDistributor.SelectedValue.ToString()), dr.Cells[6].Text, long.Parse(dr.Cells[0].Text),Constants.LongNullValue,Convert.ToDecimal(dc.chkNull_0(dr.Cells[8].Text)));
                }
            }
            LoadRollbackCheque();
        }
        else
        {
            foreach (GridViewRow dr in GrdOrder.Rows)
            {
                CheckBox ChbInvoice = (CheckBox)dr.FindControl("ChbInvoice");
                if (ChbInvoice.Checked == true)
                {
                    OrderEntryController ORD = new OrderEntryController();
                    DataControl dc = new DataControl();
                    ORD.UpdateRollBackDocument(Convert.ToInt64(GrdOrder.DataKeys[dr.RowIndex].Values["Document_ID"]), int.Parse(DrpDocumentType.SelectedValue.ToString()), int.Parse(DrpLenged.SelectedValue.ToString()));
                }
            }
            LoadRollbackDocument();
        }
    }

    /// <summary>
    /// Loads Order, Invoice, Sale Return And Realized Cheque Data To Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnGetOrder_Click(object sender, EventArgs e)
    {
        if (DrpDocumentType.SelectedIndex == 3)
        {
            LoadRollbackCheque();
            GrdOrder.Visible = false;
            GrdCheque.Visible = true;  
        }
        else
        {
            GrdOrder.Visible = true;
            GrdCheque.Visible = false;  
            LoadRollbackDocument();

        }
    }
}
