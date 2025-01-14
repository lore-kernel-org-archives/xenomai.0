Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD108615A
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866386; cv=none; b=HUw+WtLBnBqwZ/vGSLZjAu8OPl97BDy1YngSC8e58lXqyw/w79zcTUM7TZEWthk+X43XoH165Q+tLuz8cL37cDYHQZsHisXBn0bmMUkqbYj8GZVwGzTZNW/gh1Dp72w/7JvGlJUNGR5liHFQa9GJ324Z2M7hXlrkzcy8IqGTWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866386; c=relaxed/simple;
	bh=zPP2XtWLsoQFVmNNdjK/SjsL54SBZ9ggqkUIwiFQRR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVmJlPLj9fedRxC2KlC1idIW/vuvaU5XWiEht0E4MYO6G8ooKvNaunk+DvZ86nul+vtq8iMu3h+NOLtqd1PfPoTnIrKDYX56uLk07Sk67Uv85A4LzRpkqkSL7JZgMnVfWDGE08SN28FCzBk18Ualsd18b4Lk/ciMn9u7RR+F160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JDeT03co; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JDeT03co"
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED2BC20009;
	Tue, 14 Jan 2025 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736866382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPP2XtWLsoQFVmNNdjK/SjsL54SBZ9ggqkUIwiFQRR0=;
	b=JDeT03comvEKG4/OGjIj/TpPbMwhdfWpg8BAqtcU2lAc1BLOuStKaLIbYz1/yep2RaYTOC
	U30yO0sKC8Fb2dJxsLnVWgt/TUplCvnHYeM5/RcyiDaSUjhRihfiGjfbFtZvlIE1xfXduv
	tv052+eVuA9yg2XkOYt5Po6IcD2Xs4m724y9bJWYd6fyzebc8l1WHYVfde1VSoD/rA7owV
	NkHWgoiB0Zm6qWNRO4jP/NFQtyG+wvGNrzl90//0Zwkpi2g3S5JNxz5J3JVtaU749fBr3D
	DdQYeVXZUB05qPyeLrLD2UvHkBItp6uxK8rDG0dmG5DYjawqxR+Y/AwWyFp/Lg==
From: Philippe Gerum <rpm@xenomai.org>
To: Nan Chow <morthlee@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: /sys/class/evl/net/vlans: No such file or =?utf-8?Q?directory?=
 =?utf-8?Q?=E2=80=9D?= on rpi4b
 using evl
In-Reply-To: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
	(Nan Chow's message of "Tue, 14 Jan 2025 22:00:03 +0800")
References: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 14 Jan 2025 15:52:57 +0100
Message-ID: <87plkpxx9y.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org

Nan Chow <morthlee@gmail.com> writes:

> Hi all,
>
> I am developing EtherCAT master based on EVL, and my target hardware
> platform is Raspberry Pi 4b. I used the =E2=80=9Cvendor/rpi/v6.6.47=E2=80=
=9D branch
> and successfully compiled the image and dtb files with oob network
> enabled. Following the instructions in =E2=80=9CThe EVL network stack for=
 the
> impatient=E2=80=9D, I could attach a VLAN device with tag 42 to the real
> 'eth0' device, and sssign an arbitrary address to that VLAN device,
> and tell EVL that the VLAN device is an out-of-band networking port.
> But, when I did the last step, =E2=80=9Cecho 42 > /sys/class/evl/net/vlan=
s=E2=80=9D,
> there was an error =E2=80=9C/sys/class/evl/net/vlans: No such file or
> directory=E2=80=9D.
>
> My question is, does the RPi4b support OOB real-time ethernet now? And

Only partial support, see [1].

> if so, what may be the reason for the error?
>
> Thanks for any kind help!

1) Is /sys mounted? 2) Which part of this path is not present (e.g. is
/sys/class/evl/net present)?

[1]
https://v4.xenomai.org/dovetail/kernel-api/net/#dovetail-net-full-oob

--=20
Philippe.
