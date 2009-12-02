Message-ID: <4B166A5B.6030400@domain.hid>
Date: Wed, 02 Dec 2009 14:23:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>
In-Reply-To: <4B1663B9.8030306@domain.hid>
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
To: Wolfgang Mauerer <wm@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Mauerer wrote:
> Hi,
> 
> we'd like to implement a gettimeofday() mechanism that works
> in realtime context, both from user- and kernelland. Most importantly,
> the correctins made to the wall time by the NTP protcol on Linux
> must be transferred into the Xenomai domain.

Yes, the real issue is NTP, because other than that, you can simply
implement gettimeofday in terms of clock_gettime(CLOCK_REALTIME).

This issue has been discussed several times, but never a lot. We have a
simple solution: starting with 2.4 (if I remember correctly) xenomai
provides clock_settime, so you can simply rely on clock_gettime, and
call clock_settime from time to time to resync the Xenomai clock with
Linux NTP-enhanced clock. This is not pretty, you get a drift increasing
over time, then suddenly been reset. But I guess this has been enough
for current users, until now. You control the maximum drift by how often
you call clock_settime.

Would not it be enough for your use of xenomai?

-- 
                                          Gilles


