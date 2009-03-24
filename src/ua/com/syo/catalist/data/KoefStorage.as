package ua.com.syo.catalist.data {
	public class KoefStorage {
		public static var U			: Array= new Array();
		U["I"]=3.67;
		U["II"]=2.1;
		U["III"]=1.36;
		U["IV"]=1.0;
		U["V"]=0.82;
		
		public static var alpha	    : Number=	0;
		public static var cosA		: Number=	Math.cos(alpha);
		public static var sinA		: Number=	Math.sin(alpha);
		
		public static var Ga		: Number=	1045+400;
		public static var rk		: Number=	0.265;
		public static var rd		: Number=	0.265;
		public static var vMax		: Number=	140;
		public static var g100km	: Number=	6.8;
		public static var MkMax		: Number=	121.6;
		public static var nXXmin	: Number=	900;
		public static var deltaPkXX	: Number=	62;
		//TODO
		public static var dPkXX		: Number=	63;
		
		public static var u0		: Number=	4.1;
		public static var etaTrans	: Number=	0.9;
		public static var beta		: Number=	1.5;
		public static var Idv		: Number=	0.1;
		public static var IkSum		: Number=	2.94;
		public static var W			: Number=	0.051;
		public static var f0		: Number=	0.014;
		public static var f1		: Number=	0.014+0.005;
		public static var nDvZchep	: Number=	1700;
		public static var vDros		: Number=	172;
		public static var tDrosMin	: Number=	1.035*60/6.6/nXXmin;
		public static var vZchep	: Number=	112;
		public static var A			: Number=	0;
		public static var phiDrosEnd: Number=	50;
		public static var phiDrosMax: Number=	100;
		public static var phiDrosStala : Number=5.8;
		public static var phiDrosMin: Number=	4.3;
		//public static var phiDrosZch: Number=	10;
		public static var lambda	: Number=	0;
		public static var tNejtr	: Number=	1;
		public static var k			: Number=	7;
		public static var deltaTPal	: Number=	2;
		
		public static var L0ben		: Number=	14.95;
		public static var L0gas		: Number=	15.57;
		
		public static var muCO		: Number=	28;
		public static var muCO2		: Number=	44;
		public static var muCH		: Number=	82;
		public static var muNOX		: Number=	46;
		
		public static var _a0		: Number=	89.89322;
		public static var _a1		: Number=	0.0053;
		public static var _a2		: Number=	-1.45345;
		public static var _a12		: Number=	-0.00005;
		
		public static var _b0		: Number=	83.97809;
		public static var _b1		: Number=	-0.00131;
		public static var _b2		: Number=	-0.00131;
		public static var _b11		: Number=	0.00001;
		public static var _b22		: Number=	0.1611;
		public static var _b12		: Number=	-0.00018;
		public static var _b111		: Number=	-2.9195e-9;
		public static var _b222		: Number=	-0.00094;
		
		public static var _c0		: Number=	1.294;
		public static var _c1		: Number=	3.32e-3;
		
		public static var _f0		: Number=	6.6514e+1;
		public static var _f1		: Number=	2.5470e-2;
		public static var _f11		: Number=	-3.3098e-6;
		
		public static var _z0		: Number=	-286.7839;
		public static var _z1		: Number=	281.8211;
		
		public static var deltaT	: Number=	1;
		public static var Mco		: Number=	28;
		public static var Mhcs		: Number=	86;
		public static var Mnox		: Number=	16;
		public static var Mco2		: Number=	44;
		
		public static var g			: Number=	9.81;
		
		
	}
}