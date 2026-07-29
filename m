Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41447A897
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327798; cv=none; b=cBzd2+ZoLO+hLmAqE+CWcA5wlwirexjeuxOcAJhtPgDQt5hAG3o82GLkMubs9JgrkTt5nN7Q80jNXMtf5l4FAyxn78kDbledDE5mfvHifzrzAtPDMA81aojO9gXVZx7tBO2kYJtfbhiJ+E0ZBKo6Ntehnp86wR9UvbhGxB/FAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327798; c=relaxed/simple;
	bh=o43Y0g+WzMmo4XuH+8ws2Sps+mlTB6UwElihdeHYIQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRTIf7ZNf7tFN9Z+qwDHFL16o0bmKJasMEOCp2bsALvS1l1I9seTq6GedrSL+dZcJecbHpKuGCjapn7qF579h/v/yplRue7HatdNymyVOYu2LZjlz4pV9vl5eO555emHb4qY8mMHOgGh+ZTKWXevvKg34AzESxRIufrxcKbnAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=M/MivlJx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="M/MivlJx"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 231FC3EC42;
	Wed, 29 Jul 2026 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785327786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBTGtofGvSv+Zd58RiaPiwYELVllB0En1iwJFq+D/X4=;
	b=M/MivlJxhL04KdsoPMLLmFLZaXeutFjOA1zZ2cA0dS5vt15UGZ2cauZzmR4bPjNAha/4Z4
	cHOFuZBKog4mtULp+tjSHuGP2FlOMFOHLCX5AOwar8PdetiN3eynhnICICQswIPXjSlAxO
	DXUXVGcGZw1fz25KbpJry8tfw56K9UbrQJEvIKybdSnL5dvxvG6nheMMfJ8SIxqJWAPRUK
	Z7cjXmW0887MU5CPa2SDSIstt6zXdkxsSVlorK/fcuWXfcyvohk2jaJmXeMNlHfMp9dn/p
	E/cU2XwA/pWDumSUaoxIBKbklGLA22JtNtnYSscfxcBBESsCn0HMNO2vz4FMFw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
  xenomai@lists.linux.dev,  florian.bezdeka@siemens.com
Subject: Re: [PATCH xenomai-images v2 0/3] longterm EVL testing under load
In-Reply-To: <21de2d63-f569-4370-9778-ab8f7dfafdcb@siemens.com> (Jan Kiszka's
	message of "Wed, 29 Jul 2026 11:42:12 +0200")
References: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
	<21de2d63-f569-4370-9778-ab8f7dfafdcb@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 29 Jul 2026 14:23:05 +0200
Message-ID: <87se52vvbq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGaaMPELWGVpu2H3NP4Jnx7E+T1hfAmnwnj5qigR4yL8EJP8Rkozw7vtSzqT+XACR4gq5l8p0lppwdjvY5pGriqN6r+eQOczXJfMWod5BqtwkbSzevWHlqyxOyqu5pnTpttAFZ/WoSzUp63/GXumhVx1DmiUEUmMNvIp8wjqjS6V3iR0Dmh++QEUiqKa4J748+7Dm8/04si02ewkD06KRPAbvBScNioQ++D+OYWpPQvukWPIhLBtG4uzLOrjGE6HxUbnGOvf6HAcUB4y41zE29cxs51+VP/XKqK+KaBt5YeS+NrXoFwMzSc1maXecelpZ+/kq4XuUtRGsi5jb1tMAv6EJH5nuZRutD4sk4s7p9BxCNXLHwenhwLkhsm8CZtkZLRm8P8obcaeNChQw9IaPNPYNroDMQ4/e4+6xUsPCNIFAsWkINHjrTIxnr0jhrjZ1M0J5FDdM5VrjUnuN7Ffbo2oTI7VkIXu36j6H+UxpVp7Efd9U2TUUtJi5f73XmV5BUb6bD9dCkcfSa0MO8QQ7EVXOfgzkw4Cs8ufQkCtZSC0It9EspI8hgIJAg3RgkL4hAbsD4+4s32QyfZjeUnwmTcm35PjuhGFR+0lfRCoB0qffxaLvXv6rbf2guGsgLwtwUjGuKHmIkn3imwUIDsEzXu87C6mhSyS0R/BvNxtCXLHQ
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 28.07.26 16:39, Tobias Schaffner wrote:
>> Hi all,
>> 
>> This series introduces EVL test runs with additional stress applied via
>> stress-ng, as well as long-term testing. Along the way, I also updated the
>> long-term kernel under test from 6.12 to 6.18.
>> 
>> Please note:
>>  * The clock-timer-periodic test currently fails as soon as stress is
>>    applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
>>    to address this.
>>  * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
>>    threshold with debugging disabled:
>>    latency threshold is exceeded (150000 >= 163.951), aborting.
>>    https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174
>
> This second issue is basically a "regression" of adding stress-ng,
> right? I thought there were some improvements on the kernel side
> Philippe recently talked about to address this? Aren't those merged yet,
> at least not to 6.18? Do you see similar issues with latest 7.1?

I'm still to find cycles to work on this, good news is that I could grab
a spare rpi4 for testing at least.

-- 
Philippe.
