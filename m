Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A2111AD
	for <xenomai@lists.linux.dev>; Thu, 20 Mar 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496573; cv=none; b=DfN6ktZpN6F36qUUggM9DRTFaPuo/+ukkevuHeaaQHo4SxGi1kEoJmWsvtR9fM5ZgXUZxXbwCKwvF5v5UfAvghczO3weH7g68gRJpGZc85jLkvReZXWvHAI6miFf7+uTOR25EXIs5XrFr1yglnSMiZsjmF0OEtwXOyDHT3aERDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496573; c=relaxed/simple;
	bh=t+8GPx2scsKOMHbcZiiFmvA2pv+oXZLlVZkFTYKqcq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RGjGlcE6NC7DGS9k5wlzTTXFjJh77yPQqQlaeFBSdOgRvsZPdJWdV+r6bSJaJghu8Csk0s9wy/MLU87/EqzeEBPnU5CxwMLHTxmv0HdqlSG7HDTUPHgKPAN7mTyj297RYSFa+c0CtJOJ7rUbkTZujC5XcderahazpF7lVbkB0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Z08Smw8s; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Z08Smw8s"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9365E441D5;
	Thu, 20 Mar 2025 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742496568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mGqDU7Y1u+/SBRJGEwsfhxkG3XKwErfviQnWgyro5E=;
	b=Z08Smw8sAVOnBuGr40J+8/B3PrhEx1deTLjXVouh9K5JVvSO/J2Vod6RJlA2ySY/c8qghX
	DGNBLFcU5HUd3ypjYW15LtrziDw7YckwMnIYfnrm88zaKhMZyJEYKM2j3jCTtg7/s/9jKy
	faL6khoZJxnBWGQb/5qaXTNFIMNMtAnFJ0rXjVvtsq+Yt2kAm8U0avzTWkKQfpFmOMEan/
	wCfi56IedaxuXlUnCnr14EtTPDr3nhg8KSX/+q+h+UvEztnR1JwCr3o3q1sSv6PCjEkjHB
	e1ITLpAnz9IU7IPAigdqd5TcZuFX6XrikbfflQu14MGdyU7LUDkzp1FM8ZkJUQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <e6cfc82a-1b3a-4dc3-b390-8c01728c2ed0@siemens.com> (Jan Kiszka's
	message of "Thu, 20 Mar 2025 18:04:38 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
	<e6cfc82a-1b3a-4dc3-b390-8c01728c2ed0@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 20 Mar 2025 19:49:28 +0100
Message-ID: <87r02rill3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.03.25 17:50, Florian Bezdeka wrote:
>> On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> We had unbalanced hard_cond_local_irq_disable here so far.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Minus one hunk that is already in current 6.12.y, this needs to be 
>>> applied to older stable versions as well.
>> 
>> How was that tested? I think up to now nobody really cared about
>> hibernation... Will that really work now when I try to test that or
>> will I run into (other) problems?
>> 
>
> This was not tested yet, but the affected code is patched since an
> eternity. If we don't want to support this anymore, we must remove the
> changes AND declare CONFIG_HIBERNATION incompatible to
> CONFIG_IRQ_PIPELINE instead.
>

We may definitely have a system running a real-time core which is
allowed to hibernate at specific times (e.g. a copier running Xenomai
would typically do this). This used to work fine for a couple of
projects I can think of (granted, a long time ago). Let's fix the code.

-- 
Philippe.
