using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// From To Take Order, Invoice And Sale Return(Step1)
/// </summary>
public partial class Forms_frmOrderEntryStep1 : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function Populates All Combos On The Page
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadDistributor();            
            LoadArea();
            LoadOrderBooker();
            LoadDeliveryman();
//            DateTime pOrderDate = DateTime.Parse(Session["CurrentWorkDate"].ToString()).AddDays(1);
            DateTime pOrderDate = DateTime.Parse(Session["CurrentWorkDate"].ToString());
            txtToDate.Text = pOrderDate.ToString("dd-MMM-yyyy");
            txtToDate.Attributes.Add("readonly", "readonly");
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
    /// Loads Routes To Route Combo, Orderbookers To Orderbooker Combo And Deliverymen To Deliveryman Comob
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadArea();
        LoadOrderBooker();
        LoadDeliveryman();
    }
    
    /// <summary>
    /// Loads Routes To Route Combo
    /// </summary>
    private void LoadArea()
    {
        if (drpDistributor.Items.Count > 0)
        {
            DistributorAreaController mController = new DistributorAreaController();
            DataTable dt = mController.SelectDist_Area(Constants.LongNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(drpDistributor.SelectedValue.ToString()),Constants.IntNullValue, null, null);
            clsWebFormUtil.FillDropDownList(DrpRoute, dt, 0, 6, true);
        }
        else
        {
            DrpRoute.Items.Clear();
        }
    }

    /// <summary>
    /// Loads Orderbookers To Orderbooker Combo And Deliverymen To Deliveryman Comob
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void DrpRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadOrderBooker();
        LoadDeliveryman();
    }

    /// <summary>
    /// Loads Orderbookers To Orderbooker Combo
    /// </summary>
    private void LoadOrderBooker()
    {
        if (drpDistributor.Items.Count > 0 && DrpRoute.Items.Count > 0 )
        {
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(Constants.SALES_FORCE_ORDERBOOKER, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), int.Parse(Session["CompanyId"].ToString()), Constants.IntNullValue);
            clsWebFormUtil.FillDropDownList(DrpOrderBooker, m_dt, 0, 3, true);
        }
        else
        {
            DrpOrderBooker.Items.Clear();
        }
    }

    /// <summary>
    /// Loads Deliverymen To Deliveryman Combo
    /// </summary>
    private void LoadDeliveryman()
    {
        if (drpDistributor.Items.Count > 0 && DrpRoute.Items.Count > 0)
        {
            SaleForceController mDController = new SaleForceController();
            DataTable m_dt = mDController.SelectSaleForceAssignedArea(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()), int.Parse(Session["CompanyId"].ToString()));
            clsWebFormUtil.FillDropDownList(DrpDeliveryMan, m_dt, 0, 3, true);
        }
        else
        {
            DrpDeliveryMan.Items.Clear();
        }
    }

    /// <summary>
    /// Checks/UnChecks All Orders In Order Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        if (cbAll.Checked == true)
        {
            foreach (GridViewRow dr in GrdOrder.Rows)
            {
                CheckBox ChbInvoice = (CheckBox)dr.FindControl("ChbInvoice");
                ChbInvoice.Checked = true;
            }
        }
        else
        {
            foreach (GridViewRow dr in GrdOrder.Rows)
            {
                CheckBox ChbInvoice = (CheckBox)dr.FindControl("ChbInvoice");
                ChbInvoice.Checked = false;
            }
        }
    }

    /// <summary>
    /// Loads Order Grid
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnGetOrder_Click(object sender, EventArgs e)
    {
        if (DrpOrderBooker.Items.Count > 0)
        {
            LoadPendingOrder();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Select Orderbooker');", true);
        }
    }

    /// <summary>
    /// Loads Order Grid
    /// </summary>
    private void LoadPendingOrder()
    {
        OrderEntryController or = new OrderEntryController();
        DataTable dtOrder = or.SelectPendingOrder(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(DrpRoute.SelectedValue.ToString()),
            Constants.IntNullValue, int.Parse(DrpOrderBooker.SelectedValue.ToString()), int.Parse(DrpDeliveryMan.SelectedValue.ToString()),
            Constants.Order_Pending_Id, int.Parse(ddSearchType.SelectedValue.ToString()), int.Parse(Session["UserId"].ToString()), Convert.ToDateTime(txtToDate.Text));
        GrdOrder.DataSource = dtOrder;
        GrdOrder.DataBind(); 
        
    }

    /// <summary>
    /// Stores Related Data To Session Variables And Redirects To Order/Invoice Step 2
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (Convert.ToDateTime(txtToDate.Text) < Convert.ToDateTime(Session["CurrentWorkDate"]))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Invalid Working Date');", true);
            return;
        }

        if (DrpOrderBooker.Items.Count > 0)
        {
            if (drpDistributor.Items.Count > 0 && DrpRoute.Items.Count > 0 && DrpDeliveryMan.Items.Count > 0)
            {
                Session.Add("DistributorId", int.Parse(drpDistributor.SelectedValue.ToString()));
                Session.Add("AreaId", long.Parse(DrpRoute.SelectedValue.ToString()));
                Session.Add("Route", DrpRoute.SelectedItem.Text);
                Session.Add("SaleMan", DrpDeliveryMan.SelectedItem.Text);
                Session.Add("OrderDate", Convert.ToDateTime(txtToDate.Text).ToString("dd-MMM-yyyy"));



                if (DrpDocumentType.SelectedIndex == 0)
                {
                    Session.Add("OrderNo", 0);
                    Session.Add("OrderBookerId", int.Parse(DrpOrderBooker.SelectedValue.ToString()));
                    Session.Add("DeliveryManId", int.Parse(DrpDeliveryMan.SelectedValue.ToString()));
                }
                else if (DrpDocumentType.SelectedIndex == 1)
                {
                    Session.Add("OrderNo", -1);
                    Session.Add("OrderBookerId", int.Parse(DrpOrderBooker.SelectedValue.ToString()));
                    Session.Add("DeliveryManId", int.Parse(DrpDeliveryMan.SelectedValue.ToString()));
                }
                else
                {
                    Session.Add("OrderNo", -2);
                    Session.Add("OrderBookerId", int.Parse(DrpOrderBooker.SelectedValue.ToString()));
                    Session.Add("DeliveryManId", int.Parse(DrpDeliveryMan.SelectedValue.ToString()));
                }
                Response.Redirect("~/Forms/frmOrderEntry.aspx?Status=" + false + "&LevelType=3&LevelID=" + Request.QueryString["LevelID"].ToString());
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Select Orderbooker');", true);
        }
    }

    /// <summary>
    /// Converts Checked Orders In Order Grid To Invoices
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (DrpOrderBooker.Items.Count > 0)
        {
            if (IsDayClosed())
            {
                UserController UserCtl = new UserController();

                UserCtl.InsertUserLogoutTime(Convert.ToInt32(Session["User_Log_ID"]), Convert.ToInt32(Session["UserID"]));
                Session.Clear();
                System.Web.Security.FormsAuthentication.SignOut();
                Response.Redirect("../Login.aspx");
            }
            else
            {
                CustomerDataController CDC = new CustomerDataController();
                OrderEntryController ORD = new OrderEntryController();
                DataControl dc = new DataControl();
                DataTable dtStock;
                GrdFreeSKU.Visible = false;
                gvRateDifference.Visible = false;
                foreach (GridViewRow dr in GrdOrder.Rows)
                {
                    CheckBox ChbInvoice = (CheckBox)dr.FindControl("ChbInvoice");
                    if (ChbInvoice.Checked == true)
                    {
                        if (Convert.ToDateTime(Session["CurrentWorkDate"]) >= Convert.ToDateTime(ConvertDate.British_To_American2(dr.Cells[5].Text)))
                        {
                            if (int.Parse(ddSearchType.SelectedValue.ToString()) == Constants.Cash_Order_Id)
                            {
                                dtStock = ORD.ConvertOrder_to_Invoice2(int.Parse(drpDistributor.SelectedValue.ToString()), dr.Cells[12].Text, long.Parse(dr.Cells[0].Text), 0,
                                long.Parse(dr.Cells[4].Text), DateTime.Parse(Session["CurrentWorkDate"].ToString()), decimal.Parse(dc.chkNull_0(dr.Cells[6].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[7].Text)),
                                decimal.Parse(dc.chkNull_0(dr.Cells[8].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[9].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[10].Text)), Constants.Order_Posted_Id, Constants.Cash_Order_Id, int.Parse(Session["UserId"].ToString()), dr.Cells[13].Text);

                                if (dtStock.Columns.Count > 1)
                                {
                                    if (dtStock.Columns.Count == 7)
                                    {
                                        gvRateDifference.DataSource = dtStock;
                                        gvRateDifference.DataBind();
                                        gvRateDifference.Visible = true;
                                    }
                                    else
                                    {
                                        GrdFreeSKU.DataSource = dtStock;
                                        GrdFreeSKU.DataBind();
                                        GrdFreeSKU.Visible = true;
                                    }
                                    LoadPendingOrder();
                                    return;
                                }

                            }
                            else
                            {
                                DataTable dt = CDC.SelectCustomerCreditBalance(long.Parse(dr.Cells[0].Text),Constants.IntNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(ddSearchType.SelectedValue.ToString()));
                                //if (decimal.Parse(dc.chkNull_0(dt.Rows[0][0].ToString())) >= decimal.Parse(dr.Cells[10].Text))
                                //{
                                    dtStock = ORD.ConvertOrder_to_Invoice2(int.Parse(drpDistributor.SelectedValue.ToString()), dr.Cells[12].Text, long.Parse(dr.Cells[0].Text), 0,
                                       long.Parse(dr.Cells[4].Text), DateTime.Parse(Session["CurrentWorkDate"].ToString()), decimal.Parse(dc.chkNull_0(dr.Cells[6].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[7].Text)),
                                       decimal.Parse(dc.chkNull_0(dr.Cells[8].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[9].Text)), decimal.Parse(dc.chkNull_0(dr.Cells[10].Text)), Constants.Order_Posted_Id, int.Parse(ddSearchType.SelectedValue.ToString()), int.Parse(Session["UserId"].ToString()), dr.Cells[13].Text);

                                    if (dtStock.Columns.Count > 1)
                                    {
                                        if (dtStock.Columns.Count == 7)
                                        {
                                            gvRateDifference.DataSource = dtStock;
                                            gvRateDifference.DataBind();
                                            gvRateDifference.Visible = true;
                                        }
                                        else
                                        {
                                            GrdFreeSKU.DataSource = dtStock;
                                            GrdFreeSKU.DataBind();
                                            GrdFreeSKU.Visible = true;
                                        }
                                        LoadPendingOrder();
                                        return;
                                    }
                                //}
                                //else
                                //{
                                //    ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Error in Order#  " + dr.Cells[4].Text + " Customer Credit Limit " + dc.chkNull_0(dt.Rows[0][0].ToString()) + "');", true);
                                //}
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Order Date Can not be greater than current working date');", true);
                            break;
                        }
                    }
                }
                LoadPendingOrder();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('Select Orderbooker');", true);
        }        
     
    }

    private bool IsDayClosed()
    {
        bool flag = false;
        DistributorController DistrCtl = new DistributorController();
        DataTable dtDayClose = DistrCtl.MaxDayClose(Convert.ToInt32(Session["DISTRIBUTOR_ID"]), 3);
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
}