MIME-Version: 1.0
References: <CAFc1U0sYmwMNY1yE+B6=x3_C9QKb9PYivkqDztMSckPXqeUTQw@mail.gmail.com>
 <8ba27533-1944-164f-30cc-17c1bc832e51@xenomai.org>
In-Reply-To: <8ba27533-1944-164f-30cc-17c1bc832e51@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 16 Nov 2019 14:09:28 +0100
Message-ID: <CAFc1U0vF9Ogfs_JHrdSHcxnQ=xZtM8aDr8eb8PgP-BS1mMiR3w@mail.gmail.com>
Subject: Re: ARM reference platform(s)
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Hi,

Regarding  armv8 platforms, do you use kernel from
https://gitlab.denx.de/Xenomai/ipipe-arm64 or BSP one ?

I know most ARM boards (i.MX, Pi 3) should work with mainline kernel with
limited features.

regards


Le dim. 6 oct. 2019 =C3=A0 18:38, Philippe Gerum <rpm@xenomai.org> a =C3=A9=
crit :

> On 9/30/19 5:01 PM, Pierre FICHEUX via Xenomai wrote:
> > Hi all,
> >
> > Do you have a list  of ARM reference platforms used for Ipipe test and
> > validation (by the core developers) ?
> >
>
> armv7: several i.MX6 processors (fsl/nxp sabre, phytec, via), i.MX7
> (nxp), RPI2, Xilinx Cyclone-V and STmicro B2260 mainly. BBB less
> frequently.
>
> armv8: hikey (Kirin 620 so far, 970 may come at some point), RPI3,
> Xilinx ZCU102.
>
> --
> Philippe.
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
