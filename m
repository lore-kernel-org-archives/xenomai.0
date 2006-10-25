Date: Wed, 25 Oct 2006 16:32:48 +0200 (MEST)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] Re: [Xenomai-core] I-pipe patch for ARM S3C24xx
In-Reply-To: <1161783684.5114.16.camel@domain.hid>
Message-ID: <Pine.GSO.4.64.0610251623480.19474@domain.hid>
References: <E1Gapzw-0005RB-Ob@domain.hid>
	<E1GcJqn-0000Eo-Lv@domain.hid>
	<1161783684.5114.16.camel@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-559023410-851401618-1161786768=:19474"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manfred.schlaegl@domain.hid
Cc: xenomai@xenomai.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1161786768=:19474
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	studserv.stud.uni-hannover.de id k9PEWows023369

On Wed, 25 Oct 2006, Schl=E4gl Manfred jun. wrote:

> On Tue, 2006-10-24 at 12:49 +0200, Sebastian Smolorz wrote:
>>> Hi all,
>>>
>>> I'm currently working on porting I-pipe to the ARM S3C24xx. The patch=
 is
>>> attached, it must be applied after the shipped
>>> adeos-ipipe-2.6.15-arm-1.5-01.patch. Unfortunately, there is still a =
severe
>>> bug somewhere. I built Xenomai as modules. When I try to modprobe
>>> xeno_native, the system hangs. No reaction at all, inlcuding serial c=
onsole
>>> and network access. I guess that interrupts are not handled any more.=
 From
>>> what I see if I spread some debug printk() into my code, the timer st=
arts
>>> working under the control of the Xenomai domain and one or two calls =
to the
>>> Linux timer interrupt handler are made. But after that nothing happen=
s any
>>> more.
>>>
>>> As I try to find the bug for some days now but wasn't successful mayb=
e the
>>> experts have any hints where to continue searching. Or perhaps there =
is
>>> someone who can test it and confirm or disprove my observation? It wo=
uld be
>>> great to support one more ARM model.
>>
>> Small update with new infos: After Xenomai has (re)started the system =
timer
>> the Linux timer interrupt handler ist called only once, but
>> xnintr_clock_handler() is called several thousand times. So it seems t=
hat the
>> timer interrupt handler of Linux is not properly called or Xenomai is
>> starving Linux.
>>
>> Sebastian
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>
> Hi. I had the same Problem on my Netsilicon board.
>
> I changed my timer-clock from CPU_CLK/64 to CPU_CLK so Xenomai is able
> to use it with a higher granularity (set_dec/get_dec). So my machine ha=
s
> 1769472 ticks per jiffy instead of 27648. (works only with 32bit timers=
)
>
> Further I had to set CLOCK_TICK_RATE (/include/asm/arch-xxxx/timex.h) t=
o
> real cpu frequency (im my case around 176000000).
>
> Now I'm able to run latency with periods > 200us

I think we have different problems. I will give a more detailed=20
description in a separate mail.

Sebastian

P.S. Why did you change the mailing list within a thread? :-)
---559023410-851401618-1161786768=:19474--

