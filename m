Date: Wed, 26 Sep 2018 14:21:28 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180926142128.4a127510@md1pvb1c.ad001.siemens.net>
In-Reply-To: <CAPN7LrGe_wmRLdbvdcznMMqeyo1PgbrZnyUKVCWbfZAuF+t75A@mail.gmail.com>
References: <CAPN7LrHBjkFqi8x3KGmZDn810GuYTij4gpyQc1pxhFMiifdycQ@mail.gmail.com>
 <CAPN7LrGe_wmRLdbvdcznMMqeyo1PgbrZnyUKVCWbfZAuF+t75A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe 4.14 causing kernel stuck at "Loading initial
 ramdisk...", failed to boot on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: c ww <cww230@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Wed, 26 Sep 2018 18:24:50 +0800
schrieb c ww <cww230@gmail.com>:

> Hi all,
> 
> I was able to get it through by disabling the CONFIG_MAXSMP somehow.
> However, when i compiling the 4.14 kernel again from the
> henning/wip/4.14-split branch, it gave bunch of errors related to
> fpu.  :(

You will also need an unreleased version of xenomai, namely the "next"
branch. It contains fpu fixes needed for 4.14 x86.

Henning

> 
> 
> On Wednesday, September 26, 2018, c ww <cww230@gmail.com> wrote:
> 
> > Hi All,
> >
> > I wish to try use ipipe 4.14 with Xenomai 3 on x86 platform (core
> > i7-7700) running in Ubuntu linux. So i follow the discussion on the
> > email thread
> > ( https://www.mail-archive.com/xenomai@xenomai.org/msg14309.html),
> > downloaded the ipipe 4.14 repo, switched to henning/wip/4.14-split
> > branch as suggested by henning. From the xconfig, enabled the
> > CONFIG_IPIPE option and compiled the 4.14.58 kernel from the repo.
> > Upon compilation completed, trying to boot using the new compiled
> > kernel (4.14.58+), but it always hang at very beginning "Loading
> > initial ramdisk....".
> >
> > One thing i have verified and confirmed, when i compiled the 4.14.58
> > kernel *without *CONFIG_IPIPE option enable in kernel, the kernel
> > can be booted successfully. But once it is enabled, then the new
> > compiled kernel will always hang at "Loading initial ramdisk...".
> > So, may i know if anyone encounter similar issue with the
> > henning/wip/4.14-split branch and any workaround we can put in
> > place?
> >
> > Appreciate your kind advise on this...thanks!
> >
> >  
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


