class PartnersController < ApplicationController
  before_filter :authenticate_user! 
  #load_and_authorize_resource
  # GET /partners
  # GET /partners.json
  def index
    @partners = Partner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partners }
    end
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
    pid = params[:id]
    @partner = Partner.find(pid)

    @mf_loans = MonthlyFinance.find_all_by_partner_id(pid).count
    @df_loans = DailyFinance.find_all_by_partner_id(pid).count

    @loans_issued = @mf_loans + @df_loans
    # render :text => @loans_issued.inspect;return
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/new
  # GET /partners/new.json
  def new
    @partner = Partner.new
    @m_directors = MDirector.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
    @m_directors = MDirector.all
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(params[:partner])
    code = rand(5**5)
    while code.to_s.length != 5
    code =rand(6**6)
    end
    @partner.unique_id = code

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner, notice: 'Partner was successfully created.' }
        format.json { render json: @partner, status: :created, location: @partner }
      else
        format.html { render action: "new" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.json
  def update
    @partner = Partner.find(params[:id])

    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        format.html { redirect_to @partner, notice: 'Partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    respond_to do |format|
      format.html { redirect_to partners_url }
      format.json { head :no_content }
    end
  end
end
