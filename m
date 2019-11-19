Message-ID: <1574179267.6990.8.camel@smigroup.net>
Subject: Re: rt_task_self() return value
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 19 Nov 2019 17:01:07 +0100
In-Reply-To: <4d3fa642-8ac7-cd92-20cb-e755627783ab@siemens.com>
References: <1574177353.6990.5.camel@smigroup.net>
 <4d3fa642-8ac7-cd92-20cb-e755627783ab@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

On Tue, 2019-11-19 at 16:41 +0100, Jan Kiszka wrote:
> On 19.11.19 16:29, Mauro Salvini via Xenomai wrote:
> > Hi all,
> >=20
> > I'm using Xenomai 3.0.9 in cobalt mode and I'm facing an issue on
> > rt_task_self() returned value.
> >=20
> > Please see this simple code:
> >=20
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <alchemy/task.h>
> >=20
> > RT_TASK gNewTask;
> >=20
> > static void Task(void *lpArgument)
> > {
> > 	rt_printf("Task created.\n");
> > 	gNewTask =3D *(rt_task_self());
>=20
> This fills the internal data structure RT_TASK with the content of=C2=A0
> another one. Rather than "cloning", did you try using a reference as
> the=C2=A0
> API suggests? If that worked in Xenomai 2, it was luck.
>=20

Hi Jan,

thanks for your answer.
Yes, I tried it and even does not work. Changing code in this way:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alchemy/task.h>

RT_TASK* gNewTask;

static void Task(void *lpArgument)
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_printf("Task created.\=
n");
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gNewTask =3D rt_task_self=
();
}

int main()
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RT_TASK tNewTask;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err =3D rt_task_creat=
e(&tNewTask, "TEST", 16384, 10,
T_JOINABLE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_printf(" task create: =
%d\n", err);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D rt_task_start(&tN=
ewTask, Task, NULL);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_printf(" task start: %=
d\n", err);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_task_sleep(2000000000)=
;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0//err =3D rt_task_join(&t=
NewTask);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D rt_task_join(gNew=
Task);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_printf(" task join : %=
d\n", err);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
}

returns:

./test
=C2=A0task create: 0
Task created.
=C2=A0task start: 0
=C2=A0task join : -3


Thanks, regards

-- Mauro

