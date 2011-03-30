Message-ID: <4D93A7F9.8060108@domain.hid>
Date: Thu, 31 Mar 2011 00:00:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>	<4D89A334.4090802@domain.hid>
	<AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>
In-Reply-To: <AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Jeff Weber wrote:
>>> I need to timetag events from a realtime context with a NPT-synchronized
>>> system clock.  This topic comes up periodically on the mailing list.
>>  Last I
>>> recall, there was talk of adding the capability via an alternate
>>> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
>> The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
>> 2.6 branch, soon). It requires modifications of the I-pipe patch which
>> are available, at least, on x86, but are probably not really hard to
>> implement on other platforms.
>>
> 
>  clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and from
> clocktest.  Any ideas why?
> Does the CLOCK_HOST_REALTIME need to be initialized in some way?
> Test and config follow.
> 
> TIA,
> Jeff
> 
> 
> 
> # /usr/xenomai/bin/clocktest -D -C 42
> hostrt data area is not live
> clock_gettime failed for clock id 42
> hostrt data area is not live
> 
> # grep -rw CLOCK_HOST_REALTIME /usr/xenomai/include/
> /usr/xenomai/include/posix/time.h:#define CLOCK_HOST_REALTIME 42
> 
>  # zgrep HOSTRT /proc/config.gz
> CONFIG_XENO_OPT_HOSTRT=y
> CONFIG_HAVE_IPIPE_HOSTRT=y
> 
> # cat /proc/xenomai/version
> 2.5.90
> 
> # cat /proc/ipipe/version
> 2.9-00
> 
> # uname -r
> 2.6.37.3-xeno-head-smp
> 
> Architecture is x86 32-bit SMP with TSC.

CLOCK_HOST_REALTIME will work, only if the Linux kernel also uses the
TSC as its clocksource. So, check the "Switching to clocksource"
messages, or "disabling.*tsc" in the kernel log to see if the kernel has
not decided to use another clock source.

-- 
                                                                Gilles.

