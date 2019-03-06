From: Richard Weinberger <richard@nod.at>
Subject: Re: x86_64 kernel does not start under qemu
Date: Wed, 06 Mar 2019 16:33:31 +0100
Message-ID: <3942851.pmMsEQ3ikD@blindfold>
In-Reply-To: <089ad64d-f76c-44a7-a1f4-75c215b6ab29@siemens.com>
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <d2d0dff8-bfb6-6df2-6d0c-2fa0b4127d5f@siemens.com>
 <089ad64d-f76c-44a7-a1f4-75c215b6ab29@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "henning.schild@siemens.com" <henning.schild@siemens.com>
Cc: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Am Mittwoch, 6. M=E4rz 2019, 14:43:55 CET schrieb Jan Kiszka:
> On 06.03.19 14:10, Jan Kiszka wrote:
> > On 06.03.19 12:28, Lange Norbert via Xenomai wrote:
> >> Hello,
> >>
> >> I have a similar issue on real hardware (cc Philippe). Can you try boo=
ting=20
> >> with notscdeadline?
> >>
> >=20
> > I would be surprised if it's that: QEMU does not emulate this APIC feat=
ure, only=20
> > KVM does.
> >=20
> > I need to reproduce. Which QEMU version?
> >=20
>=20
> Just booted current ipipe-x86-4.14.y (4.14.103) in QEMU 3.1+ (some develo=
pment=20
> snapshot) with -smp 4 - works fine. But these are likely quite a few vari=
ations=20
> from your setup.

I'm on qemu 2.11.2.
Is this plain ipipe? Just figured that you need to prepare the kernel
with Xenomai to trigger the problem.
Xenomai is 3.0.8.

Kernel config is defconfig.

Thanks,
//richard



