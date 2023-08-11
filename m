Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A321171A
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 16:25:22 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id D9CA6100003
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 16:25:20 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 949E374003B
	for <xenomai@xenomai.org>; Fri, 11 Aug 2023 16:25:19 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 4E3A05FFCA;
	Fri, 11 Aug 2023 18:25:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 37BGPFBP365401;
	Fri, 11 Aug 2023 18:25:15 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <aabcaa96-f667-49d4-91b5-ff6be0754f34@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 92.128.82.106, 147.161.152.118
Date: Fri, 11 Aug 2023 18:25:15 +0200
Cc: xenomai@xenomai.org
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1bfb1-64d66100-5-66457a80@79680807>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_XENO=5FARCH=5FFPU?=
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 212.27.42.5 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Mercredi, Ao=C3=BBt 09, 2023 13:41 CEST, Jan Kiszka <jan.kiszka@siem=
ens.com> a =C3=A9crit: 
 
> On 09.08.23 11:17, Fran=C3=A7ois Legal wrote:
> > Le Mercredi, Ao=C3=BBt 09, 2023 09:38 CEST, Jan Kiszka <jan.kiszka@=
siemens.com> a =C3=A9crit: 
> >  
> >> On 26.07.23 15:39, Fran=C3=A7ois Legal wrote:
> >>> Hello,
> >>>
> >>> upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have=
 a build failure on kernel/cobalt/ipipe/sched.c :
> >>> kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration=
 of function 'switch=5Ffpu'; did you mean 'switch=5Fto'? [-Werror=3Dimp=
licit-function-declaration]
> >>>
> >>
> >> What is the kernel version you are building against? It's kind of =
a FAQ
> >> by now, but 3.2.x is only supported up to 5.15. Newer kernels need=

> >> current master / future 3.3.
> >>
> > 
> > I'm usign 5.4
> 
> ipipe-core-5.4.231-arm-6?
> 

Correct

> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>

