Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEA2560
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 08:21:16 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B23011BF208;
	Fri, 26 Aug 2022 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661502069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0fVJMpHpB9vfPL5oU/6jxykvgYbYFcVrbYg2RZyAXI=;
	b=IHu9lgWG9mrgck4ogQ14rPgfhieo0/HsbF4wEcRA3Bi5aHwVYuE2QuzzJjRoXge8d4boxZ
	OkaSEVowXGSJV5Q61/z7INkvXkxbGlzn64cTns4OWQfeeW8pkphG9w6zTHdgZ3a1DNMzhU
	xYaXKUd3f5En0eRMn9aeJvhHDmxyFenL/ZGesiXXqpOAe84TfgUWp3j0DofRqf1u1pcvRs
	1ZjocjR4u10XsokN36SXB+DYR/gK3ZtoNdQffG2ks+71/cEPQgRUiz2vUhFU8s1LeW3YC8
	myxvuHXvTEwd4k0wqPOqjsSxx/WXFRLsAlZC+X4IQdAzI4oPaJpE0A/0tomp8w==
References: <88f92512-a51e-7428-2c6a-926d7fa2ecbf@iki.fi>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jussi Viiri <ilmai@iki.fi>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] revl: Mutex shouldn't require locked objects to have
 the Sync trait
Date: Fri, 26 Aug 2022 10:19:54 +0200
In-reply-to: <88f92512-a51e-7428-2c6a-926d7fa2ecbf@iki.fi>
Message-ID: <87y1vbo1ot.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jussi Viiri <ilmai@iki.fi> writes:

> As said in the title, Mutex shouldn't require locked objects to have
> the Sync trait. The point of the Mutex object is to provide that trait
> by wrapping an object.
> Used ?Sized + Send like std::sync::Mutex instead.
>
> Signed-off-by: Jussi Viiri <ilmai@iki.fi>
>
> ---
>
> From 04c362a8239a71a516fb7405e3720d4cf25951dd Mon Sep 17 00:00:00 2001
> From: Jussi Viiri <ilmai@iki.fi>
> Date: Fri, 26 Aug 2022 10:29:04 +0300
> Subject: [PATCH 4/4] Mutex shouldn't require locked objects to have the S=
ync
> =C2=A0trait
>
> ---
> =C2=A0src/mutex.rs | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/mutex.rs b/src/mutex.rs
> index 57e1670..af58d40 100644
> --- a/src/mutex.rs
> +++ b/src/mutex.rs
> @@ -139,8 +139,8 @@ pub struct Mutex<T: ?Sized> {
> =C2=A0=C2=A0=C2=A0=C2=A0 data: UnsafeCell<T>,
> =C2=A0}
>
> -unsafe impl<T: Sync + Send> Send for Mutex<T> {}
> -unsafe impl<T: Sync + Send> Sync for Mutex<T> {}
> +unsafe impl<T: ?Sized + Send> Send for Mutex<T> {}
> +unsafe impl<T: ?Sized + Send> Sync for Mutex<T> {}
>
> =C2=A0impl<T> Mutex<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Create a new mutex for guarding `data`, usin=
g the properties

Merged, thanks (short log fixed up marginally to remove redundant
information).

--=20
Philippe.
