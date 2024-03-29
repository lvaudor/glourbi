# WARNING - Generated by {fusen} from dev/1-flat_distrib.Rmd: do not edit by hand

#' Plot the distribution of a variable in dataset
#' @param dataset a dataset, defaults to all_cities
#' @param varname a variable name
#' @param byclass whether to plot distributions according to class or not. Defaults to FALSE
#' 
#' @return a plot showing the distribution 
#' 
#' @export
#' @examples
#' plot_distrib(all_cities,"clim")
#' all_cities_clust=run_hclust(all_cities)
#' plot_distrib(all_cities_clust,"X2018")
#' plot_distrib(all_cities_clust,"X2018",byclass=TRUE)
plot_distrib <- function(dataset=all_cities,varname, byclass=FALSE){
 vars=sep_vars(dataset)
 dataset=dataset %>% 
   dplyr::mutate(xdistrib=.[[varname]])
 datacol=form_palette(dataset,varname)
 plot=ggplot2::ggplot(dataset,
                      ggplot2::aes(x=xdistrib))+
     ggplot2::xlab(varname)+
     ggplot2::theme(legend.position="none")
  if(byclass){
   plot=plot +
    ggplot2::facet_grid(rows=ggplot2::vars(cluster))
 } 
 if(varname %in% sep_vars(dataset)$vars_num){
   plot=plot +
    ggplot2::geom_density(lwd=1)+
    ggplot2::geom_rect(data=datacol,
                       ggplot2::aes(x=NULL,y=NULL,
                                    xmin=catmin,
                                    xmax=catmax,
                                    ymin=-Inf,ymax=+Inf,
                                    fill=categories),alpha=0.25)+
    ggplot2::scale_fill_manual(values=datacol$colors)+
    ggplot2::theme(legend.position="none")+
    ggplot2::scale_x_log10()
 }
 if(varname %in% sep_vars(dataset)$vars_cat){
   plot=plot+
    ggplot2::geom_bar(stat="count", ggplot2::aes(fill=xdistrib))+
    ggplot2::scale_fill_manual(values=datacol$colors)
 }

 return(plot)
}
