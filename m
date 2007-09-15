Message-ID: <1ce16a2c0709151401u11646e47nda8426f71e31dba9@domain.hid>
Date: Sat, 15 Sep 2007 23:01:58 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <1189887314.25006.192.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709151255r52e63d66s7d626390c9d97f97@domain.hid>
	<1189887314.25006.192.camel@domain.hid>
Subject: Re: [Xenomai-help] pipe example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

thanks for quick reply..
I wonder if you're sure that the module_param parameters in module.c is correct?
int task_period_ns = 1000000000;
module_param(task_period_ns,int,0444);
MODULE_PARM_DESC(task_period_ns, "period in ns (default: 1s)");

Gives:
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-L/usr/xenomai/lib -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
/usr/xenomai/lib  module.c   -o module
module.c:35: error: expected ')' before 'int'
module.c:36: error: expected ')' before string constant

/B

