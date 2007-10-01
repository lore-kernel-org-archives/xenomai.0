Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8042F.723E9EA1"
Date: Mon, 1 Oct 2007 15:32:00 +0200
Message-ID: <6EB3AFE7F3632E4BA457E506E6DAF4F61451A2@domain.hid>
References: <46F9167F.20008@domain.hid><46FA26ED.4070505@domain.hid>	<46FF
	78DF.7090104@domain.hid><1191149545.5989.7.camel@domain.hid>	<46FF81BA.1020506@domain.hid
	.de><46FF8BB9.9080207@domain.hid>	<1191156133.5989.17.camel@domain.hid><46FFC139.6
	0905@domain.hid>	<2ff1a98a0710010204x60178291u9633e61a89d49921@domain.hid>	
	<4700BB1C.8040007@domain.hid><2ff1a98a0710010223k1304739w2321e83c6e060ca3@
	mail.gmail.com><4700BE99.5050501@domain.hid>
	<6EB3AFE7F3632E4BA457E506E6DAF4F61451A1@domain.hid>
From: "Labozzetta, Saverio" <saverio.labozzetta@domain.hid>
Subject: Re: [Xenomai-core] crashing 2.6.22
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Labozzetta, Saverio" <saverio.labozzetta@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8042F.723E9EA1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable





-----Original Message-----
From: xenomai-core-bounces@domain.hid on behalf of Labozzetta, Saverio
Sent: Mon 2007-10-01 2:42 PM
To: Jan Kiszka; Gilles Chanteperdrix
Cc: xenomai-core
Subject: Re: [Xenomai-core] crashing 2=2E6=2E22
=20




>>-----Original Message-----
>>From: xenomai-core-bounces@domain.hid on behalf of Jan Kiszka
>>Sent: Mon 2007-10-01 11:32 AM
>>To: Gilles Chanteperdrix
>>Cc: xenomai-core
>Subject: Re: [Xenomai-core] crashing 2=2E6=2E22
>>=20
>>Gilles Chanteperdrix wrote:
>>> On 10/1/07, Jan Kiszka <jan=2Ekiszka@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> On 9/30/07, Jan Kiszka <jan=2Ekiszka@domain.hid> wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>> On Sun, 2007-09-30 at 13:42 +0200, Jan Kiszka wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Philippe Gerum wrote:
>>>>>>>>>> On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
>>>>>>>> =2E=2E=2E
>>>>>>>>>>>  And a third
>>>>>>>>>>> one only gives me "Detected illicit call from domain Xenomai"=
 before the
>>>>>>>>>>> box reboots=2E :(
>>>>>>>>>> Grmff=2E=2E=2E Do you run with your smp_processor_id()=
 instrumentation in?
>>>>>>>>> Yes, but I suspect this is just a symptom of some severe memory
>>>>>>>>> corruption that (also?) hits I-pipe data structures=2E I just put=
 in some
>>>>>>>>> different instrumentation, and that warning is gone, the box just=
 hangs
>>>>>>>>> hard at a different point=2E Very unfriendly=2E
>>>>>>>> Hah! Got some crash log by hacking a raw printk-to-uart:
>>>>>>>>
>>>>>>>> [=2E=2E=2E]
>>>>>>>> <6>Xenomai: starting RTDM services=2E
>>>>>>>> <6>NET: Registered protocol family 10
>>>>>>>> <6>lo: Disabled Privacy Extensions
>>>>>>>> <6>ADDRCONF(NETDEV_UP): eth0: link is not ready
>>>>>>>> <3>I-pipe: Detected illicit call from domain 'Xenomai'
>>>>>>>> <3>        into a service reserved for domain 'Linux' and below=2E
>>>>>>>>        f3a6bc18 00000000 00000000 c05dad6c f3a6bc3c c0105fc3=
 c03513c7 c05dc100
>>>>>>>>        00000009 f3a6bc54 c01479cb c03592f8 c0357ae2 c035e069=
 f3a6bc88 f3a6bc70
>>>>>>>>        c0127224 c0111df8 00000000 f3a6bd74 00000000 f3a6bd74=
 f3a6bc80 c012727f
>>>>>>>> Call Trace:
>>>>>>>>  [<c010520f>] show_trace_log_lvl+0x1f/0x40
>>>>>>>>  [<c01052e1>] show_stack_log_lvl+0xb1/0xe0
>>>>>>>>  [<c0105fc3>] show_stack+0x33/0x40
>>>>>>>>  [<c01479cb>] ipipe_check_context+0x7b/0x90
>>>>>>>>  [<c0127224>] __atomic_notifier_call_chain+0x24/0x60
>>>>>>>>  [<c012727f>] atomic_notifier_call_chain+0x1f/0x30
>>>>>>>>  [<c0131e02>] notify_die+0x32/0x40
>>>>>>>>  [<c0105d29>] do_invalid_op+0x59/0xa0
>>>>>>>>  [<c0111d0b>] __ipipe_handle_exception+0x7b/0x144
>>>>>>>>  [<c02dfaeb>] error_code+0x6f/0x7c
>>>>>>> Wow=2E Why that?
>>>>>>>
>>>>>>>>  [<c0111d13>] __ipipe_handle_exception+0x83/0x144
>>>>>>>>  [<c02dfaeb>] error_code+0x6f/0x7c
>>>>>>> And this? We should not get any exception over an IPI3 handler=2E I=
 guess
>>>>>>> the double fault may be explained by this root cause=2E
>>>>>>>
>>>>>>>>  [<c01117df>] __ipipe_handle_irq+0x4f/0x140
>>>>>>>>  [<c0104c5e>] ipipe_ipi3+0x26/0x40
>>>>>>> Our LAPIC timer vector=2E Are you running full modular or=
 statically btw?
>>>>>> Fully modular=2E Compiling the nucleus in makes the lock-up move to
>>>>>> another, once again invisible spot=2E
>>>>>
>>>>>> I nailed down the fault address in the scenario above=2E It's in the
>>>>>> nucleus module, at the first byte of xntimer_tick_aperiodic=2E Are=
 we
>>>>>> loosing module text pages over the time? This functions must have=
 been
>>>>>> executed before as the timer was armed while I collected the
>>>>>> /proc/modules and then triggered the crash=2E
>>>>> There is a pending issue about vmalloced areas, which I completely=
 forgot:
>>>>> https://mail=2Egna=2Eorg/public/xenomai-core/2007-02/msg00138=2Ehtml
>>>>>
>>>> Would this explain my problems which are already visible without any
>>>> Xenomai application running (and also without unloading the modules
>>>> again, to answer Philippe's question)? Hell, I would love to find the
>>>> reason here, debugging this stuff stopped being fun a long time ago=2E=
=2E=2E
>>>=20
>>> It would explain bugs involving a race between task creation and
>>> vmalloc/ioremap=2E But the bug would only happen with Xenomai tasks
>>> running,
>>
>>I don't need to start any Xenomai task to trigger the problem=2E
>>
>>> otherwise, the vmalloced/ioremaped area would be mapped lazily as usual=
=2E
>>
>>I guess module text pages are not mapped lazily, otherwise quite a lot=20
>>of things would have fallen apart much earlier, right?
>
> AFAIK Once inserted module text pages are part of the kernel, so have
>to be reliably ready as long as the servicies offered are registred,
>is the insertion function which allocates memory, access it to write=20
>the text of the module and make it part of the kernel, so is keep in=20
>main memory=2E
>

I've been silly: the pages are directly allocated in kernel space=
 (GFP_KERNEL),
and some of their addresses are pointed by the function offered in some
kernel tables=2E=2E=2E

BTW: sorry about the following nasty copiright abuse patch, is=
 automatically
attached to any mail I send outside, an sorry also for the filthy email=
 client
I use, but I've not found other ways since they put exchange on=2E=2E=2E=20

>  Saverio
>
>>
>>Jan
>>
>>--=20
>>Siemens AG, Corporate Technology, CT SE 2
>>Corporate Competence Center Embedded Linux
>>




This message contains information that may be privileged or confidential=
 and is the property of the Capgemini Group=2E It is intended only for the=
 person to whom it is addressed=2E If you are not the intended recipient, =
 you are not authorized to read, print, retain, copy, disseminate, =
 distribute, or use this message or any part thereof=2E If you receive this=
  message in error, please notify the sender immediately and delete all =
 copies of this message=2E

------_=_NextPart_001_01C8042F.723E9EA1
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3=2E2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6=2E5=2E7652=
=2E24">
<TITLE>RE: [Xenomai-core] crashing 2=2E6=2E22</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: xenomai-core-bounces@domain.hid on behalf of Labozzetta, Saverio<BR>
Sent: Mon 2007-10-01 2:42 PM<BR>
To: Jan Kiszka; Gilles Chanteperdrix<BR>
Cc: xenomai-core<BR>
Subject: Re: [Xenomai-core] crashing 2=2E6=2E22<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
&gt;&gt;-----Original Message-----<BR>
&gt;&gt;From: xenomai-core-bounces@domain.hid on behalf of Jan Kiszka<BR>
&gt;&gt;Sent: Mon 2007-10-01 11:32 AM<BR>
&gt;&gt;To: Gilles Chanteperdrix<BR>
&gt;&gt;Cc: xenomai-core<BR>
&gt;Subject: Re: [Xenomai-core] crashing 2=2E6=2E22<BR>
&gt;&gt;<BR>
&gt;&gt;Gilles Chanteperdrix wrote:<BR>
&gt;&gt;&gt; On 10/1/07, Jan Kiszka &lt;jan=2Ekiszka@domain.hid&gt;=
 wrote:<BR>
&gt;&gt;&gt;&gt; Gilles Chanteperdrix wrote:<BR>
&gt;&gt;&gt;&gt;&gt; On 9/30/07, Jan Kiszka &lt;jan=2Ekiszka@domain.hid&gt;=
 wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt; Philippe Gerum wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Sun, 2007-09-30 at 13:42 +0200, Jan Kiszka=
 wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Jan Kiszka wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Philippe Gerum wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Sun, 2007-09-30 at 12:22 +0200,=
 Jan Kiszka wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =2E=2E=2E<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; And a third<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; one only gives me=
 &quot;Detected illicit call from domain Xenomai&quot; before the<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; box reboots=2E :(<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Grmff=2E=2E=2E Do you run with=
 your smp_processor_id() instrumentation in?<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Yes, but I suspect this is just a=
 symptom of some severe memory<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; corruption that (also?) hits I-pipe=
 data structures=2E I just put in some<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; different instrumentation, and that=
 warning is gone, the box just hangs<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; hard at a different point=2E Very=
 unfriendly=2E<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hah! Got some crash log by hacking a raw=
 printk-to-uart:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [=2E=2E=2E]<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;6&gt;Xenomai: starting RTDM services=
=2E<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;6&gt;NET: Registered protocol family=
 10<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;6&gt;lo: Disabled Privacy=
 Extensions<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;6&gt;ADDRCONF(NETDEV_UP): eth0: link=
 is not ready<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;3&gt;I-pipe: Detected illicit call=
 from domain 'Xenomai'<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=
 &lt;3&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service=
 reserved for domain 'Linux' and below=2E<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 f3a6bc18 00000000 00000000 c05dad6c f3a6bc3c c0105fc3 c03513c7=
 c05dc100<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 00000009 f3a6bc54 c01479cb c03592f8 c0357ae2 c035e069 f3a6bc88=
 f3a6bc70<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 c0127224 c0111df8 00000000 f3a6bd74 00000000 f3a6bd74 f3a6bc80=
 c012727f<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Call Trace:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c010520f&gt;]=
 show_trace_log_lvl+0x1f/0x40<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c01052e1&gt;]=
 show_stack_log_lvl+0xb1/0xe0<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0105fc3&gt;]=
 show_stack+0x33/0x40<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c01479cb&gt;]=
 ipipe_check_context+0x7b/0x90<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0127224&gt;]=
 __atomic_notifier_call_chain+0x24/0x60<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c012727f&gt;]=
 atomic_notifier_call_chain+0x1f/0x30<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0131e02&gt;]=
 notify_die+0x32/0x40<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0105d29&gt;]=
 do_invalid_op+0x59/0xa0<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0111d0b&gt;]=
 __ipipe_handle_exception+0x7b/0x144<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c02dfaeb&gt;]=
 error_code+0x6f/0x7c<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Wow=2E Why that?<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0111d13&gt;]=
 __ipipe_handle_exception+0x83/0x144<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c02dfaeb&gt;]=
 error_code+0x6f/0x7c<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; And this? We should not get any exception over=
 an IPI3 handler=2E I guess<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; the double fault may be explained by this root=
 cause=2E<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c01117df&gt;]=
 __ipipe_handle_irq+0x4f/0x140<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; [&lt;c0104c5e&gt;]=
 ipipe_ipi3+0x26/0x40<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Our LAPIC timer vector=2E Are you running full=
 modular or statically btw?<BR>
&gt;&gt;&gt;&gt;&gt;&gt; Fully modular=2E Compiling the nucleus in makes=
 the lock-up move to<BR>
&gt;&gt;&gt;&gt;&gt;&gt; another, once again invisible spot=2E<BR>
&gt;&gt;&gt;&gt;&gt;<BR>
&gt;&gt;&gt;&gt;&gt;&gt; I nailed down the fault address in the scenario=
 above=2E It's in the<BR>
&gt;&gt;&gt;&gt;&gt;&gt; nucleus module, at the first byte of=
 xntimer_tick_aperiodic=2E Are we<BR>
&gt;&gt;&gt;&gt;&gt;&gt; loosing module text pages over the time? This=
 functions must have been<BR>
&gt;&gt;&gt;&gt;&gt;&gt; executed before as the timer was armed while I=
 collected the<BR>
&gt;&gt;&gt;&gt;&gt;&gt; /proc/modules and then triggered the crash=2E<BR>
&gt;&gt;&gt;&gt;&gt; There is a pending issue about vmalloced areas, which=
 I completely forgot:<BR>
&gt;&gt;&gt;&gt;&gt; <A HREF=3D"https://mail=2Egna=
=2Eorg/public/xenomai-core/2007-02/msg00138=2Ehtml">https://mail=2Egna=
=2Eorg/public/xenomai-core/2007-02/msg00138=2Ehtml</A><BR>
&gt;&gt;&gt;&gt;&gt;<BR>
&gt;&gt;&gt;&gt; Would this explain my problems which are already visible=
 without any<BR>
&gt;&gt;&gt;&gt; Xenomai application running (and also without unloading=
 the modules<BR>
&gt;&gt;&gt;&gt; again, to answer Philippe's question)? Hell, I would love=
 to find the<BR>
&gt;&gt;&gt;&gt; reason here, debugging this stuff stopped being fun a long=
 time ago=2E=2E=2E<BR>
&gt;&gt;&gt;<BR>
&gt;&gt;&gt; It would explain bugs involving a race between task creation=
 and<BR>
&gt;&gt;&gt; vmalloc/ioremap=2E But the bug would only happen with Xenomai=
 tasks<BR>
&gt;&gt;&gt; running,<BR>
&gt;&gt;<BR>
&gt;&gt;I don't need to start any Xenomai task to trigger the problem=
=2E<BR>
&gt;&gt;<BR>
&gt;&gt;&gt; otherwise, the vmalloced/ioremaped area would be mapped lazily=
 as usual=2E<BR>
&gt;&gt;<BR>
&gt;&gt;I guess module text pages are not mapped lazily, otherwise quite a=
 lot<BR>
&gt;&gt;of things would have fallen apart much earlier, right?<BR>
&gt;<BR>
&gt; AFAIK Once inserted module text pages are part of the kernel, so=
 have<BR>
&gt;to be reliably ready as long as the servicies offered are=
 registred,<BR>
&gt;is the insertion function which allocates memory, access it to=
 write<BR>
&gt;the text of the module and make it part of the kernel, so is keep=
 in<BR>
&gt;main memory=2E<BR>
&gt;<BR>
<BR>
I've been silly: the pages are directly allocated in kernel space=
 (GFP_KERNEL),<BR>
and some of their addresses are pointed by the function offered in some<BR>
kernel tables=2E=2E=2E<BR>
<BR>
BTW: sorry about the following nasty copiright abuse patch, is=
 automatically<BR>
attached to any mail I send outside, an sorry also for the filthy email=
 client<BR>
I use, but I've not found other ways since they put exchange on=2E=2E=
=2E<BR>
<BR>
&gt;&nbsp; Saverio<BR>
&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;Jan<BR>
&gt;&gt;<BR>
&gt;&gt;--<BR>
&gt;&gt;Siemens AG, Corporate Technology, CT SE 2<BR>
&gt;&gt;Corporate Competence Center Embedded Linux<BR>
&gt;&gt;<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>This message=
 contains information that may be privileged or confidential and is the=
 property of the Capgemini Group=2E It is intended only for the person to=
 whom it is addressed=2E If you are not the intended recipient,  you are=
 not authorized to read, print, retain, copy, disseminate,  distribute, or=
 use this message or any part thereof=2E If you receive this  message in=
 error, please notify the sender immediately and delete all  copies of this=
 message=2E<br>
<br>
</font></td></tr></table>
------_=_NextPart_001_01C8042F.723E9EA1--


