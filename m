Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE3AD3C
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 11:15:57 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id BAD351A0008
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 11:15:49 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A159ED80A07
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 11:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2CA91605DED7;
	Mon, 12 Jun 2023 13:15:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zq_wPlYT5g2x; Mon, 12 Jun 2023 13:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C9C0C616B2DB;
	Mon, 12 Jun 2023 13:15:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ouDN-6UwFLYP; Mon, 12 Jun 2023 13:15:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id AB55A605DED7;
	Mon, 12 Jun 2023 13:15:47 +0200 (CEST)
Date: Mon, 12 Jun 2023 13:15:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Message-ID: <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
In-Reply-To: <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at> <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
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
Thread-Index: fyQsGbKDBkEXIc1GLlvhrrt6ZOhykg==
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at;
	dmarc=none

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Thermal throttling of any kind? Is the system passively cooled and may
> overheat under performance settings for power management?

It is passive cooled but according to hardware engineers, the temperature i=
s
not even close to a limit.

Is comparing /sys/devices/system/cpu/cpuX/cpufreq/scaling_cur_freq and
scaling_max_freq the correct way to detect throttling?
=20
> Also, do you see similar variations with similar variations on the same
> hardware with preempt-rt (provided at least your synthetic tests are
> portable)?

I think I can do this. But might need some time.

Thanks,
//richard
