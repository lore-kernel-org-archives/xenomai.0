Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9612B78
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 14:31:27 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [217.70.178.230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2085ECCC61
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 14:18:57 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id D690A240004
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 14:18:48 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 71AAA740049
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 14:18:47 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 42E826012D;
	Thu, 29 Jun 2023 16:18:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 35TEIjJo2551473;
	Thu, 29 Jun 2023 16:18:45 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <525e6d4dbbdf8123b9957a244bedf817cefd8d02.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.152.105
Date: Thu, 29 Jun 2023 16:18:45 +0200
Cc: "xenomai" <xenomai@xenomai.org>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3b7514-649d9300-2f-28cbfc80@10273562>
Subject: =?utf-8?q?Re=3A?= [PATCH] Macb/gem network driver does not build anymore on 
 recent  xenomai/kernels
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Jeudi, Juin 29, 2023 15:19 CEST, Florian Bezdeka <florian.bezdeka@si=
emens.com> a =C3=A9crit: 
 
> Hi,
> 
> On Thu, 2023-06-29 at 15:04 +0200, Fran=C3=A7ois Legal wrote:
> > Subject: [PATCH] Make macb/gem RT driver to be built against linux =
>=3D 5.0 kernels
> 
> ^^ this line can be removed. We have the mail subject, that's
> sufficient.
> 
> In addition, could you please run checkpatch on your patch? There are=
 a
> lot of warnings that should be addressed (especially regarding line
> endings, code style, ...)
> 

Yes, sorry, it's been a while since I last posted a patch here.
Can I assume warnings like 
WARNING: LINUX=5FVERSION=5FCODE should be avoided, code should be for t=
he version to which it is merged
#193: FILE: kernel/drivers/net/drivers/macb.c:1810:
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(4, 5, 0)

WARNING: Comparisons should place the constant on the right side of the=
 test
#193: FILE: kernel/drivers/net/drivers/macb.c:1810:
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(4, 5, 0)

from checkpatch can be ignored (I copied existing code from the file to=
 conditionnalise some code)

?

Otherwise, v2 is ready.

Fran=C3=A7ois

> Looking forward to a v2.
> 
> Best regards,
> Florian
> 
> > 
> > PHY layer in upstream has changed a little after 5.0 in the way aut=
onegociation capabilities are encoded.
> > MACB platform data tend to disappear after 5.2 upstream.
> > Plus, ioctl prototype has changed in xenomai. RTMACB driver does no=
t build anymore.
> > 
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > ---
>

