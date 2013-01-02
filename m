MIME-Version: 1.0
In-Reply-To: <382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
Date: Wed, 2 Jan 2013 10:40:05 +0100
Message-ID: <CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On Mon, Dec 31, 2012 at 7:18 PM, Michael Haberler <mail17@mah.priv.at>wrote:

> Hi Gilles,
>
>
> I would think Henri is in better position to explain the genealogy; the
> way I understand it is is a merge of torvalds 3.2.21 onto this TI 3.2
> branch:
> http://arago-project.org/git/projects/linux-am33x.git?p=projects/linux-am33x.git;a=commit;h=d7e124e8074cccf9958290e773c88a4b2b36412b
>
> Henri told me this:
>
> > I made this tree for supporting the AM335x-evm board. The beaglebone is
> untested with this tree.
> > This posting and thread sums what I did to get the tree
> http://www.xenomai.org/pipermail/xenomai/2012-October/026594.html.
>

That post sums up well what I did to get to what I pushed to github. The
core-3.2 patch was from commit 8d70b0110a15beed9e4d692a49775bff9f575280.

Note that this was just a quick port to the AM335x-evm board which I only
used for evaluating our application on this board. There are some shortcuts
that need proper solving (and some hooks specific to our application that
got pushed by accident). Actually it was pushed to github only to guide
Stefan Videv to bring up Xenomai on his AM335x-evm board.

I took Henri's branch and merged
> http://arago-project.org/git/projects/linux-am33x.git?p=projects/linux-am33x.git;a=shortlog;h=refs/heads/v3.2-stagingwhere all the 3.2 related fixes show up.
>
> I wound up with this configuration;
> http://git.mah.priv.at/gitweb/linuxcnc-kernel.git/blob/ce9f5236ec183aff622ffc4c59e331957167f934:/arch/arm/configs/mah_bbone_defconfig which works fine for a few people working on LinuxCNC on the beaglebone in
> a tftp boot/nfs root setting.
>
> I'm sorry to be fuzzy/slightly belletristic on this, I'm not very firm in
> this space. I am also a tad confused by the number of options - there's the
> Arago project sources which look 'most TI official' to me, then the Koen
> Koi kernels, and the Robert C Nelson kernels (both on github) with a
> bewildering variety of branches.
>

My decision to base the port on the Arago project was also that it looked
'most TI official' to me. TI ships an evaluation disk with the AM335x-evm
board that is based on this project.


> I did try to replicate Stephan Kappertz's work, as well Sheng Chao's, both
> of which went nowhere for me, but that doesnt mean they dont work; just not
> for me.
>
>
> - Michael
>
>
>
> Am 31.12.2012 um 18:31 schrieb Gilles Chanteperdrix:
>
> > On 12/31/2012 05:39 PM, Michael Haberler wrote:
> >
> >> Bao,
> >>
> >> I got Xenomai working fine, based on Henri Roosen's branch:
> https://github.com/roosen/linux/tree/v3.2.21_AM33xx_core-3.2
> >
> >
> > Hi Michael,
> >
> > if you tell us on which unpatched kernel this branch is based, we could
> > generate the pre- and post- patches we have been talking about.
>

I still have the evaluation board on my desk. If there will be pre- and
post- patches please let me know and I will be happy to test these on the
AM335x-evm board. My focus for the coming weeks will be on the iMX6 based
(SabreLite) boards, but if cooking up the pre- and post- patches takes
little time and someone wants to guide me I am happy to help out there too.


> >
> > Regards.
> >
> >
> > --
> >                                                                Gilles.
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
