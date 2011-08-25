Message-ID: <4E568CFC.2050203@domain.hid>
Date: Thu, 25 Aug 2011 19:57:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>	<4E54EAE4.2060705@domain.hid>	<CAL+uwv9Lg6uhqwy_YMxevFt4e8RJLrxZhm186L4-0xAHYDgLUw@domain.hid>	<4E54F5B4.5070100@domain.hid>	<CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>	<4E552695.7090401@domain.hid>
	<CAL+uwv8La8ad9Vc8HZYhvgMyWb0=5r5-X1yy1aDKJ-jauJgESw@domain.hid>
In-Reply-To: <CAL+uwv8La8ad9Vc8HZYhvgMyWb0=5r5-X1yy1aDKJ-jauJgESw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Hanging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 08/25/2011 11:25 AM, suresh reddy wrote:
> Dear Giles,

It is Gilles.

> 
> 1. taking timing results using rt_timer-tsc on pandaboard for a test program
> using xenomai native services.
> 
> 2. taking timing results using gettimeofday on pandaboard for same test
> program using linuxthreads.
> 
> 
> Can i compare these two timing results ?

your system is likely using nptl, not linuxthreads. And clock_gettime
instead of gettimeofday will give you precision down to the nanosecond,
like rt_timer_tsc2ns.

But yes, you can compare the results, if you bear in mind that real-time
is about worst case latencies, so results obtained by running tests for
a few seconds or minutes on an idle machine are meaningless.

Also note that since Xenomai has a posix api, you can have the exact
same code running with and without xenomai.

-- 
                                                                Gilles.

