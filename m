Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E510F9
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 06:58:55 +0000 (UTC)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C9BF5CA2A1
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 06:57:58 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7E4E320000A;
	Tue, 20 Sep 2022 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1663657070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PD1pDTtyJ0lsRXh9ljNtFlFQxPamRamXuQ+0rLu8qk=;
	b=nPsmtqT7xL8GtYKfO32+RDnXJuQYmZ6CHxMdnPyH7nAbuVDdK2GGnHoiy6P4ltnFr6oo0N
	6nwx4XDc4n5oLDXmyg4BTco7WjV89eDlOxrYFPWlkR3X8q0wMN/ICD3SmDNbzfAKVBJyUk
	3xkvgmasA5nyL/vfEp3VrGJyWJrQEl2w411wKM8N/by+euF0zVn3/N79eyVxDmozgW245b
	qW4Kt6sKFnGBLPfomjXshMiIa27BS4yOAQpRy09xgRvf47BrcZIXFUU/JA4cFUT8YHQYSu
	UcCJjsTbFpYzasH5hu1GCZMfvmnvg2JMmYH1jNLepgrDCrMv+V8hs/+MVL+yhw==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: System hanging when using condition variables
Date: Tue, 20 Sep 2022 08:55:20 +0200
In-reply-to: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87edw6pm6r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
>=20=20
>
> I have been trying to debug an issue in our app where the entire system h=
angs with the following error from the kernel: =E2=80=9Ckernel:watchdog:
> BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:2:594]=E2=80=9D. This =
happens consistently on every run. I was able to strip down all of the
> relevant code into a simple standalone app that only uses 4 pthreads, 3 E=
VL events, and 3 EVL mutexes if you would like to be able to
> re-create the issue (I have attached the test file). Is there anything fu=
ndamentally flawed in this logic (the same logic worked fine previously
> with STL condition variables and STL mutexes)? It appears that there beco=
mes some kind of deadlock in the kernel due to an EVL event
> and/or EVL mutex. Let me know if there is any more information that I can=
 provide you to help clear up the scenario. I have spent multiple
> weeks tracking this issue with no luck so far.
>
>=20=20
>
> Thanks,
>
>=20=20
>
> Russell
>
> [4. application/octet-stream; test.cpp]...
>
> [[End of S/MIME Signed Part]]

Ok, thanks for the test code. I'll have a look at this issue asap. Is
this [1] patch in your test kernel already?

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/dde9fa8fbc34=
e101f5c73d719d4d0ea5e420e3c6

--=20
Philippe.
