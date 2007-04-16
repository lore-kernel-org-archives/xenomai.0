From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200704161449.27506.jweber@domain.hid>
References: <200704161449.27506.jweber@domain.hid>
Content-Type: text/plain
Date: Mon, 16 Apr 2007 22:05:33 +0200
Message-Id: <1176753934.15950.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] page faults
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On Mon, 2007-04-16 at 14:49 -0500, Jeff Weber wrote:
> I need some help finding the cause for page faults in my RT application.
> My app has a startup phase, where I can tolerate page faults, and a hard 
> realtime phase, where page faults cannot be tolerated.  Trouble is, I 
> continue to get page faults in the hard realtime phase.
> 
> The app encounters a page fault while writing to a heap buffer.  I've even 
> added steps to clear the entire buffer in the startup phase, after 
> mlockall(), to ensure each page is locked in place.  Here's a timeline of the 
> fault:
> 
> static constructor runs and allocates buffer from heap
> application main() runs
> begin application startup phase
> mlockall(MCL_CURRENT | MCL_FUTURE) runs and returns 0
> entire buffer cleared
> paranoid code even verifies buffer addr 0x81f4000 contents are 0
> begin application hard realtime phase
> time elapses ...
> page fault copying stack addr 0xb645a2d1 to heap buffer addr 0x81f4000
> 
> The page fault is confirmed by the kernel debug message:
> Xenomai: Switching mythread to secondary mode after exception #14 from 
> user-space at 0x80fb8c5 (pid 3558)
> 

Could you disassemble the code around location 0x80fb8c5?

> as well as the delivery of SIGXCPU to my application (at my request).
> 
> How do I prevent this page fault?
> 
> Is this issue covered by the recent NOCOW activity?
> 

Possibly. You need I-pipe 1.7-03 and Xenomai >= v2.3.1 to get the
ondemand mapping scheme disabled by the nucleus when your thread starts.

> 	thanks,
> 	Jeff
> 
> my config:
> CPU: VIA Nehemiah (i386)
> ipipe version: 1.5-00
> Xenomai: 2.2.4
> Linux kernel: 2.6.17.14
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



