Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6D611C
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 13:03:02 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 8CEB91A0004
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 13:03:00 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 62E747803E7
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 13:02:59 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 37246200597;
	Tue,  4 Jul 2023 15:02:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 364D2uRB2790287;
	Tue, 4 Jul 2023 15:02:56 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
In-Reply-To: <a14e96c8-d165-0972-461d-5a8e3200e28a@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 195.68.6.102, 165.225.20.106
Date: Tue, 04 Jul 2023 15:02:56 +0200
Cc: xenomai@xenomai.org
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3b7514-64a41880-35-28cbfc80@10274948>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] Make macb/gem RT driver to be built against 
 linux =?utf-8?q?>=3D?= 5.0 kernels
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of francois.legal@thom.fr.eu.org designates 212.27.42.2 as permitted sender) smtp.mailfrom=francois.legal@thom.fr.eu.org

Le Mardi, Juillet 04, 2023 14:46 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 04.07.23 14:24, Fran=C3=A7ois Legal wrote:
> > Le Mardi, Juillet 04, 2023 11:25 CEST, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 29.06.23 22:04, Fran=C3=A7ois Legal wrote:
> >>> PHY layer in upstream has changed a little after 5.0 in the way a=
utonegociation
> >>> capabilities are encoded.
> >>> MACB platform data tend to disappear after 5.2 upstream.
> >>> Plus, ioctl prototype has changed in xenomai. RTMACB driver does =
not build
> >>> anymore.
> >>>
> >>> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> >>> ---
> >>>  kernel/drivers/net/drivers/macb.c    | 60 ++++++++++++++++++----=
------
> >>>  kernel/drivers/net/drivers/rt=5Fmacb.h |  2 +-
> >>>  2 files changed, 40 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/n=
et/drivers/macb.c
> >>> index 77957d906..0648afa3b 100644
> >>> --- a/kernel/drivers/net/drivers/macb.c
> >>> +++ b/kernel/drivers/net/drivers/macb.c
> >>> @@ -132,6 +132,7 @@ void rtmacb=5Fget=5Fhwaddr(struct macb *bp)
> >>>  		bottom =3D macb=5For=5Fgem=5Freadl(bp, SA1B + i * 8);
> >>>  		top =3D macb=5For=5Fgem=5Freadl(bp, SA1T + i * 8);
> >>>  
> >>> +#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
> >>
> >> Thanks for the patch, but master does not support kernels older th=
an
> >> 5.10 (dovetail) anymore.
> >>
> >> Is this patch needed for stable/v3.2.x or can it wait for v3.3? In=
 any
> >> case, we need a master patch first, then we can discuss whether to=

> >> backport it as well.
> > 
> > Well, I started patching 3.2 then submitted it against master. I ca=
n submit for 3.2 as well. I believe this is my target version.
> > 
> >>
> >> What we also need is enabling of the driver for CI to catch such i=
ssues
> >> earlier. See .gitlab-ci.yml and all those driver configs there.
> > 
> > I don't really know about this.
> > Do you want me to submit a patch for this file ?
> > Would it be something like 
> >      - ./scripts/config -m XENO=5FDRIVERS=5FNET=5FDRV=5FE1000=5FNEW=

> >      - ./scripts/config -m XENO=5FDRIVERS=5FNET=5FDRV=5FRT2500
> > +    - ./scripts/config -m XENO=5FDRIVERS=5FNET=5FDRV=5FMACB
> >      - ./scripts/config -m XENO=5FDRIVERS=5FNET=5FFEC
> >      - ./scripts/config -m XENO=5FDRIVERS=5FNET=5FADDON=5FRTCAP
> > 
> 
> Yes, if that is sufficient to actually build it (check if it has
> dependencies that may not be fulfilled in a defconfig).

Thing is, XENO=5FDRIVERS=5FNET=5FDRV=5FMACB depends on ARM. I'm not sur=
e how this can be achieved in your CI build system

Fran=C3=A7ois

> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux
>

