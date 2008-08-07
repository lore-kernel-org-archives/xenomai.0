MIME-Version: 1.0
Date: Thu, 7 Aug 2008 10:12:52 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <488DC8B8.4080403@domain.hid>
References: <488DC8B8.4080403@domain.hid>
Message-ID: <b746c4c3fce56fac573745df6ffe5aa3@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I tried to use xntslave_start/stop in my rtdm module, but it seems that,
despite xntslave_start/stop instructions are present in my System.map, th=
e
linker don't archive :
    > grep xntslave_start /boot/System.map-2.6.25-pae
    c01629b9 T xntslave_start
    > depmod -F /boot/System.map-2.6.25-pae -e vxworks_tick_time_module.k=
o
    WARNING: vxworks_tick_time_module.ko needs unknown symbol
xntslave_start
    WARNING: vxworks_tick_time_module.ko needs unknown symbol xntslave_st=
op
I looked at the sources and found that xntbase_start/stop have the same
goals, so I use this instead of xntslave_start/stop.

My RTDM driver works well and all my ioctls work too.

I encounter something not expected : when I use xntbase_update to change
vxworks timebase period, /proc/xenomai/timebase file gives me the right
Resolution for vxworks timebase, but my test program that calculate this
value (with a task that waits for a tick thanks to a watchdog and semapho=
re
mechanism) gives me a really wrong value. And I don't know why.

I have an other problem : my rtdm module allows me to get the master time
base value using xntbase_get_time(&nktbase), but it seems like the value
returned isn't given in nanosecond. I test that getting the value in an
approximate 1 second interval, and when I check for the difference betwee=
n
the two values, I get something like 15 to 30 seconds !!

Could you tell me what can I do to find where is the problem ?

Thank you

Matthieu







