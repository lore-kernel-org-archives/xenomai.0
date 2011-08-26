From: Jeremy Friesner <jaf@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Aug 2011 13:54:23 -0700
Message-Id: <2BB74055-EB0C-4474-BA76-BE4227C56B50@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Xenomai-help] Xenomai 2.5.3 process doubles its memory footprint
	when spawning a subprocess?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jeff Koftinoff <jeffk@domain.hid>

Hi all,=20

I've got a program that runs under Xenomai 2.5.3 .... its process =
contains a Xenomai real-time thread, a few dozen non-real-time threads =
(used for disk I/O), and the main() thread which uses Linux's SCHED_RR =
at a high priority but is not, of course, a Xenomai real-time thread.

In general this all works quite well... there is one problem that I am =
seeing, though.  Occasionally the main() thread needs to spawn a =
sub-process to handle certain non-real-time chores (for example, it =
might spawn an rsync process to back up some files to a remote machine). =
 Depending on the feature being exercised, does this via the standard =
fork()/exec() calling sequence, or via forkpty(), or in some instances =
it just calls system().

The problem is that when the program has a lot of RAM allocated (e.g. a =
gigabyte or so) and/or a lot of I/O threads present, the spawning of the =
sub-process becomes very resource-intensive.  For example, in my testing =
I can do a system("/bin/sleep 1") and see the computer's RAM usage =
briefly shoot up from ~55% to ~95%, while the CPU usage spikes to 100% =
for a second or two, before the CPU usage and RAM usage both come back =
down again.  If there is a bit more RAM allocated by my program, this =
can even run the computer completely out of memory, causing my program =
and/or various other processes to report errors, crash, or exit.

I suspect that is has something to do with mlockall() and/or some other =
aspect of Xenomai partially or fully defeating the fork() call's =
Copy-On-Write feature, meaning that when the sub-process is spawned, =
most or all of the RAM pages allocated by the parent process are being =
duplicated, even though they are all going to be thrown away again =
immediately because I'm going to call exec() right afterwards.

My question is, is there some recommended way to launch a sub-process =
from a large Xenomai process that will avoid massive amounts of =
overhead?  I suppose I could launch a separate, persistent, non-Xenomai =
process that would act as a "non-Xenomai process server", and connect to =
it via TCP and ask it to spawn processes on my behalf.... but that seems =
like an awful lot of extra work.  Is there an easier way around this =
problem?

Thanks,
Jeremy=

