MIME-Version: 1.0
References: <CAFc1U0sBrAbhuNe6Zy-C861Nxc_xB5uyV=93WK3c4JbUpNXiSQ@mail.gmail.com>
 <7001086b-fe6c-5ecb-c3e1-744e691d3f08@siemens.com>
In-Reply-To: <7001086b-fe6c-5ecb-c3e1-744e691d3f08@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 5 Aug 2019 10:24:17 +0200
Message-ID: <CAFc1U0sQ4HR4fQ6_CSfKuHgEDi5A_iWkzwKbGeTEVCH0vNq6OA@mail.gmail.com>
Subject: Re: Ftrace for Xenomai 3
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
Cc: xenomai@xenomai.org

Thx a lot Jan.

Le ven. 2 ao=C3=BBt 2019 =C3=A0 10:40, Jan Kiszka <jan.kiszka@siemens.com> =
a =C3=A9crit :

> On 02.08.19 09:37, Pierre FICHEUX via Xenomai wrote:
> > Hi all,
> >
> > I read in an article (in french) by Philippe that Ftrace was available
> for
> > Xenomai 3.
> >
> >
> https://connect.ed-diamond.com/Open-Silicium/OS-016/Xenomai-3-hybride-et-=
cameleon
> >
> > "Si Ftrace l'a =C3=A9t=C3=A9 (port=C3=A9) pour Xenomai, d'autres manque=
nt encore
> > cruellement, comme Perf  et Valgrind "
> >
> > -> approximative translation to  english:
> >
> > "Ftrace was ported to Xenomai but some tools such as Perf and Valdgrind
> are
> > still missing"
> >
> > So what about Ftrace ?
>
> Just try trace-cmd record -e "cobalt_*". We also have some plugin for
> Kernelshark here, but that needs a refresher with the release 1.0
> (baseline was
> once kindly provided by Steven and his folks).
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
