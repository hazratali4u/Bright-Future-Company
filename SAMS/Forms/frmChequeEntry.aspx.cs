using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form To Add, Edit Cheques
/// </summary>
public partial class Forms_frmChequeEntry : System.Web.UI.Page
{
    LedgerController LController = new LedgerController();
    readonly ChequeEntryController _cEntryController = new ChequeEntryController();
    /// <summary>
    /// Page_Load Function Populates All Combos, ListBox And Grid On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DateTime pOrderDate = DateTime.Parse(Session["CurrentWorkDate"].ToString());
            txtToDate.Text = pOrderDate.ToString("dd-MMM-yyyy");
            txtFromDate.Text = pOrderDate.ToString("dd-MMM-yyyy");



            SAMSCommon.Classes.Configuration.GetAccountHead();
            DrpStatus.Items.Add(new ListItem("Cheque Received", "527"));
            DrpStatus.Items.Add(new ListItem("Cheque Deposit", "528"));
            DrpStatus.Items.Add(new ListItem("Cheque Realize", "529"));
            DrpStatus.Items.Add(new ListItem("Cheque Bounce", "530"));
            DrpStatus.Items.Add(new ListItem("Cheque Cancel", "560"));
            this.LoadAccountHead();
            this.LoadDistributor();
            this.LoadArea();
            this.LoadOrderBooker();
            this.LoadData();
            this.SelectCreditInvoice();
            this.LoadReceviedCheque();
          //  this.LoadDeliveryman();
            btnSave.Attributes.Add("onclick", "return ValidateForm();");
            txtStartDate.Text = Convert.ToDateTime(Session["CurrentWorkDate"]).ToString("dd-MMM-yyyy");

            //
            LoadDropdownConvertto();
            lblStatusConvertTo.Visible = false;
            DrpStatusConvertTo.Visible = false;

            lblBankAccount.Visible = false;
            DrpBankAccount.Visible = false;

            //

        }
    }


    private void LoadDropdownConvertto()
    {
        DrpStatusConvertTo.Items.Clear();
        // DrpStatusConvertTo.Items.Add(new ListItem("Cheque Received", "527"));
        DrpStatusConvertTo.Items.Add(new ListItem("Cheque Deposit", "528"));
        DrpStatusConvertTo.Items.Add(new ListItem("Cheque Realize", "529"));
        DrpStatusConvertTo.Items.Add(new ListItem("Cheque Bounce", "530"));
        DrpStatusConvertTo.Items.Add(new ListItem("Cheque Cancel", "560"));
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
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(Constants.SALES_FORCE_ORDERBOOKER, int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, int.Parse(this.Session["CompanyId"].ToString()), Constants.IntNullValue);
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
        CustomerDataController mController = new CustomerDataController();

        if (DrpChequeType.SelectedIndex == 1)
        {
            DataTable dtCustomer = mController.SelectPrincipalCustomer(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue);
            clsWebFormUtil.FillDropDownList(this.DrpCustomer, dtCustomer, 0, 4, true);
            //DrpRoute.Enabled = true;
        }
        else
        {
            if (drpDistributor.Items.Count > 0)
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
        txtBankName.Text = "";
        txtStartDate.Text = "";
        btnSave.Text = "Save";
        txtReceivedDate.Text = "";
        txtSlipNo.Text = "";
        txtRemarks.Text = "";

    }
    
    /// <summary>
    /// Loads Cheques To Grid
    /// </summary>
    private void LoadReceviedCheque()
    {
        if (DrpStatus.SelectedValue.ToString() != Constants.Cheque_Clear.ToString())
        {
            ChequeEntryController CController = new ChequeEntryController();
            DataTable dt = CController.SelectChequeEntry(int.Parse(DrpStatus.SelectedValue.ToString()), DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, DrpChequeType.SelectedIndex);
            this.Session.Add("dt", dt);
            GrdOrder.DataSource = dt;
            GrdOrder.DataBind();
        }
        else
        {
            GrdOrder.DataSource = null;
            GrdOrder.DataBind();
        }
    }

    /// <summary>
    /// Loads Crdit Invoices To Grid
    /// </summary>
    private void SelectCreditInvoice()
    {        
        GrdCredit.DataSource = null;
        GrdCredit.DataBind();
        if (DrpCustomer.Items.Count > 0 && DrpChequeType.SelectedIndex != 1)
        {
            DataTable dtCredit = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(DrpCustomer.SelectedValue.ToString()), 0);
            GrdCredit.DataSource = dtCredit;
            GrdCredit.DataBind();
        }
    }
    
    /// <summary>
    /// Saves Cheque Realization
    /// </summary>
    private void ChequeRealization()
    {        
        string MaxDocumentId = LController.SelectLedgerMaxDocumentId(Constants.Bank_Voucher, int.Parse(drpDistributor.SelectedValue.ToString()));
        decimal OfferAmount = decimal.Parse(txtAmount.Text);
        if (DrpChequeType.SelectedIndex == 0)
        {
            if (GrdCredit.Rows.Count > 0)
            {
                //DataTable dtCreditSKU = LController.SelectCreditPendingInvoice(int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, long.Parse(DrpCustomer.SelectedValue.ToString()), -1);

                foreach (GridViewRow dr in GrdCredit.Rows)
                {
                    CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                    if (chRelized.Checked == true)
                    {
                        if (decimal.Parse(dr.Cells[3].Text) >= OfferAmount)
                        {
                          //  DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                          //  if (foundrows.Length > 0)
                          //  {
                              //  foreach (DataRow drSKU in foundrows)
                               // {
                                 //   decimal SKUPer = OfferAmount * Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) / decimal.Parse(dr.Cells[3].Text);
                                  //  if (SKUPer > 0)
                                   // {
                                        LController.PostingCash_Bank_AccountNew(Constants.Bank_Voucher, long.Parse(MaxDocumentId), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, OfferAmount,
                                        DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Relization" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                        txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 18, DrpOrderBooker.SelectedValue.ToString(), 0);

                                        LController.PostingCash_Bank_AccountNew(Constants.Bank_Voucher, long.Parse(MaxDocumentId), long.Parse(DrpBankAccount.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), OfferAmount, 0,
                                        DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Relization" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                        txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 18, DrpOrderBooker.SelectedValue.ToString(), 0);

                                        LController.UpdateCreditInvoice(Convert.ToInt64(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), OfferAmount, 0, Convert.ToInt32(Session["UserID"]));
                                  //  }
                                //}
                           // }

                            OfferAmount = decimal.Parse(dr.Cells[3].Text) - OfferAmount;
                            break;
                        }
                        else if (decimal.Parse(dr.Cells[3].Text) <= OfferAmount)
                        {
                            //DataRow[] foundrows = dtCreditSKU.Select("SALE_INVOICE_ID =" + GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"].ToString());
                          //  if (foundrows.Length > 0)
                           // {
                               // foreach (DataRow drSKU in foundrows)
                               // {
                                   // if (Convert.ToDecimal(drSKU["CURRENT_CREDIT_AMOUNT"]) > 0)
                                   // {
                                       LController.PostingCash_Bank_AccountNew(Constants.Bank_Voucher, long.Parse(MaxDocumentId), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, Convert.ToDecimal(dr.Cells[3].Text),
                                        DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Relization" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                        txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 18, DrpOrderBooker.SelectedValue.ToString(), 0);

                                        LController.PostingCash_Bank_AccountNew(Constants.Bank_Voucher, long.Parse(MaxDocumentId), long.Parse(DrpBankAccount.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), Convert.ToDecimal(dr.Cells[3].Text), 0,
                                        DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Relization" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                                        txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), dr.Cells[1].Text, Constants.Document_Invoice, txtSlipNo.Text, Constants.DateNullValue, 18, DrpOrderBooker.SelectedValue.ToString(), 0);


                                        LController.UpdateCreditInvoice(Convert.ToInt64(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]), Convert.ToDecimal(dr.Cells[3].Text), 0, Convert.ToInt32(Session["UserID"]));

                                        OfferAmount = OfferAmount - Convert.ToDecimal(dr.Cells[3].Text);
                            // }
                               // }
                           // }
                        }
                    }
                }
            }
        }
        else
        {
            LController.PostingCash_Bank_Account(Constants.Bank_Voucher, long.Parse(MaxDocumentId), Convert.ToInt64(SAMSCommon.Classes.Configuration.AccountReceivable), int.Parse(drpDistributor.SelectedValue.ToString()), 0, decimal.Parse(txtAmount.Text),
                DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Advance" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Constants.LongNullValue, null, Constants.IntNullValue, txtSlipNo.Text, Constants.DateNullValue, 20, DrpOrderBooker.SelectedValue.ToString());

            LController.PostingCash_Bank_Account(Constants.Bank_Voucher, long.Parse(MaxDocumentId), long.Parse(DrpBankAccount.SelectedValue.ToString()), int.Parse(drpDistributor.SelectedValue.ToString()), decimal.Parse(txtAmount.Text), 0,
                DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), "Cheque Advance" + "(" + txtChequeNo.Text + ")", DateTime.Now, int.Parse(DrpCustomer.SelectedValue.ToString()), 0,
                txtChequeNo.Text, int.Parse(this.Session["UserId"].ToString()), Constants.LongNullValue, null, Constants.IntNullValue, txtSlipNo.Text, Constants.DateNullValue, 20, DrpOrderBooker.SelectedValue.ToString());
        }
    }
    
    /// <summary>
    /// Loads Deliverymen To Deliverman Comb
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
    /// Loads Account Heads To Account Combo
    /// </summary>
    private void LoadAccountHead()
    {
        SAMSCommon.Classes.Configuration.GetAccountHead();
        AccountHeadController mAccountController = new AccountHeadController();
        DataTable dt = mAccountController.SelectAccountHead(Constants.AC_AccountHeadId, long.Parse(SAMSCommon.Classes.Configuration.BankDefaultType));
        clsWebFormUtil.FillDropDownList(DrpBankAccount, dt, 0, 4, true);
    }

    /// <summary>
    /// Save Or Updates a Cheque
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

            ChequeEntryController CController = new ChequeEntryController();

            DateTime ChequeDate;

            if (txtStartDate.Text.Length > 0)
            {
                ChequeDate = DateTime.Parse(txtStartDate.Text);

            }
            else
            {
                ChequeDate = DateTime.Now;
            }

           

            if (btnSave.Text == "Save")
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

                if (DrpStatus.SelectedIndex == 0)
                {
                    HFChqueProcessId.Value = CController.InsertChequeEntry(int.Parse(drpDistributor.SelectedValue.ToString()), 0, long.Parse(DrpCustomer.SelectedValue.ToString()), txtChequeNo.Text, txtBankName.Text, ChequeDate,
                        DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), Constants.DateNullValue, Constants.DateNullValue, decimal.Parse(txtAmount.Text), int.Parse(DrpStatus.SelectedValue.ToString()), DateTime.Now, DrpChequeType.SelectedIndex, txtSlipNo.Text, txtRemarks.Text, long.Parse(DrpBankAccount.SelectedValue.ToString()));


                    foreach (GridViewRow dr in GrdCredit.Rows)
                    {
                        CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                        if (chRelized.Checked == true)
                        {
                            CController.InsertChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]));
                        }
                    }

                    this.PrintVoucher(Convert.ToInt64(HFChqueProcessId.Value), Constants.IntNullValue, 0);
                }
                this.ClearAll();
                this.LoadReceviedCheque();

            }
            else if (btnSave.Text == "Edit")
            {
                #region Cheque Pending

                if (int.Parse(DrpStatus.SelectedValue.ToString()) == Constants.Cheque_Pending)
                    //&& txtReceivedDate.Text == DateTime.Parse(this.Session["CurrentWorkDate"].ToString()).ToString("dd/MM/yyyy"))
                {
                    CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), int.Parse(drpDistributor.SelectedValue.ToString()), 0, long.Parse(DrpCustomer.SelectedValue.ToString()), txtChequeNo.Text, txtBankName.Text, ChequeDate, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), Constants.DateNullValue, Constants.DateNullValue,
                       decimal.Parse(txtAmount.Text), int.Parse(DrpStatus.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, int.Parse(DrpBankAccount.SelectedValue.ToString()));

                    CController.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), 1);

                    foreach (GridViewRow dr in GrdCredit.Rows)
                    {
                        CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                        if (chRelized.Checked == true)
                        {
                            CController.InsertChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]));
                        }
                    }
                }
                #endregion
                #region cheque deposit
                else if (int.Parse(DrpStatus.SelectedValue.ToString()) == Constants.Cheque_Deposit)
                {
                    CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), Constants.DateNullValue,
                         Constants.DecimalNullValue, int.Parse(DrpStatus.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, int.Parse(DrpBankAccount.SelectedValue.ToString()));
                }
                #endregion
                #region cheque bons or cancel
                else if (int.Parse(DrpStatus.SelectedValue.ToString()) == Constants.Cheque_Bons
                    || int.Parse(DrpStatus.SelectedValue.ToString()) == Constants.Cheque_Cancel)
                {
                    CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()),
                                                     Constants.DecimalNullValue, int.Parse(DrpStatus.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, long.Parse(DrpBankAccount.SelectedValue.ToString()));

                }
                #endregion
                #region cheque clear
                else if (int.Parse(DrpStatus.SelectedValue.ToString()) == Constants.Cheque_Clear)
                {

                    CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()),
                                                     Constants.DecimalNullValue, int.Parse(DrpStatus.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, long.Parse(DrpBankAccount.SelectedValue.ToString()));

                    CController.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), 1);

                    foreach (GridViewRow dr in GrdCredit.Rows)
                    {
                        CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                        if (chRelized.Checked == true)
                        {
                            CController.InsertChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]));
                        }
                    }

                

                    this.ChequeRealization();
                    this.LoadData();
                    this.SelectCreditInvoice();
                }
                #endregion

                this.ClearAll();
                this.LoadReceviedCheque();
            }
            else
            {

                foreach (GridViewRow drow in GrdOrder.Rows)
                {


                    CheckBox chSelect = (CheckBox)drow.Cells[0].FindControl("ChbIsSelect");
                    if (chSelect.Checked == true)
                    {
                        HFChqueProcessId.Value = drow.Cells[0].Text;
                        #region cheque Pending

                        if (int.Parse(DrpStatusConvertTo.SelectedValue.ToString()) == Constants.Cheque_Pending
                            && txtReceivedDate.Text ==
                            DateTime.Parse(this.Session["CurrentWorkDate"].ToString()).ToString("dd/MM/yyyy"))
                        {
                            CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), int.Parse(drpDistributor.SelectedValue.ToString()), 0, long.Parse(DrpCustomer.SelectedValue.ToString()), txtChequeNo.Text, txtBankName.Text, ChequeDate, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), Constants.DateNullValue, Constants.DateNullValue,
                               decimal.Parse(txtAmount.Text), int.Parse(DrpStatusConvertTo.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, int.Parse(DrpBankAccount.SelectedValue.ToString()));

                            CController.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), 1);

                            foreach (GridViewRow dr in GrdCredit.Rows)
                            {
                                CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                                if (chRelized.Checked == true)
                                {
                                    CController.InsertChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]));
                                }
                            }
                        }
                        #endregion
                        #region cheque deposit
                        else if (int.Parse(DrpStatusConvertTo.SelectedValue.ToString()) == Constants.Cheque_Deposit)
                        {
                            CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()), Constants.DateNullValue,
                                 Constants.DecimalNullValue, int.Parse(DrpStatusConvertTo.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, int.Parse(DrpBankAccount.SelectedValue.ToString()));
                        }
                        #endregion
                        #region cheque bons or cancel
                        else if (int.Parse(DrpStatusConvertTo.SelectedValue.ToString()) == Constants.Cheque_Bons
                            || int.Parse(DrpStatusConvertTo.SelectedValue.ToString()) == Constants.Cheque_Cancel)
                        {
                            CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()),
                                                             Constants.DecimalNullValue, int.Parse(DrpStatusConvertTo.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, long.Parse(DrpBankAccount.SelectedValue.ToString()));

                        }
                        #endregion
                        #region cheque clear
                        else if (int.Parse(DrpStatusConvertTo.SelectedValue.ToString()) == Constants.Cheque_Clear)
                        {

                            CController.UpdateChequeEntry(long.Parse(HFChqueProcessId.Value), Constants.IntNullValue, Constants.IntNullValue, Constants.LongNullValue, null, null, Constants.DateNullValue, Constants.DateNullValue, Constants.DateNullValue, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()),
                                                             Constants.DecimalNullValue, int.Parse(DrpStatusConvertTo.SelectedValue.ToString()), Constants.DateNullValue, txtSlipNo.Text, DrpChequeType.SelectedIndex, txtRemarks.Text, long.Parse(DrpBankAccount.SelectedValue.ToString()));

                            CController.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value),0);

                            foreach (GridViewRow dr in GrdCredit.Rows)
                            {
                                CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                                if (chRelized.Checked == true)
                                {
                                    CController.InsertChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]));
                                }
                            }


                            #region Load data on edit button

                            HFChqueProcessId.Value = drow.Cells[0].Text;
                            DrpRoute.SelectedValue = drow.Cells[12].Text;
                            LoadData();
                            DrpCustomer.SelectedValue = drow.Cells[1].Text;
                            txtChequeNo.Text = drow.Cells[4].Text;
                            txtBankName.Text = drow.Cells[5].Text;
                            txtStartDate.Text = drow.Cells[6].Text;
                            txtReceivedDate.Text = drow.Cells[7].Text;
                            txtAmount.Text = drow.Cells[9].Text;
                            txtSlipNo.Text = drow.Cells[10].Text.Replace("&nbsp;", "");
                            txtRemarks.Text = drow.Cells[11].Text.Replace("&nbsp;", "");
                            DrpBankAccount.SelectedValue = drow.Cells[14].Text;
                            try
                            {

                               // DrpDeliveryMan.SelectedValue = drow.Cells[15].Text;
                                DrpOrderBooker.SelectedValue = drow.Cells[16].Text;
                            }
                            catch
                            {
                            }
                            this.SelectCreditInvoice();

                            DataTable dt = _cEntryController.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), 0);

                            foreach (GridViewRow dr in GrdCredit.Rows)
                            {
                                foreach (DataRow dbr in dt.Rows)
                                {

                                    if (Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]) == Convert.ToInt64(dbr["SALE_INVOICE_ID"]))
                                    {
                                        CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                                        chRelized.Checked = true;
                                    }
                                }
                            }

                            #endregion
                            this.ChequeRealization();
                            this.LoadData();
                            this.SelectCreditInvoice();
                        }
                        #endregion
                       
                    }

                }
                this.ClearAll();
                this.LoadReceviedCheque();
            }
        }
    }

    /// <summary>
    /// Cancels Cheque Entry
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        this.ClearAll();
    }

    /// <summary>
    /// Deletes Cheque
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdOrder_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        ChequeEntryController CController = new ChequeEntryController();
        CController.DeleteChequeEntry(long.Parse(GrdOrder.Rows[e.RowIndex].Cells[0].Text));
        this.LoadReceviedCheque();
    }

    /// <summary>
    /// Loads Credit Invoices
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.SelectCreditInvoice();
    }

    /// <summary>
    /// Loads Routes, Customers, Credit Invoices And Cheques
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadArea();
        this.LoadData();
        this.SelectCreditInvoice();
        this.LoadReceviedCheque();
    }
    
    /// <summary>
    /// Sets Cheque Data For Edit. This Function Runs When An Existing Cheque Needs To Be Edited
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">GridViewEditEventArgs</param>
    protected void GrdOrder_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {   //
            DrpStatus.Enabled = false;
            //
            ChequeEntryController Ccontroller = new ChequeEntryController();
            HFChqueProcessId.Value = GrdOrder.Rows[e.NewEditIndex].Cells[0].Text;
            DrpRoute.SelectedValue = GrdOrder.Rows[e.NewEditIndex].Cells[12].Text;

            this.LoadData();
            DrpCustomer.SelectedValue = GrdOrder.Rows[e.NewEditIndex].Cells[1].Text;
            txtChequeNo.Text = GrdOrder.Rows[e.NewEditIndex].Cells[4].Text;
            txtBankName.Text = GrdOrder.Rows[e.NewEditIndex].Cells[5].Text;
            txtStartDate.Text = GrdOrder.Rows[e.NewEditIndex].Cells[6].Text;
            txtReceivedDate.Text = GrdOrder.Rows[e.NewEditIndex].Cells[7].Text;
            txtAmount.Text = GrdOrder.Rows[e.NewEditIndex].Cells[9].Text;
            txtSlipNo.Text = GrdOrder.Rows[e.NewEditIndex].Cells[10].Text.Replace("&nbsp;","");
            txtRemarks.Text = GrdOrder.Rows[e.NewEditIndex].Cells[11].Text.Replace("&nbsp;", "");
            DrpBankAccount.SelectedValue = GrdOrder.Rows[e.NewEditIndex].Cells[14].Text;
            try
            {
               // DrpDeliveryMan.SelectedValue = GrdOrder.Rows[e.NewEditIndex].Cells[15].Text;
                DrpOrderBooker.SelectedValue = GrdOrder.Rows[e.NewEditIndex].Cells[16].Text;
            }
            catch (Exception ex)
            {
                
            }

            btnSave.Text = "Edit";
            this.SelectCreditInvoice();

            DataTable dt = Ccontroller.SelectChequeEntryInvoice(long.Parse(HFChqueProcessId.Value), 0);

            foreach (GridViewRow dr in GrdCredit.Rows)
            {
                foreach (DataRow dbr in dt.Rows)
                {

                    if (Convert.ToInt64(GrdCredit.DataKeys[dr.RowIndex].Values["SALE_INVOICE_ID"]) == Convert.ToInt64(dbr["SALE_INVOICE_ID"]))
                    {
                        CheckBox chRelized = (CheckBox)dr.Cells[0].FindControl("ChbIsAssigned");
                        chRelized.Checked = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Invoice not found for selected cheque');", true);
        }
    }

    /// <summary>
    /// Loads Cheques
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (int.Parse(DrpStatus.SelectedValue) == Constants.Cheque_Pending)
        {
            DrpStatusConvertTo.Items.Clear();
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Deposit", "528"));
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Realize", "529"));
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Bounce", "530"));
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Cancel", "560"));
        }
        else if (int.Parse(DrpStatus.SelectedValue) == Constants.Cheque_Deposit)
        {
            DrpStatusConvertTo.Items.Clear();

            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Realize", "529"));
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Bounce", "530"));
            DrpStatusConvertTo.Items.Add(new ListItem("Cheque Cancel", "560"));
            for (int i = 0; i < GrdOrder.Columns.Count; i++)
            {
                if (GrdOrder.Columns[i] is CommandField)
                {
                    GrdOrder.Columns[i].Visible = false;
                }
            }
        }
        else
        {
            LoadDropdownConvertto();
        }




        if (btnSave.Text == "Save")
        {            
            this.LoadReceviedCheque();
        }
    }

    /// <summary>
    /// Loads Customers And Cheques
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpChequeType_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadData();
        this.LoadReceviedCheque();
    }

    /// <summary>
    /// Loads Customers And Credit Invoices
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadData();
        this.SelectCreditInvoice();
    }

    /// <summary>
    /// Filters Cheuqe Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)this.Session["dt"];
        switch (ddSearchType.SelectedIndex)
        {
            case 1:
                dt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 2:
                dt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 3:
                dt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 4:
                dt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " like '%" + txtSeach.Text + "%'";
                break;
            case 5:
                 dt = _cEntryController.SelectChequeEntry2(int.Parse(DrpStatus.SelectedValue), DateTime.Parse(txtFromDate.Text + " 00:00:00"), DateTime.Parse(txtToDate.Text + " 23:59:59"), int.Parse(drpDistributor.SelectedValue), Constants .IntNullValue ,int.Parse(this.Session["UserId"].ToString()));
                GrdOrder.DataSource = dt;
                GrdOrder.DataBind();

                // dt.DefaultView.RowFilter = ddSearchType.SelectedValue.ToString() + " = '" + txtSeach.Text + "'";
                   break;
          
            default:
                dt.DefaultView.RowFilter = "CHEQUE_NO" + " like '%" + "" + "%'";
                break;
        }
        GrdOrder.DataSource = dt.DefaultView;
        GrdOrder.DataBind();
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
        ds = CController.GetPaymentVoucher(Convert.ToInt64(DrpCustomer.SelectedValue), Convert.ToInt32(drpDistributor.SelectedValue), Convert.ToDateTime(Session["CurrentWorkDate"]), Convert.ToDateTime(Session["CurrentWorkDate"]), VoucherNo, VoucherTypeID, PaymentMode);
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
    protected void ChbIsSelect_SelectedIndexChanged(object sender, EventArgs e)
    {





        GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
        int index = row.RowIndex;
        CheckBox cb1 = (CheckBox)GrdOrder.Rows[index].FindControl("ChbIsSelect");

        if (cb1.Checked == true)
        {
            #region check
            if (int.Parse(DrpStatus.SelectedValue) == Constants.Cheque_Deposit)
            {
                lblsaleforce.Visible = false;
              //  DrpDeliveryMan.Visible = false;
                DrpOrderBooker.Visible = false;
                lblcustomer.Visible = false;
                DrpCustomer.Visible = false;
                lblroute.Visible = false;
                DrpRoute.Visible = false;
                GrdCredit.Visible = false;
                Panel1.Visible = false;
               
                DrpBankAccount.Enabled = false;
               

               // txtAccountNo.Enabled = false;
              //  lblBankAccount.Visible = true;
                DrpBankAccount.Visible = true;


            }
            DrpStatus.Enabled = false;
            txtChequeNo.ReadOnly = true;
            
            txtAmount.ReadOnly = true;
            txtStartDate.ReadOnly = true;
            lblStatusConvertTo.Visible = true;
            DrpStatusConvertTo.Visible = true;
            btnSave.Text = "Update";
            lblBankAccount.Visible = true;
            DrpBankAccount.Visible = true;
            txtBankName.ReadOnly = true;

            for (int i = 0; i < GrdOrder.Columns.Count; i++)
            {
                if (GrdOrder.Columns[i] is CommandField)
                {
                    GrdOrder.Columns[i].Visible = false;
                }
            }

            #endregion
        }

        else if (cb1.Checked == false)
        {

            #region Unchecked
            if (int.Parse(DrpStatus.SelectedValue) == Constants.Cheque_Deposit)
            {
               // lblsaleforce.Visible = true;
             //   DrpDeliveryMan.Visible = true;
                DrpOrderBooker.Visible = true;
              //  lblcustomer.Visible = true;
                DrpCustomer.Visible = true;
                //lblroute.Visible = true;
                DrpRoute.Visible = true;
                GrdCredit.Visible = true;
                Panel1.Visible = true;
                //DrpPrincipal.Enabled = false;
                DrpBankAccount.Enabled = false;
                //DrpChequeType.Enabled = false;
                //DrpRoute.Enabled = false;

                //txtAccountNo.Enabled = true;
                lblBankAccount.Visible = false;
                DrpBankAccount.Visible = false;
                btnSave.Text = "Save";
            }
            DrpStatus.Enabled = true;
            txtChequeNo.ReadOnly = false;
            //  txtBankName.ReadOnly = true;
         //   DrpCustomerBank.Enabled = true;
            txtAmount.ReadOnly = false;
            txtStartDate.ReadOnly = false;
            lblStatusConvertTo.Visible = false;
            DrpStatusConvertTo.Visible = false;
            
           lblBankAccount.Visible = false;
            DrpBankAccount.Visible = false;
           // txtAccountNo.Enabled = true;


            for (int i = 0; i < GrdOrder.Columns.Count; i++)
            {
                if (GrdOrder.Columns[i] is CommandField)
                {
                    GrdOrder.Columns[i].Visible = true;
                }
            }



            #endregion
        }



    }
}
