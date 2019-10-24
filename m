MIME-Version: 1.0
References: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
 <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
 <CAJPjb1+d___e1BE3tk=us9WAr0HcW3QC5ROgWaRUMPXngudqpQ@mail.gmail.com>
 <8148a617-8087-076e-f1f1-bd337e2c7a14@siemens.com>
 <CAJPjb1KgLBHRq+myFgWATpOYi3ifUahj5G2f9VQe7YKgr0UhVQ@mail.gmail.com>
 <CAJPjb1KwBgJp+Zx2CKjCK2y8C6Omj43EQCSm2CnSffbZ01AOSg@mail.gmail.com>
 <CAJPjb1JYRu493q_zpBKDLRS9HhcGb-4YvZqr12nuQN0_JwC4gA@mail.gmail.com>
 <CAJPjb1+qSBrqC5FX5j5E9awpBT6y6Z_wz8+oPR_=hQP_RsnBvA@mail.gmail.com>
 <61b4cc10-1197-2e74-8fff-9c2878287390@web.de>
In-Reply-To: <61b4cc10-1197-2e74-8fff-9c2878287390@web.de>
From: Rob Miller <rob.miller@broadcom.com>
Date: Thu, 24 Oct 2019 07:46:19 -0400
Message-ID: <CAJPjb1JCojSH_TmL0jwkBpCVhzNEJbPKsNMVkr_p5Wq2LLE+aQ@mail.gmail.com>
Subject: Re: Xenomai fails to start when running in QEMU VM
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai <xenomai@xenomai.org>

Pls see below

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Thu, Oct 24, 2019 at 6:25 AM Jan Kiszka <jan.kiszka@web.de> wrote:

> On 23.10.19 23:23, Rob Miller via Xenomai wrote:
> > Correction, stock images work by removing the enable-kvm and *NOT *adding
> > the -no-hpet QEMU cmdline options.
> >
> > also latency numbers are crazy with avg being 1678.126 usec w/ worst case
> > being 15463.240usec
> >
> > at this point, I'm not sure which way to go:
> >
> > 1) do I hunt down issues in HPET failing w/ KVM mode enabled?
> > 2) just go to dovetail
> > 3) ???
>
> Don't have a the reference image around, but I'm pretty sure it would
> work here with QEMU 4300b7c2cd9f3f273804e8cca325842ccb93b1ad (post 4.1)
> and KVM from 5.3.6. At least a different image is being used like that
> for ages, and kernel config in xenomai-image is basically derived from it.
>
RJM>] Will try

>
> For the xenomai-images check, did you use "start-qemu.sh x86" as-is?
>
RJM>] Yes, my 1st failed attempts used unmodified start-qemu.sh x86, then I
mod'd the file to remove the -enable-kvm, and it started to work UNTIL also
added -no-hpet, then I can't even boot up.

>
> Jan
>
