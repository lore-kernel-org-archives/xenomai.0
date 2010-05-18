Message-ID: <4BF248D4.4050207@domain.hid>
Date: Tue, 18 May 2010 09:59:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF1794A.6050207@domain.hid>	<181804936ABC2349BE503168465576460EBD6778@domain.hid>	<4BF1D6F0.2030305@domain.hid>
	<181804936ABC2349BE503168465576460EBD6788@domain.hid>
	<4BF23BF7.2010206@domain.hid>
In-Reply-To: <4BF23BF7.2010206@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

Jan Kiszka wrote:
> Steve Deiters wrote:
>> I guess that is my point though.  Not being all too familiar with the
>> inner workings of Linux or glibc, how am I supposed to know which
>> services are not emitting a syscall?  I accept that I will lose
>> determinism in calling these services, but I find it odd that it may
>> allow the system to deadlock.
>>
>> If nothing else the syscall-less services should be listed and noted as
>> unsafe.  I am new to most of this, but I have went through most of the
>> documentation and, unless I have overlooked it, found nothing mentioning
>> this.
> 
> Key services that do not reliably trigger syscalls:
> 
>  - gettimeofday
>  - clock_gettime (unless the POSIX skin is in use)
>  - malloc
>  - free
> 
> There are no guarantees either, but this list turned out to be fairly
> complete while porting a large (x86) application from plain Linux to
> Xenomai. Only gettimeofday (and, conditionally, clock_gettime) suffer
> from the live-lock problem.
> 
> For runtime checks, enable T_WARNSW / PTHREAD_WARNSW for your RT
> threads, additionally link against librtdk, --wrap the above services,
> and assert_nrt() will trigger a SIGDEBUG when they are used from a RT
> thread (just like normal syscalls will do).
> 
> There should be a few more services in the glibc that trigger malloc
> internally without issuing a syscall. When you come across one (check
> the man pages), additions to xenomai/src/rtdk/assert_context.c are welcome.

Should not we make things more automatic? Integrate rtdk into libxenomai
and forcibly do the wrapping? I am also thinking about modifying
rt_print to make it possible to use it as a drop-in replacement of
printf, and wrap it when using the posix skin.

-- 
					    Gilles.

