Received: from mxout34.expurgate.net (mxout34.expurgate.net [91.198.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC48F64
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtPU9-004KU4-Rq; Thu, 19 Oct 2023 11:38:33 +0200
Received: from [185.2.140.90] (helo=mail.ipg-automotive.com)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtPU9-004KTo-Ex; Thu, 19 Oct 2023 11:38:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.ipg-automotive.com (Postfix) with ESMTP id 695572EE0255;
	Thu, 19 Oct 2023 11:38:32 +0200 (CEST)
Received: from mail.ipg-automotive.com ([127.0.0.1])
 by localhost (mail.ipg-automotive.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IakwpJ-KWeTT; Thu, 19 Oct 2023 11:38:32 +0200 (CEST)
Received: from mail.ipg-automotive.com (mail.ipg-automotive.com [192.168.200.11])
	by mail.ipg-automotive.com (Postfix) with ESMTP id 0CAEB2EE0238;
	Thu, 19 Oct 2023 11:38:31 +0200 (CEST)
Date: Thu, 19 Oct 2023 11:38:29 +0200 (CEST)
From: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1873992245.28780880.1697708309041.JavaMail.zimbra@ipg-automotive.com>
In-Reply-To: <cf30fc77-0095-40bc-8fd9-a5c908dfb7ce@siemens.com>
References: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com> <917e42af-545c-4439-bac4-78d1f9548931@siemens.com> <617630177.28605403.1697705869664.JavaMail.zimbra@ipg-automotive.com> <cf30fc77-0095-40bc-8fd9-a5c908dfb7ce@siemens.com>
Subject: Re: Cobalt kernel parameters
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.200.11]
Thread-Topic: Cobalt kernel parameters
Thread-Index: E9cFbZhtAFaSzf01cfgecVM9W9pDFg==
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.cyren.com for details.
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1697708313-C6D7C1F7-E7B07388/0/0

Does this mean , if CLOCK_REALTIME is  is synchronized  with  PTP,=20
Xenomai clock is also is also indirectly PTP synchronized?

Best Regards
Prasanna


----- Urspr=C3=BCngliche Mail -----
Von: "Jan Kiszka" <jan.kiszka@siemens.com>
An: "Prasanna Kannan" <prasanna.kannan@ipg-automotive.com>, "xenomai" <xeno=
mai@lists.linux.dev>
Gesendet: Donnerstag, 19. Oktober 2023 11:04:03
Betreff: Re: Cobalt kernel parameters

On 19.10.23 10:57, Prasanna Kannan wrote:
> Thanks for explanation.=20
> Does Xenomai 3.2 sync with the Linux clock only on start or is there a po=
ssiblity to also force the sync during run-time?

Xenomai uses that clock source all the time, no need for sync'ing. Be
aware, though, that changes to CLOCK_REALTIME will now also affect
Xenomai tasks & timers.

Jan

>=20
> Best Regards
> Prasanna
> ----- Urspr=C3=BCngliche Mail -----
> Von: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;
> An: Prasanna Kannan &lt;prasanna.kannan@ipg-automotive.com&gt;, xenomai@l=
ists.linux.dev
> Gesendet: Thu, 19 Oct 2023 06:43:40 +0200 (CEST)
> Betreff: Re: Cobalt kernel parameters
>=20
> On 19.10.23 06:17, Prasanna Kannan wrote:
> &gt; Hello,
> &gt;=20
> &gt; I=E2=80=99m currently using Xenomai 3.2.2, and here passing the kern=
el parameter =E2=80=9Cxenomai.clockfreq=E2=80=9D doesn=E2=80=99t seem to ha=
ve any effect.
> &gt; In Xenomai 3.1 I was able to successfully use this parameters. Is th=
is parameter still valid with Xenomai 3.2.2,=20
> &gt; if not are there any suitable alternatives?
> &gt; In the past I also used to check the clockfreq registered by Xenomai=
 using /sys/module/xenomai/parameters/clockfreq.=20
> &gt; Somehow this is also missing in 3.2.2. I am thankful for any pointer=
s here.
> &gt;=20
>=20
> This parameter was obsoleted by the switch to dovetail kernel patches:
> Xenomai is now using Linux and its vdso as clock source. This also means
> there is no longer a need to calibrate some hardware clock itself in
> Xenomai, therefore also no clockfreq parameter anymore.
>=20
> Jan
>=20

--=20
Siemens AG, Technology
Linux Expert Center
