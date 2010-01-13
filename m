From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>	<002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>	<4B4CA076.1050205@domain.hid>	<002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>	<4B4CD5E8.7040904@domain.hid>
	<004301ca93d8$4f6ca660$ee45f320$@kalatchev@domain.hid>
	<4B4CFAF1.80204@domain.hid>
	<004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
	<4B4D11CF.7030007@domain.hid>
In-Reply-To: <4B4D11CF.7030007@domain.hid>
Date: Wed, 13 Jan 2010 08:55:03 -0500
Message-ID: <004b01ca9458$0240e240$06c2a6c0$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-ca
Subject: Re: [Xenomai-help] Viper board (ARM XScale)
	problems	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'Xenomai help' <xenomai@xenomai.org>

> Here comes the patch:
> diff --git a/include/asm-arm/arith.h b/include/asm-arm/arith.h
> index eca69ba..6908681 100644
> --- a/include/asm-arm/arith.h
> +++ b/include/asm-arm/arith.h
> @@ -14,9 +14,9 @@ rthal_arm_nodiv_ullimd(const unsigned long long op,
>  #else /* arm <=3D v3 */
>  #define __rthal_add96and64(l0, l1, l2, s0, s1)         \
>         do {                                            \
> -               __asm__ ("adds %2, %4\n\t"              \
> -                        "adcs %1, %3\n\t"              \
> -                        "adc %0, #0\n\t"               \
> +               __asm__ ("adds %2, %2, %4\n\t"          \
> +                        "adcs %1, %1, %3\n\t"          \
> +                        "adc %0, %0, #0\n\t"           \
>                          : "+r"(l0), "+r"(l1), "+r"(l2) \
>                          : "r"(s0), "r"(s1): "cc");     \
>         } while (0)
> @@ -46,17 +46,17 @@ rthal_arm_nodiv_ullimd(const unsigned long long =
op,
>=20
>         __asm__ ("umull %[tl], %[rl], %[opl], %[fracl]\n\t"
>                  "umull %[rm], %[rh], %[oph], %[frach]\n\t"
> -                "adds %[rl], %[tl], lsr #31\n\t"
> -                "adcs %[rm], #0\n\t"
> -                "adc %[rh], #0\n\t"
> +                "adds %[rl], %[rl], %[tl], lsr #31\n\t"
> +                "adcs %[rm], %[rm], #0\n\t"
> +                "adc %[rh], %[rh], #0\n\t"
>                  "umull %[tl], %[th], %[oph], %[fracl]\n\t"
> -                "adds %[rl], %[tl]\n\t"
> -                "adcs %[rm], %[th]\n\t"
> -                "adc %[rh], #0\n\t"
> +                "adds %[rl], %[rl], %[tl]\n\t"
> +                "adcs %[rm], %[rm], %[th]\n\t"
> +                "adc %[rh], %[rh], #0\n\t"
>                  "umull %[tl], %[th], %[opl], %[frach]\n\t"
> -                "adds %[rl], %[tl]\n\t"
> -                "adcs %[rm], %[th]\n\t"
> -                "adc %[rh], #0\n\t"
> +                "adds %[rl], %[rl], %[tl]\n\t"
> +                "adcs %[rm], %[rm], %[th]\n\t"
> +                "adc %[rh], %[rh], #0\n\t"
>                  "umlal %[rm], %[rh], %[opl], %[integ]\n\t"
>                  "mla %[rh], %[oph], %[integ], %[rh]\n\t"
>                  : [rl]"=3Dr"(rl), [rm]"=3Dr"(rm), [rh]"=3Dr"(rh),
>=20

Hi Gilles,

Repeating of the first argument did solved the problem! I've built 2.5.0 =
and will start to play with it.
By the way, for some reason patch itself didn't work - said something =
about malformed patch at line 16:

	@@ -46,17 +46,17 @@ rthal_arm_nodiv_ullimd(const unsigned long long op,

 I couldn't see what the problem was, so just updated everything =
manually.

Thanks a lot for your help.
Best regards,

Ivan


