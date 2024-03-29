# WARNING - Generated by {fusen} from dev/1-flat_distrib.Rmd: do not edit by hand

#' Describe all characteristics of a city
#' @param dataset a dataset, defaults to all_cities
#' @param city city name
#' @return a plot
#' @export
#' @examples
#' describe_city(all_cities,"Cordoba--Spain")
#' all_cities_clust=all_cities %>% run_hclust(15)
#' describe_city(all_cities_clust,"Cordoba--Spain")
describe_city <- function(dataset=all_cities,city){
  dataset_num = dataset %>%
      norm_data() %>% 
      tibble::rownames_to_column("name") %>%
      tidyr::pivot_longer(cols=-name, names_to="varname") %>% 
      dplyr::group_by(varname) %>% 
      dplyr::mutate(maxval=max(value)) %>%
      dplyr::mutate(value=value/maxval) %>% 
      dplyr::ungroup() %>% 
      dplyr::filter(name==city) %>% 
      dplyr::mutate(type="num",
                    index=1:dplyr::n(),
                    text=varname,
                    color="#e9e9e9") %>% 
      dplyr::mutate(x1=0,x2=1,y1=index-0.5,y2=index+1) %>% 
      dplyr::select(type,index,name,varname,value,x1,x2,y1,y2,color,text)
    dataset_cat=dataset[,c("name",sep_vars(dataset)$vars_cat)]  %>% 
      dplyr::filter(name==city) %>% 
      tidyr::pivot_longer(cols=-name, names_to="varname") %>% 
      dplyr::mutate(color=purrr::map2_chr(varname,value,glourbi:::get_color, dataset=dataset))
    set_colors=c(dataset_cat$color,"#e9e9e9")
    names(set_colors)=set_colors
    dataset_cat=dataset_cat %>% 
      dplyr::mutate(type="cat",
                    index=0:-(dplyr::n()-1)-0.5,
                    text=paste0(varname,": ", value),
                    value=NA,
                    x1=0,
                    x2=1,
                    y1=index,
                    y2=index+1) %>%
      dplyr::select(type,index,name,varname,value,
                    x1,x2,y1,y2,color,text)
  dataset_title=tibble::tibble(type="title",index=max(dataset_num$index)+1,
                               name=city,varname=city,value=NA,
                               x1=0,x2=1,y1=index,y2=index+1,color=NA,text=city)          
 
  dataset_vars=dplyr::bind_rows(dataset_cat,dataset_num,dataset_title)
                                  
  plot=
    ggplot2::ggplot(data=dataset_vars)+
    ggplot2::geom_rect(ggplot2::aes(xmin=x1,ymin=y1,xmax=x2,ymax=y2,fill=color),
                       show.legend=FALSE)+
    ggplot2::geom_segment(ggplot2::aes(x=x1,xend=x2,y=index,yend=index))+
    ggplot2::geom_point(ggplot2::aes(x=value,y=index),size=5, col="blue")+
    ggplot2::geom_text(ggplot2::aes(x=0.5, y=index+0.5,label=text))+
    ggplot2::scale_x_continuous(limits=c(0,1)) +
    ggplot2::scale_fill_manual(values=set_colors)+
    ggplot2::theme_void()
  return(plot)
}
