Message-ID: <441816CE.2040206@domain.hid>
Date: Wed, 15 Mar 2006 14:29:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenoami task pids
References: <067C9A1F6AFEB643895EA4513E116884178FBD@exfp1.Railpowertech.local>
In-Reply-To: <067C9A1F6AFEB643895EA4513E116884178FBD@exfp1.Railpowertech.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Moser, Dan" <DMoser@domain.hid>
Cc: xenomai@xenomai.org

Moser, Dan wrote:
> Hi,
> 
> I am a Linux and Xenomai newbie.
> 
> I have two separate Xenomai 2.1-rc4 environments, one I built with
> Gentoo running under VMware (WindowsXP Host) and another (that somebody
> else built sometime in the recent past) with Gentoo running native on a
> PC.
> 
> I have identical code (and Makefile) that simply executes an
> rt_task_create(), rt_task_set_periodic(), and rt_task_start() and runs
> (seemingly) proper on both boxes.
> 
> But:
> 
> On one box, the main thread and the Xenomai task thread have DIFFERENT
> pids (reported via a call to getpid()).  On the other box, the main
> thread and the Xenomai task thread have the SAME pid (again, reported
> via a call to getpid()).
> 
> Is there some sort of Xenomai and/or application config/build option
> that controls this behavior?

Looks like one box uses an old glibc with LinuxThreads support (multiple pids are 
visible from the application, one for each created thread including the main one), 
and the other one a more recent NPTL-based pthread support (getpid() returns a 
single "main" pid per process, although the NTPL still enforces a 1:1 mapping 
between user-space and kernel threads that support them). This is not a Xenomai 
issue in fact, but rather a glibc one, given that Xenomai relies on the glibc to 
create user-space threads before promoting them to the real-time domain it controls.

Reading this may help:
http://publib.boulder.ibm.com/infocenter/wasinfo/v5r1//index.jsp?topic=/com.ibm.websphere.base.doc/info/aes/ae/cins_nptl.html

> 
> Thanks in advance,
> Dan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

