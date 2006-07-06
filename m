Subject: Re: [Xenomai-help] Detecting switch to secondary mode
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20060706134351.2e582664@domain.hid>
References: <20060706134351.2e582664@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 13:55:47 +0200
Message-Id: <1152186947.4978.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "J. Niehaus" <Niehaus@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-07-06 at 13:43 +0200, J. Niehaus wrote:
> Hello,
> 
> I have written a xenomai application (posix-skin) with several tasks. All of them should normally use primary mode (SCHED_FIFO). While some are allowed to switch to secondary mode for stuff like I/O and memory allocation others must not switch due to hard realtime constraints. 
> 
> Is there a way to check if and how often a thread has switched to secondary mode and maybe even what system call caused the switch? While a test from within the program itself would be great some information from /proc/xenomai would also do.
> 

The MSW ("mode switch") column from /proc/xenomai/stats tells you how
many times any given thread switched to secondary mode; there is no
finer detail given though. Also, setting the PTHREAD_TRAPSW switch for a
thread using pthread_set_mode_np() makes Xenomai send this thread a
SIGXCPU signal upon switch from primary to secondary - it's a useful
debug tool when used along with GDB for instance.

> Thanks,
> 	Jens
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



