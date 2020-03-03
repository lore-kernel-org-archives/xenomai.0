MIME-Version: 1.0
References: <DB8PR09MB3612215A31188B5C00AD779BF0E70@DB8PR09MB3612.eurprd09.prod.outlook.com>
 <c4a79189-6696-a109-97f6-8cadbb36923e@siemens.com>
 <CALLqZ8TNspMLYOfrA11_xB6dh=LjXiTV8_P12+s_a_exUv6tqQ@mail.gmail.com>
 <68ddab50-1002-7100-a745-3387b28592b2@siemens.com>
 <1a4b8b29-2c9d-676b-cedc-d7eddb461189@hbm.com>
In-Reply-To: <1a4b8b29-2c9d-676b-cedc-d7eddb461189@hbm.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 3 Mar 2020 08:53:11 -0500
Message-ID: <CALLqZ8S63mKXCpWcAeb7haW4x03Y07evBxJPD-j2ciJY40=9NA@mail.gmail.com>
Subject: Re: Ipipe-Patch for kernel version 5.4.23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Moder <ralf.moder@hbkworld.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Mar 3, 2020 at 8:46 AM Ralf Moder <ralf.moder@hbkworld.com> wrote:

> Am 02.03.20 um 17:01 schrieb Jan Kiszka:
> > On 02.03.20 16:17, Greg Gallagher wrote:
> >>
> >> On Mon, Mar 2, 2020 at 7:38 AM Jan Kiszka via Xenomai
> >> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
> >>
> >>     On 02.03.20 11:00, Ralf Moder via Xenomai wrote:
> >>      > Hello everyone,
> >>      > I need the kernel version 5.4.23 in an embedded linux project
> >>     because of driver stuff but also the Xenomai extension. How big is
> >>     the probability that an I-pipe patch for the 5.4 version will be
> >>     released in the next 2 to 3 months?
> >>
> >>     I would first of all say that it's >0. But beyond that, it
> >> depends on
> >>     the architecture: x86 should be available on 5.4 in the next month=
s
> >>     with
> >>     a probability >>50% as that will be my primary target for looking
> >> into
> >>     how to move forward. ARM and ARM64 currently lacks a maintainer.
> >> If we
> >>     are lucky, the base enabling via Philippe's dovetail queue will
> >> enable
> >>     those more or less as well. But it will definitely take someone
> >> to take
> >>     responsibility for those archs because my colleagues and I current=
ly
> >>     cannot invest beyond integrating contributions. There is also ppc3=
2
> >>     (which has a maintainer), but I suppose that this is not your
> >> target.
> >>
> >>     Jan
> >>
> >>     --     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >>     Corporate Competence Center Embedded Linux
> >>
> >> If you need this for arm I was going to try to port the ipipe to 5.4
> >> in the near future. Effort wise it shouldn't be too bad, but it all
> >> depends on how much the upstream changes impact us.  What board are
> >> you targeting?
> it is a SoC from xilinx with 2 arm cortex a53 kernel on it

This is an ultrascale? I=E2=80=99ve run the current ipipe code (4.19) on th=
e
ultra96 without issue.


> >
> > I suppose that questions addresses Ralf (provided he runs on ARM).
> >
> > As mentioned before, our tiny test lab currently contains for ARM a
> > BeagleBone Black and QEMU instance.
> The ESPRESSObin from marvell could be a good eval board for testing .If
> you need it we can send you one. Or we can test new patches here in our
> company.
> >>
> >> Jan, I can  help out maintaining the ARM ipipe.  We can talk offline
> >> if you'd like.
> It would be great if you could keep us up to date on your progress in
> patching kernel version 5.4. If we can support you in any way, let us kno=
w.
>
> > That would be great, looking forward!
> >
> > Jan
> >
> Ralf
>
> Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt,
> Germany | www.hbm.com Registered as GmbH (German limited liability
> corporation) in the commercial register at the local court of Darmstadt,
> HRB 1147 Company domiciled in Darmstadt | Managing Directors: Thomas Lipp=
ok
> & Jens Wiegand | Chairman of the board: Joseph Michael Vorih Als
> Gesellschaft mit beschr=C3=A4nkter Haftung eingetragen im Handelsregister=
 des
> Amtsgerichts Darmstadt unter HRB 1147 Sitz der Gesellschaft: Darmstadt |
> Gesch=C3=A4ftsf=C3=BChrung: Thomas Lippok & Jens Wiegand | Aufsichtsratsv=
orsitzender:
> Joseph Michael Vorih The information in this email is confidential. It is
> intended solely for the addressee. If you are not the intended recipient,
> please let me know and delete this email. Die in dieser E-Mail enthaltene
> Information ist vertraulich und lediglich f=C3=BCr den Empf=C3=A4nger bes=
timmt.
> Sollten Sie nicht der eigentliche Empf=C3=A4nger sein, informieren Sie mi=
ch
> bitte kurz und l=C3=B6schen diese E-Mail.
>
