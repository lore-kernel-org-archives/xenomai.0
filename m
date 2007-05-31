From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
Content-Type: text/plain
Date: Thu, 31 May 2007 16:28:05 +0200
Message-Id: <1180621686.5020.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
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
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2007-05-31 at 15:08 +0200, RAKOTOSALAMA, Nirilanto wrote:
> Hi,
> 
> I'm still blocked on a CPU affinity problem.
> In order to adapt a set affinity function which is based on
> posix linux lib :
> - CPU_AssignPID(uint32 PID, uint32 CPU_id)
> - the cpu affinity of the caller and all its child threads must be set to CPU_id.
> 
> Problems are:
> Child PIDs must be listed, the only means I found is listing pids using `ls /proc/"Parent pid"/ > temp_file`
> And each listed pid is sched_setaffinity'ed.
> I don't know if setting affinity of RT threads from an other thread (parent) using pid works with xenomai.
> 
> So, my question is :
> With xenomai, is recursively cpu affinity setting from a parent thread, a good way of doing ?

Neither good nor bad. The (i.e. your == Airbus code) library you are
trying to adapt _wants_ to set the CPU affinity for an entire process
hierarchy, probably to remain compatible with the behaviour inherited
from legacy RT environments. Therefore, unless you want to change this
behaviour at interface specification level (unlikely, right?), you need
your code to recurse down the process tree too.

> I read switchtest program, and I conclude that in a xenomai and RT perspective, it seems "nicer"
> to set affinity each threads separately during their init phase before the RT infinite loop.

There are two questions here:

Q. whether setting affinity during the init phase is best
A. yes, since you want to use the regular sched_setaffinity(2) call for
that, this will switch the caller to secondary mode, and you don't want
such mode switch to happen during the actual RT processing.

Q. whether you should opt for flat or process tree-based affinity setup.
A. it depends on your requirements. IIUC, your specs imply recursive
setup (because you want to mimic some existing behaviour), so the point
seems moot here. However, it is always better not to rely on implicit
affinities; you may end up with a sub-optimal runtime configuration,
just because the existing process hierarchy may not always be consistent
with the optimal CPU placement. This said, again, you might have no
choice here if you need to port some existing library without
significant changes, especially wrt the higher level code using such
library.

> Otherwise, setting affinity after child threads creation from its parent, may switch them into 
> secondary mode during their RT loop, and at an unknown moment.

Actually, only the caller (i.e. the one who calls set_schedaffinity)
would switch to reenter the Linux kernel properly, in order to submit
the sched_setaffinity() request. When a thread running in primary mode
is set a different CPU affinity by another thread using the regular
Linux kernel service (here, the former thread must be aslept waiting for
some Xenomai resource), then the new affinity would be enforced only
when the target thread leaves primary mode. For an immediate migration
to take place while running in primary mode, you need to ask Xenomai to
manage it, but there is no direct interface from the POSIX skin to the
nucleus service performing this magic.

To sum up, with the Xenomai POSIX interface, you need to call
sched_setaffinity(2) to set the CPU affinity for both Xenomai and
regular threads, and if you want to recurse down a process hierarchy,
you need to make sure that all the targeted children are waiting in a
plain Linux context, for some master thread to ask for such global
migration. For instance, you could just sync them all on some init
barrier which would mark the end of the initialization phase, and the
latter would include setting the CPU affinity.

This said, CPU affinity is a task property inherited upon fork, so if
you manage to have the parent of the process tree setting up the right
affinity before creating any child thread, you are basically done.

> Argumentation is important for my internship because I have to port on xenomai a very big RT 
> posix based application. And I should justify any modifications and prevent potential problems.
> 
> Sorry, I don't know if it is clear.
> 
> Thanks in advance, Niry.
> 
> This e-mail is intended only for the above addressee. It may contain privileged information.
> If you are not the addressee you must not copy, distribute, disclose or use any of the information in it. 
> If you have received it in error please delete it and immediately notify the sender.
> Security Notice: all e-mail, sent to or from this address, may be accessed by someone other than the recipient, for system management and security reasons. This access is controlled under Regulation of security reasons.
> This access is controlled under Regulation of Investigatory Powers Act 2000, Lawful Business Practises.
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



