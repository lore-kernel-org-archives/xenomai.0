Message-ID: <48722055.2090801@domain.hid>
Date: Mon, 07 Jul 2008 15:55:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48721B0D.5070003@domain.hid>
	<a9dc62b9d29de870cdd353c83ea844f8@domain.hid>
In-Reply-To: <a9dc62b9d29de870cdd353c83ea844f8@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Matthieu wrote:
>>> I need a clock to get the time with a 10 µs precision. I tought using
>> this
>>> master timebase, as it gives me a time in nanoseconds, irrespective of
>>> vxworks timebase.
>> That will work. The master timebase is always active and does return
>> nanoseconds
>> when inquired.
> 
> What instruction I use to get this time ? 
> I tried :
> 
> #include <native/timer.h>

#include <nucleus/timebase.h>, but that's not the point.

> xntbase_get_time(&nktbase);
> 
> But it doesn't work

It ought to work, otherwise nothing would. What's the issue? Unpected result?

-- 
Philippe.

