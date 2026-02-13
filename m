Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D531986F
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983424; cv=none; b=Pilu2MGGNLrI25L8lgLKM3V9fHx3pczUBX2iAuk1TS/crMoiVx7dFKgu9k2wSXKCH8t7dB97+DeGMJk8MqzGFfuYGDx+g7bpYQzRy/aCzJO45Di5ZLXEqkqRSGWOACnxGJfcbWPAm12uHVhFaQ73Lzu1AwJ9JAfRcF/Os0R0n08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983424; c=relaxed/simple;
	bh=eJZ+jVOjJK7miC6tp0s3TnZjhS/j94RWyok28iodSmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZZXy1/oSpPQ/bf65hIxbgaTadh+8lXOsDsXbRfqDAVlg8T9KEfamo3YUxewg53Uw5BaisxdAlfhCDQ8ny3F3/idilmfD2nOZ5HbP1oxLt6JnBk72Z2mBrJmweKY9fsLYg1mRa7olf5bWehosOA4+FhHOUdX7KV26h4LpVfCvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YpBv4FVX; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YpBv4FVX"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260213115017be727ad9bb00020787
        for <xenomai@lists.linux.dev>;
        Fri, 13 Feb 2026 12:50:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eJZ+jVOjJK7miC6tp0s3TnZjhS/j94RWyok28iodSmQ=;
 b=YpBv4FVXs2irDTPgOq4I0+49MdYoGpMBsY6JNNqBeKGgqLCekhe9zGY8/cvIxUuAE3hYuX
 hQieX11FQMEVkOCKFzcxclgkbdPyYzz+JcpJQDb4rnUJNNDOfYa16USP5gSG01vrAxdksNwM
 wpT/45Sy1XOJmbiFGpXVu0I9VU2DWHhwn2IRfbI4MMrhW2gGlXmIxouFU4gD4EzaspNn12Ab
 NIaY2iO/UBk7dj4vhsDlJIdxgjxuQRxvvtP97qYbr/bjWejdcfTVb8GFAB/FlC/ZGUjamlhz
 Jc+MhfgBFpQEeT88+QMCeEhH8YzjMbjfyilNjJjmLyMmFgS4eW/aU6CQ==;
Message-ID: <7a955d849a7ec9245543c399ec9673d98ee4d5a3.camel@siemens.com>
Subject: Re: cobalt-like pthread wrappers for evl
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 13 Feb 2026 12:50:17 +0100
In-Reply-To: <8c539987-12ba-912d-f50a-cdaccc2cb7e6@bela.io>
References: <8c539987-12ba-912d-f50a-cdaccc2cb7e6@bela.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Giulio,

[ Cc + Philippe ]

On Thu, 2026-02-12 at 22:33 -0500, Giulio Moro wrote:
> Hi there,
> I have to port a large-ish C application to EVL. The application uses pth=
read_mutex, pthread_cond etc. Porting it to Xenomai-3 was straightforward, =
thanks to libcobalt and linker wrapping.
>=20
> Is there anything similar to that currently available for EVL? Maybe some=
one's half-tested branch stashed somewhere? Much appreciate any pointers th=
at will save me from starting from scratch.

That topic is most likely stuck in the design phase. Maybe Philippe can
comment on the current state. The topic was discussed a few times in the
past but never got traction.

Maybe it's time to revive this topic.

Best regards,
Florian
