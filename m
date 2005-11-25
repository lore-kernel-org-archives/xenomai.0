Message-ID: <4386C775.4070603@domain.hid>
Date: Fri, 25 Nov 2005 09:12:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Priorities in the vxWorks skin
References: <000001c5f050$416d9e00$7b030080@domain.hid>
In-Reply-To: <000001c5f050$416d9e00$7b030080@domain.hid>
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
To: "Hans-J. Ude" <software@domain.hid>
Cc: xenomai@xenomai.org

Hans-J. Ude wrote:
> When I create some tasks under the vx skin with different priorities and
> then look at the /proc/xeno/sched file they are all listed with the
> value 2. Shouldn't priorities be mapped to the internal priority scale?
> Of course I can't expect the original vx values there but nevertheless
> they shouldn't be all the same. I've created an rtai interrupt handler
> task with priority 99 too. That one appeares with the value 100 in the
> list.
> 

The explanation is accessible there:
http://download.gna.org/xenomai/documentation/tags/v2.0.1/pdf/Introduction-to-UVMs.pdf

In short, in the context of the UVM, a user-space copy of the nucleus is 
running embodied into your Linux process, this is the one that enforces 
the VxWorks priority levels. To this end, it only uses three scheduling 
levels from the real nucleus in kernel space it communicates with, in 
order to schedule the application threads: one for the interrupt 
services, one for the idle thread, and the final one for the thread that 
should be running application-wise. Non-running threads are simply 
suspended from the in-kernel nucleus POV.

> regards,
> Hans
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

