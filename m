Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50E1CC06.9050404@xenomai.org>
Date: Mon, 31 Dec 2012 19:18:19 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,


I would think Henri is in better position to explain the genealogy; the =
way I understand it is is a merge of torvalds 3.2.21 onto this TI 3.2 =
branch: =
http://arago-project.org/git/projects/linux-am33x.git?p=3Dprojects/linux-a=
m33x.git;a=3Dcommit;h=3Dd7e124e8074cccf9958290e773c88a4b2b36412b

Henri told me this:

> I made this tree for supporting the AM335x-evm board. The beaglebone =
is untested with this tree.
> This posting and thread sums what I did to get the tree =
http://www.xenomai.org/pipermail/xenomai/2012-October/026594.html.

I took Henri's branch and merged =
http://arago-project.org/git/projects/linux-am33x.git?p=3Dprojects/linux-a=
m33x.git;a=3Dshortlog;h=3Drefs/heads/v3.2-staging where all the 3.2 =
related fixes show up.

I wound up with this configuration; =
http://git.mah.priv.at/gitweb/linuxcnc-kernel.git/blob/ce9f5236ec183aff622=
ffc4c59e331957167f934:/arch/arm/configs/mah_bbone_defconfig  which works =
fine for a few people working on LinuxCNC on the beaglebone in a tftp =
boot/nfs root setting.

I'm sorry to be fuzzy/slightly belletristic on this, I'm not very firm =
in this space. I am also a tad confused by the number of options - =
there's the Arago project sources which look 'most TI official' to me, =
then the Koen Koi kernels, and the Robert C Nelson kernels (both on =
github) with a bewildering variety of branches.

I did try to replicate Stephan Kappertz's work, as well Sheng Chao's, =
both of which went nowhere for me, but that doesnt mean they dont work; =
just not for me.


- Michael



Am 31.12.2012 um 18:31 schrieb Gilles Chanteperdrix:

> On 12/31/2012 05:39 PM, Michael Haberler wrote:
>=20
>> Bao,
>>=20
>> I got Xenomai working fine, based on Henri Roosen's branch: =
https://github.com/roosen/linux/tree/v3.2.21_AM33xx_core-3.2
>=20
>=20
> Hi Michael,
>=20
> if you tell us on which unpatched kernel this branch is based, we =
could
> generate the pre- and post- patches we have been talking about.
>=20
> Regards.
>=20
>=20
> --=20
>                                                                Gilles.


