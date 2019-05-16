Date: Thu, 16 May 2019 23:56:52 +0200 (CEST)
From: <cern@tuta.io>
Message-ID: <Lf1YPs7--3-1@tuta.io>
Subject: Getting started with Xenomai, installing on Debian, problem with
 sysregd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello,
I am getting into Xenomai world by installing co-kernel onto new netinstall=
 (with Desktop) Debian 10 installation with kernel version 4.14.111, I-pipe=
 version  ipipe-core-4.14.111-x86-3.patch and Xenomai branch stable/v3.0.x =
installed as a Debian packages by use of the Xenomai Debian folder. (Based =
on Installation guide from Xenomai wiki and couple articles found on the we=
b.)

The installation of kernel patched package is without problem. Installation=
 of Xenomai library packages is also uneventful. I modified the debian/rule=
s file:

CONFIG_OPTS =3D --prefix=3D/usr \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --includ=
edir=3D/usr/include/xenomai \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --mandir=
=3D/usr/share/man \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --with-t=
estdir=3D/usr/lib/xenomai/testsuite \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable=
-smp \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable=
-pshared \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable=
-registry \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --with-c=
ore=3Dcobalt \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --with-p=
ic

And I am able to run latency test both as a root and as a regular user (who=
 is member of the xenomai group).

Then I tried simple test:

#include <stdio.h>
#include <stdbool.h>
#include <xenomai/init.h>
#include <alchemy/task.h>
#include <xenomai/tunables.h>

RT_TASK task;
RT_TASK loop_task;

void loop_task_task(void *arg)
{
RT_TASK *currtask;
currtask =3D rt_task_self();
rt_task_set_periodic(currtask, TM_NOW, 100000);
RTIME then =3D rt_timer_read();
=C2=A0 while(true){
=C2=A0=C2=A0=C2=A0 printf("Loop time: %.5f ms\n", (rt_timer_read() - then)/=
1000000.0);
=C2=A0=C2=A0=C2=A0 rt_task_wait_period(NULL);
=C2=A0 }
}

int main(int argc, char *const *argv) {

set_runtime_tunable(verbosity_level,10);

int retval;
retval =3D rt_task_create(&task,"First",0,98,0);
printf("%i return on create\n",retval);


retval =3D rt_task_create(&loop_task, "loop_task", 0,99,0);
retval =3D rt_task_start(&loop_task,loop_task_task, NULL);
pause();
retval =3D rt_task_delete(&loop_task);
retval +=3D rt_task_delete(&task);
printf("%i return on delete\n",retval);
printf("%s", "END");
return 0;
}

Which run as a root without problem, but with regular user there is a probl=
em of:

sysregd: create_directory_recursive("/var/run/xenomai/orion/anon@684"): Per=
mission denied
sysregd: create_directory_recursive("/var/run/xenomai/orion/anon@684"): Per=
mission denied
sysregd: create_directory_recursive("/var/run/xenomai/orion/anon@684"): Per=
mission denied
=C2=A0=C2=A0 0"600.015| WARNING: [main] cannot connect to registry daemon
=C2=A0=C2=A0 0"600.059| WARNING: [main] setup call copperplate failed
=C2=A0=C2=A0 0"600.072| BUG in __xenomai_init(): [main] initialization fail=
ed, EAGAIN

When run as regular user with --no-registry, it again run.

Looking at the registry when run as a root also gives odd info about tasks,=
 respectively gives no info (readable). Only info is given on system in sys=
tem folder.

The First file in tasks opened with nano gives:

^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@$

Also, under the /var/run/xenomai/root/ there seems to hang tasks which shou=
ld already be deleted.

>From https://unix.stackexchange.com/questions/175380/how-to-list-all-runnin=
g-daemons <https://unix.stackexchange.com/questions/175380/how-to-list-all-=
running-daemons> I tried the=20
$ ps -eo 'tty,pid,comm' | grep ^?
but see no sysregd. Is there way to determine if sysregd works correctly?

Thank you,
Cern.


