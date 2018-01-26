MIME-Version: 1.0
In-Reply-To: <df27493b419a4ff4a603ddc503201523@NANS01204.it.intra.sercel.com>
References: <df27493b419a4ff4a603ddc503201523@NANS01204.it.intra.sercel.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 26 Jan 2018 15:42:33 -0500
Message-ID: <CALLqZ8Tm90Wyg2-5qwxJfVL64ORrhBFCLCGHLiv2BsPpMjx97Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Writing to UDD driver through mapped memory cause
 secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MINIER Bertrand <Bertrand.MINIER@sercel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry to bring back an old thread but I just noticed this.  Did you
solve your issue?  Did you use the documentation in this file for
help? https://git.xenomai.org/xenomai-3.git/tree/include/cobalt/kernel/rtdm/udd.h?id=f4a54b173db71a182d9826852a94b20f6095b411

-Greg

On Thu, Dec 14, 2017 at 6:23 AM, MINIER Bertrand
<Bertrand.MINIER@sercel.com> wrote:
> Hi,
>
> I implemented an UDD driver for a SOC IP on my Xilinx Ultrascale ZCU102 board.
> The arch is arm64 so I'm using Xenomai from the next branch.
>
> When I try to write to the memory mapped from the user space side, Xenomai switches to secondary mode.
>
> I activated the SIGDEBUG and attached an handler to point the origin and the reason of this secondary mode switch.
> The result of sigdebug_reason(siginfo) is SIGDEBUG_MIGRATE_FAULT.
>
> I'm using mmap with the following attributes:
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fpgaMemfd, 0);
>
> The file descriptor is opened with O_RDWR flag.
>
> What is strange is that memory write effectively works but the SIGDEBUG_MIGRATE_FAULT is triggered. Reading the physical driver memory with devmem returns the written value.
>
> Does anyone would have any idea about the origin of the issue ?
>
> Thanks,
>
> Bertrand Minier
>
>
> This e-mail and any accompanying attachments are confidential. If you are not the intended recipient, you must not review, disclose, copy, distribute or use this e-mail; please delete it from your system and notify the sender immediately.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

