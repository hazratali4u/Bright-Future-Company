using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;

/// <summary>
/// Form For Sales & Closing Stock Report
/// </summary>
public partial class Forms_RptDistributorReports : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.DistributorType();
            this.LoadAssingned();
            this.LoadPrincipal();
            this.LoadCategory();
            this.LoadBrand();
            this.LoadSKU();
            SAMSCommon.Classes.Configuration.SystemCurrentDateTime = (DateTime)this.Session["CurrentWorkDate"];
            txtStartDate.Text = SAMSCommon.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
            txtEndDate.Text = SAMSCommon.Classes.Configuration.SystemCurrentDateTime.ToString("dd-MMM-yyyy");
        }
    }

    /// <summary>
    /// Loads Location Types
    /// </summary>
    private void DistributorType()
    {
        DistributorController dController = new DistributorController();
        DataTable dt = dController.SelectDistributorTypeInfo(Constants.IntNullValue);
        clsWebFormUtil.FillDropDownList(ddDistributorType, dt, 0, 2);
    }

    /// <summary>
    /// Loads User Assigned Locations To Location Combo
    /// </summary>
    private void LoadAssingned()
    {
        if (ddDistributorType.Items.Count > 0)
        {
            drpDistributor.Items.Clear();    
            UserController mUserController = new UserController();
            DataTable dt = mUserController.SelectUserAssignment(int.Parse(this.Session["UserId"].ToString()), int.Parse(ddDistributorType.SelectedValue.ToString()), 1, int.Parse(this.Session["CompanyId"].ToString()));
            drpDistributor.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(drpDistributor, dt, 0, 1);
        }
    }

    /// <summary>
    /// Loads Principals To Principal Combo
    /// </summary>
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));        
        clsWebFormUtil.FillListBox(this.cblPrincipal, m_dt, 0, 1);

        foreach (ListItem li in cblPrincipal.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadCategory()
    {
        string PrincipalIDs = null;
        foreach (ListItem li in cblPrincipal.Items)
        {
            if (li.Selected)
            {
                PrincipalIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(1, PrincipalIDs);
        clsWebFormUtil.FillListBox(cblCategory, dt, 0, 1, true);

        foreach (ListItem li in cblCategory.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadBrand()
    {
        string CategoryIDs = null;
        foreach (ListItem li in cblCategory.Items)
        {
            if (li.Selected)
            {
                CategoryIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(2, CategoryIDs);
        clsWebFormUtil.FillListBox(cblBrand, dt, 0, 1, true);

        foreach (ListItem li in cblBrand.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadSKU()
    {
        string BrandIDs = null;
        foreach (ListItem li in cblBrand.Items)
        {
            if (li.Selected)
            {
                BrandIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(3, BrandIDs);
        clsWebFormUtil.FillListBox(cblSKU, dt, 0, 1, true);

        foreach (ListItem li in cblSKU.Items)
        {
            li.Selected = true;
        }
    }

    /// <summary>
    /// Shows Sales & Closing Stock in PDF
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        ShowReport(0);
    }

    protected void DrpReportType_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFromDate.Text = "From Date";
        lblToDate.Visible = true;
        ibnEndDate.Visible = true;
        txtEndDate.Visible = true;

        if (DrpReportType.SelectedValue == "3" || DrpReportType.SelectedValue == "4")
        {
            lblFromDate.Text = "Date";
            lblToDate.Visible = false;
            ibnEndDate.Visible = false;
            txtEndDate.Visible = false;
        }
    }

    /// <summary>
    /// Loads Locations
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void ddDistributorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadAssingned();
    }

    /// <summary>
    /// Shows Sales & Closing Stock in Excel
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        ShowReport(1);
    }

    private void ShowReport(int ReportType)
    {
        System.Text.StringBuilder sbSKUs = new System.Text.StringBuilder();
        foreach (ListItem li in cblSKU.Items)
        {
            if (li.Selected)
            {
                sbSKUs.Append(li.Value);
                sbSKUs.Append(",");
            }
        }

        int TypeID = 0;
        if (cbQuantity.Checked && cbValue.Checked)
        {
            TypeID = 3;
        }
        else if (cbValue.Checked)
        {
            TypeID = 2;
        }
        else if (cbQuantity.Checked)
        {
            TypeID = 1;
        }
        if (TypeID > 0)
        {
            DateTime dtFrom = DateTime.Parse(this.txtStartDate.Text);
            DateTime dtTo = new DateTime();
            if (DrpReportType.SelectedValue == "3" || DrpReportType.SelectedValue == "4")
            {
                dtTo = DateTime.Parse(this.txtStartDate.Text);
            }
            else
            {
                dtTo = DateTime.Parse(this.txtEndDate.Text);
            }
            
            DocumentPrintController mDocumentPrntControl = new DocumentPrintController();
            RptSaleController RptSaleCtl = new RptSaleController();
            DataSet ds = RptSaleCtl.GetRegionSaleDetail(int.Parse(this.ddDistributorType.SelectedItem.Value), sbSKUs.ToString(), Constants.IntNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), dtFrom, dtTo, Constants.IntNullValue, Convert.ToInt32(DrpReportType.SelectedValue), TypeID, int.Parse(this.Session["UserId"].ToString()));
            DataTable dt = mDocumentPrntControl.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));

            CrystalDecisions.CrystalReports.Engine.ReportDocument CrpReport = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
            CrpReport = new SAMSBusinessLayer.Reports.RegionWiseSaleReport();
            string ReportTitle = "Category Wise " + DrpReportType.SelectedItem.Text;
            
            if (cbQuantity.Checked && cbValue.Checked)
            {
                ReportTitle += " (Quantity & Value)";
            }
            else if (cbQuantity.Checked)
            {
                ReportTitle += " (Quantity)";
            }
            else if (cbValue.Checked)
            {
                ReportTitle += " (Value)";
            }
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();
            CrpReport.SetParameterValue("fromDate", dtFrom);
            CrpReport.SetParameterValue("todate", dtTo);
            CrpReport.SetParameterValue("ReportTitle", ReportTitle);
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
            this.Session.Add("CrpReport", CrpReport);
            this.Session.Add("ReportType", ReportType);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
    }

    protected void cbAllPrincipal_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblPrincipal.Items)
        {
            li.Selected = cbAllPrincipal.Checked;
        }
        cblPrincipal_SelectedIndexChanged(null, null);
    }

    protected void cbAllCategory_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblCategory.Items)
        {
            li.Selected = cbAllCategory.Checked;
        }
        cblCategory_SelectedIndexChanged(null, null);
    }

    protected void cbAllBrand_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblBrand.Items)
        {
            li.Selected = cbAllBrand.Checked;
        }
        cblBrand_SelectedIndexChanged(null,null);
    }

    protected void cbAllSKU_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblSKU.Items)
        {
            li.Selected = cbAllSKU.Checked;
        }
    }

    protected void cblPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadCategory();
        this.LoadBrand();
        this.LoadSKU();
    }

    protected void cblCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadBrand();
        this.LoadSKU();
    }

    protected void cblBrand_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadSKU();
    }    
}