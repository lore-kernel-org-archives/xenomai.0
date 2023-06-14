Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84209A41
	for <xenomai@lists.linux.dev>; Wed, 14 Jun 2023 09:12:19 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 5059580002
	for <xenomai@lists.linux.dev>; Wed, 14 Jun 2023 09:12:17 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 59F5AD8026E
	for <xenomai@xenomai.org>; Wed, 14 Jun 2023 09:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CE552616B2C5;
	Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vYOYJhn2cRtD; Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5E715616B2CC;
	Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9yyFKUX4cXKF; Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3EDD1616B2C5;
	Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
Date: Wed, 14 Jun 2023 11:12:15 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>
Message-ID: <116129980.5299274.1686733935108.JavaMail.zimbra@nod.at>
In-Reply-To: <MN2PR11MB42852073A335361100FF8948F25AA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at> <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com> <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at> <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at> <MN2PR11MB42852073A335361100FF8948F25AA@MN2PR11MB4285.namprd11.prod.outlook.com>
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
Thread-Index: ecxCFjAboALDcvYMCoVCc8urSYAceJq2B3qAAAFT3oAAPwLOgAAfSPhwhcfPc8o=
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at;
	dmarc=none

----- Urspr=C3=BCngliche Mail -----
> Von: "Hongzhan Chen" <hongzhan.chen@intel.com>
> SMI processing can last for hundreds of microseconds depending on system.
> I know that it  are all disabled according to your hardware vendor. I do =
not
> know if it is worth
> double confirming the value through rdmsr 0x34 really does not increase w=
hen
> issue happen
> but we have no idea about the root cause.

Our test case monitors the SMI counter via /dev/cpu/X/msr and observes
no change in the counters while the test runs.
So I'd rule out SMI.

Thanks,
//richard
