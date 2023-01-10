all: data/reviews.csv data/listings.csv gen/analysis/temp/df_listings_merged.csv gen/analysis/temp/df_aggregated.csv gen/paper/output/histogram.pdf gen/paper/output/plot.pdf

data/reviews.csv data/listings.csv: src/data-preparation/download_data.R
	R --vanilla < src/data-preparation/download_data.R
	
gen/analysis/temp/df_listings_merged.csv: src/data-preparation/filter_merge_data.R
	R --vanilla < src/data-preparation/filter_merge_data.R
	
gen/analysis/temp/df_aggregated.csv: src/data-preparation/aggregate_data.R
	R --vanilla < src/data-preparation/aggregate_data.R
	
gen/paper/output/histogram.pdf: src/analysis/data_histogram.R
	R --vanilla < src/analysis/data_histogram.R
	
gen/paper/output/plot.pdf: src/analysis/data_plot.R
	R --vanilla < src/analysis/data_plot.R
	
clean: 
	-rm -r data
	-rm -r gen