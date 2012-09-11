MIME-Version: 1.0
In-Reply-To: <504F6C8E.8070706@logilin.fr>
References: <CAP1DbD7y_G+5tjUucgXE57gA-8K4vMCe5s_cVfOoEJV3CVF_RQ@mail.gmail.com>
	<504F6604.2000104@xenomai.org> <504F6C8E.8070706@logilin.fr>
From: Soo-Hyun Yoo <yoos117@gmail.com>
Date: Tue, 11 Sep 2012 11:27:26 -0700
Message-ID: <CAP1DbD7vj4zFCZf69pFSBw0Mn_XqXg1r0mD6_UBYiW_jcbiR2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Children of forked process do not die upon receiving
 SIGKILL in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christophe Blaess <mailist@logilin.fr>
Cc: xenomai@xenomai.org

On Tue, Sep 11, 2012 at 9:53 AM, Christophe Blaess <mailist@logilin.fr> wro=
te:
> Le 11/09/2012 18:25, Gilles Chanteperdrix a =C3=A9crit :
>
>> On 09/11/2012 06:22 PM, Soo-Hyun Yoo wrote:
>>>
>>> Hello,
>>>
>>> I have a certain process "A" that forks and execs a process "B". B
>>> spawns multiple child processes.
>>>
>>> In the vanilla Linux kernel, I can have A send a SIGTERM or SIGKILL to
>>> B and thereby successfully kill B and all of its children.
>
> No, the childs of B remain alive. Try this code.
>
> *test-kill.c*
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> int main(void)
> {
>     pid_t pid;
>
>     fprintf(stderr, "[%d] I'm A\n", getpid());
>     if ((pid =3D fork()) =3D=3D 0) {
>         fprintf(stderr, "[%d] I'm B\n", getpid());
>        if (fork() =3D=3D 0) {
>             while (1) {
>                 fprintf(stderr, "[%d] I'm C\n", getpid());
>                 sleep(1);
>             }
>         } else {
>             while (1) {
>                 fprintf(stderr, "[%d] I'm B\n", getpid());
>                 sleep(1);
>             }
>         }
>     }
>     sleep(3);
>     fprintf(stderr,"A kills B\n");
>     kill(pid, 9);
>     fprintf(stderr, "and A exits\n");
>     exit(0);
> }
>
>
> And you'll see :
>
> $ ./test-kill
> [15925] I'm A
> [15926] I'm B
> [15926] I'm B
> [15927] I'm C
> [15926] I'm B
> [15927] I'm C
> [15926] I'm B
> [15927] I'm C
> A kills B
> and A exits
> $ [15927] I'm C
> [15927] I'm C
> [15927] I'm C
> [15927] I'm C
> [15927] I'm C
> [15927] I'm C
> [15927] I'm C
>
> To kill B's childs, you need to send the signal to the group of processes=
.

I see I had misunderstood the way in which processes work. Thank you
for the code. Apparently, I also did not test this as thoroughly as I
thought I had.

What really is a problem is that Robot Operating System's rosbag (our
process B) does not die properly upon receiving a SIGINT in Xenomai
(whereas it does in vanilla Linux) and instead gets stuck at 100% CPU
core usage in a few of its threads. This is what led me to 4 hours of
fumbling around with other signal types. This, however, is a different
problem that is probably more related to ROS, so I will ask on their
mailing list.

Soo-Hyun Yoo

>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

