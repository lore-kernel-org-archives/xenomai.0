MIME-Version: 1.0
References: <d0dbd921-5127-0acc-a1df-ab5b173b7b00@siemens.com>
 <20201026082352.GB17437@linux.intel.com>
In-Reply-To: <20201026082352.GB17437@linux.intel.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 26 Oct 2020 09:45:07 -0400
Message-ID: <CALLqZ8RptPrOTccwKSU-L2ee0dYeuyJfZYaTRLTgbAdXM5W8vQ@mail.gmail.com>
Subject: Re: Kernel 5.4 status
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Oct 26, 2020 at 4:25 AM Fino Meng via Xenomai
<xenomai@xenomai.org> wrote:
>
> On Mon, Oct 26, 2020 at 08:54:54AM +0100, Jan Kiszka via Xenomai wrote:
> > Hi all,
> >
> > a brief update on the porting status to 5.4:
> >
> > - new noarch ipipe/master is ready:
> >
> >   https://gitlab.denx.de/Xenomai/ipipe-noarch/-/commits/ipipe/master
> >
> >   I've regenerated the queue from Fino's work, reviewing conflict
> >   resolutions once again. No issues found, well done! I've only done a
> >   few cleanups and added missing patches from the latest 4.19-noarch.
> >
> >   This should now be a reasonable baseline for porting other archs.
> >
> > - x86 5.4 branch is also ready:
> >
> >   https://gitlab.denx.de/Xenomai/ipipe-x86/-/commits/ipipe-x86-5.4.y
> >
> >   Here I added the FPU changes, fixing the hard-irqs mask leak and
> >   hardening an additionally needed path (fpu__clear). I've also done a
> >   full merge conflict review, and I think I found and fixed issues in
> >   the kvm code. Still untested, though. I've cleaned up the GTOD update.
> >   I furthermore fixed missing hard-irqs reenabling in some page-fault
> >   paths. And added latest x86 patches from 4.19.
> >
> > - Xenomai next is almost ready:
> >
> >   https://gitlab.denx.de/Xenomai/xenomai/-/commits/next
> >
> >   RTnet and Analogy are not building ATM. That still breaks CI. But the
> >   result is otherwise working fine, at least in QEMU/KVM. More tests
> >   welcome!
> >
> > Jan
> >
>
> Thanks Jan, and great team work! We really need Xenomai on newest Linux
> kenrel, not only used as bare metal, also working as RTVM in ACRN. We
> will contribute more on Xenomai and Dovetail.
>
> BR fino
>
> > --
> > Siemens AG, T RDA IOT
> > Corporate Competence Center Embedded Linux
> >
>

Great work, I'll start getting braches up for arm and arm64 development ready.

-Greg

