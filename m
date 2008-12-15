Message-ID: <BAY135-W24B610EE040424CA85E6A5C6F40@domain.hid>
From: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Date: Mon, 15 Dec 2008 14:29:52 -0700
In-Reply-To: <4946A913.1000201@domain.hid>
References: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>
	<49468135.6060602@domain.hid>
	<BAY135-W2875D734AB22FC0E2FD238C6F40@domain.hid>
	<4946A913.1000201@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] BUG: soft lockup
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
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org


Hi Gilles=2C
=20
>>=20
>>>> The kernel runs fine without the Xenomai patch.
>>>> I also tried the version in the current svn repository with the same r=
esult.
>>>> Please let me know you what I can do to help to fix this or what
>>>> additional info I should provide.
>>> Does this problem also occurs when you
>>> - disable CONFIG_XENOMAI?
>>> - boot with maxcpus=3D2=2C and then maxcpus=3D1?
>>=20
>> Disabling CONFIG_XENOMAI doesn't help but using maxcpus=3D2 or maxcpus=
=3D1 makes it boot again.
>=20
> Could you try the following patch?
>=20
> --- linux/include/asm-x86/irq_vectors.h~ 2008-12-09 18:05:38.000000000 +0=
100
> +++ linux/include/asm-x86/irq_vectors.h 2008-12-15 19:48:53.000000000 +01=
00
> @@ -80=2C7 +80=2C7 @@
> #ifdef CONFIG_IPIPE
> #define INVALIDATE_TLB_VECTOR_END 0xf2
> #define INVALIDATE_TLB_VECTOR_START 0xf0 /* f0-f2 used for TLB flush */
> -#define NUM_INVALIDATE_TLB_VECTORS 4 /* f3-f7 used by I-pipe */
> +#define NUM_INVALIDATE_TLB_VECTORS 3 /* f3-f7 used by I-pipe */
> #else /* !CONFIG_IPIPE */
> #define INVALIDATE_TLB_VECTOR_END 0xf7
> #define INVALIDATE_TLB_VECTOR_START 0xf0 /* f0-f7 used for TLB flush */
>=20
> --=20
> Gilles.
=20
With the patch applied Linux seems to start correctly.
=20
Regards=2C
Thomas
_________________________________________________________________


