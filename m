Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2008 08:00:04 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0159@domain.hid>
In-Reply-To: <48FB7819.3010501@domain.hid>
From: <thomas.debes@domain.hid>
Subject: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello Alexis, hello Philippe,

thanks for your suggestions - the protection bits did the trick! Adding =
them to xnarch_remap_io_page_range(...) in rtdm_mmap_buffer() solved the =
problem. We already tried this few months ago using

pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE | _PAGE_GUARDED | =
PAGE_SHARED;

but missed the fact that xnarch_remap_io_page_range only takes =
PAGE_SHARED instead of use vma->vm_page_prot as its 5th parameter. I am =
not sure wether this extension will have side effects on other =
architectures. Maybe there is a better place for this fix. What do you =
think?

Thanks again!

Thomas




> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Philippe Gerum
> Gesendet: Sonntag, 19. Oktober 2008 20:11
> An: Gilles Chanteperdrix
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
>=20
> Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Alexis Berlemont wrote:
> >>>> Hi,
> >>>>
> >>>> On Friday 17 October 2008 06:46,=20
> thomas.debes@domain.hid wrote:
> >>>>> No comments or ideas? Providing this feature is=20
> essential for our=20
> >>>>> CPCI drivers. We have to port some Linux applications=20
> to Xenomai=20
> >>>>> which use that mmap stuff intensely.
> >>>>>
> >>>>> Thanks again!
> >>>>>
> >>>>> Thomas
> >>>>>
> >>>>>> -----Urspr=FCngliche Nachricht-----
> >>>>>> Von: xenomai-help-bounces@domain.hid
> >>>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
> >>>>>> thomas.debes@domain.hid
> >>>>>> Gesendet: Mittwoch, 8. Oktober 2008 11:49
> >>>>>> An: xenomai@xenomai.org
> >>>>>> Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> in the following thread I was asking for a solution to use
> >>>>>> rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)
> >>>> In 2.4 kernel, rtdm_iomap_to_user() is based on the function=20
> >>>> remap_page_range (with vma->vm_flags |=3D VM_RESERVED).
> >>>>
> >>>> Once, I had to develop a classical Linux driver (for PPC) which=20
> >>>> provided mmap functionalites so as to let a user=20
> application mmap a=20
> >>>> buffer allocated thanks to __get_free_pages().
> >>>>
> >>>> On a 2.6 kernel, I used remap_pfn_range() and it works=20
> great but on=20
> >>>> 2.4 kernel the function remap_page_range() did not work as I=20
> >>>> expected. I had a quick look on its implementation and I=20
> found that=20
> >>>> instead of mapping my buffer it mapped newly allocated=20
> zeroed pages (if my memories are correct).
> >>>>
> >>>> If I remember well, these pages were allocated in lazy=20
> mode. That=20
> >>>> could explain the freeze of your whole system: in case a RT=20
> >>>> application in primary mode tries to access the mmapped buffer.
> >>> Well, normally, the fault should cause the RT application=20
> to switch=20
> >>> to secondary mode and be handled gracefully from there,=20
> unless there=20
> >>> is a bug hidden in Xenomai or I-pipe. Besides, RT applications=20
> >>> usually use "mlockall", so the kernel should make all the pages=20
> >>> present and not rely on further faults (at least, is it=20
> how it works on 2.6).
> >>>
> >> powerpc may still trigger minor faults upon TLB misses=20
> though. That=20
> >> arch has a software-assisted MMU.
> >=20
> > Ok, and can these faults cause lockups when they happen in=20
> primary mode?
> >=20
>=20
> Unless I messed up things in the I-pipe patch, no. Depending=20
> on the MMU management code, some of them will reach the Linux=20
> fault handler and trigger the mode switch via the Xenomai=20
> fault handler, others will be processed directly from the=20
> low-level exception code when it is possible to fix up the=20
> mapping from there.
>=20
> As I mentioned a long time ago, the issue is more likely=20
> related to the protection bits used with PCI memory=20
> resources, which do require additional fixup on powerpc=20
> (_PAGE_GUARDED and _PAGE_NO_CACHE come to mind here).
>=20
> --
> Philippe.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! =
thomas.debes@domain.hid
--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

