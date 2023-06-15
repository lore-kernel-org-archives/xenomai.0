Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521AEAF8
	for <xenomai@lists.linux.dev>; Thu, 15 Jun 2023 20:09:22 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id EDD561A000B
	for <xenomai@lists.linux.dev>; Thu, 15 Jun 2023 20:09:13 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DD509AC19FD;
	Thu, 15 Jun 2023 20:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5D1EA616B2CC;
	Thu, 15 Jun 2023 22:09:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DO2xiMDvpg-S; Thu, 15 Jun 2023 22:09:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0242C616B2D4;
	Thu, 15 Jun 2023 22:09:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r3DH1TrWw3NL; Thu, 15 Jun 2023 22:09:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D0F71616B2CC;
	Thu, 15 Jun 2023 22:09:11 +0200 (CEST)
Date: Thu, 15 Jun 2023 22:09:11 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Hongzhan Chen <hongzhan.chen@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	xenomai <xenomai@xenomai.org>
Message-ID: <471825413.5689772.1686859751567.JavaMail.zimbra@nod.at>
In-Reply-To: <87r0qdcbwc.fsf@xenomai.org>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at> <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com> <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at> <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at> <MN2PR11MB42852073A335361100FF8948F25AA@MN2PR11MB4285.namprd11.prod.outlook.com> <116129980.5299274.1686733935108.JavaMail.zimbra@nod.at> <87r0qdcbwc.fsf@xenomai.org>
Subject: Re: Massive variations of execution time on x86
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Massive variations of execution time on x86
Thread-Index: 5Q8ybtva3ID/zlNzu0obs9H1Xt2LMg==
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at

----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
> Any chance an NMI-based Perf event handler might be causing this?
> (nmi_watchdog=3D0)

Hm, I did check "NMI" in /proc/interrupts, the numbers don't raise.

Thanks,
//richard
