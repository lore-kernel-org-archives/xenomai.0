Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6E1C13
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:36:37 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 3B45AD17A7
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:28:02 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 7685420003
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:27:54 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 664EE740059
	for <xenomai@xenomai.org>; Wed, 21 Dec 2022 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671632872; bh=YP2R7rfOstW5n16LRFhFG8kkMN6gvFS0U9aHxxjrjpk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KXLWd29vm9cCoR9pXeDSNV/J4lkPHujItUvwvF7xfNDE5VuvGlsOP7MhT/drZ1TPA
	 MmzWFASPuhRSUhqk1rPMWpJRGa6FM2iNYZ/1qQkhxnN1EFoK3uOx0SiH4Vu257Twxo
	 b2U3uYErHaatJbYDAysyAq4K+PsM0NqwhQkGfkITz+yKsFRiVOh2W1vqqAa8MzI366
	 /w4Si44zwqbkpsvfggBYElr5d6NBGW1vW9aC0Nn3oIgpa88VhvSm1O/DziLjAp+CTK
	 Vr9LJeRDpzPbA3l9pANMhn0Tvv5IW6Kef3N1WoT6+BW95xrM/yCQigVrS+OQR9DJja
	 nOw2z90udcmyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1oPtkH1mWf-00i626; Wed, 21
 Dec 2022 15:27:52 +0100
Message-ID: <b8f18ed3-37de-9a93-88ba-701860442844@web.de>
Date: Wed, 21 Dec 2022 15:27:51 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Incompatible pointer type error when compiling kernel
Content-Language: en-US
To: hansen.franck1@free.fr, xenomai@xenomai.org
References: <1231689819.651785197.1671540043295.JavaMail.root@zimbra90-e16.priv.proxad.net>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <1231689819.651785197.1671540043295.JavaMail.root@zimbra90-e16.priv.proxad.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7RS1OcCKntr714s+8bXUtr6s6aMbjQFD/eSLsSjW0IUTv5CcJo
 ZfG+pKgJzUCh6G9d4pRfm0CPiDsPv0Q4cWd//A+Jft00tHkfGCiwTR4Pkc2T1A3WbWvJFLq
 eNem3frCpFIkIjrutwzDyfZpxUc4/mt+QW+M424DfgYtcka2n61aKzof6QNM7Xu3YZ2sOoj
 Mv1CC48Aig5D5EOYwQtWw==
UI-OutboundReport: notjunk:1;M01:P0:T83EDK1ZGgQ=;rtJ5ca21+AhwlKrxn5Di2y/nxFv
 S86mnicMNqEIWbcItrjXBlvc/zmBv/ZoMv4zproUTjtC8kcfRCZF5CtpWbX97d88Gzj8hgwee
 62pcFyfzkezdmjooKjhMhLCZ60t5ZMPvYm9duayGTB3KpiZ26paJGjO/NjkB+oOLaMOrkmrzt
 Dg2fh3vnCEGf5vVc1PkTikKlCO6nk4jQSbvM/JJ0dUZTvIEwjp6D6M7yeNmV/4NoLfS5aOPZ7
 Q4AIf8LRjcEucS3E29K8S8OvS4uGVQ7nSc4Rs8ti4+538zBN2CVLRqDFwGWa3KYh2cqaHeJhW
 ctzaaIB72CWTDMyw7EH1yBrxj6FcujLenuG9zXhEQ9J3Vdd0QMPmE7RywDTFGeJZHGvSYk/jc
 r1KkQToEz236q+DeTYG4gmhf7NWat/7m14ZcMYOrOtJcqx6ek3cbjeXLWo2wHKMmVr+oARr+7
 UNp17DfKTQBCzAfbyoIf0rOUrgV/H1CaSzdIilFHvlGm3CVJxnyoYd/vFA8YN3T1b/UlDMyQ4
 1Rxsmo9EN/Uno6ALRMdl5UzQz/onBKjv0IRYSR4ox3yyMFAHY/F7tfznweSuZnXPfwxlltqac
 K9arHXZ5zzCI27oOAOOFfIHE4nF790rPwkXEuyhnBDxe+yAtLK3nxw6kOHilBnisPhGskCecI
 OEdP1flefnCb1QQVbPT76Ee31Mm7OJ6NTt2NJUC7i6wsVi3sVqCScf+nH9l1wLnV9tlUeOWF4
 t2G6qVSmRk+cQtBqHCIyc14ZZeU8D46kREFvYKEOAES8+iufMM2HZ1mt9Na5sXXhbYv5UmbTb
 fG0Zybz2I1uiWVvRdpGP0eNDCAfOblyw7P66dz+XHDWUSvaG2qpLOIIvrNQqDc0mw6OEsUeOY
 K48FRdHa1ylC2utPADnFAYbW0gpGjELxUSWyeiECvgZabj7unV72lGls4l3YnWjJ7dMB5g8Ka
 mzucSw==
Received-SPF: pass (spool2: domain of web.de designates 212.227.17.12 as permitted sender) client-ip=212.227.17.12; envelope-from=jan.kiszka@web.de; helo=mout.web.de;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=web.de header.s=s29768273 header.b=KXLWd29v;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@web.de designates 212.227.17.12 as permitted sender) smtp.mailfrom=jan.kiszka@web.de;
	dmarc=pass (policy=none) header.from=web.de

On 20.12.22 13:40, hansen.franck1@free.fr wrote:
> You can test this :
>
>
>         ....
> 	__prev =3D (xnstat_exectime_t *)atomic_long_xchg(((atomic_long_t *)&(sc=
hed)->current_account), (long)(new_account)); \
>         ....
>

ENOCONTEXT - can you provide more details what you compiled (versions)
and how (build steps)?

Jan


