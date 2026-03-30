Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB542FD7D3
	for <xenomai@lists.linux.dev>; Mon, 30 Mar 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895830; cv=none; b=iLwCuMwKtEmsQpzf+yOeSlmMgA0n18DairbD3R8ACIr79IaVukGVD6WUvvNPVJCB0ISOG2L0PEaoQvmC7SvCUto36eGDDEINBDfSggMeIWxAteXYjYF0H1sMy6TPJjZrV1acC1wMgvsveWHEBSGGstaVtyz6bFEIUA4FMcvyyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895830; c=relaxed/simple;
	bh=G/SNqdV6mpdloLeIW3l4H3F93CCWFdZqvWdIMzcHQSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=td/qqvxSyK5ycMvSBiojyXhQ8joOvddqgoewfvqlM+VWvw9zo0VH48VXuETzMLLkoohjmIBO20fIT2z1K0jBT4A3qSPtE+JTk+oTgTQGCB9i7sZvsF8X5QBCJAE67OUBc+Fd2ZkU0UqpFMeUGu3EOe3kK/gRSuoDB86YwRikpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=A7UzawKK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="A7UzawKK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C7233EE78;
	Mon, 30 Mar 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774895819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4PM5lWW/AMsMBecNDzY7V6gNLUJZJy1mldsBnQ+68k=;
	b=A7UzawKKG0s2UsycgCAm4dODiMKun2daV8LsJpuWjreiEhhVNfDy6657Waa1XEHgtcGocW
	t3KPK55JUHxYhEektb3mIT89A77vt5Ym58tH0OVDkfOHp7OquW3gdD08YQS3E0JSoT5Pzj
	DLhEG3PKAg1AJQslZmdTCIn0ROx471IZ+InsrBXW12GQLhabp9Iq6VcS3+qqk2KaY5QYWS
	cWeyJ47r6qsDuSyxTIZgrmBqd4rqw9f8C0Xn5BuHPM5tutePS9rUxwtwamZzqAxT8QR07V
	KJNWBeMgTnN0PzOaF/FXV/bD7FfDK3wCAymeihOkw8Sa9L1nvi4fBjJ4+1r7mA==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brho@relativityspace.com>
Cc: Brandon Ho <brandonho667@gmail.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH] release oob skb when received in-band and fix
 setsockopt ret
In-Reply-To: <SA1P110MB12788B81A19D6618E2ADA984D352A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
	(Brandon Ho's message of "Mon, 30 Mar 2026 17:11:40 +0000")
References: <20260327184718.580694-1-brho@relativityspace.com>
	<874im0b7w0.fsf@xenomai.org>
	<SA1P110MB12788B81A19D6618E2ADA984D352A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 30 Mar 2026 20:36:54 +0200
Message-ID: <87y0j9nozd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFllAjGWAoALDrgKODt6kAEhNeegufPKTdk64NoLHLr9TXmD5kJoka9d16tZE3bfj6Qv1E7Ng5SDII3c+Ueeymf7P5m9Zbq3wYIUMmTkMCXIjuwvPm0LqQ8l798dstC8F4A7zHKPBwBj/pRgUyroqdVUATt34gKSy/cmPKQqkt6b6HDKtxvP1WsRvNRwmgmfrWUFjs65hq4NOCsqFBOj6QakUs8s45OrTgwwiFsPaQoqi6ZPNmnQ5WBCG2x6Jt8T80i+8+wlh/nyoGXqPidGpV0H1mhGQLPm8/lwQ+oouV5Xcalat/jspig+Mw8hH0Ek+41VzH02IsuFui5tbG10hWntlQy9RFcShhE38HDWwcRqhimEv3QNXzLAO5TjuemRgY/5QXAQKloGcVckwgI9t+sAGd3Xd1AcP/ygzHzYFWAwUQb4nPVpfKonRCUbuJlWzSVqyagQnVS+/esuiXjSvWVXlPbdGazWGX1+e56g9VG/XPF7BS0Wih07zR2KZGLQQIIbgL/5VTFoJs/Z7C0jXb+3mp6zMSoQu+RdJwQX3WhOpC3l4DLedN+PVcLgs0elthm1oTbQaUbGyn9EO5V+C62d8GsJrAODkuNN8VkLpj2LVHMEahQjUY93JXKWIhD45Q1si3Zta6RroIqx3yEunNWjlJ59WboAMQPcC46SWaYUA

Brandon Ho <brho@relativityspace.com> writes:

>> __consume_stateless_skb() should never be called from the oob stage, or
>> receive any oob-managed skb, which makes the redirection via
>> skb_release_oob() pointless. Did you identify any code path which would
>> hand over oob skbs to skb_consume_udp() for release?
>
> The code path I found was udp_recvmsg->skb_consume_udp->__consume_statele=
ss_skb =E2=80=94 I would run into ENOMEM without the
> skb_release_oob.
>

Ok, I better understand the issue now. You likely have an oob-enabled
driver receiving packets, in which case some skbs left by the evl core
to the regular netstack for handling may indeed be pulled from oob pools
and never released back. So your patch does make sense.

>> We don't need this, all following code paths either assign this variable
>> prior to using it, or simply return an immediate value. The original
>> code does not initialize this variable on entry, which confirms the
>> latter.
>
> Oops sorry I meant to make the patch in sk_setsockopt =E2=80=94 that one =
returns ret at the end. I was getting ENOIOCTLCMD when calling
> setsockopt for SO_REUSEADDR.
>

Ok, got it. You must be working with the v6.1.y-cip kernel series,
right? v6.12.y-cip, v6.18 and v7.0 don't have this issue (anymore). Word
of caution: v6.1.y-cip+{dovetail/evl} is semi-EOL, some kind zombie
state. v6.12.y-cip is the current SLTS for us, you may want to upgrade
if possible.

>>  PS: on a general note, please split patches addressing unrelated topics.
>
> Sorry I'll make new patches
>

Np, you are welcome.

PS: mentioning the target kernel release for those patches may help.

--=20
Philippe.
