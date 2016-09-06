From: Tobias Luksch <Tobias.Luksch@itk-engineering.de>
Date: Tue, 6 Sep 2016 15:38:41 +0000
Message-ID: <fe0243c96682430eb5c01ebec98b269e@itk-engineering.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Multiple processes within same session
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

[Arch:x86, Processor:Corei7, Kernel: 4.1.18, Xenomai:3.0.2]

we are using several Xenomai processes communicating using shared memory (r=
t_heap) and a few named mutexes. The processes also create additional unnam=
ed task, mutexes, semaphores, etc.
After porting to Xenomai 3, I see the following problem: To access the shar=
ed heap, I start two processes within the same session (--session from comm=
and line). Shared access to the heap works, but when creating unnamed objec=
ts, e.g. a mutex, in the second process, rt_mutex_create returns -17.

Here is a small example program to reproduce this:

#include <alchemy/task.h>
#include <alchemy/mutex.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	rt_printf("hello  world\n");
	RT_MUTEX mutex;
	int ret_val =3D rt_mutex_create( &mutex, NULL );
	rt_printf( "rt_mutex_create: %d\n", ret_val );

	while (true)
	{
		rt_task_sleep(1000000000);
		rt_printf("ping\n");
	}
	return 0;
}

Starting this program (called xeno-test here) once gives:
$ ./xeno-test --session=3Dtest
hello  world
rt_mutex_create: 0
ping
ping
[..]

Starting it a second time with the same session:
$ ./xeno-test --session=3Dtest
hello  world
rt_mutex_create: -17
ping
ping
[..]

Starting the program another time with a different session works without er=
ror. Also using differently named mutexes for both instances works.

I am not sure about the naming mechanism (if any) when creating unnamed obj=
ects like mutexes, nor about what is actually shared between processes when=
 using the same session. It would be great if anyone could give some detail=
s on this.

Any help would be appreciated.

Best regards,
Tobias





