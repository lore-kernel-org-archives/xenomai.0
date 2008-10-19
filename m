From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sun, 19 Oct 2008 02:58:16 +0200
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018D014F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8018D014F@ARVMAIL1.mra.roland-man.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200810190258.16939.berlemont.hauw@domain.hid>
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

Hi,

On Friday 17 October 2008 06:46, thomas.debes@domain.hid wrote:
> No comments or ideas? Providing this feature is essential for our CPCI
> drivers. We have to port some Linux applications to Xenomai which use that
> mmap stuff intensely.
>
> Thanks again!
>
> Thomas
>
> > -----Urspr=FCngliche Nachricht-----
> > Von: xenomai-help-bounces@domain.hid
> > [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von
> > thomas.debes@domain.hid
> > Gesendet: Mittwoch, 8. Oktober 2008 11:49
> > An: xenomai@xenomai.org
> > Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
> >
> > Hello,
> >
> > in the following thread I was asking for a solution to use
> > rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)


In 2.4 kernel, rtdm_iomap_to_user() is based on the function remap_page_ran=
ge=20
(with vma->vm_flags |=3D VM_RESERVED).

Once, I had to develop a classical Linux driver (for PPC) which provided mm=
ap=20
functionalites so as to let a user application mmap a buffer allocated than=
ks=20
to __get_free_pages().

On a 2.6 kernel, I used remap_pfn_range() and it works great but on 2.4 ker=
nel=20
the function remap_page_range() did not work as I expected. I had a quick=20
look on its implementation and I found that instead of mapping my buffer it=
=20
mapped newly allocated zeroed pages (if my memories are correct).

If I remember well, these pages were allocated in lazy mode. That could=20
explain the freeze of your whole system: in case a RT application in primar=
y=20
mode tries to access the mmapped buffer.

My remembrance are not very accurate and considering the hour, I will just =
be=20
able to give you some idea of tests to perform.

1) Have you tried to access your driver with a classical NRT process (not w=
ith=20
a RT task even on secondary mode); in such a configuration, I think there=20
should be no freeze.

2) Could you try to develop a minimal Linux driver (without RTDM) which map=
s a=20
buffer thanks to remap_page_range(). Could you check that you are not able =
to=20
properly access the data (you should read zero everywhere) ? A good test=20
would be to open and perform the mmap with a classical user process and, on=
ce=20
the mmap initialization is done, you could shadow your process=20
(rt_task_shadow) and try to access the mmapped buffer. That should freeze=20
your system and then prove that the problem comes from remap_page_range().

In my case, I resolved my problem by using the no_page() way described in=20
Rubbini's book (Linux device driver 2nd edition). By the way, I think that=
=20
was the recommended method for my configuration.

Alexis.

> > https://mail.gna.org/public/xenomai-help/2008-05/msg00153.html
> >
> > As suggested by Philippe I tried the current 2.4.5 stable
> > release, but the problem still remains. The call to
> > rtdm_iomap_to_user returns success (0) but any access to the
> > mapped memory section ends in freezing the whole system.
> >
> > Thanks for your help!
> >
> > Thomas
> >
> > Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address!
> > thomas.debes@domain.hid
> > --------------------------------------------------------
> > manroland AG
> > Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> > Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr.
> > Markus Rall, Paul Steidle
> > Sitz der Gesellschaft: Offenbach am Main, Registergericht:
> > Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-Nr. DE 250200933
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
> Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address!
> thomas.debes@domain.hid
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,
> Paul Steidle Sitz der Gesellschaft: Offenbach am Main, Registergericht:
> Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-Nr. DE 250200933
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


