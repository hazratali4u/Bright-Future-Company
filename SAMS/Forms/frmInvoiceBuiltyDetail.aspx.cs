using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form To Add, Edit Freight
/// </summary>
public partial class Forms_frmInvoiceBuiltyDetail : System.Web.UI.Page
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
            this.LoadDistributor();
            this.LoadCustomer();
            this.LoadTransporter();
            this.LoadGrid();
        }
    }

    /// <summary>
    /// Loads Transporter To Transporter Combo
    /// </summary>
    private void LoadTransporter()
    {
        DataTable dt =  DistributorController.SelectTranspoter();
        clsWebFormUtil.FillDropDownList(DrpTransporter, dt, 0, 1);
          
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
    /// Loads Customers To Customer Combo
    /// </summary>
    private void LoadCustomer()
    {
        if (drpDistributor.Items.Count > 0)
        {
            CustomerDataController mController = new CustomerDataController();
            DataTable dtCustomer = mController.SelectPrincipalCustomer(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
            string[] colums = new string[] { "CUSTOMER_ID", "CUSTOMER_DETAIL"};
            DataTable dtCustomer2 = dtCustomer.DefaultView.ToTable("dtCustomer2", true, colums);
            
            clsWebFormUtil.FillDropDownList(this.DrpCustomer, dtCustomer2, 0, 1, true);
            
            if (dtCustomer.Rows.Count > 0)
            {
                DrpInvoiceNo.Items.Clear();   
                DataRow[] foundRows = dtCustomer.Select("Customer_id  = " + DrpCustomer.SelectedValue);
                for (int i = 0; i < foundRows.Length; i++)
                {
                    DrpInvoiceNo.Items.Add(new ListItem(foundRows[i]["MANUAL_INVOICE_ID"].ToString(), foundRows[i]["Sale_Invoice_Id"].ToString()));

                }
                this.Session.Add("dtCustomer", dtCustomer);
            }
        }
        else
        {
            DrpCustomer.Items.Clear();
        }
    }
    
    /// <summary>
    /// Loads Freight Data To Grid
    /// </summary>
    private void LoadGrid()
    {
        if (drpDistributor.Items.Count > 0)
        {
            LedgerController LController = new LedgerController();
            DataTable dt = LController.SelectBankCashTransction2(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.Builty_Exp ,
                DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
            GrdOrder.DataSource = dt;
            GrdOrder.DataBind();
        }
    }

    /// <summary>
    /// Saves Frieght
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        LedgerController LController = new LedgerController();
        SAMSCommon.Classes.Configuration.GetAccountHead();

        string MaxDocumentId = LController.SelectLedgerMaxDocumentId(Constants.Journal_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));

        if (Convert.ToDecimal(txtAmount.Text) > 0)
        {
            //Transportation           
            LController.PostingCash_Bank_Account(Constants.Journal_Voucher, long.Parse(MaxDocumentId), long.Parse(SAMSCommon.Classes.Configuration.BuiltyExp.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), decimal.Parse(txtAmount.Text), 0,
                   DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                    null, int.Parse(this.Session["UserId"].ToString()), int.Parse(DrpInvoiceNo.SelectedValue.ToString()), DrpInvoiceNo.SelectedItem.Text, Constants.Document_Invoice, null, Constants.DateNullValue, Constants.Builty_Exp, DrpTransporter.SelectedValue.ToString());
        }

        if (Convert.ToDecimal(txtBiltyExpenses.Text) > 0)
        {
            //Builty Expense

            LController.PostingCash_Bank_Account(Constants.Journal_Voucher, long.Parse(MaxDocumentId), 662, int.Parse(drpDistributor.SelectedValue.ToString()), decimal.Parse(txtBiltyExpenses.Text), 0,
                   DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                    null, int.Parse(this.Session["UserId"].ToString()), int.Parse(DrpInvoiceNo.SelectedValue.ToString()), DrpInvoiceNo.SelectedItem.Text, Constants.Document_Invoice, null, Constants.DateNullValue, Constants.Builty_Exp2, DrpTransporter.SelectedValue.ToString());
        }

        this.LoadGrid();
        txtAmount.Text = "";
        txtBiltyExpenses.Text = "";
        txtRemarks.Text = ""; 
    }

    /// <summary>
    /// Loads Invoices To Invoice Combo
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dtCustomer = (DataTable)this.Session["dtCustomer"];
        
        DrpInvoiceNo.Items.Clear();   
        
        DataRow[] foundRows = dtCustomer.Select("Customer_id  = " + DrpCustomer.SelectedValue);
        
        for (int i = 0; i < foundRows.Length; i++)
        {
            DrpInvoiceNo.Items.Add(new ListItem(foundRows[i]["MANUAL_INVOICE_ID"].ToString(), foundRows[i]["Sale_Invoice_Id"].ToString()));
        } 
    }

    /// <summary>
    /// Deletes Fright
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdOrder_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        LedgerController LController = new LedgerController();
        DataControl dc = new DataControl();

        LController.DeleteWareHouseLedger(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[2].Text)),
        int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[7].Text)), Constants.LongNullValue, decimal.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[8].Text)) + decimal.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[9].Text)));
        this.LoadGrid();
        
    }

    /// <summary>
    /// Loads Customers And Freight Data
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadCustomer(); 
        this.LoadGrid();
    }
}
