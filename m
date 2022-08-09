Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525B5C8E
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 06:53:32 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 862E2200003;
	Tue,  9 Aug 2022 06:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1660028010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOrr6NqWhrKmAYSJrcy3F37RlBz8yn1JJviTNG9EZr8=;
	b=kSSvcWNJIenKa3yZs2UgdgXxfgFNkuP22t7SIYtgRbi92Zt1RpY/ow21ETxFcQAANiAI/v
	bYbybPgfIVAfPmb8Gj3rnJrNCbmqHVlT9Xf/hxepvQXWxPxTNmD1uLiyDOdQLhWIpon6ZA
	kACgw8qY2S//PoECzK6wfocJoYQr3vSXnanV574jBKo9KzstTuEKPkFs73e182w/iBgvxe
	8YD5+A/r1wFsPtFqZtrKXnSVoiANiPRMk5Nxlbh9vjrwTLmU8+rdIzmdSVgOIDPhuKb3sm
	wMLs2NNC0uNeMTt0q8TojxutcmxHspNX8TLys0tEKxDTsSU8O3NRksuod9N2zg==
References: <PH1P110MB10504D04678A4ABF57F6040FE2639@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Using an xbuf between two processes
Date: Tue, 09 Aug 2022 08:22:06 +0200
In-reply-to: <PH1P110MB10504D04678A4ABF57F6040FE2639@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <877d3hoql3.fsf@xenomai.org>
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
> We are intending to split our current application into two separate proce=
sses =E2=80=93 one with the non-realtime code and one with the realtime code
> (the realtime app will be forked from the non-realtime one). The xbuf app=
ears to be the natural solution for transferring data between the two
> processes. From what I can tell from using it and reading about it on the=
 wiki, it should work for not only inter-thread communication but also
> inter-process communication, correct? I figure one app will create the xb=
uf (making it public) and the other app will open the already created
> xbuf. Then they can simply read/write back and forth. I just want to clar=
ify that this is one of the intended purposes of the xbuf architecture
> and that we are not architecting ourselves in the wrong direction.
>
>

This is correct, an xbuf is definitely an IPC too - by definition, any
EVL resource which may have public visibility in /dev/evl may be shared
between processes.

You could also use a EVL (public) proxy [1] for sharing a linux 'file'
object between oob and regular threads regardless of the process they
belong to, while keeping real-time guarantees for the former when they
read from, write to such file. To implement IPC, the file can be a
socket, an eventfd, etc.

[1] https://evlproject.org/core/user-api/proxy/

--=20
Philippe.
