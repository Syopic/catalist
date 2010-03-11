package ua.com.syo.catalist.data {
	[Bindable]	
	public class KoefStorage {
		
		public static var U	: Array;
		
		public static function init():void {
			U = new Array();
			U["I"] = UI;
			U["II"] = UII;
			U["III"] = UIII;
			U["IV"] = UIV;
			U["V"] = UV;
		}
		
		//----------------- Параметри КТЗ і двигуна ---------------
		
		//Модель КТЗ
		public static var ktzModel:String = "ВАЗ-2106»";
		
		//Передаткові числа коробки передач
		public static var UI:Number = 3.67;
		public static var UII:Number = 2.1;
		public static var UIII:Number = 1.36;
		public static var UIV:Number = 1.0;
		public static var UV:Number = 0.82;
		
		//Передаткове число головної передачі
		public static var u0:Number = 4.1;
		//Повна вага КТЗ (маса спорядженого КТЗ + корисна навантага)
		public static var Ga:Number = 1045+400;
		//Максимальний крутний момент двигуна, Н∙м
		public static var MkMax:Number = 121.6;
		//Максимальна швидкість руху на вищій передачі при повній масі, км/год
		public static var vMax:Number = 140;
		//Радіус кочення коліс КТЗ, м
		public static var rk:Number = 0.265;
		//Динамічний радіус колеса, м
		public static var rd:Number = 0.265;
		//Витрата палива в міському циклі, л/100км
		public static var g100km:Number = 6.8;
		//ККД трансмісії
		public static var etaTrans:Number = 0.9;
		//Коефіцієнт запасу зчеплення
		public static var beta:Number = 1.5;
		//Сумарний момент інерції усіх коліс КТЗ, кгм2
		public static var IkSum:Number = 2.94;
		//Фактор обтічності КТЗ, Н ∙ с2/м4
		public static var W:Number = 0.051;
		//Коефіцієнт опору коченню, кгс/кг
		public static var f0:Number = 0.014;
		//Частота обертання колінчастого валу двигуна в момент вмикання зчеплення, хв-1
		public static var nDvZchep	: Number=	2100;
		//Найменший кут відкриття дросельних заслінок
		public static var phiDrosMin: Number=	0;
		
		//------------------ Параметри палива ------------------
		
		//Густина палива, кг/л
		public static var roBenz    : Number=	0.72;
		public static var roGas     : Number=	0.546;
		//Вміст сірки в паливі
		public static var Sbenz     : Number=	0.0005;
		public static var Sgas      : Number=	0;
		//Вміст свинцю в паливі, г/л
		public static var PbBenz    : Number=	0.013;
		public static var PbGas     : Number=	0;
		//Нижча теплота згорання, МДж/кг
		public static var HuBenz: Number=	44;
		public static var HuGas: Number=	45.672;
		//Теоретично необхідна кількість повітря для згорання 1 кг палива
		public static var L0ben		: Number=	14.95;
		public static var L0gas		: Number=	15.57;
		//Відносна молекулярна маса чадного газу
		public static var muCO		: Number=	28;
		//Відносна молекулярна маса вуглекислого газу
		public static var muCO2		: Number=	44;
		//Відносна молекулярна маса вуглеводнів (за гексаном)(за пропаном – 44)
		public static var muCH		: Number=	86;
		//Відносна молекулярна маса оксидів азоту (за NO2)
		public static var muNOX		: Number=	46;
		//Відносна молекулярна маса кисню
		public static var muO2		: Number=	32;
		
		//----------------- Інші параметри ----------------
		
		//Умовний опір коченню коліс КТЗ
		public static var A			: Number=	0;
		//Кут нахилу повздовжнього профілю дороги
		public static var alpha	    : Number=	0;
		//Швидкість зростання моменту тертя зчеплення, Нм/с
		public static var vZchep	: Number=	112;
		//Швидкість відкриття дросельних заслінок %/с
		public static var vDros		: Number=	172;
		//Експериментальний коефіцієнт неусталеного режиму
		public static var lambda	: Number=	0;
		
		
		
		//----------------- Внутрішні параметри --------------
		public static var nXXmin:Number = 900;
		public static var Idv:Number = 0.1;
		public static var dPkXX		: Number=	62;
		
		//Експериментальний кут відкриття дросельних заслінок за сталої швидкості
		public static var phiDrosStalaBW : Number=4.65;
		
		public static function get tDrosMin():Number {
			return 1.035*60/6.6/nXXmin;
		}
		
		public static var phiDrosStalaB : Number=2.33;
		public static var phiDrosStalaGW : Number=6.98;
		public static var phiDrosStalaG : Number=5.83; 
		
		public static function get cosA():Number {
			return Math.cos(alpha);
		}
		
		public static function get sinA():Number {
			return Math.sin(alpha);
		}
		
		//Коефіцієнт опору коченню із урахуванням втрат в трансмісії, кгс/кг
		public static var f1		: Number=	0.014+0.005;
		//Кут відкриття дросельних заслінок під час розгону, %
		public static var phiDrosEnd: Number=	50;
		//Максимальний кут відкриття дросельних заслінок, %
		public static var phiDrosMax: Number=	100;
		//Прискорення вільного падіння
		public static var g			: Number=	9.81;
	}
}