MIME-Version: 1.0
References: <CO6PR11MB56493CA60ADCFBEFC2670FF3BA749@CO6PR11MB5649.namprd11.prod.outlook.com>
 <DM5PR11MB1852F1F506FE58645808D1B2F2749@DM5PR11MB1852.namprd11.prod.outlook.com>
 <f0d18fad-1dd8-7b78-7878-995ecaa5bfc9@siemens.com>
In-Reply-To: <f0d18fad-1dd8-7b78-7878-995ecaa5bfc9@siemens.com>
From: Antoine Hoarau <antoine@flr.io>
Date: Thu, 8 Apr 2021 20:14:39 +0200
Message-ID: <CAPnNZ0WNaJmfH=YDftgBkR2auEaXqEojmKAHcx2bmxh7-K85Hw@mail.gmail.com>
Subject: Re: Xenomai Community Call Minutes - April 7, 2021
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Xenomai <xenomai@xenomai.org>

I ran into the same issue. Using default config too. Had to enable EFI
manually.

Le jeu. 8 avr. 2021 =C3=A0 10:28, Jan Kiszka via Xenomai <xenomai@xenomai.o=
rg> a
=C3=A9crit :

> On 08.04.21 10:19, Chen, Hongzhan via Xenomai wrote:
> >> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Wang, Rick Y
> via Xenomai
> >> Sent: Thursday, April 8, 2021 8:52 AM
> >> To: xenomai@xenomai.org
> >> Subject: Xenomai Community Call Minutes - April 7, 2021
> >>
> >> Attendees:
> >>
> >> Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen,
> >> Dao Zhang, Jianbo Cao, Yanfeng Pu, Rick Wang
> >>
> >>
> >> *Community update
> >>
> >> - No code change in the past two weeks
> >> - Greg is debugging jitter issue on ARM.
> >> - Siemens is testing WIP-Dovetail branch internally. Some issues were
> >> reported related to clock source or gdb crash.
> >> - Jan will log the issues to gitlab Xenomai hacker space:
> >> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
> >> - For Xenomai 3.2, there are some submitted patches pending on Jan's
> review
> >> and merge. Also some patches in Philippe's private tree are pending on
> >> submission.
> >> - Florian and Song are working on Y2038 issue on Philippe's tree. It
> depends
> >> on some Dovetail codes to be merged first.
> >> - Hongzhan is working on latmus GPIO porting. 5.10 Dovetail-based
> Xenomai
> >> and EVL can't boot up on his dev board yet. 5.9 kernel can boot on the
> >
> > After further debug , when failure happen, actually system is wrong to
> use pit instead of
> > LAPIC as clock event device because pit can not work with dovetail.
> After check log , found
> > that there is abnormal info related to APIC reported "[    2.812126]
> APIC: ACPI MADT or MP tables are not detected"
> > It mentioned ACPI.  So I traced ACPI related log suggested by Jan and
> Florian and found that there is
> > ACPI related error reported earlier in log like " [    0.013416] ACPI
> BIOS Error (bug): A valid RSDP was not found (20200925/tbxfroot-210)".
> > I googled this error but all the solution related to it  can not fix th=
e
> issue for example enabling ACPI in BIOS.
> > And then I captured kernel log for 5.9 and compare them with 5.10 and
> finally found that there is log info related to ACPI missing with my 5.10
> image like
> > " [    0.000000] efi: ACPI 2.0=3D0x8c3ee000 ACPI=3D0x8c3ee000
> TPMFinalLog=3D0x8c4ad000 SMBIOS=3D0x8c9ca000 SMBIOS 3.0=3D0x8c9c9000
> MEMATTR=3D0x88059418"
> > After check kernel config, I found  that my 5.10 config actually have
> not enabled CONFIG_EFI. After enable it, evl successfully boot up on
> > my Rock PI X board now.
> >
> > Thanks for Jan and Florian's suggestions.
> >
>
> Great to hear it works now!
>
> Yeah, CONFIG_EFI=3Dy is part of x86_64_defconfig - that's why I suggested
> to retry starting from there.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
>
