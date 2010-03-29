package ua.com.syo.catalist.utils {
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	
	import ua.com.syo.utils.StringUtils;
	

	public class ExportUtils {

		/**
         * Convert the datagrid to a html table
         * Styling etc. can be done externally
         * 
         * @param: dg Datagrid Contains the datagrid that needs to be converted
         * @returns: String
         */
        public static function convertDGToHTMLTable(dg:DataGrid):String {
        	//Set default values
        	var font:String = dg.getStyle('fontFamily');
        	var size:String = dg.getStyle('fontSize');
        	var str:String = '';
        	var colors:String = '';
        	var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';				
        	var hcolor:Array;
        	
        	//Retrieve the headercolor
        	if(dg.getStyle("headerColor") != undefined) {
        		hcolor = [dg.getStyle("headerColor")];
        	} else {
        		hcolor = dg.getStyle("headerColors");
        	}				
        	
        	//Set the htmltabel based upon knowlegde from the datagrid
        	str+= '<table width="'+dg.width+'"><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
        	
        	//Set the tableheader data (retrieves information from the datagrid header				
        	for(var i:int = 0;i<dg.columns.length;i++) {
        		if ((dg.columns[i] as DataGridColumn).visible) {
	        		colors = dg.getStyle("themeColor");
	        			
	        		if(dg.columns[i].headerText != undefined) {
	        			str+="<th "+style+">"+dg.columns[i].headerText+"</th>";
	        		} else {
	        			str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";
	        		}
        		}
        	}
        	str += "</tr></thead><tbody>";
        	colors = dg.getStyle("alternatingRowColors");
        	
        	//Loop through the records in the dataprovider and 
        	//insert the column information into the table
        	for(var j:int =0;j<dg.dataProvider.length;j++) {					
        		str+="<tr width=\""+Math.ceil(dg.width)+"\">";
        			
        		for(var k:int=0; k < dg.columns.length; k++) {
        			
        			//Do we still have a valid item?						
        			if((dg.columns[k] as DataGridColumn).visible && dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
        				
        				if (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) {
		        			var s:String = dg.dataProvider.getItemAt(j)[dg.columns[k].dataField].toString();
		        			if (!isNaN(dg.dataProvider.getItemAt(j)[dg.columns[k].dataField].toString())) {
		        				s = StringUtils.dotToComma(dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]);
		        			} else {
		        				s = dg.dataProvider.getItemAt(j)[dg.columns[k].dataField];
		        			}
	        			}
        				//Check to see if the user specified a labelfunction which we must
        				//use instead of the dataField
        				if(dg.columns[k].labelFunction != undefined) {
        					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
        					
        				} else {
        					//Our dataprovider contains the real data
        					//We need the column information (dataField)
        					//to specify which key to use.
        					
        					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+s+"</td>";
        				}
        			}
        		}
        		str += "</tr>";
        	}
        	str+="</tbody></table>";
        	return str;
        }

	}
}

