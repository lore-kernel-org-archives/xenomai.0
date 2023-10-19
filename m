Received: from mxout34.expurgate.net (mxout34.expurgate.net [91.198.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A09194
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipg-automotive.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtKTk-000SOP-Cf
	for xenomai@lists.linux.dev; Thu, 19 Oct 2023 06:17:48 +0200
Received: from [185.2.140.90] (helo=mail.ipg-automotive.com)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <prasanna.kannan@ipg-automotive.com>)
	id 1qtKTk-00E1zd-01
	for xenomai@lists.linux.dev; Thu, 19 Oct 2023 06:17:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.ipg-automotive.com (Postfix) with ESMTP id 673EF2EE031A
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 06:17:47 +0200 (CEST)
Received: from mail.ipg-automotive.com ([127.0.0.1])
 by localhost (mail.ipg-automotive.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id csYchyHPOnT6 for <xenomai@lists.linux.dev>;
 Thu, 19 Oct 2023 06:17:47 +0200 (CEST)
Received: from mail.ipg-automotive.com (mail.ipg-automotive.com [192.168.200.11])
	by mail.ipg-automotive.com (Postfix) with ESMTP id 827FA2EE0190
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 06:17:46 +0200 (CEST)
Date: Thu, 19 Oct 2023 06:17:45 +0200 (CEST)
From: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
To: xenomai@lists.linux.dev
Message-ID: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com>
Subject: Cobalt kernel parameters
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.200.11]
Thread-Index: qhlTWHyRkgs81WW7AM9xEt1tw1JLwA==
Thread-Topic: Cobalt kernel parameters
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.cyren.com for details.
X-purgate-ID: 151534::1697689068-DDB7B1F7-9B0B7E91/0/0
X-purgate-type: clean
X-purgate: clean

Hello,

I=E2=80=99m currently using Xenomai 3.2.2, and here passing the kernel para=
meter =E2=80=9Cxenomai.clockfreq=E2=80=9D doesn=E2=80=99t seem to have any =
effect.
In Xenomai 3.1 I was able to successfully use this parameters. Is this para=
meter still valid with Xenomai 3.2.2,=20
if not are there any suitable alternatives?
In the past I also used to check the clockfreq registered by Xenomai using =
/sys/module/xenomai/parameters/clockfreq.=20
Somehow this is also missing in 3.2.2. I am thankful for any pointers here.

Prasanna
