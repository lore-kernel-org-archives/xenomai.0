Date: Mon, 29 Oct 2018 11:07:56 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [Xenomai] ipipe-4.14: planned release date
Message-ID: <20181029110756.67447340@md1pvb1c.ad001.siemens.net>
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7DB540@DEMUC-SMX001.data-modul.local>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
 <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
 <52b6df12-fbb5-871a-7c4c-5208e7e04978@siemens.com>
 <cuc1u0s6krjua13us78v6n9g.1539284434958@email.android.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DB540@DEMUC-SMX001.data-modul.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Mon, 15 Oct 2018 10:56:41 +0000
schrieb "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>:

> Hi Jan,
>=20
> now I run into another problem. My Board does a reset right after
> "Loading initial ramdisk..." It is an AMD Ryzon Embedded V1000. There
> are no logs to kern.log I already tried disabling CONFIG_MAXSMP.
> Original 4.14.71 boots without problems.
>=20
> Any ideas?

Any updates on that? We are about to release 4.14 amd64 so any known
open issues should be fixed before.

Please check 361b1bac5d903d2199903a5cb3d6e0fbc3c604ae together with
xenomai/master.

Henning

> Thanks,
> Martin
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von
> Schrenkhammer, Martin Gesendet: Donnerstag, 11. Oktober 2018 21:00
> An: Jan Kiszka; xenomai@xenomai.org
> Betreff: Re: [Xenomai] ipipe-4.14: planned release date
>=20
> That solved the problem. Thanks a lot for your help!
>=20
> Martin
> 11.10.2018 2:22 nachm. schrieb Jan Kiszka <jan.kiszka@siemens.com> :
> On 11.10.18 11:21, Schrenkhammer, Martin wrote:
> > Thanks for your reply.
> > Checked again today with your latest commit
> > 20db5ea2eee38b123c9641003fe55c895a1fd514 with same errors. I wanted
> > to run a first build without modifications (beside
> > prepare-kernel.sh and make menuconfig to append a local version.
> > Maybe you can send my your actual x86 config and I can check
> > differences and adopt to my platform. Mine .config is enclosed. =20
>=20
> Reproduced: The actual problem is related to CONFIG_HYPERV which
> selects CONFIG_PARAVIRT which conflicts with CONFIG_IPIPE.
>=20
> Furthermore, you want to disable CONFIG_SCHED_MC so that you can also
> turn off the power management features Xenomai complains about.
>=20
> And then there is CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_CMA. When
> both are off, you can also disable COMPACTION and MIGRATION.
>=20
> In general, it's not optimal to start from a distro config without
> further tuning.
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>=20
> ________________________________
> Vertrauliche E-Mail von / Confidential e-mail from Data Modul AG
> Vorstand / CEO: Dr. Florian Pesahl
> Vorsitzende des Aufsichtsrates / Chairwoman of the Supervisory Board:
> Kristin D. Russell Sitz der Gesellschaft / Registered Office: M=C3=BCnchen
> Registergericht / Registration Court: M=C3=BCnchen - Handelsregister B 85
> 591
>=20
> Datamodul
> [cid:0021-0001@01d46194.a5f3ebae]
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ECS-electronica_2018_d.gif
> Type: image/gif
> Size: 8162 bytes
> Desc: ECS-electronica_2018_d.gif
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20181011/a6d2cc1d/attac=
hment.gif>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>=20
> Vertrauliche E-Mail von / Confidential e-mail from: DATA MODUL AG
> Vorstand / CEO: Dr. Florian Pesahl
> Vorsitzende des Aufsichtsrates / Chairwoman of the Supervisory Board:
> Kristin D. Russell Sitz der Gesellschaft / Registered Office: M=C3=BCnchen
> Registergericht / Registration Court: M=C3=BCnchen Handelsregister B 85 5=
91
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


