Message-ID: <465ECF6D.40006@domain.hid>
Date: Thu, 31 May 2007 15:36:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
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

RAKOTOSALAMA, Nirilanto wrote:
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
> I read switchtest program, and I conclude that in a xenomai and RT perspective, it seems "nicer"
> to set affinity each threads separately during their init phase before the RT infinite loop.
> Otherwise, setting affinity after child threads creation from its parent, may switch them into 
> secondary mode during their RT loop, and at an unknown moment.
> Argumentation is important for my internship because I have to port on xenomai a very big RT 
> posix based application. And I should justify any modifications and prevent potential problems.
> 
> Sorry, I don't know if it is clear.

I think that it is safe to assume that if the affinity of a thread is
inherited from the thread that created it with Linux posix library, the
same will happen with Xenomai.

Now, if you want to set the affinity of a group of threads after their
creation, I do not see how to do this without walking through the list
of threads. If your library has an abstraction for threads, you can keep
them in a list. It will be useful at process exit time to cleanly cancel
all threads (this may be useful if you want to detect leaks for instance).

Note that when talking about scheduling affinity function, we are
swimming in the undefined, since these functions are not standardized by
posix.

But since you are porting a library to Xenomai maybe you can have a look
at the current implementation of CPU_AssignPID ?

-- 
                                                 Gilles Chanteperdrix


