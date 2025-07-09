Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807A1DDA15
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062367; cv=none; b=h+o/BNxCfePsohCVQ1OaeMDrzo1hFx2qkHJzR8hgXVDJlmj/kf1VQdiz6HI1J4JrEdwNxSUU9Rh8gOmN8gh3MPvk8YGcGKl7B2nY3y9SiJRQoKn//wREVhQkpRXJSW9neikOJjwy6fcNCb+ZUk/4FS1UEKpRpvFuxSh6p8t8ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062367; c=relaxed/simple;
	bh=c1HX0atfzyXFufYmKZODqr5TrmPLo0faS5cINKIT128=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAQuQY3VD4ZNWv+bwRyM4rCf+oRBr1OoiJjbNjSAsFxrwd/nk3XB0T/rGjT7X+I8H6hGc8HToicvO561/vr+oI062rIqbDPcCOHuDozzsk9hcqsBDCFJN9uW3Nvg5iDYlRhvzOUs13kSrKOdvt0aFGO7Yu01hSReIKshCekp98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pqFzKPmR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pqFzKPmR"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 664B6438D0;
	Wed,  9 Jul 2025 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1752062362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/pYPYZC2oDzNx9lDUGLh3a6B+n8z5nO9tNv1yvDFl0=;
	b=pqFzKPmRTzB5csVeCDUcaf7yI0TuWA7faq2dD9beOioMrhGjD+rHNowDMwcM0oLTg99g3b
	M4IiUUH54CD+cYUM4gQ+MU5gZsRJtE7G2IKG+mDaIcu4MluMjMHAg5tLkDQhrA3AgZ2ymN
	U2d4FM0oLiL4jQ96vRZs8HLihT1QQFqcuOTkWaPo/KBged7EJ2TZZLjnZIJL0K5Ioif+rj
	ieQ/MNOkzEICZOI+l5a5yJRGx5WFBD/P5pts8wz2/KUHd6cgQAzFTy+Cliu/LNdJTGBKES
	EoNYYwzYOJDTfddCJ4dssr+Fe7F1HE+D/8xzn4c/iuF2l9/DZICps7jreYVVYA==
From: Philippe Gerum <rpm@xenomai.org>
To: "Steub, Peter" <Peter.Steub@baumueller.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: AW: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
In-Reply-To: <9778eb48b6f94d0a92b613eb19a2426d@baumueller.com> (Peter Steub's
	message of "Wed, 9 Jul 2025 08:56:51 +0000")
References: <e5963e4cef7d473baf4a039d8eac49b1@baumueller.com>
	<87o6ttn4yd.fsf@xenomai.org>
	<9778eb48b6f94d0a92b613eb19a2426d@baumueller.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 09 Jul 2025 13:59:20 +0200
Message-ID: <87frf5k21z.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprfgvthgvrhdrufhtvghusgessggruhhmuhgvlhhlvghrrdgtohhm
X-GND-Sasl: rpm@xenomai.org

"Steub, Peter" <Peter.Steub@baumueller.com> writes:

>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Philippe Gerum <rpm@xenomai.org>
>> Gesendet: Mittwoch, 9. Juli 2025 10:28
>> An: Steub, Peter <Peter.Steub@baumueller.com>
>> Cc: xenomai@lists.linux.dev
>> Betreff: Re: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit
>> ARMv7
>>=20
>> "Steub, Peter" <Peter.Steub@baumueller.com> writes:
>>=20
>> > I just realized, that my application is using 32bit time values, which=
 is not
>> what I want and need. So I added " -D_TIME_BITS=3D64 -
>> D_FILE_OFFSET_BITS=3D64" to my toolchain. Now the evl api is not working
>> anymore. All functions with "timespec" like "evl_read_clock()" fail since
>> "timespec" has changed from 32bit seconds to 64bit seconds.
>> >
>> > What is the right way to fix this, I guess I need to build libevl with=
 64bit time
>> values but I did not find how to do it right.
>> >
>> > Evl (R51) is cross build through a Yocto build.
>> >
>> > Thank you.
>> >
>> > Mit freundlichen Gr=C3=BC=C3=9Fen / kind regards
>> >
>>=20
>> Since Yocto 4.3 nanbield, 64bit time and largefile support are automatic=
ally
>> enabled for 32bit architectures such as armv7. I'm building libevl from =
Yocto
>> styhead ATM, with sizeof(struct timespec) =3D=3D
>> 16 as observed by libevl, as expected. There is no specific tuning neede=
d by
>> libevl regarding this, if the toolchain building it does the right thing.
>>=20
>> Which Yocto release are you using?
>>=20
>> --
>> Philippe.
>
> Hmm I am on 4.0 (kirkstone), so I probably should just build libevl with =
64bit time and large file support, I do not want to break some random packa=
ge.=20
> Can you tell me what to set in the libevl recipe to build it with 64bit t=
ime value and large file support?
>

I would enable this in the toolchain produced and used by bitbake
(including in the one produced for the SDK), there is no provision for
doing that in libevl separately. IOW, you may want to enable this
support in Kirkstone. This is done by pulling in
poky/meta/conf/distro/include/time64.inc these days. Kirkstone ships
with glibc 2.35, so TIME_BITS is available there as well.

With the Yocto toolchain enabling 64bit time and largefile support for
everything it builds, the issue would be solved.  OTOH, even if you
hacked the libevl recipe by passing extra CFLAGS to meson during the
configuration step, this would still not cope well with other libs the
libevl package might depend on built with 64bit time support disabled.

--=20
Philippe.
