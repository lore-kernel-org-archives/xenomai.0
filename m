Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194A8615A
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866574; cv=none; b=LksCts5h41QCZU2kuw8ZEPz3u7vej02MChqjVf1KsvdJIdFEtnLf33kE5Gi4ajZluCFQLy90sLa45tdSYH8vTtoLHRcz7Ij9vl9+PXl0WRjCrnlxAZAoC2E8fovMfpSa5X1ChOTG9kL/XYMSzJTRsIJDlSww4ZW4jppoUjgwQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866574; c=relaxed/simple;
	bh=pwkXp9bYcg+ht1257alCyL5NyvttkulITPx/iAo1Sro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LI5qoSbCutypFCJ5/IP1Q74chf6NupKpQ4UXKb5Kx9KmSKAnWPONT8rAGU4A+OxVuxD08D0L+8mbNfMKUCUj5PiDPgFTZrti3LrOvURmi76kbrU6+mckBq7blIDIZnd9RhbOOQqNG3DokBE8l6vNCyRCLuYSUMr6r8T1gid5TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YUY8z0zz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YUY8z0zz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9985040009;
	Tue, 14 Jan 2025 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736866563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwkXp9bYcg+ht1257alCyL5NyvttkulITPx/iAo1Sro=;
	b=YUY8z0zzoO99t8ouEwLyV3HrS+pTk87qkn+ssEXTG27Jz3HK7wmuLUi/jRNl3sQUsqiymT
	/TgTlxTceq1/my7AYshWvHsiu7d7TjpNye5mrwiu+UTWiilR0KZJR8YvKfY0v0OloSAmhs
	quxJ1YCNZASrVM+vuXBI3/lFBnOBqGBcnN5Plgs/hz1zKtAOCYphGoJm9wkj5C0KRTQFWz
	9Jfaex2oGYXJk/qohTSnRM2yozd+D5mjuWwFpI2Vhb3R+K+qg+twECJJmOTeEerfeqWH3l
	BrPB8jfvaNWYAWq8ofyLa202DNeIYFIdEc6POEDdz5SFvbQYBDnJKCYGFuTSDg==
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
Date: Tue, 14 Jan 2025 15:56:03 +0100
Message-ID: <87h661xx4s.fsf@xenomai.org>
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

FYI, this vendor branch is not maintained by the Xenomai project.

--=20
Philippe.
