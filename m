From: Richard Weinberger <richard@nod.at>
Subject: Re: x86_64 kernel does not start under qemu
Date: Fri, 08 Mar 2019 12:19:46 +0100
Message-ID: <2063425.dnF2CDgauY@blindfold>
In-Reply-To: <77bd8c5c-9961-35f0-e2fd-4c6df8a78a14@siemens.com>
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <3942851.pmMsEQ3ikD@blindfold>
 <77bd8c5c-9961-35f0-e2fd-4c6df8a78a14@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "henning.schild@siemens.com" <henning.schild@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Am Mittwoch, 6. M=E4rz 2019, 17:39:38 CET schrieb Jan Kiszka:
> On 06.03.19 16:33, Richard Weinberger wrote:
> > Am Mittwoch, 6. M=E4rz 2019, 14:43:55 CET schrieb Jan Kiszka:
> >> On 06.03.19 14:10, Jan Kiszka wrote:
> >>> On 06.03.19 12:28, Lange Norbert via Xenomai wrote:
> >>>> Hello,
> >>>>
> >>>> I have a similar issue on real hardware (cc Philippe). Can you try b=
ooting
> >>>> with notscdeadline?
> >>>>
> >>>
> >>> I would be surprised if it's that: QEMU does not emulate this APIC fe=
ature, only
> >>> KVM does.
> >>>
> >>> I need to reproduce. Which QEMU version?
> >>>
> >>
> >> Just booted current ipipe-x86-4.14.y (4.14.103) in QEMU 3.1+ (some dev=
elopment
> >> snapshot) with -smp 4 - works fine. But these are likely quite a few v=
ariations
> >> from your setup.
> >=20
> > I'm on qemu 2.11.2.
>=20
> That one might still be serializing SMP, thus only use one core on the ho=
st.=20

Well, why is this a problem for Xenomai?
Does it deadlock if you have more than one cpu and these are not truly para=
llel?
This seems a little odd to me.

> Currently trying to emulate that as it changes timing.

Just retried with latest qemu (v3.1.0-2421-g9b748c5e061b), same problem.
=20
> > Is this plain ipipe? Just figured that you need to prepare the kernel
> > with Xenomai to trigger the problem.
> > Xenomai is 3.0.8.
>=20
> I have Xenomai stable/v3.0.x running as well.

What kernel config are you using and what is your qemu command line?

Thanks,
//richard



