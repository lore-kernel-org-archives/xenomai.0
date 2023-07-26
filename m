Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DDBA43
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 13:39:13 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id E68361A0008
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 13:39:11 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8F009AC1580
	for <xenomai@xenomai.org>; Wed, 26 Jul 2023 13:39:10 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 586475FFA9
	for <xenomai@xenomai.org>; Wed, 26 Jul 2023 15:39:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 36QDd8rn3815115
	for <xenomai@xenomai.org>; Wed, 26 Jul 2023 15:39:08 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@xenomai.org
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 26 Jul 2023 15:39:08 +0200
Subject: =?utf-8?q?XENO=5FARCH=5FFPU?=
Message-ID: <38a527-64c12200-3-647b8480@101120884>
X-Forward: 217.109.173.233, 147.161.152.105
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Hello,

upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have a bui=
ld failure on kernel/cobalt/ipipe/sched.c :
kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration of fu=
nction 'switch=5Ffpu'; did you mean 'switch=5Fto'? [-Werror=3Dimplicit-=
function-declaration]

The problem seem to be caused by CONFIG=5FXENO=5FARCH=5FFPU not being d=
efined, and in this case, the switch=5Ffpu() function is not defined, b=
ut called unconditionnally in pipeline=5Fswitch=5Fto() and pipeline=5Fl=
eave=5Finband()

The fix seem straightforward, however, I could not find any place where=
 this CONFIG=5FXENO=5FARCH=5FFPU gets defined for any arch, nor any Kco=
nfig menu to enable/disable it.

It is however the same for my previous xenomai 3.1 setup

Can anybody help on this ?

Thanks in advance

Fran=C3=A7ois

