Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3980F
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 07:55:39 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 31D7C10000A;
	Thu,  5 Jan 2023 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1672905332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFcdZ2c60QXTWB8sJILV1eTtL52c/rhPw0RoU9cUt5s=;
	b=Zxu2Wb0PZHDutcgmzR/kJk/qf5OJby8/ZiGgK/G7FyJtc3J4f1NSIJMiGyGSyoqNAzkADu
	wbRVmDyxJAI1xdixB5mtEufMLniN3oI0vxlAOM0IqIc7lytrYf+DCs0/z7XSq7qlyu21kQ
	//wTdAHTMzKSC3JtRt9Lzixt+PUxIJcn9iLdTC+YZvodbfBDuJqAdQVGfr/gcxCy6xJFqW
	rDqdakaIcptorJTuz2AmpVE0xz+lNhMGUee9+qdcS5icMe39th71HcusVv4Jldl6ZexD5E
	dNCmgI6TyUEnXwCtAvUsEryWu5EOjRXAFCfUwCGUM/u5sKIOUCE0hkiyEdI8fA==
References: <PH1P110MB105062C7FFC4554A49CC1A3AE2FA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: libevl install does not include evl/compat.h
Date: Thu, 05 Jan 2023 08:55:24 +0100
In-reply-to: <PH1P110MB105062C7FFC4554A49CC1A3AE2FA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87fscps9e4.fsf@xenomai.org>
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
> I built and installed the latest libevl, and when I go to build against i=
t, I get an error saying that evl/compat.h cannot be found. Turns out that
> =E2=80=98meson install=E2=80=99 does not appear to copy over that header =
file.
>
>=20=20
>
>=20=20
>
> Thanks,
>
>=20=20
>
> Russell
>
> [[End of S/MIME Signed Part]]

Fixed upstream, thanks.

--=20
Philippe.
