Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E929B79B
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579733; cv=none; b=kdTQRlLTEA46ft0kOREvVd6MBPOowkEhbaSvVXSLXmYCcskl07QMomwixtI9jP8mEoKQpkjFri5hnY1p+o/jjG4PSy95vOWQqQm8/6lhkSyaiOs0s8R8p/MSf5LJXQRx13ckzvLgmidR9v0khU9beI9Q0u9yuYbev3T+ri6cqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579733; c=relaxed/simple;
	bh=+L98M+x9ONJXCjoAO3bnv1ATdlQMoffVDy2y3cqgenM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJ6WaInnKBQiW4drQk5zzcvrwb3fBMgxxR0JUcMGm9wd4vSqcubbhqgB+E617wWIMlAR9Au7AhXPIypcduHxQtxF2SbE9lWGken1MH6jzLjrzIRFNcNppHqpgRZgwuNeddsnfVq8JbKl156IhyEzg/HN1B5cqR5LbqoFZzAIcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lWPI/vqc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lWPI/vqc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D8AA41C54;
	Fri, 20 Feb 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771579729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNBhwUCPTtQSnhs7RNXFr9JTtUii+NxNo2Mm4hJ1TgA=;
	b=lWPI/vqcA56qyfAvI+nqtTM8mk8IR8YNAxMutLIMromTKKh6dp2YU6ou22EVruwvUlW/FC
	heww2RnWDpDtFT0rcSWsS+9g12xCp0+cb5jL7n8tvsb0fio64IzghJkAxUmtUQnVcu/9iJ
	qHa6nNAeDe63gkNew14zCFUWlAsuPlTVdEq85+SMwmE09KlE3iCha/J/OC82lltdEN8sKf
	bTKtgPGwpRps8lgFynvyRbd9kEaxnlShQzSLQq4W9kXkDO5gaGRCpKtvXlq0oGhH3yZ+/l
	OQLLGGtE3wd38GOpe0uNN88UD510Ix1Z+sbL0xKacRQxhyPcAS1+Qg4Fi89R5Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	(Florian Bezdeka's message of "Fri, 20 Feb 2026 10:08:43 +0100")
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 10:28:48 +0100
Message-ID: <87tsvbhigf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptdffkeetteegudevheegpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> The current time64_t / y2038 support switched libcobalt to time64_t
> only, removing the interfaces for the native time_t type.
>
> With that series applied both worlds can live together in one libcobalt
> build which should hopefully increase the backward compatibility a bit.
>

Is this series re-enabling time32 in a way?

-- 
Philippe.
