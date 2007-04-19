Message-Id: <s6279262.045@domain.hid>
Date: Thu, 19 Apr 2007 16:03:45 +0200
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__PartAE89C2D1.0__="
Subject: Re: [Xenomai-help] [RTDM] IRQ lock problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--=__PartAE89C2D1.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>>>> Jan Kiszka <jan.kiszka@domain.hid> 19.04 13:55 >>>
>Nicolas BLANCHARD wrote:
>> Hi,
>>  
>> I've write an rtdm driver and i have a problem.
>> I use ioctl (rt_dev_ioctl) to read and write data (RTC time) on
cmos. 
>> (I know it could better to use _rt_dev_read or rt_dev_write 
>>  but it was my first rtdm driver, and i' think that it's not the
cause
>> of my problem).
>>  
>> My user application (Native xenomai task) use this rt_dev_ioctl
each
>> 100 ms to read data on cmos.
>> But, sometime (each 3 or 4 days), i read bad values.
>>  
>> this is the code to read the cmos (call in an rt_dev_ioctl) : 
>>  
>>
//---------------------------------------------------------------------------------------------
>> static unsigned char get_cmos_time(struct rtc146818drv_context
*ctx,
>>            struct rtc_time *rtc_tm)
>> {
>>  unsigned char uip;
>>  rtdm_lockctx_t  lock_ctx;
>>  
>>  rtdm_lock_get_irqsave(&ctx->lock, lock_ctx); 
>>  
>>  uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
>>  
>>  if(uip == 0)
>>  {
>>       rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
>>       rtc_tm->tm_mon = CMOS_READ(RTC_MONTH);
>>       rtc_tm->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
>>       rtc_tm->tm_hour = CMOS_READ(RTC_HOURS);
>>       rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
>>       rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
>>       rtc_tm->tm_wday = CMOS_READ(RTC_DAY_OF_WEEK);
>> }
>> rtc_tm->tm_yday = 0;
>> rtc_tm->tm_isdst = 0;
>> 
>> rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx); 
>>  
>> return uip;
>> }
>>
//---------------------------------------------------------------------------------------------
>>  
>> Data are read on MC146818A chipset, documentaton of this chipset
>> explain that an update cycle is execute
>> once per second and during this update  RTC_values or not fully
>> available.
>> So, we test the uip,when uip==0 the update cycle is not in progress
and
>> will not be for at least 244 us (for all time bases).
>>  
>> So to be sure that in thoses 244 us i've time to execute my code,
i've
>> disable the premption with rtdm_lock_get_irqsave.
>> But sometime, like if the update cycle begin in the midle of my
code, i
>> read bad value (value 165 exactly).
>>  
>> For example i read this bad time : 
>> "19/04/07 11:165:165 day 165" (like if i've been prempt after
>> CMOS_READ(RTC_HOURS) instructions).
>> or
>> "19//04/165 165:165:165 day 165" (like if i've been prempt after
>> CMOS_READ(RTC_MONTH) instructions).
>>  
>> We use the same hardware with other system (RTLinux), with same test
on
>> uip bit and we have no problem ( problem isn't on the chipset .. ).
>>  
>> So Is my rtdm_lock_get_irqsave and restore use correct ?
>> Is it sure that my critical section is protected from any premption
>> with this lock ?
>
>rtdm_lock_get_irqsave protects against preemption, but did you check
>
>o how CMOS_READ is realised internally?
>o if there are other CMOS_xxx users in the stock kernel that can bite
>   you?
>
>As I already explained to you earlier, the CMOS access itself is
>problematic because it contains non-atomic operations that must be
>protected against re-entrance. Linux does this via
>local_irq_save/restore etc. Xenomai breaks this mechanism by making
>Linux fully preemptible. Even worse, your invocation of CMOS_READ in
>Xenomai context also invokes Linux local_irq_restore, potentially
>causing unwanted side effects.
>
 
Ok, that right.
CMOS_READ call local_irq_save and local_irq_restore.
I've write my CMOS_READ function ... without those local_irq_ call.
It's on test. 

>The Linux preemptibility issue applies to RTLinux as well, just how
>local_irq_save/restore behaves when being invoked from incorrect
>context may differ and explain the observed behaviour.
>
>Jan
>
 
With RtLinux we used rtl_crtical and rtl_end_crtical functions, after
some define and macro
i can see that it corresponding on cli ans sti processor instructions.
In this case, if local_irq_ call
on CMOS_READ have no negative effect it's perhaps because those calls
have been changed by the rtlinux patch.
 
I was thinking that with xenomai, all local_irq_ call are catch by the
adeos layer and just the rtdm_lock_irq could
make cli and sti processor instructions ... But it seems to be
different. I'm not very experimented with thoses concepts
(that why i' have not understand your previous explanation :-) ).
 
thanks a lot.
blanchard nicolas

--=__PartAE89C2D1.0__=
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma"><BR>&gt;&gt;&gt;&gt;=
 Jan=20
Kiszka &lt;jan.kiszka@domain.hid&gt; 19.04 13:55 &gt;&gt;&gt;<BR>
<DIV>&gt;Nicolas BLANCHARD wrote:<BR>&gt;&gt; Hi,<BR>&gt;&gt;&nbsp; =
<BR>&gt;&gt;=20
I've write an rtdm driver and i have a problem.<BR>&gt;&gt; I use ioctl=20
(rt_dev_ioctl) to read and write data (RTC time) on cmos. <BR>&gt;&gt; (I =
know=20
it could better to use _rt_dev_read or rt_dev_write <BR>&gt;&gt;&nbsp; but =
it=20
was my first rtdm driver, and i' think that it's not the cause<BR>&gt;&gt; =
of my=20
problem).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; My user application (Native =
xenomai=20
task) use this rt_dev_ioctl each<BR>&gt;&gt; 100 ms to read data on=20
cmos.<BR>&gt;&gt; But, sometime (each 3 or 4 days), i read bad=20
values.<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; this is the code to read the cmos =
(call=20
in an rt_dev_ioctl) : <BR>&gt;&gt;&nbsp; <BR>&gt;&gt;=20
//-------------------------------------------------------------------------=
--------------------<BR>&gt;&gt;=20
static unsigned char get_cmos_time(struct rtc146818drv_context=20
*ctx,<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
struct rtc_time *rtc_tm)<BR>&gt;&gt; {<BR>&gt;&gt;&nbsp; unsigned char=20
uip;<BR>&gt;&gt;&nbsp; rtdm_lockctx_t&nbsp; lock_ctx;<BR>&gt;&gt;&nbsp;=20
<BR>&gt;&gt;&nbsp; rtdm_lock_get_irqsave(&amp;ctx-&gt;lock, lock_ctx);=20
<BR>&gt;&gt;&nbsp; <BR>&gt;&gt;&nbsp; uip =3D (CMOS_READ(RTC_FREQ_SELECT) =
&amp;=20
RTC_UIP);<BR>&gt;&gt;&nbsp; <BR>&gt;&gt;&nbsp; if(uip =3D=3D 0)<BR>&gt;&gt;=
&nbsp;=20
{<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_tm-&gt;tm_year =
=3D=20
CMOS_READ(RTC_YEAR);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rtc_tm-&gt;tm_mon =3D=20
CMOS_READ(RTC_MONTH);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rtc_tm-&gt;tm_mday =3D=20
CMOS_READ(RTC_DAY_OF_MONTH);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
rtc_tm-&gt;tm_hour =3D=20
CMOS_READ(RTC_HOURS);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rtc_tm-&gt;tm_min =3D=20
CMOS_READ(RTC_MINUTES);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rtc_tm-&gt;tm_sec =3D=20
CMOS_READ(RTC_SECONDS);<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rtc_tm-&gt;tm_wday =3D CMOS_READ(RTC_DAY_OF_WEEK);<BR>&gt;&gt; }<BR>&gt;&gt=
;=20
rtc_tm-&gt;tm_yday =3D 0;<BR>&gt;&gt; rtc_tm-&gt;tm_isdst =3D 0;<BR>&gt;&gt=
;=20
<BR>&gt;&gt; rtdm_lock_put_irqrestore(&amp;ctx-&gt;lock, lock_ctx);=20
<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; return uip;<BR>&gt;&gt; }<BR>&gt;&gt;=20
//-------------------------------------------------------------------------=
--------------------<BR>&gt;&gt;&nbsp;=20
<BR>&gt;&gt; Data are read on MC146818A chipset, documentaton of this=20
chipset<BR>&gt;&gt; explain that an update cycle is execute<BR>&gt;&gt; =
once per=20
second and during this update&nbsp; RTC_values or not fully<BR>&gt;&gt;=20
available.<BR>&gt;&gt; So, we test the uip,when uip=3D=3D0 the update =
cycle is not=20
in progress and<BR>&gt;&gt; will not be for at least 244 us (for all =
time=20
bases).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; So to be sure that in thoses 244 us =
i've=20
time to execute my code, i've<BR>&gt;&gt; disable the premption with=20
rtdm_lock_get_irqsave.<BR>&gt;&gt; But sometime, like if the update cycle =
begin=20
in the midle of my code, i<BR>&gt;&gt; read bad value (value 165=20
exactly).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; For example i read this bad time =
:=20
<BR>&gt;&gt; "19/04/07 11:165:165 day 165" (like if i've been prempt=20
after<BR>&gt;&gt; CMOS_READ(RTC_HOURS) instructions).<BR>&gt;&gt; =
or<BR>&gt;&gt;=20
"19//04/165 165:165:165 day 165" (like if i've been prempt after<BR>&gt;&gt=
;=20
CMOS_READ(RTC_MONTH) instructions).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; We use =
the=20
same hardware with other system (RTLinux), with same test on<BR>&gt;&gt; =
uip bit=20
and we have no problem ( problem isn't on the chipset .. ).<BR>&gt;&gt;&nbs=
p;=20
<BR>&gt;&gt; So Is my rtdm_lock_get_irqsave and restore use correct=20
?<BR>&gt;&gt; Is it sure that my critical section is protected from any=20
premption<BR>&gt;&gt; with this lock ?<BR>&gt;<BR>&gt;rtdm_lock_get_irqsave=
=20
protects against preemption, but did you check<BR>&gt;<BR>&gt;o how =
CMOS_READ is=20
realised internally?<BR>&gt;o if there are other CMOS_xxx users in the =
stock=20
kernel that can bite<BR>&gt;&nbsp;&nbsp; you?<BR>&gt;<BR>&gt;As I =
already=20
explained to you earlier, the CMOS access itself is<BR>&gt;problematic =
because=20
it contains non-atomic operations that must be<BR>&gt;protected against=20
re-entrance. Linux does this via<BR>&gt;local_irq_save/restore etc. =
Xenomai=20
breaks this mechanism by making<BR>&gt;Linux fully preemptible. Even =
worse, your=20
invocation of CMOS_READ in<BR>&gt;Xenomai context also invokes Linux=20
local_irq_restore, potentially<BR>&gt;causing unwanted side=20
effects.<BR>&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Ok, that right.</DIV>
<DIV>CMOS_READ call local_irq_save and local_irq_restore.</DIV>
<DIV>I've write my CMOS_READ function ... without those local_irq_ call. =
It's on=20
test.&nbsp;</DIV>
<DIV><BR>&gt;The Linux preemptibility issue applies to RTLinux as well, =
just=20
how<BR>&gt;local_irq_save/restore behaves when being invoked from=20
incorrect<BR>&gt;context may differ and explain the observed behaviour.</DI=
V>
<DIV>&gt;<BR>&gt;Jan<BR>&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>With RtLinux we used rtl_crtical and rtl_end_crtical functions,=20
after&nbsp;some&nbsp;define and macro</DIV>
<DIV>i can see that it corresponding on cli ans sti processor instructions.=
 In=20
this case, if local_irq_ call</DIV>
<DIV>on CMOS_READ have no negative effect it's perhaps because those=20
calls&nbsp;have been&nbsp;changed by the rtlinux patch.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I was thinking that with xenomai, all local_irq_ call&nbsp;are catch =
by the=20
adeos layer and just the rtdm_lock_irq could</DIV>
<DIV>make cli and sti processor instructions ... But it seems to be =
different.=20
I'm not very experimented with thoses concepts</DIV>
<DIV>(that why i' have not understand your previous explanation :-) =
).</DIV>
<DIV>&nbsp;</DIV>
<DIV>thanks a lot.</DIV>
<DIV>blanchard nicolas</DIV></BODY></HTML>

--=__PartAE89C2D1.0__=--

