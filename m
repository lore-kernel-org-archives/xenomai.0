Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA3361
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 05:52:49 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 4BDE31A0002
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 05:52:47 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3FE99AC0BF5
	for <xenomai@xenomai.org>; Tue, 13 Jun 2023 05:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 96FF1616B2C5;
	Tue, 13 Jun 2023 07:52:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 808bcTQscPhf; Tue, 13 Jun 2023 07:52:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3150E616B2DB;
	Tue, 13 Jun 2023 07:52:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9d78-m0twMVo; Tue, 13 Jun 2023 07:52:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0E090616B2C5;
	Tue, 13 Jun 2023 07:52:45 +0200 (CEST)
Date: Tue, 13 Jun 2023 07:52:44 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>
Message-ID: <419315969.3719613.1686635564849.JavaMail.zimbra@nod.at>
In-Reply-To: <MN2PR11MB4285A757D474F8E0FF2AEE75F255A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at> <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com> <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at> <MN2PR11MB4285A757D474F8E0FF2AEE75F255A@MN2PR11MB4285.namprd11.prod.outlook.com>
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
Thread-Index: ecxCFjAboALDcvYMCoVCc8urSYAceJq2B3qAAAFT3oAAHbkSsGPK/sza
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at

----- Urspr=C3=BCngliche Mail -----
> Von: "Hongzhan Chen" <hongzhan.chen@intel.com>
> Did you try with disabling Hyper-threading?

Hyperthreading is always disabled on all x86 systems here.

Thanks,
//richard
