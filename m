Message-ID: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
Date: Mon, 31 Mar 2008 18:29:03 -0400 (EDT)
From: vleves@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: jay@domain.hid

Hello,

A few months ago, my colleague Jerome Pasquero reported a problem with
calls to system() with the 2.4 branch of Xenomai
(https://mail.gna.org/public/xenomai-help/2008-01/msg00047.html). I am
experiencing the same problem with linux 2.6.24.4 and xenomai 2.4.2.

The problem occurs when calling system() or fork() in a realtime task. It
only seems to occur when the program is linked against other libraries
(e.g. -lxml2 or -lgtkmm-2.4). The mouse continues to function after the
call but the system becomes unresponsive and must be rebooted.

The problem can be reproduced by compiling and running the following code=
:

gcc -lgtkmm-2.4 -lnative `/usr/xenomai/bin/xeno-config --xeno-cflags`
`/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ main.cpp

#include <native/task.h>
#include <sys/mman.h>
int main(int argc, char* argv[])
{
	RT_TASK task;
	mlockall(MCL_CURRENT | MCL_FUTURE);
	rt_task_shadow(&task, "stress-gui", 50, 0);
	system("ls");
	return 0;
};

I tried to apply the patch suggested by Jan Kiszka
(https://mail.gna.org/public/xenomai-help/2008-01/msg00051.html) but I
wasn't able to find the version of linux kernel and xenomai that the patc=
h
was intended for.

I would appreciate your help to resolve or work around this problem. I am
using the system() calls to insert and remove modules with modprobe and
rmmod. Is there a better way to accomplish the same result? Is there a wa=
y
to terminate a realtime task and resume normal execution? I could then
execute the modprobe and rmmod commands before and after running the
realtime tasks.

Thank you,

Vincent Levesque
vleves@domain.hid





