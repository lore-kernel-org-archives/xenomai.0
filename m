Message-ID: <4BECE0E9.4000807@domain.hid>
Date: Fri, 14 May 2010 07:34:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <SNT125-W47B0622A941FB9CEDA2C479C350@domain.hid>
	<loom.20100514T000318-597@domain.hid>
In-Reply-To: <loom.20100514T000318-597@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] a problem about Calibrating delay loop...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonata Apolinario <jonataapolinario@domain.hid>
Cc: xenomai@xenomai.org

Jonata Apolinario wrote:
> =E8=B4=B9=E6=9C=B1=E9=9D=92 <mouse19875 <at> hotmail.com> writes:
>=20
>>
>> HI all,
>>      I am porting xenomai-2.5.1 to arm architecture(Samsung
> S3C2440).Everything is ok when I do patch and compile.But the board sta=
rt
> up,console lock and say"calbrating delay loop...".(before patch xenomai=
 into
> kernel,the kernel image can work well)
>>      Xenomai say that it supports "S3C24xx family" ,but I always meet =
this
> problem.
>>      Someone said the timer interrupt does not work,I don't know how t=
o watch
> it and work out this problem.
>>      Do you know some methods that can  solve it ?=20
>> thanks
>> justin fei=E6=9B=B4=E5=A4=9A=E7=83=AD=E8=BE=A3=E8=B5=84=E8=AE=AF=E5=B0=
=BD=E5=9C=A8=E6=96=B0=E7=89=88MSN=E9=A6=96=E9=A1=B5=EF=BC=81 =E7=AB=8B=E5=
=88=BB=E8=AE=BF=E9=97=AE=EF=BC=81
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help <at> gna.org
>> https://mail.gna.org/listinfo/xenomai-help
>>
>=20
>=20
> Hi!
> well, i think i solved.
> i found in arch/arm/plat-s3c/time.c:
> the path inserted these lines:
>=20
> tcfg1 =3D __raw_readl(S3C2410_TCFG1);
> tcfg1 &=3D ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
> tcfg1 |=3D (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
> __raw_writel(tcfg1, S3C2410_TCFG1);
>=20
> in the function "static void s3c2410_timer_setup (void)"
> in the "else" side of the "if (use_tclk1_12())"
> use_tclk1_12 as i can see is to use external clock on pin clk1.
> the patch put these lines in the else too, that as i can see, is wrong.=

> i removed these lines from the ELSE side and the kernel passed by this =
point.
>=20
> see if it solves your problem and post your results.

This issue is fixed in Xenomai 2.5.3.

--=20
					    Gilles.


