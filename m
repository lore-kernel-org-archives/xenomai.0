Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2ED1553B7
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868623; cv=none; b=OR19NKHpVlxRd0EdGaKVCtzy3QAqJ+RqKn+MLUlvp0TSmBqb0j8LI0Q7lUD6TrF7Ynb46yT+IseyW7FINBhW49m2dmQVRcDbbSr9WgdqjINB4O7NznSD+D6GkWENSf5qHbCVaHe63xzoe8AUEWOArBIPDfABIyP2y/xA7WxjpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868623; c=relaxed/simple;
	bh=Afc4NkONLXYDVz1/YCy+84A5twtv8vTzvDMtaz8IiUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JKjxPzGYZbomc1ZmibT7EB4lQGvbNi23ECo3srLcmMjjkJxShDRwVuZPHOdh3ge92vbi0JUTEbUOv9+zuwCqJN2Y7R2TV2tLxc5DJqQN2muJHMg1rXvWsGW4eyZ6v18D2qa/yWObA1sx7VjoeMaIIxWntcc8Wvb7R3l01x9Ztmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bUgNAfXZ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bUgNAfXZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A3AF20007;
	Tue, 14 Jan 2025 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736868619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwX9UkRXPs1i1LQX3ybjNyfE7DN2YGFoKFeJK+Lj0Bc=;
	b=bUgNAfXZsIMmpoNof1mLJNTvG3bNpPx/D4D202KVw0RsN+eFQ+FTxmKk1Jvhy/Yn3xPtPe
	LDznTaum3cJmk4SRkQ1VBoVXnJgP28cUK2HwGG3cwNn73KyG+eZE3Vs/UFpC5qUxqMlVTx
	TUT/a8qi6iY6otQrzFArHpGvN+t8sSDEEcc6c5oMUeEdastttAufsmC9REBuRQo0X9EbPq
	2W8Tn2W4LNHn12Kt/B1bhZ+ky0sQjAS5U50NR95X+N1iNwhA/3CYno+JQmjoDHPhP98QoC
	WOWSAFTG9/q/V0djbZZdSDtBTGhV7sqWNHnr9gdVByNz6jUEuAvrLu2/r8Weww==
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: /sys/class/evl/net/vlans: No such file or =?utf-8?Q?directory?=
 =?utf-8?Q?=E2=80=9D?= on rpi4b
 using evl
In-Reply-To: <CAHR=ZXFO-zG8hyjpYFSQ3PmhQQt90LTF=p377TH2jaVZ3NuvmQ@mail.gmail.com>
	(Qichen Qiu's message of "Tue, 14 Jan 2025 23:21:40 +0800")
References: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
	<87plkpxx9y.fsf@xenomai.org>
	<CAHR=ZXFO-zG8hyjpYFSQ3PmhQQt90LTF=p377TH2jaVZ3NuvmQ@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 14 Jan 2025 16:30:18 +0100
Message-ID: <87bjw9xvjp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org

Qichen Qiu <ruiqurm@gmail.com> writes:

> Hi,
>
> Although the EtherCAT master supports VLAN, many EtherCAT slaves may
> drop these frames. For example, we tested this with the LAN9255, though
> we=E2=80=99re unsure about other EtherCAT slaves.
>
> Would EVL consider directly supporting filtering based on the EtherCAT
>  identifier? Specifically, when the receiver thread detects an Ethernet
> frame with the identifier 0x88A4, it could treat it as an OOB
> packet. When sending a packet, pass some flags so the OOB stack
> won't attach anything to the original Ethercat packet.
>
> Given the widespread use of EtherCAT in industrial applications with
> Xenomai, this feature could be highly beneficial for developers who use
> the user-space Ethercat driver, like SOEM.
>

BPF. See https://v4.xenomai.org/core/net/#evl-input-diversion.

--=20
Philippe.
