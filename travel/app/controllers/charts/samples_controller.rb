class Charts::SamplesController < ApplicationController
  # GET /charts/samples
  # GET /charts/samples.json
  def index
	@h = LazyHighCharts::HighChart.new('graph') do |f| 
		f.options[:chart][:defaultSeriesType] = "area" 
		f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9]) 
		f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] ) 
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charts_samples }
    end
  end

  # def index
  #   @charts_samples = Charts::Sample.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @charts_samples }
  #   end
  # end

  # GET /charts/samples/1
  # GET /charts/samples/1.json
  def show
    @charts_sample = Charts::Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charts_sample }
    end
  end

  # GET /charts/samples/new
  # GET /charts/samples/new.json
  def new
    @charts_sample = Charts::Sample.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charts_sample }
    end
  end

  # GET /charts/samples/1/edit
  def edit
    @charts_sample = Charts::Sample.find(params[:id])
  end

  # POST /charts/samples
  # POST /charts/samples.json
  def create
    @charts_sample = Charts::Sample.new(params[:charts_sample])

    respond_to do |format|
      if @charts_sample.save
        format.html { redirect_to @charts_sample, notice: 'Sample was successfully created.' }
        format.json { render json: @charts_sample, status: :created, location: @charts_sample }
      else
        format.html { render action: "new" }
        format.json { render json: @charts_sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charts/samples/1
  # PUT /charts/samples/1.json
  def update
    @charts_sample = Charts::Sample.find(params[:id])

    respond_to do |format|
      if @charts_sample.update_attributes(params[:charts_sample])
        format.html { redirect_to @charts_sample, notice: 'Sample was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charts_sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/samples/1
  # DELETE /charts/samples/1.json
  def destroy
    @charts_sample = Charts::Sample.find(params[:id])
    @charts_sample.destroy

    respond_to do |format|
      format.html { redirect_to charts_samples_url }
      format.json { head :no_content }
    end
  end
end
