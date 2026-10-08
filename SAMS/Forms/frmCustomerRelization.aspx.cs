using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form For Bank Transaction
/// </summary>
public partial class Forms_frmCustomerRelization : System.Web.UI.Page
{
    LedgerController LController = new LedgerController();

    /// <summary>
    /// Page_Load Function Populates All Combos And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SAMSCommon.Classes.Configuration.GetAccountHead();
            this.LoadDistributor();           
            this.LoadArea();
            this.LoadOrderBooker();
            this.LoadData();
            this.LoadAccountHead();
            this.LoadGrid();
            this.SelectCreditInvoice();
            btnSave.Attributes.Add("onclick", "return ValidateForm();");
            this.SetTableSorter();
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
    /// Loads Routes To Route Combo
    /// </summary>
    private void LoadArea()
    {
        DistributorAreaController mController = new DistributorAreaController();
        DataTable dt = mController.SelectDist_Area(Constants.LongNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, null, null,true);
        clsWebFormUtil.FillDropDownList(DrpRoute, dt, 0, 6, true);
    }
    
    private void LoadOrderBooker()
    {
        if (drpDistributor.Items.Count > 0)// && DrpRoute.Items.Count > 0)
        {
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(Constants.SALES_FORCE_DELIVERYMAN, int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(this.Session["CompanyId"].ToString()), Constants.IntNullValue);
            clsWebFormUtil.FillDropDownList(this.DrpOrderBooker, m_dt, 0, 3, true);
        }
        else
        {
            DrpOrderBooker.Items.Clear();
        }
    }
    
    /// <summary>
    /// Loads Customers To Customer Combo
    /// </summary>
    private void LoadData()
    {
        GrdCredit.DataSource = null;
        GrdCredit.DataBind();
        if (drpDistributor.Items.Count > 0)
        {
            CustomerDataController mController = new CustomerDataController();

            if (DrpAccountType.SelectedValue == "21" || DrpAccountType.SelectedValue == "29")
            {

                DataTable dt = mController.SelectPrincipalCustomer(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue);
                clsWebFormUtil.FillDropDownList(this.DrpCustomer, dt, 0, 4, true);
               // DrpRoute.Enabled = true;
            }
            else
            {
                DataTable dtCredit = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.LongNullValue, int.Parse(DrpRoute.SelectedValue.ToString()));
                clsWebFormUtil.FillDropDownList(this.DrpCustomer, dtCredit, 0, 1, true);
               // DrpRoute.Enabled = false;
            }
        }
    }
    
    /// <summary>
    /// Resets Form Controls
    /// </summary>
    private void ClearAll()
    {
        txtChequeNo.Text = "";
        txtAmount.Text = "";
        txtRemarks.Text = "";
        txtSlipNo.Text = "";
        btnSave.Text = "Save";
    }
    
    /// <summary>
    /// Loads Bank Transactions To Grid
    /// </summary>
    private void LoadGrid()
    {
        if (DrpAccountType.SelectedIndex != 7)
        {
            string DrpAccountTypeSelectedValue = "";
            if (DrpAccountType.SelectedValue == "222")
            {
                DrpAccountTypeSelectedValue = "22";
            }
            else
            {
                DrpAccountTypeSelectedValue = DrpAccountType.SelectedValue;
            }
            if (drpDistributor.Items.Count > 0)
            {                
                DataTable dt = LController.SelectBankCashTransction(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Convert.ToInt32(DrpAccountTypeSelectedValue),
                    DrpOrderBooker.SelectedValue,DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
                GrdOrder.DataSource = dt;
                GrdOrder.DataBind();
            }
        }
    }
    
    /// <summary>
    /// Loads Account Heads To Account Combo
    /// </summary>
    private void LoadAccountHead()
    {
        if (DrpAccountType.SelectedValue == "19" || DrpAccountType.SelectedValue == "21" || DrpAccountType.SelectedValue == "29")
        {
            AccountHeadController mAccountController = new AccountHeadController();
            DataTable dt = mAccountController.SelectAccountHead(Constants.AC_AccountHeadId, long.Parse(SAMSCommon.Classes.Configuration.CashDefaultType));
            clsWebFormUtil.FillDropDownList(DrpAccountDetail, dt, 0, 4, true);
        }
        else if (DrpAccountType.SelectedValue == "23")
        {
            DrpAccountDetail.Items.Clear();
            DrpAccountDetail.Items.Add(new ListItem("Tax Deducted By Parties", "127"));
        }
        else if (DrpAccountType.SelectedValue == "28")
        {
            DrpAccountDetail.Items.Clear();
            DrpAccountDetail.Items.Add(new ListItem("Credit Transfer Out", "361"));
        }
        else if (DrpAccountType.SelectedValue == "22" || DrpAccountType.SelectedValue == "222")
        {
            AccountHeadController mAccountController = new AccountHeadController();
            DataTable dt = mAccountController.SelectAccountHead(Constants.AC_AccountHeadId, long.Parse(SAMSCommon.Classes.Configuration.BankDefaultType));
            clsWebFormUtil.FillDropDownList(DrpAccountDetail, dt, 0, 4, true);
        }
        else
        {
            DrpAccountDetail.Items.Clear();
        }

    }
        
    /// <summary>
    /// Saves Cash Realization
    /// </summary>
    private void CashRealization()
    {   
        if (GrdCredit.Rows.Count > 0)
        {
            string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Cash_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
            decimal OfferAmount = decimal.Parse(txtAmount.Text);

          //  DataTable dtCreditSKU = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(DrpCustomer.SelectedValue.ToString()), -1);

            foreach (GridViewRow dr in GrdCredit.Rows)
            {
                CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                if (chRelized.Checked == true)
                {
                    if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                    {
                       // DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                       // if (foundrows.Length > 0)
                       // {
                        //    foreach (DataRow drSKU in foundrows)
                         //   {
                            //    decimal SKUPer = OfferAmount * Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) / decimal.Parse(dr.Cells[3].Text);
                            //    if (SKUPer > 0)
                             //   {
                                    LController.PostingCash_Bank_AccountNew(Constants.Cash_Voucher, long.Parse(MaxDocumentID), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, OfferAmount,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 19, DrpOrderBooker.SelectedValue.ToString(), 0);

                                    LController.PostingCash_Bank_AccountNew(Constants.Cash_Voucher, long.Parse(MaxDocumentID), long.Parse(DrpAccountDetail.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), OfferAmount, 0,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 19, DrpOrderBooker.SelectedValue.ToString(), 0);

                                       //  }
                          //  }
                       // }

                       

                        LController.UpdateCreditInvoice(Constants.LongNullValue, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), OfferAmount, 0, Convert.ToInt32(Session["UserID"]));
                        OfferAmount = decimal.Parse(dr.Cells[3].Text) - OfferAmount;
                        break;
                    }
                    else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                    {
                        //DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                        //if (foundrows.Length > 0)
                       // {
                         //   foreach (DataRow drSKU in foundrows)
                           // {
                              //  if (Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) > 0)
                               // {
                        LController.PostingCash_Bank_AccountNew(Constants.Cash_Voucher, long.Parse(MaxDocumentID), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, Convert.ToDecimal(dr.Cells[3].Text),
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 19, DrpOrderBooker.SelectedValue.ToString(), 0);

                        LController.PostingCash_Bank_AccountNew(Constants.Cash_Voucher, long.Parse(MaxDocumentID), long.Parse(DrpAccountDetail.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), Convert.ToDecimal(dr.Cells[3].Text), 0,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 19, DrpOrderBooker.SelectedValue.ToString(), 0);

                                    
                                     LController.UpdateCreditInvoice(Constants.LongNullValue, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), Convert.ToDecimal(Convert.ToDecimal(dr.Cells[3].Text)), 0, Convert.ToInt32(Session["UserID"]));
                                     OfferAmount = OfferAmount - Convert.ToDecimal(dr.Cells[3].Text);
                        //  } 
                           // }
                        //}
                    }                    
                }
            }
            PrintVoucher(Convert.ToInt64(MaxDocumentID), Constants.Cash_Voucher, Constants.CashPayment);
        }
    }
    
    /// <summary>
    /// Saves Cash Advance
    /// </summary>
    private void CashAdvance()
    {        
        string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Cash_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));

        DataTable dtLedger = CreateTable();

        //Credit from Account Receivable (Party Wise)
        DataRow dr = dtLedger.NewRow();
        
        dr["VOUCHER_TYPE_ID"] = Constants.Cash_Voucher;
        dr["VOUCHER_NO"] = MaxDocumentID;
        dr["ACCOUNT_HEAD_ID"] = SAMSCommon.Classes.Configuration.AccountReceivable;
        dr["Distributor_ID"] = drpDistributor.SelectedValue;
        dr["DEBIT"] = 0;
        dr["CREDIT"] = txtAmount.Text;
        dr["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr["Remarks"] = txtRemarks.Text;
        dr["TimeStamp"] = DateTime.Now;
        dr["Customer_ID"] = DrpCustomer.SelectedValue;
        dr["Principal_ID"] = 0;
        dr["Cheque_NO"] = txtChequeNo.Text;
        dr["UserID"] = this.Session["UserId"].ToString();
        dr["Document_ID"] = Constants.LongNullValue;
        dr["Manual_Document_ID"] = null;
        dr["DocumentTypeID"] = Constants.IntNullValue;
        dr["SlipNo"] = txtSlipNo.Text;
        dr["ChequeDate"] = Constants.DateNullValue;
        dr["PaymentMode"] = 21;
        dr["PayeesName"] = DrpOrderBooker.SelectedValue;
        dtLedger.Rows.Add(dr);

        //Debit to selected Account Head
        DataRow dr2 = dtLedger.NewRow();
        
        dr2["VOUCHER_TYPE_ID"] = Constants.Cash_Voucher;
        dr2["VOUCHER_NO"] = MaxDocumentID;
        dr2["ACCOUNT_HEAD_ID"] = DrpAccountDetail.SelectedValue;
        dr2["Distributor_ID"] = drpDistributor.SelectedValue;
        dr2["DEBIT"] = txtAmount.Text;
        dr2["CREDIT"] = 0;
        dr2["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr2["Remarks"] = txtRemarks.Text;
        dr2["TimeStamp"] = DateTime.Now;
        dr2["Customer_ID"] = DrpCustomer.SelectedValue;
        dr2["Principal_ID"] = 0;
        dr2["Cheque_NO"] = txtChequeNo.Text;
        dr2["UserID"] = this.Session["UserId"].ToString();
        dr2["Document_ID"] = Constants.LongNullValue;
        dr2["Manual_Document_ID"] = null;
        dr2["DocumentTypeID"] = Constants.IntNullValue;
        dr2["SlipNo"] = txtSlipNo.Text;
        dr2["ChequeDate"] = Constants.DateNullValue;
        dr2["PaymentMode"] = 21;
        dr2["PayeesName"] = DrpOrderBooker.SelectedValue;
        dtLedger.Rows.Add(dr2);

        LController.PostingCash_Bank_Account(dtLedger);

        this.PrintVoucher(Convert.ToInt64(MaxDocumentID), Constants.Cash_Voucher, Constants.Cash_Advance);
    }
    
    /// <summary>
    /// Saves Bank Deposits For Branch And Deliveryman
    /// </summary>
    /// <param name="p_SaleForceID"></param>
    private void BankDeposit(string p_SaleForceID)
    {        
        string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Bank_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
        DataTable dtLedger = CreateTable();
        
        //Credit from NCS
        DataRow dr = dtLedger.NewRow();
        dr["VOUCHER_TYPE_ID"] = Constants.Bank_Voucher;
        dr["VOUCHER_NO"] = MaxDocumentID;
        dr["ACCOUNT_HEAD_ID"] = SAMSCommon.Classes.Configuration.CashDefault;
        dr["Distributor_ID"] = drpDistributor.SelectedValue;
        dr["DEBIT"] = 0;
        dr["CREDIT"] = txtAmount.Text;
        dr["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr["Remarks"] = txtRemarks.Text;
        dr["TimeStamp"] = DateTime.Now;
        dr["Customer_ID"] = Constants.IntNullValue;
        dr["Principal_ID"] = 0;
        dr["Cheque_NO"] = txtChequeNo.Text;
        dr["UserID"] = this.Session["UserId"].ToString();
        dr["Document_ID"] = Constants.LongNullValue;
        dr["Manual_Document_ID"] = null;
        dr["DocumentTypeID"] = Constants.IntNullValue;
        dr["SlipNo"] = txtSlipNo.Text;
        dr["ChequeDate"] = Constants.DateNullValue;
        dr["PaymentMode"] = 22;
        dr["PayeesName"] = p_SaleForceID;
        dtLedger.Rows.Add(dr);

        //Debit to selected Account Head
        DataRow dr2 = dtLedger.NewRow();       
        dr2["VOUCHER_TYPE_ID"] = Constants.Bank_Voucher;
        dr2["VOUCHER_NO"] = MaxDocumentID;
        dr2["ACCOUNT_HEAD_ID"] = DrpAccountDetail.SelectedValue;
        dr2["Distributor_ID"] = drpDistributor.SelectedValue;
        dr2["DEBIT"] = txtAmount.Text;
        dr2["CREDIT"] = 0;
        dr2["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr2["Remarks"] = txtRemarks.Text;
        dr2["TimeStamp"] = DateTime.Now;
        dr2["Customer_ID"] = Constants.IntNullValue;
        dr2["Principal_ID"] = 0;
        dr2["Cheque_NO"] = txtChequeNo.Text;
        dr2["UserID"] = this.Session["UserId"].ToString();
        dr2["Document_ID"] = Constants.LongNullValue;
        dr2["Manual_Document_ID"] = null;
        dr2["DocumentTypeID"] = Constants.IntNullValue;
        dr2["SlipNo"] = txtSlipNo.Text;
        dr2["ChequeDate"] = Constants.DateNullValue;
        dr2["PaymentMode"] = 22;
        dr2["PayeesName"] = p_SaleForceID;
        dtLedger.Rows.Add(dr2);
        
        LController.PostingCash_Bank_Account(dtLedger);
    }
    
    /// <summary>
    /// Saves Petty Cash
    /// </summary>
    private void PettyCash()
    {        
        string MaxDocumentId = LController.SelectLedgerMaxDocumentId(Constants.Cash_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));

        LController.PostingCash_Bank_Account(Constants.Cash_Voucher, long.Parse(MaxDocumentId), long.Parse(SAMSCommon.Classes.Configuration.CashDefault), int.Parse(drpDistributor.SelectedValue.ToString()), decimal.Parse(txtAmount.Text), 0,
                 DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, Constants.IntNullValue, 0,
                 txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Constants.LongNullValue,null, Constants.IntNullValue, txtSlipNo.Text, Constants.DateNullValue, int.Parse(DrpAccountType.SelectedValue.ToString()), "");

    }
    
    /// <summary>
    /// Loads Deliveryment To Deliveryman Combo
    /// </summary>
    private void LoadDeliveryman()
    {
        if (drpDistributor.Items.Count > 0)
        {
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(this.Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(this.DrpDeliveryMan, m_dt, 0, 3, true);
        }
    }
    
    /// <summary>
    /// Loads Credit Invoices To Invoice Grid
    /// </summary>
    private void SelectCreditInvoice()
    {        
        GrdCredit.DataSource = null;
        GrdCredit.DataBind();
        if (DrpCustomer.Items.Count > 0 && DrpAccountType.SelectedValue != "21" && DrpAccountType.SelectedValue != "29")
        {
            DataTable dtCredit = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(DrpCustomer.SelectedValue.ToString()), 0);
            GrdCredit.DataSource = dtCredit;
            GrdCredit.DataBind();
        }
    }
    
    /// <summary>
    /// Saves Income Tax
    /// </summary>
    private void IncomeTax()
    {        
        string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Journal_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
        decimal OfferAmount = decimal.Parse(txtAmount.Text);
        foreach (GridViewRow dr in GrdCredit.Rows)
        {
            CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
            if (chRelized.Checked == true)
            {
                DataTable dtLedger = CreateTable();

                //Credit from Account Receivable (Party Wise)
                DataRow drLedger = dtLedger.NewRow();
                drLedger["VOUCHER_TYPE_ID"] = Constants.Journal_Voucher;
                drLedger["VOUCHER_NO"] = MaxDocumentID;
                drLedger["ACCOUNT_HEAD_ID"] = SAMSCommon.Classes.Configuration.AccountReceivable;
                drLedger["Distributor_ID"] = drpDistributor.SelectedValue;
                if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                {
                    drLedger["DEBIT"] = 0;
                    drLedger["CREDIT"] = OfferAmount;
                }
                else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                {
                    drLedger["DEBIT"] = 0;
                    drLedger["CREDIT"] = dr.Cells[3].Text;
                }
                drLedger["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
                drLedger["Remarks"] = txtRemarks.Text;
                drLedger["TimeStamp"] = DateTime.Now;
                drLedger["Customer_ID"] = DrpCustomer.SelectedValue;
                drLedger["Principal_ID"] = 0;
                drLedger["Cheque_NO"] = txtChequeNo.Text;
                drLedger["UserID"] = this.Session["UserId"].ToString();
                drLedger["Document_ID"] = GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString();
                drLedger["Manual_Document_ID"] = dr.Cells[1].Text;
                drLedger["DocumentTypeID"] = Constants.Document_Invoice;
                drLedger["SlipNo"] = txtSlipNo.Text;
                drLedger["ChequeDate"] = Constants.DateNullValue;
                drLedger["PaymentMode"] = DrpAccountType.SelectedValue;
                drLedger["PayeesName"] = DrpOrderBooker.SelectedValue;
                dtLedger.Rows.Add(drLedger);

                //Debit to selected Account Head
                DataRow drLedger2 = dtLedger.NewRow();
                drLedger2["VOUCHER_TYPE_ID"] = Constants.Journal_Voucher;
                drLedger2["VOUCHER_NO"] = MaxDocumentID;
                drLedger2["ACCOUNT_HEAD_ID"] = DrpAccountDetail.SelectedValue;
                drLedger2["Distributor_ID"] = drpDistributor.SelectedValue;
                if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                {
                    drLedger2["DEBIT"] = OfferAmount;
                    drLedger2["CREDIT"] = 0;
                }
                else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                {
                    drLedger2["DEBIT"] = dr.Cells[3].Text;
                    drLedger2["CREDIT"] = 0;
                }

                drLedger2["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
                drLedger2["Remarks"] = txtRemarks.Text;
                drLedger2["TimeStamp"] = DateTime.Now;
                drLedger2["Customer_ID"] = DrpCustomer.SelectedValue;
                drLedger2["Principal_ID"] = 0;
                drLedger2["Cheque_NO"] = txtChequeNo.Text;
                drLedger2["UserID"] = this.Session["UserId"].ToString();
                drLedger2["Document_ID"] = GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString();
                drLedger2["Manual_Document_ID"] = dr.Cells[1].Text;
                drLedger2["DocumentTypeID"] = Constants.Document_Invoice;
                drLedger2["SlipNo"] = txtSlipNo.Text;
                drLedger2["ChequeDate"] = Constants.DateNullValue;
                drLedger2["PaymentMode"] = DrpAccountType.SelectedValue;
                drLedger2["PayeesName"] = DrpOrderBooker.SelectedValue;
                dtLedger.Rows.Add(drLedger2);

                if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                {
                    OfferAmount = decimal.Parse(dr.Cells[3].Text) - OfferAmount;
                    LController.PostingCash_Bank_Account(dtLedger, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), int.Parse(drpDistributor.SelectedValue.ToString()), OfferAmount);
                }
                else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                {
                    OfferAmount = OfferAmount - decimal.Parse(dr.Cells[3].Text);
                    LController.PostingCash_Bank_Account(dtLedger, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), int.Parse(drpDistributor.SelectedValue.ToString()), 0);
                }
                break;
            }
        }
    }

    /// <summary>
    /// Saves Credit Transfer Out
    /// </summary>
    private void CreditTransferOut()
    {
        if (GrdCredit.Rows.Count > 0)
        {
            string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Cash_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
            decimal OfferAmount = decimal.Parse(txtAmount.Text);

           // DataTable dtCreditSKU = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(DrpCustomer.SelectedValue.ToString()), -1);

            foreach (GridViewRow dr in GrdCredit.Rows)
            {
                CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                if (chRelized.Checked == true)
                {
                    if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                    {
                        //DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                       // if (foundrows.Length > 0)
                       // {
                         //   foreach (DataRow drSKU in foundrows)
                           // {
                              //  decimal SKUPer = OfferAmount * Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) / decimal.Parse(dr.Cells[3].Text);
                              //  if (SKUPer > 0)
                              //  {
                                    LController.PostingCash_Bank_AccountNew(Constants.Journal_Voucher, long.Parse(MaxDocumentID), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, OfferAmount,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, Convert.ToInt32(DrpCustomer.SelectedValue), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, Constants.Credit_TransferOut, DrpOrderBooker.SelectedValue.ToString(), 0);

                                    LController.PostingCash_Bank_AccountNew(Constants.Journal_Voucher, long.Parse(MaxDocumentID), long.Parse(DrpAccountDetail.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), OfferAmount, 0,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, Convert.ToInt32(DrpCustomer.SelectedValue), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, Constants.Credit_TransferOut, DrpOrderBooker.SelectedValue.ToString(), 0);
                              //  }
                           // }
                        //}

                        
                        LController.UpdateCreditInvoice(Constants.LongNullValue, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), OfferAmount,0, Convert.ToInt32(Session["UserID"]));
                        OfferAmount = decimal.Parse(dr.Cells[3].Text) - OfferAmount;
                        break;
                    }
                    else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                    {
                        //DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                    //    if (foundrows.Length > 0)
                      //  {
                          //  foreach (DataRow drSKU in foundrows)
                          //  {
                             //   if (Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) > 0)
                              //  {
                        LController.PostingCash_Bank_AccountNew(Constants.Journal_Voucher, long.Parse(MaxDocumentID), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, Convert.ToDecimal(dr.Cells[3].Text),
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, Convert.ToInt32(DrpCustomer.SelectedValue), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, Constants.Credit_TransferOut, DrpOrderBooker.SelectedValue.ToString(),0);

                        LController.PostingCash_Bank_AccountNew(Constants.Journal_Voucher, long.Parse(MaxDocumentID), long.Parse(DrpAccountDetail.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), Convert.ToDecimal(dr.Cells[3].Text), 0,
                                    DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), txtRemarks.Text, DateTime.Now, Convert.ToInt32(DrpCustomer.SelectedValue), 0,
                                    txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, Constants.Credit_TransferOut, DrpOrderBooker.SelectedValue.ToString(), 0);


                        LController.UpdateCreditInvoice(Constants.LongNullValue, Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), decimal.Parse(dr.Cells[3].Text), 0, Convert.ToInt32(Session["UserID"]));
                                    OfferAmount = OfferAmount - decimal.Parse(dr.Cells[3].Text);      
                        //  }
                           // }
                        //}
                    }
                }
            }
        }
    }
    
    /// <summary>
    /// Saves Advance Return
    /// </summary>
    private void AdvanceReturn()
    {                
        string MaxDocumentID = LController.SelectLedgerMaxDocumentId(Constants.Cash_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
        DataTable dtLedger = CreateTable();

        //Debit to Account Receivable (Party Wise)
        DataRow dr = dtLedger.NewRow();
        dr["VOUCHER_TYPE_ID"] = Constants.Cash_Voucher;
        dr["VOUCHER_NO"] = MaxDocumentID;
        dr["ACCOUNT_HEAD_ID"] = SAMSCommon.Classes.Configuration.AccountReceivable;
        dr["Distributor_ID"] = drpDistributor.SelectedValue;
        dr["DEBIT"] = txtAmount.Text;
        dr["CREDIT"] = 0;
        dr["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr["Remarks"] = txtRemarks.Text;
        dr["TimeStamp"] = DateTime.Now;
        dr["Customer_ID"] = DrpCustomer.SelectedValue;
        dr["Principal_ID"] = 0;
        dr["Cheque_NO"] = txtChequeNo.Text;
        dr["UserID"] = this.Session["UserId"].ToString();
        dr["Document_ID"] = Constants.LongNullValue;
        dr["Manual_Document_ID"] = null;
        dr["DocumentTypeID"] = Constants.IntNullValue;
        dr["SlipNo"] = txtSlipNo.Text;
        dr["ChequeDate"] = Constants.DateNullValue;
        dr["PaymentMode"] = 29;
        dr["PayeesName"] = "";
        dtLedger.Rows.Add(dr);

        //Credit from selected Account Head
        DataRow dr2 = dtLedger.NewRow();
        dr2["VOUCHER_TYPE_ID"] = Constants.Cash_Voucher;
        dr2["VOUCHER_NO"] = MaxDocumentID;
        dr2["ACCOUNT_HEAD_ID"] = DrpAccountDetail.SelectedValue;
        dr2["Distributor_ID"] = drpDistributor.SelectedValue;
        dr2["DEBIT"] = 0;
        dr2["CREDIT"] = txtAmount.Text;
        dr2["Ledger_Date"] = this.Session["CurrentWorkDate"].ToString();
        dr2["Remarks"] = txtRemarks.Text;
        dr2["TimeStamp"] = DateTime.Now;
        dr2["Customer_ID"] = DrpCustomer.SelectedValue;
        dr2["Principal_ID"] = 0;
        dr2["Cheque_NO"] = txtChequeNo.Text;
        dr2["UserID"] = this.Session["UserId"].ToString();
        dr2["Document_ID"] = Constants.LongNullValue;
        dr2["Manual_Document_ID"] = null;
        dr2["DocumentTypeID"] = Constants.IntNullValue;
        dr2["SlipNo"] = txtSlipNo.Text;
        dr2["ChequeDate"] = Constants.DateNullValue;
        dr2["PaymentMode"] = 29;
        dr2["PayeesName"] = "";
        dtLedger.Rows.Add(dr2);

        LController.PostingCash_Bank_Account(dtLedger);
    }
    
    /// <summary>
    /// Loads Routes, Customers, Deliverymen And Bank Transactions
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.DrpAccountType.SelectedIndex != 7)
        {
            this.LoadArea();
            this.LoadData();
            this.LoadGrid();
            
            gvSaleForceCash.Visible = false;
            GrdOrder.Visible = true;
        }
        else if (this.DrpAccountType.SelectedIndex == 7)
        {
            this.LoadSaleFoceCash();
        }
       // this.LoadDeliveryman();
        this.LoadOrderBooker();
        this.SetTableSorter();
    }

    /// <summary>
    /// Loads Customers And Credit Invoices
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData();
        SelectCreditInvoice();
        SetTableSorter();
       // this.LoadOrderBooker();
    }

    /// <summary>
    /// Loads Customers
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpAccountDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadGrid();
        this.SetTableSorter();
    }

    /// <summary>
    /// Deletes Bank Transaction
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdOrder_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {        
        DataControl dc = new DataControl();
        if (DrpAccountType.SelectedValue == "19" || DrpAccountType.SelectedValue == Constants.Credit_TransferOut.ToString())
        {
            DataTable dtCreditSKU = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(GrdOrder.Rows[e.RowIndex].Cells[11].Text), -1, long.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[10].Text.Replace("&nbsp;", ""))));

            foreach (DataRow dr in dtCreditSKU.Rows)
            {
                LController.DeleteCashBankTransction(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[2].Text)),
                int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[7].Text)), long.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[10].Text.Replace("&nbsp;", ""))), decimal.Parse(dr["CURRENT_CREDIT_AMOUNT"].ToString()), Convert.ToInt32(dr["SKU_ID"]));
            }
        }        
        else
        {
            LController.DeleteCashBankTransction(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[2].Text)),
            int.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[7].Text)), long.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[10].Text.Replace("&nbsp;", ""))), decimal.Parse(dc.chkNull_0(GrdOrder.Rows[e.RowIndex].Cells[8].Text)));
        }
        this.LoadGrid();
        this.SelectCreditInvoice();
        this.SetTableSorter();            

    }

    /// <summary>
    /// Loads Account Head, Customers, Deliverymen And Bank Transactions
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpAccountType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.DrpAccountType.SelectedIndex == 2 || this.DrpAccountType.SelectedIndex == 7)
        {
            this.HideShowControls(false);
        }
        else
        {
            this.HideShowControls(true);
        }

        if (this.DrpAccountType.SelectedIndex != 7)
        {
            this.LoadData();
            this.LoadAccountHead();
            this.LoadGrid();
            this.SelectCreditInvoice();
            gvSaleForceCash.Visible = false;
            GrdOrder.Visible = true;
            
        }
        else
        {
            this.LoadSaleFoceCash();
        }       
        this.SetTableSorter();
        
    }

    /// <summary>
    /// Loads Credit Invoices
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.SelectCreditInvoice();
        this.SetTableSorter();
    }
        
    /// <summary>
    /// Creates Datatable For Bank Transaction
    /// </summary>
    /// <returns></returns>
    private DataTable CreateTable()
    {
        DataTable dtLedger = new DataTable();
        dtLedger.Columns.Add("VOUCHER_TYPE_ID", typeof(int));
        dtLedger.Columns.Add("VOUCHER_NO", typeof(long));
        dtLedger.Columns.Add("ACCOUNT_HEAD_ID", typeof(long));
        dtLedger.Columns.Add("Distributor_ID", typeof(int));
        dtLedger.Columns.Add("Debit", typeof(decimal));
        dtLedger.Columns.Add("Credit", typeof(decimal));
        dtLedger.Columns.Add("Ledger_Date", typeof(DateTime));
        dtLedger.Columns.Add("Remarks", typeof(string));
        dtLedger.Columns.Add("TimeStamp", typeof(DateTime));
        dtLedger.Columns.Add("Customer_ID", typeof(int));
        dtLedger.Columns.Add("Principal_ID", typeof(int));
        dtLedger.Columns.Add("Cheque_NO", typeof(string));
        dtLedger.Columns.Add("UserId", typeof(int));
        dtLedger.Columns.Add("Document_ID", typeof(long));
        dtLedger.Columns.Add("Manual_Document_ID", typeof(string));
        dtLedger.Columns.Add("DocumentTypeID", typeof(int));
        dtLedger.Columns.Add("SlipNo", typeof(string));
        dtLedger.Columns.Add("ChequeDate", typeof(DateTime));
        dtLedger.Columns.Add("PaymentMode", typeof(int));
        dtLedger.Columns.Add("PayeesName", typeof(string));
        this.Session.Add("dtLedger", dtLedger);
        return dtLedger;
    }
    
    /// <summary>
    /// Saves/Uupdates Bank Transaction
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (IsDayClosed())
        {
            UserController UserCtl = new UserController();

            UserCtl.InsertUserLogoutTime(Convert.ToInt32(Session["User_Log_ID"]), Convert.ToInt32(Session["UserID"]));
            this.Session.Clear();
            System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("../Login.aspx");
        }
        else
        {
            if (btnSave.Text == "Update")
            {
                SaleForceController mSaleForce = new SaleForceController();
                mSaleForce.DeleteSaleForceCash(Convert.ToInt32(hfSALE_FORCE_CASH_ID.Value), Convert.ToInt32(drpDistributor.SelectedValue), Convert.ToInt32(hfPRINCIPAL_ID.Value), Convert.ToInt32(hfDELIVERYMAN_ID.Value));
            }

            if (DrpAccountType.SelectedIndex == 0)
            {
                int InvoiceCount = Constants.IntNullValue;
                foreach (GridViewRow dr in GrdCredit.Rows)
                {
                    CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                    if (chRelized.Checked == true)
                    {
                        InvoiceCount++;
                        break;
                    }
                }

                if (InvoiceCount == Constants.IntNullValue)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Must Select Invoice');", true);
                    return;
                }
                this.CashRealization();
                this.SelectCreditInvoice();
            }
            else if (DrpAccountType.SelectedIndex == 1)
            {
                this.CashAdvance();
            }
            else if (DrpAccountType.SelectedIndex == 2)
            {
                this.BankDeposit("");
            }
            else if (DrpAccountType.SelectedIndex == 6)
            {
                BankDeposit(DrpOrderBooker.SelectedValue);
            }
            else if (DrpAccountType.SelectedIndex == 5)
            {
                this.AdvanceReturn();
            }
            else if (DrpAccountType.SelectedIndex == 3)
            {
                this.IncomeTax();
                this.SelectCreditInvoice();

            }
            else if (DrpAccountType.SelectedIndex == 4)
            {
                this.CreditTransferOut();
                this.SelectCreditInvoice();
            }
            else if (DrpAccountType.SelectedIndex == 7)
            {
                this.SaleForceCashReceived();
                this.LoadSaleFoceCash();
            }
            else
            {
                this.PettyCash();
            }
            this.ClearAll();
            this.LoadGrid();
            this.SetTableSorter();
        }
    }

    /// <summary>
    /// Saves Sale Force Cash
    /// </summary>
    private void SaleForceCashReceived()
    {
        try
        {
            SaleForceController mSaleForce = new SaleForceController();
            Convert.ToDecimal(txtAmount.Text);
            mSaleForce.InsertSaleForceCash(Convert.ToInt32(drpDistributor.SelectedValue), 0, Convert.ToInt32(DrpDeliveryMan.SelectedValue), Convert.ToDateTime(this.Session["CurrentWorkDate"]), Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(this.Session["UserId"]));
            
        }
        catch (Exception)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Amount must be decimal')", true); 
        }
    }

    /// <summary>
    /// Deletes Sale Force Cash
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void gvSaleForceCash_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SaleForceController mSaleForce = new SaleForceController();

        if (mSaleForce.DeleteSaleForceCash(Convert.ToInt32(gvSaleForceCash.Rows[e.RowIndex].Cells[0].Text), Convert.ToInt32(drpDistributor.SelectedValue), Convert.ToInt32(gvSaleForceCash.Rows[e.RowIndex].Cells[1].Text), Convert.ToInt32(gvSaleForceCash.Rows[e.RowIndex].Cells[3].Text)))
        {
            this.LoadSaleFoceCash();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Some error occured. Cash received not deleted.');", true);
        }
        this.SetTableSorter();
    }

    /// <summary>
    /// Sets Sale Force Cash For Edit. This Function Runs When An Existing Sale Force Cash Needs To Be Edited
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void gvSaleForceCash_RowEditing(object sender, GridViewEditEventArgs e)
    {
        DrpDeliveryMan.SelectedValue = gvSaleForceCash.Rows[e.NewEditIndex].Cells[3].Text;
        txtAmount.Text = gvSaleForceCash.Rows[e.NewEditIndex].Cells[6].Text;

        hfSALE_FORCE_CASH_ID.Value = gvSaleForceCash.Rows[e.NewEditIndex].Cells[0].Text;
        hfPRINCIPAL_ID.Value = gvSaleForceCash.Rows[e.NewEditIndex].Cells[1].Text;
        hfDELIVERYMAN_ID.Value = gvSaleForceCash.Rows[e.NewEditIndex].Cells[3].Text;

        btnSave.Text = "Update";
        this.SetTableSorter();
    }

    /// <summary>
    /// Loads Sale Force Cash To Grid
    /// </summary>
    private void LoadSaleFoceCash()
    {
        SaleForceController mSaleForce = new SaleForceController();
        gvSaleForceCash.DataSource = null;
        gvSaleForceCash.DataBind();

        DataTable dt = mSaleForce.GetSaleForceCash(Convert.ToInt32(drpDistributor.SelectedValue), Constants.IntNullValue, Convert.ToInt32(DrpDeliveryMan.SelectedValue), Convert.ToDateTime(this.Session["CurrentWorkDate"]), Convert.ToDateTime(this.Session["CurrentWorkDate"]));
        gvSaleForceCash.DataSource = dt;
        gvSaleForceCash.DataBind();
        gvSaleForceCash.Visible = true;
        GrdOrder.Visible = false;
    }

    /// <summary>
    /// Loads Bank Transactions
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpDeliveryMan_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.DrpAccountType.SelectedIndex == 7)
        {
            this.LoadSaleFoceCash();
        }
        else
        {
            gvSaleForceCash.Visible = false;
            GrdOrder.Visible = true;
        }
    }

    protected void DrpOrderBooker_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadGrid();
    }

    /// <summary>
    /// Hides/Shows Controls
    /// </summary>
    /// <param name="Visible"></param>
    private void HideShowControls(bool Visible)
    {
        if (this.DrpAccountType.SelectedIndex == 2)
        {
            Label2.Enabled = Visible;
            DrpRoute.Enabled = Visible;
            Label4.Enabled = Visible;
            DrpCustomer.Enabled = Visible;
            Panel1.Enabled = Visible;
            Label7.Enabled = Visible;
            DrpAccountDetail.Enabled = true;
            Label10.Enabled = Visible;
            DrpDeliveryMan.Enabled = Visible;
        }
        else
        {
            Label2.Enabled = Visible;
            DrpRoute.Enabled = Visible;
            Label4.Enabled = Visible;
            DrpCustomer.Enabled = Visible;
            Panel1.Enabled = Visible;
            Label7.Enabled = Visible;
            DrpAccountDetail.Enabled = Visible;
            Label5.Enabled = Visible;
            Label3.Enabled = Visible;
            txtChequeNo.Enabled = Visible;
            txtSlipNo.Enabled = Visible;
            Label9.Enabled = Visible;
            txtRemarks.Enabled = Visible;
            Label10.Enabled = true;
            DrpDeliveryMan.Enabled = true;
        }
    }

    /// <summary>
    /// Sets Grids Columns For JQury Sorting
    /// </summary>
    private void SetTableSorter()
    {
        if (GrdOrder.Rows.Count > 1)
        {
            GrdOrder.UseAccessibleHeader = true;
            GrdOrder.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        if (gvSaleForceCash.Rows.Count > 1)
        {
            gvSaleForceCash.UseAccessibleHeader = true;
            gvSaleForceCash.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    private bool IsDayClosed()
    {
        bool flag = false;
        DistributorController DistrCtl = new DistributorController();
        DataTable dtDayClose = DistrCtl.MaxDayClose(Convert.ToInt32(drpDistributor.SelectedValue), 3);
        if (Convert.ToDateTime(Session["CurrentWorkDate"]) <= Convert.ToDateTime(dtDayClose.Rows[0]["DayClose"]))
        {
            flag = false;
        }
        else
        {
            flag = true;
        }

        return flag;
    }

    /// <summary>
    /// Shows Vouchers in Crystal Report For Print Purpose
    /// </summary>
    /// <param name="VoucherNo">Voucher</param>
    private void PrintVoucher(long VoucherNo, int VoucherTypeID, int PaymentMode)
    {
        DocumentPrintController DPrint = new DocumentPrintController();
        ChequeEntryController CController = new ChequeEntryController();
        CrystalDecisions.CrystalReports.Engine.ReportDocument SubReport = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
        SAMSBusinessLayer.Reports.CrpVoucherView2 CrpReport = new SAMSBusinessLayer.Reports.CrpVoucherView2();
        SubReport = CrpReport.OpenSubreport("srInvoiceDetail");


        DataSet ds = null;
        DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));
        ds = CController.GetPaymentVoucher(Convert.ToInt64(DrpCustomer.SelectedValue), Convert.ToInt32(drpDistributor.SelectedValue),Convert.ToDateTime(Session["CurrentWorkDate"]), Convert.ToDateTime(Session["CurrentWorkDate"]), VoucherNo, VoucherTypeID, PaymentMode);
        CrpReport.SetDataSource(ds);
        SubReport.SetDataSource(ds);
        CrpReport.Refresh();

        CrpReport.SetParameterValue("Company_Name", dt.Rows[0]["COMPANY_NAME"].ToString());
        CrpReport.SetParameterValue("DISTRIBUTOR_NAME", dt.Rows[0]["DISTRIBUTOR_NAME"].ToString());
        CrpReport.SetParameterValue("PrintedBy", Session["UserName2"].ToString());
        this.Session.Add("CrpReport", CrpReport);
        this.Session.Add("ReportType", 0);
        string url = "'Default.aspx'";
        string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
        Type cstype = this.GetType();
        ClientScriptManager cs = Page.ClientScript;
        cs.RegisterStartupScript(cstype, "OpenWindow", script);
    }
}