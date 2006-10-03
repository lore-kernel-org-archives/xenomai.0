Date: Tue,  3 Oct 2006 09:47:34 +0200
Message-Id: <J6JUZA$835CBCA6714D18503B21543C9C3611BE@laposte.net>
Subject: Re:[Xenomai-help] POSIX API Questions
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "jeff.webb" <jeff.webb@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

---------- Debut du message initial -----------

De     : xenomai-help-bounces@domain.hid
A      : "Xenomai help" xenomai@xenomai.org
Copies : 
Date   : Mon, 02 Oct 2006 13:16:13 -0500
Objet  : [Xenomai-help] POSIX API Questions

> I have a couple of questions regarding the userspace POSIX
API...
> 
> I remember reading somewhere that in order to make blocking
> calls to Xenomai resources from the main thread, a Xenomai
> shadow thread needs to be created by calling rt_task_shadow.
>  Of course, this routine is part of the native API.  From
> my research, the equivalent way of doing this using the
> POSIX skin appears to be adding these lines to the main
> program:
> 
>   struct sched_param sparam;
>   sparam.sched_priority =3D 0; /* Must be zero for SCHED_OTHER? */
>   pthread_setschedparam(pthread_self(), SCHED_OTHER, &sparam);
> 
> The documentation says that calling pthread_setschedparam
for the
> main thread will make it into a Xenomai task.  So, is the above
> code correct?  The main thread is intended to be a non-RT I/O
> thread that communicates with an RT thread via POSIX message
> queues.
> 
> When I look at /proc/xenomai/sched, it appears that a shadow
> thread is created even if I omit the call to
> pthread_setschedparam mentioned above.  Is this always done
> automatically, or should I follow the procedure above and
> explicitly call pthread_setschedparam?

The main thread is automatically shadowed by the POSIX skin
library initialization routine. Most people need this anyway
and if they do not need it, it is harmless.

> 
> I am new to POSIX thread programming (and Xenomai), so I am
> trying to figure out how everything works.  I have attached
> an example that compiles and runs under vanilla linux as
> well as Xenomai using the POSIX API.  It appears to work
> the way I would expect.  I would appreciate it if someone
> would look it over the example see if the signal handling,
> task creation/deletion, error handling, mqueue operation,
> etc. looks correct.  

A word about the process termination: using atexit is error
prone, because the registered callback get called in the 
context of the thread that is calling exit, before the
cancellation handlers are called, so for example if a thread
is calling exit while holding a mutex and the routine
registered with atexit need to lock the same mutex, the program
deadlocks. I experienced various issues trying to terminate
cleanly a posix application, the method I would advise is the
one used by the switchtest program.


> Am I doing anything that would make my rt_thread non-RT? 
(e.g. is it
> okay to call snprintf?)

I do not see anything suspicious, but in order to be sure you can
use pthread_set_mode_np(0, PTHREAD_WARNSW) to cause a SIGXCPU
signal to be sent when the calling thread involontary switches to 
secondary mode. See:
http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread.=
html#ga14


-- 
                 Gilles Chanteperdrix=0A=0AAcc=E9dez au courrier =E9lectr=
onique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A


