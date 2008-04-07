package ua.com.syo.catalist.cycle.calc
{
	import ua.com.syo.catalist.cycle.CycleData;
	import mx.core.Application;
	import ua.com.syo.catalist.data.storage.KoefStorage;
	import ua.com.syo.catalist.cycle.math.DiffUr;
	
	public class CalcEnergyVars
	{
		private static var nZchep_array:Array=new Array();
		private static var rozginTime:Number=0;
		
		public static function init(): void
		{
			fillArrays();
		}
		
		private static function fillArrays():void
		{
			var isRush:Boolean=false;
			var isRozginTimeSkip:Boolean=false;
			
			for (var i:Number = 0; i<CycleData.getPoinsNum()*10; i++) 
			{
				var time:Number=i/10;
				var mode:String=CycleData.getMode(time);
				
				
				switch (mode)
				{
					//холостий хід
					case "ХХ" :
						//phiDros
						CycleData.PhiDrosPoint_array[i]= KoefStorage.phiDrosMin;
						//Ndv
						CycleData.NdvPoint_array[i]=KoefStorage.nXXmin;
						//Mk
						CycleData.MkPoint_array[i]=0;
						//deltaPk
						CycleData.DeltaPkPoint_array[i]= KoefStorage.dPkXX;
						//nZchep
						nZchep_array[i]=0;
						//mode
		    			CycleData.modePoint2_array[i]="ХХ";
		    			
		    			rozginTime=0;
				    	isRozginTimeSkip=false;
					break;
					//розгін
					case "розгін" :
						rozginTime+=0.1;
						var prevNDv:Number=CycleData.NdvPoint_array[i-1];
						//
	    					// рушання
	    					//Application.application["outputTxt"].text+="mode: "+mode+"  prevNDv: "+prevNDv+"\n";
		    				if (prevNDv<KoefStorage.nDvZchep && !isRush)
		    				{
		    					//phiDros
		    					CycleData.PhiDrosPoint_array[i]= KoefStorage.phiDrosMin+KoefStorage.vDros*rozginTime;
		    					if (CycleData.PhiDrosPoint_array[i]>KoefStorage.phiDrosEnd)
								{
									CycleData.PhiDrosPoint_array[i]=KoefStorage.phiDrosEnd;
								}
		    					//Ndv
		    					CycleData.NdvPoint_array[i]=DiffUr.rungeKutta((time-0.1), prevNDv, time, 10, NdvFunc);
		    					
		    					//Mk
		    					var phiDrosZch:Number=KoefStorage._c0+KoefStorage._c1*KoefStorage.nDvZchep;
		    					var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*CycleData.NdvPoint_array[i]+(KoefStorage._a2+KoefStorage._a12*CycleData.NdvPoint_array[i])*(KoefStorage._b0+KoefStorage._b1*CycleData.NdvPoint_array[i]+KoefStorage._b11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]+KoefStorage._b111*Math.pow(CycleData.NdvPoint_array[i],3)+(KoefStorage._b2+KoefStorage._b12*CycleData.NdvPoint_array[i])*(phiDrosZch+KoefStorage.phiDrosMin)/2+KoefStorage._b22*(phiDrosZch*phiDrosZch+phiDrosZch*KoefStorage.phiDrosMin+KoefStorage.phiDrosMin*KoefStorage.phiDrosMin)/3+KoefStorage._b222*(Math.pow(phiDrosZch,3)+phiDrosZch*KoefStorage.phiDrosMin*KoefStorage.phiDrosMin+phiDrosZch*phiDrosZch*KoefStorage.phiDrosMin+Math.pow(KoefStorage.phiDrosMin, 3))/4);
		    					var tOb:Number=60/CycleData.NdvPoint_array[i];
								var tDros:Number=(CycleData.PhiDrosPoint_array[i]-KoefStorage.phiDrosMin)/KoefStorage.vDros;
								if (tDros<KoefStorage.tDrosMin)
								{
									tDros=KoefStorage.tDrosMin;
								}
								
		    					CycleData.MkPoint_array[i]=Math.abs(_Mk_ust*(1.035-6.6*(tOb/tDros)));//TODO
		    					//Application.application["outputTxt"].text+="mode: "+mode+"  _Mk_neust: "+_Mk_neust+"\n";
		    					
		    					//deltaPk
		    					CycleData.DeltaPkPoint_array[i]=0;
		    					
		    					//nZchep
								nZchep_array[i]=0;
		    					
		    					//mode
		    					CycleData.modePoint2_array[i]="рушання";
		    					
		    				}
		    				else
		    				{
		    					isRush=true;
		    					nZchep_array[i]=DiffUr.rungeKutta((time-0.1), nZchep_array[i-1], time, 10, NZchFunc);
			    				// розгін с пробуксовуючим зчепленням
			    				if (prevNDv>nZchep_array[i-1])
			    				{
			    					if (!isRozginTimeSkip)
			    					{
				    					rozginTime=0;
				    					isRozginTimeSkip=true;
			    					}
			    					//phiDros
		    						CycleData.PhiDrosPoint_array[i]= KoefStorage.phiDrosMin+KoefStorage.vDros*rozginTime;
		    						if (CycleData.PhiDrosPoint_array[i]>KoefStorage.phiDrosMax)
									{
										CycleData.PhiDrosPoint_array[i]=KoefStorage.phiDrosMax;
									}
									
		    						
		    						//Ndv
		    						if (CycleData.PhiDrosPoint_array[i]<KoefStorage.phiDrosMax)
		    						{
		    							//переміщення дросельних заслінок триває
		    							
		    							//Ndv
		    							CycleData.NdvPoint_array[i]=DiffUr.rungeKutta((time-0.1), prevNDv, time, 10, Ndv2Func);
		    							
		    							//Mk
		    							var phiDrosZch:Number=KoefStorage._c0+KoefStorage._c1*KoefStorage.nDvZchep;
		    							var MZch:Number=KoefStorage.vZchep*CalcEnergyVars.rozginTime;
		    							var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*CycleData.NdvPoint_array[i]+(KoefStorage._a2+KoefStorage._a12*CycleData.NdvPoint_array[i])*(KoefStorage._b0+KoefStorage._b1*CycleData.NdvPoint_array[i]+KoefStorage._b11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]+KoefStorage._b111*Math.pow(CycleData.NdvPoint_array[i],3)+(KoefStorage._b2+KoefStorage._b12*CycleData.NdvPoint_array[i])*(phiDrosZch+KoefStorage.phiDrosMin)/2+KoefStorage._b22*(phiDrosZch*phiDrosZch+phiDrosZch*KoefStorage.phiDrosMin+KoefStorage.phiDrosMin*KoefStorage.phiDrosMin)/3+KoefStorage._b222*(Math.pow(phiDrosZch,3)+phiDrosZch*KoefStorage.phiDrosMin*KoefStorage.phiDrosMin+phiDrosZch*phiDrosZch*KoefStorage.phiDrosMin+Math.pow(KoefStorage.phiDrosMin, 3))/4);
				    					var tOb:Number=60/CycleData.NdvPoint_array[i];
										var tDros:Number=(CycleData.PhiDrosPoint_array[i]-KoefStorage.phiDrosMin)/KoefStorage.vDros;
										if (tDros<KoefStorage.tDrosMin)
										{
											tDros=KoefStorage.tDrosMin;
										}
								
		    							CycleData.MkPoint_array[i]=_Mk_ust*(1.035-6.6*(tOb/tDros));
		    							//CycleData.MkPoint_array[i]=CycleData.getAcceleration(time)*KoefStorage.Idv*Math.PI/30+MZch;
		    							
		    							//Application.application["outputTxt"].text+="MZch: "+MZch+"\n";
		    							//mode
		    							CycleData.modePoint2_array[i]="розгін- триває";
		    						}
		    						else
		    						{
		    							//переміщення дросельних заслінок закінчилось
		    							
		    							//Ndv
		    							CycleData.NdvPoint_array[i]=DiffUr.rungeKutta((time-0.1), prevNDv, time, 10, Ndv3Func);
		    							
		    							//Mk
		    							var _Mk_ust:Number=KoefStorage._f0+KoefStorage._f1*CycleData.NdvPoint_array[i]+KoefStorage._f11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]
		    							var MZch:Number=KoefStorage.vZchep*CalcEnergyVars.rozginTime;
		    							var _Mk_neust:Number=_Mk_ust*(1-Math.PI/(30*KoefStorage.Idv))+MZch/KoefStorage.Idv;
		    							CycleData.MkPoint_array[i]=_Mk_neust;
		    							
		    							//mode
		    							CycleData.modePoint2_array[i]="розгін-";
		    						}
			    				}
			    				else
			    				{
			    					//розгін зі з'єднаним зчепленням
			    					
			    					//phiDros
		    						CycleData.PhiDrosPoint_array[i]= KoefStorage.phiDrosMin+KoefStorage.vDros*rozginTime;
		    						if (CycleData.PhiDrosPoint_array[i]>KoefStorage.phiDrosMax)
									{
										CycleData.PhiDrosPoint_array[i]=KoefStorage.phiDrosMax;
									}
									
									//Ndv
		    						CycleData.NdvPoint_array[i]=CycleData.getSpeed(time)*KoefStorage.U[CycleData.getU(time)]*KoefStorage.u0*30/(Math.PI*KoefStorage.rk);
			    					
			    					//deltaPk
			    					CycleData.DeltaPkPoint_array[i]=KoefStorage._b0+KoefStorage._b1*CycleData.NdvPoint_array[i]+KoefStorage._b2*CycleData.PhiDrosPoint_array[i]+KoefStorage._b11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]+KoefStorage._b22*CycleData.PhiDrosPoint_array[i]*CycleData.PhiDrosPoint_array[i]+KoefStorage._b12*CycleData.NdvPoint_array[i]*CycleData.PhiDrosPoint_array[i]+KoefStorage._b111*Math.pow(CycleData.NdvPoint_array[i], 3)+KoefStorage._b222*Math.pow(CycleData.PhiDrosPoint_array[i], 3);
			    					
			    					if (CycleData.PhiDrosPoint_array[i]<KoefStorage.phiDrosMax)
		    						{
		    							//переміщення дросельних заслінок триває
		    							
		    							//Mk
		    							var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*CycleData.NdvPoint_array[i]+KoefStorage._a2*CycleData.DeltaPkPoint_array[i]+KoefStorage._a12*CycleData.DeltaPkPoint_array[i]*CycleData.NdvPoint_array[i];
				    					var tOb:Number=60/CycleData.NdvPoint_array[i];
										var tDros:Number=(CycleData.PhiDrosPoint_array[i]-KoefStorage.phiDrosMin)/KoefStorage.vDros;
										if (tDros<KoefStorage.tDrosMin)
										{
											tDros=KoefStorage.tDrosMin;
										}
										
										
										var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/tDros));
								
		    							CycleData.MkPoint_array[i]=_Mk_neust;
		    							
		    							//mode
		    							CycleData.modePoint2_array[i]="розгін+ триває";
		    							
		    						}
		    						else
		    						{
		    							//переміщення дросельних заслінок закінчилось
		    							
		    							//Mk
		    							var _Mk_ust:Number=KoefStorage._f0+KoefStorage._f1*CycleData.NdvPoint_array[i]+KoefStorage._f11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]
		    							var MZch:Number=KoefStorage.beta*KoefStorage.MkMax;
		    							var _Mk_neust:Number=_Mk_ust*(1-Math.PI/(30*KoefStorage.Idv))+MZch/KoefStorage.Idv;
		    							CycleData.MkPoint_array[i]=_Mk_neust;
		    							
		    							//mode
		    							CycleData.modePoint2_array[i]="розгін+";
		    						}
			    					
			    					
			    				}
			    			}
			    			//deltaPk
			    			if (CycleData.PhiDrosPoint_array[i]>=KoefStorage.phiDrosMax)
							{
								CycleData.DeltaPkPoint_array[i]=0;
							}
							else
							{
			    				CycleData.DeltaPkPoint_array[i]=KoefStorage._b0+KoefStorage._b1*CycleData.NdvPoint_array[i]+KoefStorage._b2*CycleData.PhiDrosPoint_array[i]+KoefStorage._b11*CycleData.NdvPoint_array[i]*CycleData.NdvPoint_array[i]+KoefStorage._b22*CycleData.PhiDrosPoint_array[i]*CycleData.PhiDrosPoint_array[i]+KoefStorage._b12*CycleData.NdvPoint_array[i]*CycleData.PhiDrosPoint_array[i]+KoefStorage._b111*Math.pow(CycleData.NdvPoint_array[i], 3)+KoefStorage._b222*Math.pow(CycleData.PhiDrosPoint_array[i], 3);
			    			}
	    			break;	
	    			
					//стала швидкість
					case "стала" :
						//Ndv
						CycleData.NdvPoint_array[i]= CycleData.getSpeed(time)*KoefStorage.U[CycleData.getU(time)]*KoefStorage.u0*30/(Math.PI*KoefStorage.rk);
						//Mk
						var l_k:Number=KoefStorage.rd*KoefStorage.g/(KoefStorage.U[CycleData.getU(time)]*KoefStorage.u0*KoefStorage.etaTrans);
						//квадрат швидкості
						var l_v2:Number=CycleData.getSpeed(time)*CycleData.getSpeed(time);
						CycleData.MkPoint_array[i]= (KoefStorage.Ga*(KoefStorage.f1*KoefStorage.cosA*(1+KoefStorage.A*l_v2)+KoefStorage.sinA)+KoefStorage.W*l_v2)*l_k;
						//deltaPk
						CycleData.DeltaPkPoint_array[i]= (CycleData.getMk(time)-KoefStorage._a0-KoefStorage._a1*CycleData.NdvPoint_array[i])/(KoefStorage._a2+KoefStorage._a12*CycleData.NdvPoint_array[i]);
						//phiDros
						CycleData.PhiDrosPoint_array[i]=KoefStorage.phiDrosStala;
						
						//nZchep
						nZchep_array[i]=CycleData.NdvPoint_array[i];
						//mode
		    			CycleData.modePoint2_array[i]="стала";
		    			
		    			rozginTime=0;
				    	isRozginTimeSkip=false;
					break;
					//уповільнення зі зєднаним зчепленням
					case "упов.+" :
						//mode
		    			CycleData.modePoint2_array[i]="упов.+";
					break;
					//уповільнення з розєднаним зчепленням
					case "упов.-" :
						//mode
		    			CycleData.modePoint2_array[i]="упов.-";
					break;
					//перемикання передач
					case "перемик." :
						//mode
		    			CycleData.modePoint2_array[i]="перемик.";
		    			
		    			rozginTime=0;
				    	isRozginTimeSkip=false;
					break;
				}
				
			}
			for (var j:Number = 109; j<18*10; j++) 
			{
				var modej:String=CycleData.modePoint2_array[j];
				Application.application["outputTxt"].text+="##################### time: "+j/10+" , mode: "+modej+" ###\n";
				Application.application["outputTxt"].text+="nDv: "+CycleData.NdvPoint_array[j]+"\n";
				Application.application["outputTxt"].text+="Mk: "+CycleData.MkPoint_array[j]+"\n";
				Application.application["outputTxt"].text+="phiDros: "+CycleData.PhiDrosPoint_array[j]+"\n";
				Application.application["outputTxt"].text+="dPk: "+CycleData.DeltaPkPoint_array[j]+"\n";
				Application.application["outputTxt"].text+="a: "+CycleData.getAcceleration(j/10)+"\n";
			}
		
		}
		
		private static function NdvFunc(x:Number, y:Number): Number
		{
			var result:Number;
			
			x=Math.round(x*10)/10;
			var prevNdv:Number=y;
			
			trace(prevNdv);
			
			var deltaPk:Number=KoefStorage._b0+KoefStorage._b1*prevNdv+KoefStorage._b2*CycleData.getPhiDros(x)+KoefStorage._b11*Math.pow(prevNdv, 2)+KoefStorage._b22*Math.pow(CycleData.getPhiDros(x), 2)+KoefStorage._b12*prevNdv*CycleData.getPhiDros(x)+KoefStorage._b111*Math.pow(prevNdv, 3)+KoefStorage._b222*Math.pow(CycleData.getPhiDros(x), 3);
			var phiDrosZch:Number=KoefStorage._c0+KoefStorage._c1*KoefStorage.nDvZchep;
			//var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*prevNdv+(KoefStorage._a2+KoefStorage._a12*prevNdv)*(KoefStorage._b0+KoefStorage._b1*prevNdv+KoefStorage._b11*prevNdv*prevNdv+KoefStorage._b111*Math.pow(prevNdv,3)+(KoefStorage._b2+KoefStorage._b12*prevNdv)*(phiDrosZch+KoefStorage.phiDrosMin)/2+KoefStorage._b22*(phiDrosZch*phiDrosZch+phiDrosZch*KoefStorage.phiDrosMin+KoefStorage.phiDrosMin*KoefStorage.phiDrosMin)/3+KoefStorage._b222*(Math.pow(phiDrosZch,3)+phiDrosZch*KoefStorage.phiDrosMin*KoefStorage.phiDrosMin+phiDrosZch*phiDrosZch*KoefStorage.phiDrosMin+Math.pow(KoefStorage.phiDrosMin, 3))/4);
			var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*prevNdv+KoefStorage._a2*deltaPk+KoefStorage._a12*deltaPk*prevNdv;
			
			//trace(phiDrosZch);
			//trace(_Mk_ust);
			
			var tOb:Number=60/prevNdv;
			var tDros:Number=(CycleData.getPhiDros(x)-KoefStorage.phiDrosMin)/KoefStorage.vDros;
			if (tDros<KoefStorage.tDrosMin)
			{
				tDros=KoefStorage.tDrosMin;
			}
			
			//Application.application["outputTxt"].text+="deltaPk "+ deltaPk+"\n";
			
			var _Mk_neust:Number =_Mk_ust*Math.abs(1.035-6.6*(tOb/tDros));//TODO abs
			
			//fill Array
			//CycleData.MkPoint_array[x]=_Mk_neust;
			
			result=_Mk_neust*30/(KoefStorage.Idv*Math.PI);
			
			//Application.application["outputTxt"].text+="x "+x+"getPhiDros(x) "+CycleData.getPhiDros(x)+"\n";
			//Application.application["outputTxt"].text+="x "+x+" _Mk_neust "+_Mk_neust+"\n";
			//Application.application["outputTxt"].text+="mode: "+CycleData.getMode(x)+" getPhiDros(x) "+CycleData.getPhiDros(x)+"\n";
			
			return result;
			
			
		}
		
		private static function Ndv2Func(x:Number, y:Number): Number
		{
			var result:Number;
			
			x=Math.round(x*10)/10;
			var prevNdv:Number=y;
			
			var phiDrosZch:Number=KoefStorage._c0+KoefStorage._c1*KoefStorage.nDvZchep;
			var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*prevNdv+(KoefStorage._a2+KoefStorage._a12*prevNdv)*(KoefStorage._b0+KoefStorage._b1*prevNdv+KoefStorage._b11*prevNdv*prevNdv+KoefStorage._b111*Math.pow(prevNdv,3)+(KoefStorage._b2+KoefStorage._b12*prevNdv)*(phiDrosZch+KoefStorage.phiDrosMin)/2+KoefStorage._b22*(phiDrosZch*phiDrosZch+phiDrosZch*KoefStorage.phiDrosMin+KoefStorage.phiDrosMin*KoefStorage.phiDrosMin)/3+KoefStorage._b222*(Math.pow(phiDrosZch,3)+phiDrosZch*KoefStorage.phiDrosMin*KoefStorage.phiDrosMin+phiDrosZch*phiDrosZch*KoefStorage.phiDrosMin+Math.pow(KoefStorage.phiDrosMin, 3))/4);
			
			var tOb:Number=60/prevNdv;
			var tDros:Number=(CycleData.getPhiDros(x)-KoefStorage.phiDrosMin)/KoefStorage.vDros;
			if (tDros<KoefStorage.tDrosMin)
			{
				tDros=KoefStorage.tDrosMin;
			}
			
			var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/tDros));
			
			var MZch:Number=KoefStorage.vZchep*CalcEnergyVars.rozginTime;
			result=(_Mk_neust-MZch)*30/(KoefStorage.Idv*Math.PI);
			
			return result;
			
			
		}
		
		private static function Ndv3Func(x:Number, y:Number): Number
		{
			var result:Number;
			
			x=Math.round(x*10)/10;
			var prevNdv:Number=y;
			
			var _Mk_ust:Number=KoefStorage._f0+KoefStorage._f1*prevNdv+KoefStorage._f11*prevNdv*prevNdv;
			
			var MZch:Number=KoefStorage.vZchep*CalcEnergyVars.rozginTime;
			result=(1/(KoefStorage.Idv+KoefStorage.lambda))*(_Mk_ust-MZch*30/Math.PI);
			
			return result;
			
			
		}
		
		private static function NZchFunc(x:Number, y:Number): Number
		{
			var result:Number;
			
			x=Math.round(x*10)/10;
			
			var MZch:Number=KoefStorage.vZchep*CalcEnergyVars.rozginTime;
			var MOporu:Number=KoefStorage.Ga*(KoefStorage.f0*KoefStorage.cosA+KoefStorage.sinA)*KoefStorage.rd*KoefStorage.g/(KoefStorage.U[CycleData.getU(x)]*KoefStorage.u0);
			var Jm:Number=(KoefStorage.Ga*KoefStorage.rk*KoefStorage.rk+KoefStorage.IkSum)/(Math.pow(KoefStorage.U[CycleData.getU(x)]*KoefStorage.u0,2));
			
			result=(MZch-MOporu)*30/(Jm*Math.PI);
			
			return result;
		}
	}
}