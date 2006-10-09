Subject: Re: [Xenomai-help] 3rd party task mode switches and inquiries
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1160411937.6268.14.camel@domain.hid>
References: <1160411937.6268.14.camel@domain.hid>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 20:14:36 +0200
Message-Id: <1160417676.4981.4.camel@domain.hid>
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, 2006-10-09 at 11:38 -0500, Jeff Weber wrote:
> I have a need for task t1 to switch task t2 to and from primary mode,
> using the native API.  The rt_task_set_mode() API does not have an
> argument for the target task, and assumes the current task.  How can I
> initiate a 3rd party task mode switch?
> 

You can't, it's forbidden. Too many indirect issues would become
possible as a result of allowing that. Only the current task can switch
its own mode.

> On a related note, the task info returned from rt_task_inquire() does
> not indicate task mode switches in the corresponding T_PRIMARY (0x200)
> bit, which is the bit used to command the mode switch.  However, a mode
> switch can be seen in the 0x100 status bit, which corresponds to the
> XNRELAX bit, (not in the public native/task.h API).  What's the best way
> to inquire if an arbitrary task is in primary or secondary mode?
> 

Testing XNRELAX is the current way to do it, since no native interface
exists yet. Before this happens, there's some sanitization to do first
(e.g. if T_PRIMARY is used to switch mode, it should be usable to check
the status word too, instead of having T_SECONDARY as XNRELAX but which
could not be used for switching modes).

> I am using Xenomai-2.2.0.
> 
> thanks,
> 	Jeff Weber
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



