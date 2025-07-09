Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB2277C82
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051122; cv=none; b=djrWRhNZ1ifl37RrM9wGg1xvOaPU1TeRhvrqkhizLcQkAdG/ife1nXFYQdQd56K4m1tv+kO3X4UARjVHpNyXr+83Z4hnEKFhotZiPrrqY5aOYgfT4aXrnWlWqQgSKqya33EKOruZsfmXASfjOIxVHlLbRx9JzjePxwOC12HlXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051122; c=relaxed/simple;
	bh=eN6iyrN7598rBYcgfVbt+pPUUDKujrgC5fiL3zxw3XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmSDglsiSools8p6Fn2gfbSAMs7wHaHaZH/0o9fOImdMJjyBThABzkr9+m0VYkM6yNTANO64haCOUx0kF3ZCPn9eqvq7gdBHSogzfTlTnmNoessU8TIHcSUdNQ5aRjtmIZo3fUVJw7lPgO5cSv1CiS8HA0ExplaVQ5up1VMXf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YYo8l20F; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YYo8l20F"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C83F6582890
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 08:28:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A63B4331D;
	Wed,  9 Jul 2025 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1752049711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN6iyrN7598rBYcgfVbt+pPUUDKujrgC5fiL3zxw3XA=;
	b=YYo8l20FlARRTJKhjw0FYv3O4jAoPVlNVB6VU2Rzcgf8WMYlbffj3VMifSMb1FWAgn0peX
	ZEAe03OE9lh95EtBOLq7sQonUJJMNk9PYXsaDZTP/dFt7zkwknOnCCCEq9y6sF8oHBxZgi
	uXDng2gh5DVFzRz6sx+SDnQLthkfzk60w1d13890ajzLmCFBRTjs1BS8bwCB/99ZyoiYOc
	9zrWaSQL2LnTugHEzyC9GpNmtYFw0bNXFIDLHi+8ZmTN/jWTbOIUmo0m/GZ7Eov0xDUKnF
	pxpmYUu8TKAE52mhIOp3Brg0pqwVldIj1xtaqxaM2BD7HeUKhJohCPVNSUB+qQ==
From: Philippe Gerum <rpm@xenomai.org>
To: "Steub, Peter" <Peter.Steub@baumueller.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
In-Reply-To: <e5963e4cef7d473baf4a039d8eac49b1@baumueller.com> (Peter Steub's
	message of "Wed, 9 Jul 2025 07:56:03 +0000")
References: <e5963e4cef7d473baf4a039d8eac49b1@baumueller.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 09 Jul 2025 10:28:26 +0200
Message-ID: <87o6ttn4yd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprfgvthgvrhdrufhtvghusgessggruhhmuhgvlhhlvghrrdgtohhm
X-GND-Sasl: rpm@xenomai.org

"Steub, Peter" <Peter.Steub@baumueller.com> writes:

> I just realized, that my application is using 32bit time values, which is=
 not what I want and need. So I added " -D_TIME_BITS=3D64 -D_FILE_OFFSET_BI=
TS=3D64" to my toolchain. Now the evl api is not working anymore. All funct=
ions with "timespec" like "evl_read_clock()" fail since "timespec" has chan=
ged from 32bit seconds to 64bit seconds.
>
> What is the right way to fix this, I guess I need to build libevl with 64=
bit time values but I did not find how to do it right.=20
>
> Evl (R51) is cross build through a Yocto build.
>
> Thank you.
>
> Mit freundlichen Gr=C3=BC=C3=9Fen / kind regards
>

Since Yocto 4.3 nanbield, 64bit time and largefile support are
automatically enabled for 32bit architectures such as armv7. I'm
building libevl from Yocto styhead ATM, with sizeof(struct timespec) =3D=3D
16 as observed by libevl, as expected. There is no specific tuning
needed by libevl regarding this, if the toolchain building it does the
right thing.

Which Yocto release are you using?

--=20
Philippe.
