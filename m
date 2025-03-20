Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1147226D1C
	for <xenomai@lists.linux.dev>; Thu, 20 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496729; cv=none; b=itXZtEWrkt1w8e4a3sd9qwWzkwBH9NB8PKjrD7ph7oDPyyKlVld2T+SmmaVX7x5yAe8vIJfWGWI8ClluPWTtzRpOcUWS010wJfviUl1DJQx7W1QXvWsRTuoX+WX14hCi9f9yRPBTcVBfBaa3IwIZQ51QbEz7INa4TblGCS527F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496729; c=relaxed/simple;
	bh=7EseD22YmN966pfxSGfepFgSoHw7X/wADHpzW9GMPfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LfWh3anmMqHWEuMqMLlijnn0wrD7sDCeaFZ7aeVbNrO6FIHQzm8pYQUj/WP1FEkcp5gijz/2zOVDwCu0CcCpZphxsB2Y+ztfWbgvk1Mj6aQPoutUTpWV9EUUAmtUGNqBYUsD+lsxjIyfEsFCAloR57MyP6YNIdb3FtYFnh086lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=g7I3QyxA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="g7I3QyxA"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29FAC44443;
	Thu, 20 Mar 2025 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742496719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PIN7+7KOVpbRAuki2LRs8f4lsOs/zRjBfGsP26C6x7k=;
	b=g7I3QyxAI10S6Vu4tpYfsvaEmqMSrqoDRyG9KdYBBzrtm7wwcFgIZs5ua/gOx/zkmFFrxE
	a5W5C2pYXPHxx0Hx7WaoW80f+MbXu/LRKtLruJxdjoeehK3ARALMxz5GPGx+1z8zVMQle7
	JjQvp2nA/H+NmTHOV3c9MWqivckqcLthIXonlR2d5WiL3tE1aG3Dgpn15JRvjRthaltUZg
	8HNy1xA46zAsZ+s3JIeNWciOfEmt2ovXJxod6t3/xeCFum2cs6dpT/B6hdXs+SE+Ti98QE
	hp3tWhyMNKTCDBVCiCMEt1otmCflHHnO1kUz1i3UdeBusGrL/dR6KbQTrws7uA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 20 Mar 2025 17:50:41 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 20 Mar 2025 19:51:58 +0100
Message-ID: <87ldszilgx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> We had unbalanced hard_cond_local_irq_disable here so far.
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> 
>> Minus one hunk that is already in current 6.12.y, this needs to be 
>> applied to older stable versions as well.
>
> How was that tested? I think up to now nobody really cared about
> hibernation... Will that really work now when I try to test that or
> will I run into (other) problems?

We can write to /sys/power/state to trigger the suspend-to-disk sequence.

-- 
Philippe.
