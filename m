From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A87CD6@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A87CD6@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Jun 2009 16:19:35 +0200
Message-Id: <1245248375.9280.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-06-17 at 13:40 +0200, roderik.wildenburg@domain.hid
wrote:
> Hello,=20
>=20
> > On Tue, 2009-06-16 at 15:20 +0200, roderik.wildenburg@domain.hid
> > wrote:
> > > Hi,
> > >=20
> > > I applied your ipipe-patch to our 2.4.25 ppc kernel, but=20
> > unfortunatelly I now can=C2=B4t compile the kernel any more.
> > > I get following error messages :
> > >=20
> > > ipipe.c:393: error: `__switch_to' undeclared here (not in a=20
> > function)
> > > ipipe.c:393: error: initializer element is not constant
> > > ipipe.c:393: error: (near initialization for=20
> > `__ksymtab___switch_to.value')
> > > ipipe.c:394: error: `show_stack' undeclared here (not in a function=
)
> > > ipipe.c:394: error: initializer element is not constant
> > > ipipe.c:394: error: (near initialization for=20
> > `__ksymtab_show_stack.value')
> > > ipipe.c:393: error: __ksymtab___switch_to causes a section=20
> > type conflict
> > > ipipe.c:394: error: __ksymtab_show_stack causes a section=20
> > type conflict
> > > make[1]: *** [ipipe.o] Fehler 1
> > >=20
> > >=20
> > >=20
> > > Our hardware is based on a freescale 5200B, so, as far as I=20
> > understand your question about PICs, your patch should work=20
> > for our hardware (I hope).
> >=20
> > This patch is based on the current HEAD of
> > git://www.denx.de/git/linuxppc_2_4_devel.git
> > (commit 5bab6d641ff5ba139f9f41869502cb7c96d785bc)
> >=20
> > The patched kernel builds and runs fine using lite5200b_defconfig.
> >=20
>=20
> Our kernel isn=C2=B4t HEAD but is close to (2 or 3 commits before HEAD)=
.
> Nevetheless I checked out HEAD and used the lite5200b_defconfig.
> Indeed the kernel compiles fine with this configuration.=20
> After comparing the lite5200b configuration with our one (uc101) and pl=
aying around quite a while with the options I figured out that "CONFIG_MO=
DULES=3Dy" does the trick. Activating this option leads to the errors I d=
escribed in my ealier mails. Please find attached the .config I used to p=
roduce the compile errors.
> Do you have an idea what I have to change in the 2.0-Ipipe-patch to mak=
e it work with CONFIG_MODULES enabled.
>=20

The EXPORT directives were wrong, actually copied&pasted as is from 2.6.
Try this patch instead:

http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-ppc-DEN=
X-2.0-01.patch


> Thank you for your help and best regards=20
> Roderik
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
--=20
Philippe.



