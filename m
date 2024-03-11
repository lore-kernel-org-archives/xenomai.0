Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6D537E8
	for <xenomai@lists.linux.dev>; Mon, 11 Mar 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178242; cv=none; b=JcnfPHSA4+xt/Su/ZinibnfqdpaHAPkO/1EwU6MU+4oWCPaUE3RZzXvVcqIWm9D2HVOB+mGZXA+QEGzK6BR4YFbntdLkg6Vqfq19uuRLi/PYEGHHlYZjTYiwI4Q0UwKn6Eq7thE252c02E4m28OqRRTB37155aNxWRTM3FZdcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178242; c=relaxed/simple;
	bh=YyNRdgZUcabr+Ftwsj/Jdg6bY5BOPaLG6RNnTvry4YA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AupvxlNzwsrGCGiWFAFai91N8CwjOKljk4Lua8h5EWQeE9gn5UfgYhV8Y26N69SYVqwEs1beBSwD8eAdV45Dd6Jun43M1zlHBPrqBd57FVYZjb9MbZ6GddPjugGg6hev+JIcDGLbpOuhAVM3IisThVvXseRnTKRdN8wr2Imlwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413183f5e11so18510345e9.1
        for <xenomai@lists.linux.dev>; Mon, 11 Mar 2024 10:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178239; x=1710783039;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YyNRdgZUcabr+Ftwsj/Jdg6bY5BOPaLG6RNnTvry4YA=;
        b=DJYFeSGLAP9gCmOJxZaXIhSyfhFm4ZabzhfIghLGnYeXfkhbWXvSTbBZIrulqm3bp6
         aHIOsHs9xUA7CTT+C2Hw0MmIyQvxGAQfiydD3NdacOf+NLDX1nDt2GKd1dgYR4lVTv42
         uZ/uMSbryH4y7asYi9W/3hP961uLiucupDcfnMS9y2HLt1kL1mDN31zonO5iXcDLPGij
         jeMlkmc5YiRRb8Ygxh4s5mj2pY70PFVtQs6ApQF2mmxpRUbKO3OahZPvwJW79T6aZDIW
         KyTm6DpkoDun499gFgSKpUaYg3kGH3UuVJFOEJEUveiQakXnx8KsbSJiREdtrmB8CrUz
         414w==
X-Gm-Message-State: AOJu0YwAFuiSifIZXHXl/QiqBovqqsCAKHcn3Gpgh4Q+CmmafGryWocP
	wExM1A1pOlsrfp89HrQ5aW56NrnnaKGM4y+I1sRSyyvNRFKDixHfUHb8WUk9
X-Google-Smtp-Source: AGHT+IFbbIXY/eHF1zmy1/Sjyh6nC8ElMdIEqJ3GCI5RBqjKvzSoziLdtW96GoCGqlfQ9fXeb+N25g==
X-Received: by 2002:a05:600c:19cc:b0:412:f3af:c6c6 with SMTP id u12-20020a05600c19cc00b00412f3afc6c6mr6359457wmq.10.1710178238365;
        Mon, 11 Mar 2024 10:30:38 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b004132ab0c305sm3495900wmb.41.2024.03.11.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:30:37 -0700 (PDT)
References: <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Date: Mon, 11 Mar 2024 18:26:42 +0100
In-reply-to: <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
Message-ID: <87bk7kwu9z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


"Rosenow, James" <jim.rosenow@mts.com> writes:

> We have a COM express carrier with an on-board SSD.=C2=A0 The SSD has
> Ubuntu 22.04 installed on it, on top of that, I've installed the
> latest Xenomai (master) alongside the 'v6.5-dovetail-rebase' kernel
> from the linux-dovetail repository .=C2=A0 Given that our board supports
> COM Express, we can easily swap between various processors and have
> been doing so looking for the best price/performance ratio and of
> course, low latency.=C2=A0
>
> I have two modules that I am currently testing, an i3-11100HE and an i7-9=
850HL.=C2=A0 Since the SSD is on the base board, I'm running the exact same=
 version of Ubuntu, kernel and root file system regardless of the installed=
 processor board.
>
> The gen9 processor boots and runs the Xenomai kernel without any
> trouble at all.=C2=A0 I'm having SMI issues but that is another subject.=
=C2=A0
> When I put the gen11 board on the carrier, it hangs at 'loading
> initial ramdisk .'.=C2=A0 It is noteworthy that if I interrupt grub and
> select the stock 6.5.x Ubuntu kernel on either, both gen 11 and gen 9
> boot and run fine.=C2=A0 I've verified the Xenomai kernel runs fine on
> generation 7 and 6 CPU's as well.
>
> I've searched the web for possible reasons why Linux would hang at that p=
oint; for Linux in general, it is a common thing and I've tried many, many =
of the solutions that others have found to work, all to no avail.=C2=A0 I d=
o not know how to get additional information on what is hanging as there is=
 really no context from which to proceed.
>
> I'm looking for suggestions on next steps to root cause this hang.
>
> Thanks and regards,
> Jim

Could you boot the machine with the stock kernel that works, then paste
the output of /proc/interrupts? This may help finding out which IRQ
controller might be involved in the issue.

Also, you may want to check whether enabling CONFIG_IRQ_PIPELINE only
(i.e. w/o CONFIG_DOVETAIL and therefore no Xenomai on top) still causes
the issue. That might help pointing the finger at either a generic IRQ
pipelining issue, or something related to the tick device instead.

--=20
Philippe.
