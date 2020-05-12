MIME-Version: 1.0
References: <CAAvDm6bKxtaf-xg5bM+SGgt39CrTh94chO9rfs-NuAO4nwPx3w@mail.gmail.com>
 <37d2adba-f2e4-dd77-89cc-a6d5ee95ee34@freyder.net>
In-Reply-To: <37d2adba-f2e4-dd77-89cc-a6d5ee95ee34@freyder.net>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 12 May 2020 14:37:47 +0800
Message-ID: <CAAvDm6ZKzpHp5g6G2x71-HSzOaq88E6TbhbbUMBZwx+pE9-NhA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_When_the_linux_process_could_recieve_the_message?=
 =?UTF-8?Q?_transport_through_XDDP=EF=BC=9F?=
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
To: steve freyder <steve@freyder.net>
Cc: xenomai <xenomai@xenomai.org>

Hi,Steve:
     Thank you for the clarification.

    >>Will ADOES wake up the related linux process at once when the head
    >>domain write something to the XDDP node?* Or, the linux process
    >>has to wait for the schedule of linux kernel, if the processor is
    >>busy, it may wait for a long long time.
    >The Linux process cannot wake up immediately, otherwise what would
    >be the point of having an RT co-kernel if it didn't preempt the
    >non-RT environment.
     Yea=EF=BC=8CI can't agree  more.
     Imagine this  scenario, your processor have 4 cores and you only have
one
     RT process which has single thread.So, there are 3 cores could be used
     for the linux processes at least. What i am interested in is that* if =
*
*     the linux process wait to receive message through XDDP has to compete=
*
*     for the cpu resources** with so many other linux processes .*

     >If you're going to build code that makes a NRT process a subordinate
     >of an RT process, you're going to have to employ some non-standard
    >logic and get creative about how you deal with the inverted priority
    >relationship that implicitly exists between the RT/NRT schedulers
    >involved in that scenario.

    What do you mean by " employ  some non-standard logic"=EF=BC=9FCould yo=
u make
me more clearlly?

     Thank you for your attention.
     Look forward to hearing from you.

steve freyder <steve@freyder.net> =E4=BA=8E2020=E5=B9=B45=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:43=E5=86=99=E9=81=93=EF=BC=9A

> On 5/11/2020 9:16 PM, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
>
> Hi,
>      As i am using XDDP to transport messages bettween the head domain an=
d
> linux domain(i mean there are two processes, one is rt process, the other
> is linux process.),I wonder that when the linux process could recieve the
> message=EF=BC=9F
>      *Will ADOES wake up the related linux process at once when the head
> domain write something to the XDDP node?* Or, the linux process has to wa=
it
> for the schedule of linux kernel, if the processor is busy, it may wait f=
or
> a long long time.
>
>      Thank you for your attention.
>      Looking forward to hearing from you.
>
> The Linux process cannot wake up immediately, otherwise what would be the
> point of having an RT co-kernel if it didn't preempt the non-RT environme=
nt.
>
>
> If the RT process wishes to give the non-RT process an opportunity to run
> in order to receive the just-sent message, it had better relinquish the
> CPU.  Inserting an rt_sleep() call (or equivalent) might be one
> (inelegant?) option, but certainly nothing in iPipe or anything at that
> layer is going to magically solve that problem for you.
>
>
> If you're going to build code that makes a NRT process a subordinate of a=
n
> RT process, you're going to have to employ some non-standard logic and ge=
t
> creative about how you deal with the inverted priority relationship that
> implicitly exists between the RT/NRT schedulers involved in that scenario=
.
> XDDP is a bidirectional data relay, not a scheduler.
>
>
> Regards,
>
> Steve
>
>
>
