Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Oct 2008 07:03:53 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018D015F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <48FDB900.5080102@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Dienstag, 21. Oktober 2008 13:12
> An: Debes, Thomas RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
>=20
> thomas.debes@domain.hid wrote:
> > Hello Alexis, hello Philippe,
> >=20
> > thanks for your suggestions - the protection bits did the trick!=20
> > Adding them to xnarch_remap_io_page_range(...) in=20
> rtdm_mmap_buffer()=20
> > solved the problem. We already tried this few months ago using
> >=20
> > pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE | _PAGE_GUARDED |=20
> > PAGE_SHARED;
> >=20
> > but missed the fact that xnarch_remap_io_page_range only=20
> takes PAGE_SHARED instead of use vma->vm_page_prot as its 5th=20
> parameter. I am not sure wether this extension will have side=20
> effects on other architectures. Maybe there is a better place=20
> for this fix. What do you think?
> >
>=20
> Not all archs will have the same requirements, unfortunately.=20
> Could you try the attached patch? It also makes sure that=20
> prefetchable PCI memory won't be accessed as page guarded in 2.6. TIA,


Ok, got it working. Everything works as expected (at least for kernel =
2.4). Will that patch be included in the next release (2.4.6)?

Regards
Thomas


>=20
> > Thanks again!
> >=20
> > Thomas
> >=20
> >=20
> >=20
> >=20
> >> -----Urspr=FCngliche Nachricht-----
> >> Von: xenomai-help-bounces@domain.hid
> >> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Philippe Gerum
> >> Gesendet: Sonntag, 19. Oktober 2008 20:11
> >> An: Gilles Chanteperdrix
> >> Cc: xenomai@xenomai.org
> >> Betreff: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
> >>
> >> Gilles Chanteperdrix wrote:
> >>> Philippe Gerum wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Alexis Berlemont wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Friday 17 October 2008 06:46,
> >> thomas.debes@domain.hid wrote:
> >>>>>>> No comments or ideas? Providing this feature is
> >> essential for our
> >>>>>>> CPCI drivers. We have to port some Linux applications
> >> to Xenomai
> >>>>>>> which use that mmap stuff intensely.
> >>>>>>>
> >>>>>>> Thanks again!
> >>>>>>>
> >>>>>>> Thomas
> >>>>>>>
> >>>>>>>> -----Urspr=FCngliche Nachricht-----
> >>>>>>>> Von: xenomai-help-bounces@domain.hid
> >>>>>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
> >>>>>>>> thomas.debes@domain.hid
> >>>>>>>> Gesendet: Mittwoch, 8. Oktober 2008 11:49
> >>>>>>>> An: xenomai@xenomai.org
> >>>>>>>> Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
> >>>>>>>>
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> in the following thread I was asking for a solution to use
> >>>>>>>> rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)
> >>>>>> In 2.4 kernel, rtdm_iomap_to_user() is based on the function=20
> >>>>>> remap_page_range (with vma->vm_flags |=3D VM_RESERVED).
> >>>>>>
> >>>>>> Once, I had to develop a classical Linux driver (for=20
> PPC) which=20
> >>>>>> provided mmap functionalites so as to let a user
> >> application mmap a
> >>>>>> buffer allocated thanks to __get_free_pages().
> >>>>>>
> >>>>>> On a 2.6 kernel, I used remap_pfn_range() and it works
> >> great but on
> >>>>>> 2.4 kernel the function remap_page_range() did not work as I=20
> >>>>>> expected. I had a quick look on its implementation and I
> >> found that
> >>>>>> instead of mapping my buffer it mapped newly allocated
> >> zeroed pages (if my memories are correct).
> >>>>>> If I remember well, these pages were allocated in lazy
> >> mode. That
> >>>>>> could explain the freeze of your whole system: in case a RT=20
> >>>>>> application in primary mode tries to access the mmapped buffer.
> >>>>> Well, normally, the fault should cause the RT application
> >> to switch
> >>>>> to secondary mode and be handled gracefully from there,
> >> unless there
> >>>>> is a bug hidden in Xenomai or I-pipe. Besides, RT applications=20
> >>>>> usually use "mlockall", so the kernel should make all the pages=20
> >>>>> present and not rely on further faults (at least, is it
> >> how it works on 2.6).
> >>>> powerpc may still trigger minor faults upon TLB misses
> >> though. That
> >>>> arch has a software-assisted MMU.
> >>> Ok, and can these faults cause lockups when they happen in
> >> primary mode?
> >> Unless I messed up things in the I-pipe patch, no.=20
> Depending on the=20
> >> MMU management code, some of them will reach the Linux=20
> fault handler=20
> >> and trigger the mode switch via the Xenomai fault handler, others=20
> >> will be processed directly from the low-level exception=20
> code when it=20
> >> is possible to fix up the mapping from there.
> >>
> >> As I mentioned a long time ago, the issue is more likely=20
> related to=20
> >> the protection bits used with PCI memory resources, which=20
> do require=20
> >> additional fixup on powerpc (_PAGE_GUARDED and=20
> _PAGE_NO_CACHE come to=20
> >> mind here).
> >>
> >> --
> >> Philippe.
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >>
> >=20
> > Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address!=20
> > thomas.debes@domain.hid
> > --------------------------------------------------------
> > manroland AG
> > Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> > Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch,=20
> Dr. Markus Rall, Paul Steidle  =20
> > Sitz der Gesellschaft: Offenbach am Main, Registergericht:=20
> Amtsgericht=20
> > Offenbach HRB-Nr. 42592 USt-Ident-Nr. DE 250200933
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >=20
>=20
>=20
> --
> Philippe.
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

