Message-Id: <s62756bc.018@domain.hid>
Date: Thu, 19 Apr 2007 11:49:06 +0200
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part30175C02.0__="
Subject: [Xenomai-help] [RTDM] IRQ lock problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help, xenomai@xenomai.org, 

--=__Part30175C02.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
 
I've write an rtdm driver and i have a problem.
I use ioctl (rt_dev_ioctl) to read and write data (RTC time) on cmos. 
(I know it could better to use _rt_dev_read or rt_dev_write 
 but it was my first rtdm driver, and i' think that it's not the cause
of my problem).
 
My user application (Native xenomai task) use this rt_dev_ioctl each
100 ms to read data on cmos.
But, sometime (each 3 or 4 days), i read bad values.
 
this is the code to read the cmos (call in an rt_dev_ioctl) : 
 
//---------------------------------------------------------------------------------------------
static unsigned char get_cmos_time(struct rtc146818drv_context *ctx,
           struct rtc_time *rtc_tm)
{
 unsigned char uip;
 rtdm_lockctx_t  lock_ctx;
 
 rtdm_lock_get_irqsave(&ctx->lock, lock_ctx); 
 
 uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
 
 if(uip == 0)
 {
      rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
      rtc_tm->tm_mon = CMOS_READ(RTC_MONTH);
      rtc_tm->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
      rtc_tm->tm_hour = CMOS_READ(RTC_HOURS);
      rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
      rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
      rtc_tm->tm_wday = CMOS_READ(RTC_DAY_OF_WEEK);
}
rtc_tm->tm_yday = 0;
rtc_tm->tm_isdst = 0;

rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx); 
 
return uip;
}
//---------------------------------------------------------------------------------------------
 
Data are read on MC146818A chipset, documentaton of this chipset
explain that an update cycle is execute
once per second and during this update  RTC_values or not fully
available.
So, we test the uip,when uip==0 the update cycle is not in progress and
will not be for at least 244 us (for all time bases).
 
So to be sure that in thoses 244 us i've time to execute my code, i've
disable the premption with rtdm_lock_get_irqsave.
But sometime, like if the update cycle begin in the midle of my code, i
read bad value (value 165 exactly).
 
For example i read this bad time : 
"19/04/07 11:165:165 day 165" (like if i've been prempt after
CMOS_READ(RTC_HOURS) instructions).
or
"19//04/165 165:165:165 day 165" (like if i've been prempt after
CMOS_READ(RTC_MONTH) instructions).
 
We use the same hardware with other system (RTLinux), with same test on
uip bit and we have no problem ( problem isn't on the chipset .. ).
 
So Is my rtdm_lock_get_irqsave and restore use correct ?
Is it sure that my critical section is protected from any premption
with this lock ?
 
i use xenomai 2.3, hal 1.6-03, linux 2.6.19-2.
 
Thanks for your help!
 
 
 

--=__Part30175C02.0__=
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma">
<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've write an rtdm driver and i have a problem.</DIV>
<DIV>I use ioctl (rt_dev_ioctl) to read and write data (RTC time)&nbsp;on =
cmos.=20
</DIV>
<DIV>(I know it could better to use _rt_dev_read or rt_dev_write </DIV>
<DIV>&nbsp;but it was my first rtdm driver, and i' think that it's not the =
cause=20
of my problem).</DIV>
<DIV>&nbsp;</DIV>
<DIV>My user application (Native xenomai task)&nbsp;use this rt_dev_ioctl =
each=20
100 ms to read data on cmos.</DIV>
<DIV>But, sometime (each 3 or 4 days), i read bad values.</DIV>
<DIV>&nbsp;</DIV>
<DIV>this is the code to read the cmos (call in an rt_dev_ioctl)&nbsp;: =
</DIV>
<DIV>&nbsp;</DIV>
<DIV>//--------------------------------------------------------------------=
-------------------------</DIV>
<DIV>static unsigned char get_cmos_time(struct rtc146818drv_context=20
*ctx,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
struct=20
rtc_time *rtc_tm)<BR>{<BR>&nbsp;unsigned char uip;<BR>&nbsp;rtdm_lockctx_t&=
nbsp;=20
lock_ctx;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;rtdm_lock_get_irqsave(&amp;ctx-&gt;lock, lock_ctx);&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;uip =3D (CMOS_READ(RTC_FREQ_SELECT) &amp; RTC_UIP);</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;if(uip =3D=3D 0)<BR>&nbsp;{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=

rtc_tm-&gt;tm_year =3D CMOS_READ(RTC_YEAR);<BR>&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;rtc_tm-&gt;tm_mon =3D=20
CMOS_READ(RTC_MONTH);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_tm-&gt;tm_mday =
=3D=20
CMOS_READ(RTC_DAY_OF_MONTH);<BR>&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;rtc_tm-&gt;tm_hour =3D=20
CMOS_READ(RTC_HOURS);<BR>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;rtc_tm-&gt;tm_min =
=3D=20
CMOS_READ(RTC_MINUTES);<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;rtc_tm-&gt;tm_sec=
 =3D=20
CMOS_READ(RTC_SECONDS);<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;rtc_tm-&gt;tm_wda=
y =3D=20
CMOS_READ(RTC_DAY_OF_WEEK);<BR>}<BR>rtc_tm-&gt;tm_yday =3D=20
0;<BR>rtc_tm-&gt;tm_isdst =3D 0;<BR></DIV>
<DIV>rtdm_lock_put_irqrestore(&amp;ctx-&gt;lock, lock_ctx); </DIV>
<DIV>&nbsp;</DIV>
<DIV>return uip;<BR>}</DIV>
<DIV>//--------------------------------------------------------------------=
-------------------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>Data are read on MC146818A chipset, documentaton of this chipset =
explain=20
that an update cycle is execute</DIV>
<DIV>once per second and during this update&nbsp;&nbsp;RTC_values or not =
fully=20
available.</DIV>
<DIV>So, we test the uip,when uip=3D=3D0 the update cycle is not in =
progress and=20
will not be for at least 244 us (for all time bases).</DIV>
<DIV>&nbsp;</DIV>
<DIV>So to be sure that in thoses 244 us i've time to execute my code, =
i've=20
disable the premption with rtdm_lock_get_irqsave.</DIV>
<DIV>But sometime, like if the update cycle begin in the midle of my code, =
i=20
read bad value (value 165 exactly).</DIV>
<DIV>&nbsp;</DIV>
<DIV>For example i read this bad time : </DIV>
<DIV>"19/04/07 11:165:165 day 165" (like if i've been prempt after=20
CMOS_READ(RTC_HOURS) instructions).</DIV>
<DIV>or</DIV>
<DIV>"19//04/165 165:165:165 day 165"&nbsp;(like if i've been prempt =
after=20
CMOS_READ(RTC_MONTH) instructions).</DIV>
<DIV>&nbsp;</DIV>
<DIV>We use the same hardware with other system (RTLinux), with&nbsp;same =
test=20
on uip bit and&nbsp;we have no problem ( problem isn't on the chipset =
..=20
).</DIV>
<DIV>&nbsp;</DIV>
<DIV>So Is my rtdm_lock_get_irqsave and restore use correct ?</DIV>
<DIV>Is it sure that my critical section is protected from any premption =
with=20
this lock ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>i use xenomai 2.3, hal 1.6-03, linux 2.6.19-2.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks for your help!</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

--=__Part30175C02.0__=--

