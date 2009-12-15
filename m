Message-ID: <4B27A62C.2050300@domain.hid>
Date: Tue, 15 Dec 2009 16:07:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid> <4B166A5B.6030400@domain.hid>
	<20091215150008.GA10925@domain.hid>
In-Reply-To: <20091215150008.GA10925@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Wed, Dec 02, 2009 at 02:23:39PM +0100, Gilles Chanteperdrix wrote:
>> This issue has been discussed several times, but never a lot. We have a
>> simple solution: starting with 2.4 (if I remember correctly) xenomai
>> provides clock_settime, so you can simply rely on clock_gettime, and
>> call clock_settime from time to time to resync the Xenomai clock with
>> Linux NTP-enhanced clock. This is not pretty, you get a drift increasing
>> over time, then suddenly been reset. But I guess this has been enough
>> for current users, until now. You control the maximum drift by how often
>> you call clock_settime.
> 
> Well, it looks like I will need to use this method, too, until the
> "real" solution comes along. But that leaves me with more questions:
> 
> 1. My program is written using the native skin, and I need to time
> stamp some data while in primary mode. Can I safely call the posix
> skin's clock_gettime() function from my native thread?

Yes.

> 
> 2. I will need a non-critical thread to go the gettimeofday() -
> clock_settime() adjustment hack once in a while. Can I safely start a
> both a posix skin thread and a native thread from the same main
> program?

Yes. But you should better use __real_clock_gettime than gettimeofday,
since it returns a struct timespec which you may feed into clock_settime
without any further adjustments.

-- 
                                          Gilles


