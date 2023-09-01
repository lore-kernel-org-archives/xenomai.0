Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B916BE5A
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:44:32 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 46AEF6146;
	Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 46AEF6146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1693575871; bh=alpZ8Aadg4GuzEbP3udA1Cr4nB3FrjQ4f6Rrtu+S1Gw=;
	h=Date:From:To:Cc:In-Reply-To:References:From;
	b=rV1J8N/ylwAbcKKLsvm02L9jPFyk5Nzg1Xvt9dbgpX5E7Fj2W6rCJDGwzvfs5PspE
	 0fdT1nJufmhz8olwLcMFb0kyziLTvbv8SUDsS/2uw9uZk1wVcDXT260DQboaYUIYaj
	 S7jPm28u4gb3Lu8U1L5J/q00rCFs0+F/bhysFJhU=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 41C9830004E;
	Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 3D81D100671;
	Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 1BD711006B1;
	Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 1BD711006B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1693575871;
	bh=alpZ8Aadg4GuzEbP3udA1Cr4nB3FrjQ4f6Rrtu+S1Gw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=W3ug5SP8VIOrU2VfTLupKngLyxPtlxJQzeJGqfMMl0B0QQvgd+3aR17foTcjPET7u
	 JBo+mPH0rSUGCxgoW6yzZUFB0cazBKH9J6ZjDlgb8celnz+TBb6O1uzT2yrZ+rOnu5
	 2vtlXpsX1gCarE9PgfrWE3tWwaHZi7ccI5acMsZgnkCQPPzZXCSA+g+uva4VLOSR2F
	 VWQ7J2PZWtV/vYL1+dzpx3QbK/Ya+NFySZWvcqArNhpkhKYFKAskiWJ3HIYLoVzdAe
	 UdbR+naj5dT7opow9S3IhR2abzjZpccMbZ/es2bn8HZA5NXMxLAJ/zs8Lvz+QRrh2j
	 cwzZlZs8W4iFQ==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6h0ETKp5TxZy; Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 060A4100671;
	Fri,  1 Sep 2023 08:44:31 -0500 (CDT)
Date: Fri, 1 Sep 2023 08:44:31 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Message-ID: <955481814.1525807.1693575870993.JavaMail.zimbra@wolfram.com>
In-Reply-To: <926e7876-c2b0-43eb-91b7-7b7f969ab208@siemens.com>
References: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com> <926e7876-c2b0-43eb-91b7-7b7f969ab208@siemens.com>
Subject: Re: Status of Xenomai-images
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [46.59.13.250]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC116 (Linux)/9.0.0_GA_4478)
Thread-Topic: Status of Xenomai-images
Thread-Index: 1GMynkc0XaDMZa7aLYOgBpPKoOngVw==


----- Den 1 sep 2023, p=C3=A5 kl 15:34, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 01.09.23 15:26, Per Oberg wrote:
> > Hello list

>> I just tried out the xenomai-images [1] but I couldn't make the images b=
oot on
> > my hardware. The qemu variants worked.

>> I used "kas-container menu" without any changes and tried a few combinat=
ions
> > like

> > * Generic x86-64 EFI target
> > * Latest 3.2.x release / Head of stable/v3.2.x branch
>> * Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest 5.=
10
> > Dovetail version

>> The hardware I tried so far were PCs with intel core i3 or AMD Ryzen bas=
ed
>> architectures. I managed to get my USB stick flashed with the wic-file a=
nd boot
>> into grub. But then it hung with a blinking cursor when trying to boot t=
he
> > linux kernel.

> > Am I making some sort of silly mistake ?

> Maybe framebuffer output is not working, and you are only "seeing" boot
> messages on the UART then.

> Not sure if we allow for an interactive grub session, but you could try
> adjusting the kernel command line there to use console=3Dtty0 instead of
> ttyS. If that was the reason, we should likely fix something.

> Jan

> --
> Siemens AG, Technology
> Linux Expert Center

Yes, that was it.=20

Completely removing console=3DttyS0 showed me the regular linux boot.=20
But then it got stuck in initrd because it couln't find the root partition.=
=20
Seems to be looking for the wrong uuid.

Per =C3=96berg=20

