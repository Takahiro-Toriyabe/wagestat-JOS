capture program drop export_graph
program define export_graph
	syntax namelist(min=1 max=1), path(string) [path_html(string)]

	foreach d in "`path'" "`path'/pdf" "`path'/png" {
		capture mkdir "`d'"
	}

	qui graph export "`path'/pdf/`namelist'.pdf", replace
	qui graph export "`path'/png/`namelist'.png", replace ///
		width(${png_w}) height(${png_h})
	
	if "`path_html'" != "" {
		capture mkdir "`path_html'"
		qui graph export "`path_html'/`namelist'.png", replace ///
			width(${png_html_w}) height(${png_html_h})
	}
end
