Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C3BE6C
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:50:46 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id A67485E4E;
	Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com A67485E4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1693576245; bh=7BpmjYwGcFfJWKVyazQsCdSD767Ov1UFFBQO9AoG2eY=;
	h=Date:From:To:Cc:In-Reply-To:References:From;
	b=TdkeAhs98w1VItkbBRhNHBxmpp+J/supSy2j0flkC5UDGuWWu4dLaOqswqV/RiAmL
	 B3JyrgRi5DDqiGEXWGb8Qizhrfm4JEeFVYz1g6bcL62UYYH9r+eE+jgbRn0Y3GN2pB
	 J9y5wH6PM9qaYNeFwu0sH+HlrXpx/r7GSLdPGSBc=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id A269430004E;
	Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 9E8121006C1;
	Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 876691006BE;
	Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 876691006BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1693576245;
	bh=7BpmjYwGcFfJWKVyazQsCdSD767Ov1UFFBQO9AoG2eY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=CqPW3yG0rpbXY01lH9BEhkAQ+i2rGYeEylO7Lh5LGu1mYdCBTHtBeB/sPdD8RKmYr
	 nvYdHlhOmkZYB+jD+2cPmsl74xWFGybUQUV3PCW9LPOoM/ueDd7JTNYbCXCHW8+1wr
	 QVtXePcSoa8gRoaNsifNr0e3w+ad+Ou6hdshSVdFWz5LWD4urmSJxqi4toxALbLeFT
	 FvM7Segr/tMWKQwmwocI6n7sV7ZTEcL6NEcdIgMzD/c5EiF6uI2NHAA80IEtUt+6E2
	 4Jf8F4K0BNB9UznTjTc0ziaoYGrmb9Y+rfi8Ksj244FreSpAsXX5FTPMD5MULvUD4U
	 1K6LrEOQTH0fA==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UcyYOll4X4yj; Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 6F2CD10068F;
	Fri,  1 Sep 2023 08:50:45 -0500 (CDT)
Date: Fri, 1 Sep 2023 08:50:45 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Message-ID: <127715732.1527015.1693576245422.JavaMail.zimbra@wolfram.com>
In-Reply-To: <f7e4b137-668e-4e0c-bc65-cdc97e516bc8@siemens.com>
References: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com> <926e7876-c2b0-43eb-91b7-7b7f969ab208@siemens.com> <955481814.1525807.1693575870993.JavaMail.zimbra@wolfram.com> <f7e4b137-668e-4e0c-bc65-cdc97e516bc8@siemens.com>
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
Thread-Index: oDqKXf0jT0Zd3q2MM4Ufy5Pr1v5sMw==

----- Den 1 sep 2023, p=C3=A5 kl 15:48, Jan Kiszka <jan.kiszka@siemens.com>=
 skrev:=20

> On 01.09.23 15:44, Per Oberg wrote:

> > ----- Den 1 sep 2023, p=C3=A5 kl 15:34, Jan Kiszka jan.kiszka@siemens.c=
om skrev:

> >> On 01.09.23 15:26, Per Oberg wrote:
> >>> Hello list

> >>> I just tried out the xenomai-images [1] but I couldn't make the image=
s boot on
> >>> my hardware. The qemu variants worked.

> >>> I used "kas-container menu" without any changes and tried a few combi=
nations
> >>> like

> >>> * Generic x86-64 EFI target
> >>> * Latest 3.2.x release / Head of stable/v3.2.x branch
> >>> * Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest=
 5.10
> >>> Dovetail version

> >>> The hardware I tried so far were PCs with intel core i3 or AMD Ryzen =
based
> >>> architectures. I managed to get my USB stick flashed with the wic-fil=
e and boot
> >>> into grub. But then it hung with a blinking cursor when trying to boo=
t the
> >>> linux kernel.

> >>> Am I making some sort of silly mistake ?

> >> Maybe framebuffer output is not working, and you are only "seeing" boo=
t
> >> messages on the UART then.

> >> Not sure if we allow for an interactive grub session, but you could tr=
y
> >> adjusting the kernel command line there to use console=3Dtty0 instead =
of
> >> ttyS. If that was the reason, we should likely fix something.

> >> Jan

> >> --
> >> Siemens AG, Technology
> >> Linux Expert Center

> > Yes, that was it.

> > Completely removing console=3DttyS0 showed me the regular linux boot.
> > But then it got stuck in initrd because it couln't find the root partit=
ion.
> > Seems to be looking for the wrong uuid.

> ...or we lack USB support in the kernel built-in or as modules in the
> initrd so that your USB stick can be found. That may be a matter of
> tuning the x86 defconfig in use.

> Jan

> --
> Siemens AG, Technology
> Linux Expert Center

Per =C3=96berg=20

Wolfram MathCore AB=20
Teknikringen 1E=20
SE-583 30 Link=C3=B6ping=20
Sweden=20
Cellphone: +46 76 877 89 70=20
Phone: +46 85 592 16 41=20

Please visit us at: [ http://www.wolframmathcore.com/ | wolframmathcore.com=
 ] or [ http://www.wolfram.com/ | wolfram.com ]

----- Den 1 sep 2023, p=C3=A5 kl 15:48, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 01.09.23 15:44, Per Oberg wrote:

> > ----- Den 1 sep 2023, p=C3=A5 kl 15:34, Jan Kiszka jan.kiszka@siemens.c=
om skrev:

> >> On 01.09.23 15:26, Per Oberg wrote:
> >>> Hello list

> >>> I just tried out the xenomai-images [1] but I couldn't make the image=
s boot on
> >>> my hardware. The qemu variants worked.

> >>> I used "kas-container menu" without any changes and tried a few combi=
nations
> >>> like

> >>> * Generic x86-64 EFI target
> >>> * Latest 3.2.x release / Head of stable/v3.2.x branch
> >>> * Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest=
 5.10
> >>> Dovetail version

> >>> The hardware I tried so far were PCs with intel core i3 or AMD Ryzen =
based
> >>> architectures. I managed to get my USB stick flashed with the wic-fil=
e and boot
> >>> into grub. But then it hung with a blinking cursor when trying to boo=
t the
> >>> linux kernel.

> >>> Am I making some sort of silly mistake ?

> >> Maybe framebuffer output is not working, and you are only "seeing" boo=
t
> >> messages on the UART then.

> >> Not sure if we allow for an interactive grub session, but you could tr=
y
> >> adjusting the kernel command line there to use console=3Dtty0 instead =
of
> >> ttyS. If that was the reason, we should likely fix something.

> >> Jan

> >> --
> >> Siemens AG, Technology
> >> Linux Expert Center

> > Yes, that was it.

> > Completely removing console=3DttyS0 showed me the regular linux boot.
> > But then it got stuck in initrd because it couln't find the root partit=
ion.
> > Seems to be looking for the wrong uuid.

> ...or we lack USB support in the kernel built-in or as modules in the
> initrd so that your USB stick can be found. That may be a matter of
> tuning the x86 defconfig in use.

> Jan

> --
> Siemens AG, Technology
> Linux Expert Center

Yes, right again. I have no keyboard either.=20

Regards
Per =C3=96berg

