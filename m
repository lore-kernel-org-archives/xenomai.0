Message-ID: <22085002.1223638963339.JavaMail.ngmail@domain.hid>
Date: Fri, 10 Oct 2008 13:42:43 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <48EF1B17.807@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <48EF1B17.807@domain.hid>
	<3298865.1223620599925.JavaMail.ngmail@domain.hid>
	<48EE2BF6.60300@domain.hid>	<15875130.1223557641586.JavaMail.ngmail@domain.hid>
	<8227750.1223626784795.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Bug with Xenomai and xeno_heap: Eeek!
 page_mapcount(page) went negative!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Hello Gilles,

thanks! Now it works fine!=20
Great support.=20

Best regards

Mathias

> Yes, thanks. This is a bug which should have been fixed since then. But=
=20
> here is a patch for your version. Could you try it?
>=20
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 816cf71..568cd8d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -109,7 +109,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_CAN_NONLINEAR 0x08000000=09/* Has ->fault & does nonlinear pa=
ges
> */
>  #define VM_MIXEDMAP=090x10000000=09/* Can contain "struct page" and pure=
 PFN
> pages */
> =20
> -#define VM_PINNED=090x10000000=09/* Disable faults for the vma */
> +#define VM_PINNED=090x20000000=09/* Disable faults for the vma */
> =20
>  #ifndef VM_STACK_DEFAULT_FLAGS=09=09/* arch can override this */
>  #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

