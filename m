Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D0613F
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 09:17:19 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 92E92200007
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 09:17:11 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2F66B7803E3
	for <xenomai@xenomai.org>; Wed,  9 Aug 2023 09:17:10 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id D51FA5FFD7;
	Wed,  9 Aug 2023 11:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 3799H7LN264123;
	Wed, 9 Aug 2023 11:17:07 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <94d3c359-941d-a745-6551-fe4a94f83939@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 92.128.82.106, 147.161.152.118
Date: Wed, 09 Aug 2023 11:17:07 +0200
Cc: xenomai@xenomai.org
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1bfb1-64d35980-3-66457a80@79680774>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_XENO=5FARCH=5FFPU?=
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Mercredi, Ao=C3=BBt 09, 2023 09:38 CEST, Jan Kiszka <jan.kiszka@siem=
ens.com> a =C3=A9crit: 
 
> On 26.07.23 15:39, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have a=
 build failure on kernel/cobalt/ipipe/sched.c :
> > kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration o=
f function 'switch=5Ffpu'; did you mean 'switch=5Fto'? [-Werror=3Dimpli=
cit-function-declaration]
> > 
> 
> What is the kernel version you are building against? It's kind of a F=
AQ
> by now, but 3.2.x is only supported up to 5.15. Newer kernels need
> current master / future 3.3.
> 

I'm usign 5.4

> Jan
> 
> > The problem seem to be caused by CONFIG=5FXENO=5FARCH=5FFPU not bei=
ng defined, and in this case, the switch=5Ffpu() function is not define=
d, but called unconditionnally in pipeline=5Fswitch=5Fto() and pipeline=
=5Fleave=5Finband()
> > 
> > The fix seem straightforward, however, I could not find any place w=
here this CONFIG=5FXENO=5FARCH=5FFPU gets defined for any arch, nor any=
 Kconfig menu to enable/disable it.
> > 
> > It is however the same for my previous xenomai 3.1 setup
> > 
> > Can anybody help on this ?
> > 
> > Thanks in advance
> > 
> > Fran=C3=A7ois
> > 
> > 
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>

