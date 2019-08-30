MIME-Version: 1.0
From: Tormod Volden <lists.tormod@gmail.com>
Date: Fri, 30 Aug 2019 17:00:08 +0200
Message-ID: <CAArsGaYNRuA-=MuevVffbU63YfE4WnOKLwhRt+i4AZo77=Td+Q@mail.gmail.com>
Subject: missing compat version of rt_task_set_periodic
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I am porting an old RTNet / RTAI (3.8.1) application to latest xenomai
(currently using git master). For this I chose the alchemy skin, and
to make it as close as possible to the old API, I am also trying to
enable the --compat transition kit. However, rt_task_set_periodic()
disappears as soon as I add --compat. I am not sure whether it is an
include file / macro bug or if I am not using it correctly, so I hope
you can give me a hint.

xenomai was built from git master, with --configure --with-core=3Dcobalt
and installed.

$ xeno-config --skin=3Dalchemy --compat --cflags

-I/usr/xenomai/include/trank -D__XENO_COMPAT__
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
-I/usr/xenomai/include/alchemy

Here is a small compile test program:

$ cat xeno_compat_test.c

#include <alchemy/task.h>
void test(void)
{
  rt_task_set_periodic(NULL, TM_NOW, 0);
}

Using only --alchemy works fine:

$ gcc -c xeno_compat_test.c $(xeno-config --skin=3Dalchemy --cflags)
$

However, with --compat it fails:

$ gcc -c xeno_compat_test.c $(xeno-config --skin=3Dalchemy --compat --cflag=
s)
xeno_compat_test.c: In function =E2=80=98test=E2=80=99:
xeno_compat_test.c:6:3: warning: implicit declaration of function
=E2=80=98rt_task_set_periodic=E2=80=99; did you mean =E2=80=98rt_task_set_p=
riority=E2=80=99?
[-Wimplicit-function-declaration]
   rt_task_set_periodic(NULL, TM_NOW, 0);
   ^~~~~~~~~~~~~~~~~~~~
   rt_task_set_priority

Using --skin=3Dnative gives the same result as --compat. I found out
that I can use __current_rt_task_set_periodic() to force the use of
the "new" function, but I could't get something like
__compat_rt_task_set_periodic() to work.

Best regards,
Tormod

