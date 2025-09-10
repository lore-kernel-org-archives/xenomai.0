Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009923B607
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536511; cv=none; b=V57IvZMb+nAQMEyN0Qr09Z9AZrJmvyIwTzqq56z53W+UbHBBZrwumsT8EapJMHQ6Giye7MGgtXy2YNGTnigICff2J0XteKIdKRN0z2cTJql/lWOIht3phVJUOThjY8p/wwCelvV4/Z2hU9RIafHSfuJfqMxbiFLILhr7qLgcusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536511; c=relaxed/simple;
	bh=ZM1deLDSOBbb9z9n9+SpaOc3hTKMP1doR1gP86qAC1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8QBzI8ALp4OmTsM51vho2UtIr6oSQkAYvbCJ2GxSkV9xaHQqq/JsFeK3sTP0wYZl5gPXNVnr9bI+UgK+oIMbR/fF4iGM0NWUj6h/BYbSaRqXJd7g3FfTX+gHJqYA24ogxvJcKwzZTMX7oQs6QDzxjEl7BhYoINTeipsyJJjI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=CVqwo6L0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="CVqwo6L0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C880644366;
	Wed, 10 Sep 2025 20:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757536501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKp5W734NPXKnZ8TGntyhom+jMVL40ZrD04MU4tEDtw=;
	b=CVqwo6L0IUc+A+F6cTRy3Vvb75PLnirJP6zMI5VzzWJbXuJGvRBQuD/ERQ+v0huYthacGf
	o+Xe88o12qE3aNZPSdv0DnggBdKepeGA93/OFu+D5wm/9YTJ7iWHJwSKpjv+wEuw7adWBj
	V83DK1RwYVq6bikz8IgdyGNLKWRIQq+3VfJVCSbwuOVGvByNk8MuSYEcqWFq5fz0o3mfLG
	NIm8E+HcjB4QHwRZJiUCCby8wcGI9S/YjNLsZ1JkL262lSxiiR9kIo2pb6VfrOjVvWfIsj
	LRW+/9T84YWJuJpau/Wclfb8dF0abTzGvxualBwuO1/U5OsvP9bBbSh8rfA9nQ==
From: Philippe Gerum <rpm@xenomai.org>
To: "Xie, Nick" <nick.xie@festo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Error during libevl build and runtime settings failed
In-Reply-To: <AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
	(Nick Xie's message of "Wed, 10 Sep 2025 19:54:52 +0000")
References: <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 22:35:00 +0200
Message-ID: <878qimxczv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnihgtkhdrgihivgesfhgvshhtohdrtghomh
X-GND-Sasl: rpm@xenomai.org

"Xie, Nick" <nick.xie@festo.com> writes:

> Hi Philippe,
>
> Thank you for your information. We tried 0.54 and 0.55 and got error. It complained " EVL kernel uapi is too old " and then we rebuild the 6.12 kernel with the newest update. The whole processing seems fine and please see below. But we have a new problem now.  
>
> The startup stuck at 
> "Loading Linux 6.12.30- g06a9a69b631e,Loading initial ramdisk "
>
> Please advise. Thank you in advance.
>

Since this is a runtime/boot error, please get a full kernel console
output, so that we can figure out where the boot actually stops. There
is no way to help only with the information above. Using a serial
console is preferred over a vt.

PS: booting over a ramdisk inherited from some distro-specific boot
setup builder is discouraged if a problem arises in the early
steps. This only obfuscates the issue. In order to understand obscure
boot issues, you may want to strip your kernel configuration in order to
statically enable in the kernel (i.e. not as modules) only the device
drivers which the hardware requires for a minimal boot. Once the boot
issue is understood and solved, you can switch back to whatever boot
setup you see fit.

-- 
Philippe.
