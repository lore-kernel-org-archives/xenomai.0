Message-ID: <4BF1D63A.7050607@domain.hid>
Date: Tue, 18 May 2010 01:50:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF1794A.6050207@domain.hid>
	<181804936ABC2349BE503168465576460EBD6778@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD6778@domain.hid>
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
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai@xenomai.org

Steve Deiters wrote:
>> Yes, that's expected: If gettimeofday runs syscall-less, it 
>> tries to read the time offset from a page which the Linux 
>> kernel updates regularly. When user-space detects an ongoing 
>> update, it spins until that has completed. But as Xenomai 
>> runs the task with higher priority than the Linux update 
>> handler, you just ran into a live-lock.
>>
>> Switching on the Xenomai watchdog will confirm this: It will 
>> shoot that task, and the system will recover.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT T DE IT 1 Corporate 
>> Competence Center Embedded Linux
>>
> 
> I'm not all too familiar with the time handling in the kernel.  If you
> have any refernces that help me better follow your explanation that
> would be appreciated.
> 
> If you linked against the POSIX skin it would then seem there is no safe
> way of calling gettimeofday.  Even starting from main in this case is a
> real time task.  In this case I would think that gettimeofday should be
> either wrapped to force a mode change before calling
> __real_gettimeofday, or should somehow be expressly forbidden.


The reason why I did not wrap gettimeofday is that we already have a
wrapped clock_gettime, which is the newer service supposed to be used by
real-time applications. If you are not porting a non real-time
application, there is no reason to use gettimeofday, and if you are,
this guide:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Timing_services.

Should explain you what you need to do.

-- 
					    Gilles.

