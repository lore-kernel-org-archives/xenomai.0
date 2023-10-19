Received: from mxout34.expurgate.net (mxout34.expurgate.net [194.37.255.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDC101DA
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtOqo-00Ft8p-Pm; Thu, 19 Oct 2023 10:57:54 +0200
Received: from [185.2.140.90] (helo=mail.ipg-automotive.com)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtOqo-00AQUB-5q; Thu, 19 Oct 2023 10:57:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.ipg-automotive.com (Postfix) with ESMTP id B6A822EE01E7;
	Thu, 19 Oct 2023 10:57:52 +0200 (CEST)
Received: from mail.ipg-automotive.com ([127.0.0.1])
 by localhost (mail.ipg-automotive.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pZLmp3sxD9lD; Thu, 19 Oct 2023 10:57:52 +0200 (CEST)
Received: from mail.ipg-automotive.com (mail.ipg-automotive.com [192.168.200.11])
	by mail.ipg-automotive.com (Postfix) with ESMTP id 3175D2EE01C9;
	Thu, 19 Oct 2023 10:57:52 +0200 (CEST)
Date: Thu, 19 Oct 2023 10:57:49 +0200 (CEST)
From: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <617630177.28605403.1697705869664.JavaMail.zimbra@ipg-automotive.com>
In-Reply-To: <917e42af-545c-4439-bac4-78d1f9548931@siemens.com>
References: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com> <917e42af-545c-4439-bac4-78d1f9548931@siemens.com>
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
Thread-Index: 1EZdEjJC/UOSQruoTqgEQwfKYiCsIA==
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.cyren.com for details.
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1697705874-D3E9C639-CB5CAED3/0/0

Thanks for explanation.=20
Does Xenomai 3.2 sync with the Linux clock only on start or is there a poss=
iblity to also force the sync during run-time?

Best Regards
Prasanna
----- Urspr=C3=BCngliche Mail -----
Von: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;
An: Prasanna Kannan &lt;prasanna.kannan@ipg-automotive.com&gt;, xenomai@lis=
ts.linux.dev
Gesendet: Thu, 19 Oct 2023 06:43:40 +0200 (CEST)
Betreff: Re: Cobalt kernel parameters

On 19.10.23 06:17, Prasanna Kannan wrote:
&gt; Hello,
&gt;=20
&gt; I=E2=80=99m currently using Xenomai 3.2.2, and here passing the kernel=
 parameter =E2=80=9Cxenomai.clockfreq=E2=80=9D doesn=E2=80=99t seem to have=
 any effect.
&gt; In Xenomai 3.1 I was able to successfully use this parameters. Is this=
 parameter still valid with Xenomai 3.2.2,=20
&gt; if not are there any suitable alternatives?
&gt; In the past I also used to check the clockfreq registered by Xenomai u=
sing /sys/module/xenomai/parameters/clockfreq.=20
&gt; Somehow this is also missing in 3.2.2. I am thankful for any pointers =
here.
&gt;=20

This parameter was obsoleted by the switch to dovetail kernel patches:
Xenomai is now using Linux and its vdso as clock source. This also means
there is no longer a need to calibrate some hardware clock itself in
Xenomai, therefore also no clockfreq parameter anymore.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


