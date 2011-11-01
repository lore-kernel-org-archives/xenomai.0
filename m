MIME-Version: 1.0
In-Reply-To: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>
References: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Tue, 1 Nov 2011 13:42:05 +0100
Message-ID: <CAAeYjMkVuQLzq-B+Nh1xOXFSHR4K74cwGGCVsZoJaT3GP2mHFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel compilation error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Tue, Nov 1, 2011 at 12:34, =C5=81ukasz Sacha <dragilla@domain.hid> wrote:
> Hello again:
>
> luke@domain.hid$ make ARCH=3Darm
> CROSS_COMPILE=3Darm-none-linux-gnueabi-
> ...
> =C2=A0CC =C2=A0 =C2=A0 =C2=A0arch/arm/kernel/fiq.o
> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete type
> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete type
> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete type
> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete type
> make[1]: *** [arch/arm/kernel/fiq.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> luke@domain.hid$
>
> This is how it looks like
> 80:void set_fiq_handler(void *start, unsigned int length)
> 81:{
> 82:#if defined(CONFIG_CPU_USE_DOMAINS)
> 83: =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((void *)0xffff001c, start, length);
> 84:#else
> 85: =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(vectors_page + 0x1c, start, length)=
;
> 86:#endif
> 87: =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_icache_range(0xffff001c, 0xffff001c =
+ length);
> 88: =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vectors_high())
> 89: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_icache_r=
ange(0x1c, 0x1c + length);
> 90:}
>
> Any ideas?

Please take a look at this as this is piece of code the adeos i-pipe
patch (./ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch)
modifies : in line 819.

If you can't help nobody can :/

regards,
--
=C5=81ukasz Dragilla Sacha

