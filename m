Subject: Re: What are the relations bettween COBALT_SYSCALL(ioctl, handover,
 args...) and COBALT_IMPL(int, ioctl, args...)?d
References: <CAAvDm6Zk5xh-8R12MxuJKgc8b2Gw5K1hLqLHcwdzj=bDqJoyHw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d800b23b-2654-f722-bdf5-5ea55435ac5d@siemens.com>
Date: Mon, 11 May 2020 08:50:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Zk5xh-8R12MxuJKgc8b2Gw5K1hLqLHcwdzj=bDqJoyHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 11.05.20 08:22, 孙世龙 via Xenomai wrote:
> Hi,
>      What are the relations bettween* COBALT_SYSCALL(ioctl, handover,
> args...) *and* COBALT_IMPL(int, ioctl,  args...)*?
>      The related source code could be seen in the urls listed below.
>       https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/lib/cobalt/rtdm.c
> （COBALT_SYSCALL(
> ioctl )）
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9/kernel/cobalt/posix/io.c （
> COBALT_IMPL(int, ioctl,  args...) ）
> 
>       Similar question is bettween *COBALT_SYSCALL_DECL(sched_yield, (void) *
> and * COBALT_IMPL(int, sched_yield, (void)).*
> 

The former site issues the ioctl to the Xenomai core, the latter is the 
entry point (after generic syscall handling) inside the kernel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

