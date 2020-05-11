MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 11 May 2020 14:22:53 +0800
Message-ID: <CAAvDm6Zk5xh-8R12MxuJKgc8b2Gw5K1hLqLHcwdzj=bDqJoyHw@mail.gmail.com>
Subject: What are the relations bettween COBALT_SYSCALL(ioctl, handover,
 args...) and COBALT_IMPL(int, ioctl, args...)?d
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
To: xenomai <xenomai@xenomai.org>

Hi,
    What are the relations bettween* COBALT_SYSCALL(ioctl, handover,
args...) *and* COBALT_IMPL(int, ioctl,  args...)*?
    The related source code could be seen in the urls listed below.
     https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/lib/cobalt/rtdm.c
=EF=BC=88COBALT_SYSCALL(
ioctl )=EF=BC=89
https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/kernel/cobalt/posix/io=
.c =EF=BC=88
COBALT_IMPL(int, ioctl,  args...) =EF=BC=89

     Similar question is bettween *COBALT_SYSCALL_DECL(sched_yield, (void) =
*
and * COBALT_IMPL(int, sched_yield, (void)).*

    Thank you for your attention.
    Look forward to hearing from you.
