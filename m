Message-ID: <4F5F9077.8000700@domain.hid>
Date: Tue, 13 Mar 2012 19:22:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <584FFDF8F96BB74593285A7D65886EC008B91F25@domain.hid>
In-Reply-To: <584FFDF8F96BB74593285A7D65886EC008B91F25@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] system locks when calling Linux clock_gettime
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/13/2012 07:06 PM, Herrera-Bendezu, Luis wrote:
> Hello,
> 
> Xenomai version 2.4.10, Linux version 2.6.30.3, CPU PPC.
> 
> I am trying to work around an issue where the Linux and Xenomai realtime clocks
> drifts when Linux clock is updated by NTP. It was suggested in the mail exchange:
> http://www.mail-archive.com/xenomai@xenomai.org
> 
> to use clock_gettime()/clock_settime() to keep both clocks in sync.
> 
> However, calling linux clock_gettime() from a Xenomai  thread is causing system to
> freeze after a few minutes as shown in the following test program where the interval
> to re-sync clocks is small, 50 msec, to force error faster:

Yes, this is a known issue too. You can only call __real_clock_gettime
when in secondary mode. So, preferably from a thread created with
__real_pthread_create.

Any chance of updating xenomai? Xenomai 2.6 allows accessing a clock
synchronized with Linux clock from xenomai threads, without even
emitting a system call depending on the architecture.

-- 
                                                                Gilles.

