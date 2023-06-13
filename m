Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70F23C6A
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 17:20:09 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id CC1DE80006
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 17:20:01 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B8D3D74003C
	for <xenomai@xenomai.org>; Tue, 13 Jun 2023 17:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3E12160FB282;
	Tue, 13 Jun 2023 19:20:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Nst2CzrBQ3Nc; Tue, 13 Jun 2023 19:19:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD23D61CED10;
	Tue, 13 Jun 2023 19:19:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dmx4oNkz1xgd; Tue, 13 Jun 2023 19:19:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id AE5B460FB282;
	Tue, 13 Jun 2023 19:19:59 +0200 (CEST)
Date: Tue, 13 Jun 2023 19:19:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Message-ID: <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at>
In-Reply-To: <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at> <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com> <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
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
Thread-Index: fyQsGbKDBkEXIc1GLlvhrrt6ZOhyksETGpDv
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
> An: "Jan Kiszka" <jan.kiszka@siemens.com>
> It is passive cooled but according to hardware engineers, the temperature=
 is
> not even close to a limit.
>=20
> Is comparing /sys/devices/system/cpu/cpuX/cpufreq/scaling_cur_freq and
> scaling_max_freq the correct way to detect throttling?
>=20
>> Also, do you see similar variations with similar variations on the same
>> hardware with preempt-rt (provided at least your synthetic tests are
>> portable)?
>=20
> I think I can do this. But might need some time.

I can confirm that the variations are also observable without Xenomai/Dovet=
ail.

Thanks,
//richard
