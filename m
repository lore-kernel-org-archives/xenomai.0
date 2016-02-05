Date: Fri, 5 Feb 2016 10:51:28 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160205105128.027df956@md1em3qc>
In-Reply-To: <1454618843.7389.35.camel@hpe.com>
References: <20160204131901.6cd6924b@md1em3qc>
 <1454604076.7389.27.camel@hpe.com>
 <20160204173528.50a028bb@md1em3qc>
 <1454618843.7389.35.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] huge ioremap from kernel 4.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, 4 Feb 2016 13:47:23 -0700
Toshi Kani <toshi.kani@hpe.com> wrote:

> On Thu, 2016-02-04 at 17:35 +0100, Henning Schild wrote:
> > On Thu, 4 Feb 2016 09:41:16 -0700
> > Toshi Kani <toshi.kani@hpe.com> wrote:
> >  =20
> > > On Thu, 2016-02-04 at 13:19 +0100, Henning Schild wrote: =20
> > > > Hey Toshi,
> > > >=20
> > > > i am working on the xenomai project where we recently rebased
> > > > our patches on 4.1. The fact that io-regions may be mapped as
> > > > huge pages caused some problem in our patch.
> > > >=20
> > > > Whenever memory is vmalloced or ioremapped we make sure it is
> > > > synched into all mm's to avoid page faults in that area. We use
> > > > vmalloc_sync_one to do that. Now vmalloc_sync_one can not handle
> > > > huge pages (i am talking about x86 32+64). Hence for areas
> > > > where you introduced huge pages vmalloc_fault should never
> > > > happen in any mm, otherwise your patchset would have introduced
> > > > a regression in mainline.
> > > >=20
> > > > Can you help me understand by which mechanism these io-regions
> > > > are always mapped into all mm's, ruling out calls to
> > > > vmalloc_fault and vmalloc_sync_one? Because calling this on
> > > > these regions will treat you device memory as pagetables when
> > > > huge pages are used.=C2=A0=C2=A0 =20
> > >=20
> > > The hugepage feature is enabled on x86 PAE and 64. =C2=A0You can
> > > disable this hugepage feature by using "nohugeiomap" kernel
> > > option. =C2=A0You can use this option to workaround the issue for the
> > > time being. =20
> >=20
> > That is what we do at the moment but in the long run we would like
> > our patch to be able to use the feature.
> > =C2=A0 =20
> > > That said, vmalloc_sync_one() may not be used for ioremap'd
> > > ranges. (BTW, this function is defined on 32-bit only, so I
> > > assume you only call it on 32-bit, and do not see the problem on
> > > 64-bit..?) =20
> >=20
> > Back in 4.1 there is a 32- and 64-bit version. I saw that the 64bit
> > version is gone in the meantime, but probably just folded into its
> > single user or something.
> >=20
> > Do you happen to know the reason why it may not be used? Is there
> > another reason except the now obvious "cant deal with huge pages"
> > vs. "contains huge pages since 4.1". =20
>=20
> No, and now that I think this should be cleaned up...
>=20
> > > ioremap
> > > itself sets up the page tables for the entire range. =C2=A0Hence,
> > > there is no page fault when you access to the ioremap'd range.
> > > =C2=A0If you simply remove this call, I think you should be fine. =20
> >=20
> > Removing the call is exactly what i plan to do. But before doing
> > that i would like to understand why faults in that area can never
> > happen. When calling ioremap the current mm will get the full
> > mapping, nothing lazy here. But how do all the other pre-existing
> > mm's also get that mapping?
> > Say a device interrupt with iomem-access in the handler hits the
> > init-process. That wont cause a fault because somehow the mappings
> > where synched into the init-mm from the modprobe-mm, right? How
> > and
> > where is that done?
> >=20
> > One possible way would be sharing of pagetables. =20
>=20
> When a process is created via fork(), it calls pgd_alloc(), which then
> calls pgd_ctor(). =C2=A0This function copies the kernel's pgd entries to
> the process's pgd for the kernel ranges. =C2=A0So, process's pgd shares
> the same page tables for the kernel space.

Sure a new process will inherit the current kernel reference. The
pinning we do is for pre-existing mm's that did not inherit those
parts when they where forked. Hence the example with init and a later
insmod causing ioremap. There has to be a way to sync the changes from
the insmod mm into the init-mm. Otherwise running the device driver in
the init-mm could cause #PFs.
So i am afraid it is still not completely clear to me.

> Let me know if I am missing something.

Sorry to bother you with these questions, but you obviously know that
subsystem better than me.

regards,
Henning

