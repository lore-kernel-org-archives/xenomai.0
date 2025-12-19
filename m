Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5613DBA0
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135754; cv=none; b=n4cidFU74EpWxja139m1t0IG4t3tivoSlv8arGMeiyPkOljUNG1W8aTNJowomuWAiozWX6pDeA+s8qSQsc1o/o9CBnUhvGF9vE05gAgS3y/j2+B/tPkvczkSA3LhivWI6xkprWZ9/OPcfJP6RW+cuHpK/gWPlyEdtgVrFZU8OgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135754; c=relaxed/simple;
	bh=5BVA7+gxb0xSriCIFozOvNGHBr6PvgLtDjzLwyE0VB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTiLKrIqvVbzbrwFQzwHHFAZfrKAwTLXd9CWVzhVpiwrfMPTsUedaoK7AxqA+YKUuXGlFZN66DBK1Y8wnVyjFExZ3kxWMn/6pRdknRv8uqsdyXKp6LI54Xy9jVOR5pFexillg9ujTV1cg/pf58mriWB+wz8W3g7NIJX1Dpi4A90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=aQC5iSkI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="aQC5iSkI"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F3B6444F6;
	Fri, 19 Dec 2025 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1766135743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BVA7+gxb0xSriCIFozOvNGHBr6PvgLtDjzLwyE0VB4=;
	b=aQC5iSkIOrC4cW4qRU2H0kljZ/eLrShUIiwBPyh9JjajJHyo6gkoJ9A5oBYPsDOIJkzey/
	N//VTeHaHsf0y8ojLrrkIG3zALQY4PBojj2Yt/avPr/KwqSdojaSzkREZXmu6LJMTQkGV/
	bWicYtilV5ibaXuvFT37G04/pzSn4nBENaUfFi+m/fsl7rTaP9aAjg93DtoL1AUknb1fwX
	sByMEruSBxfJeYC3Rr2FGaBZUmQCXxTUwyMKImKUrdA34ks400Rwrs3v4+VPJlUHJEkCnA
	tzU10yHV833OlnPeCa+EoaqCmZrXbKg9dZUaQo/lu8tWzuMufwEqN3udmUp3EQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: EVL UART driver
In-Reply-To: <CAFc1U0sKevnf4i9HFLaRu5nJ-Lajn7khjsLDRtxx=CEFWy36OQ@mail.gmail.com>
	(Pierre FICHEUX's message of "Fri, 28 Nov 2025 18:48:48 +0100")
References: <CAFc1U0sKevnf4i9HFLaRu5nJ-Lajn7khjsLDRtxx=CEFWy36OQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 19 Dec 2025 10:15:38 +0100
Message-ID: <87fr96zvb9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeitddvjefhjeevgffhteetheefhfehieektdetueffleejteeufeffvdefjefgffenucffohhmrghinhepgigvnhhomhgrihdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepfefhfeeuieeggeeghfeipdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphhivghrrhgvrdhfihgthhgvuhigsehsmhhilhgvrdhfrh
X-GND-State: clean

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> Hi all,
>
> I'm looking for information about writing such a driver. Reading
> https://v4.xenomai.org/core/drivers/index.html leads me to think there
> is nothing available for UARTs.
>
> Is there any example of documentation anywhere ?
>
> I've read a post by a french developper (Cl=C3=A9ment Godbille) but it was
> in 2021, just a short discussion with Philippe.

There is indeed no support for driving uarts from the oob stage yet. As
the document you pointed out suggests, providing such support first
requires to figure out how to properly teach the tty layer about the oob
stage, IOW how to provide a functional subset which could work from an
NMI-like context, so that we don't have to fork off any random mainline
(uart) driver to adapt it specifically for oob, with all the bit rot
issues this caused to Xenomai3 over time.

Xenomai4 already does this for the DMA, GPIO, SPI and network
subsystems, I have no doubt this could be done for the tty layer the
same way.

--=20
Philippe.
