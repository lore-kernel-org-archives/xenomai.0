Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A631398
	for <xenomai@lists.linux.dev>; Wed, 24 Aug 2022 10:40:13 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 56E4610000C;
	Wed, 24 Aug 2022 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661337611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7G5EusanlD/5IplWL6pq1oHHiwOKs4qMlEdJnn/bohM=;
	b=BMqyor4ItybPeavlUaloiDFWeQNYGRf7WrEA5WVIJVvLBtSRNwm614F9ittYZu89dpXMZK
	+5Nz9bTlwT2DB81HuHmXPz4y4zFWxPQ66S0KA2kNXdkqPbQ78V0BYUygYnIdGTnEy+YqAc
	F4i+Jo19gv6+a7ZuW6MQwfeRem783ImjLAKpJaqwh/Kho8ULmJTIHfBwKbLBqePV4NahNh
	U376Iw4g89tLz91j+uGyIFI/h0v98Idk3hMK/KEp82ECPCkPyyEEIMZwwAHqJdwCsrNWik
	JEKrEzeHoLbyfWIFqjayg2u9qY5KYHG5mbK6266LXKLfjXmVOQM/KHPvfx9qLw==
References: <0990af90-25f5-fdb7-8438-3d65d7dfe528@iki.fi>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jussi Viiri <ilmai@iki.fi>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] revl: Add empty Send + Sync implementations for Event
Date: Wed, 24 Aug 2022 12:12:35 +0200
In-reply-to: <0990af90-25f5-fdb7-8438-3d65d7dfe528@iki.fi>
Message-ID: <87a67tgc1i.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jussi Viiri <ilmai@iki.fi> writes:

> Event wasn't safe to send across threads. Fixed.
>
> ---
>
> From 0782e7d6c5f9189fe85f8f340721e1bcec3d16b2 Mon Sep 17 00:00:00 2001
> From: Jussi Viiri <ilmai@iki.fi>
> Date: Tue, 23 Aug 2022 22:49:01 +0300
> Subject: [PATCH 3/3] Add empty Send + Sync implementations for Event
>
> ---
> =C2=A0src/event.rs | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>
> diff --git a/src/event.rs b/src/event.rs
> index 7fdfd23..f469c43 100644
> --- a/src/event.rs
> +++ b/src/event.rs
> @@ -76,6 +76,9 @@ impl WaitTimeoutResult {
>
> =C2=A0pub struct Event(UnsafeCell<evl_event>);
>
> +unsafe impl Send for Event {}
> +unsafe impl Sync for Event {}
> +
> =C2=A0impl Event {
> =C2=A0=C2=A0=C2=A0=C2=A0 pub fn new(builder: Builder) -> Result<Self, Err=
or> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D Self(Unsafe=
Cell::new(unsafe {

LGTM. We enforce the developer's certificate of origin as defined by the
linux kernel project, please send all patches with a Signed-off-by line
(resending this one as well).

Thanks,

--=20
Philippe.
