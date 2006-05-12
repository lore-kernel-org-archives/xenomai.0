Message-ID: <44646A0A.90406@domain.hid>
Date: Fri, 12 May 2006 12:57:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44646131.9090600@domain.hid>
In-Reply-To: <44646131.9090600@domain.hid>
Content-Type: multipart/mixed; boundary="------------030909030606080506010200"
Subject: [Xenomai-core] Re: [BUG] kernel oops on registry duplicate names
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030909030606080506010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> The subject pretty much explains it all.
>=20
> Just try to create a task named "foo" and a queue also named "foo".
>=20
> Tested in 2.1.1 and svn HEAD.
>=20

I can't reproduce it with the attached simple test. rt_queue_create()=20
returns -EEXIST as expected. Do you have any test frag to reproduce it?

--=20

Philippe.

--------------030909030606080506010200
Content-Type: text/x-csrc;
 name="dup.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dup.c"

#include <sys/types.h>
#include <sys/mman.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <native/task.h>
#include <native/queue.h>

RT_TASK task;

RT_QUEUE q;

void queuer (void *x)

{
    int err;

    err = rt_queue_create(&q,"foo",16*1024,Q_UNLIMITED,Q_FIFO);
    printf("rt_queue_create() = %d, mapaddr=%p, mapsize=%u\n",err,q.mapbase,q.mapsize);
    err = rt_queue_delete(&q);
    printf("rt_queue_delete() = %d, mapaddr=%p, mapsize=%u\n",err,q.mapbase,q.mapsize);
}

int main (int argc, char **argv)

{
    mlockall(MCL_FUTURE|MCL_CURRENT);
    rt_task_create(&task,"foo",0,2,T_FPU);
    rt_task_start(&task,&queuer,(void *)(argc > 1));
    pause();
    exit(0);
}

--------------030909030606080506010200--

