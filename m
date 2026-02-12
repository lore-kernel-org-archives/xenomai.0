Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7535CBA0
	for <xenomai@lists.linux.dev>; Thu, 12 Feb 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907482; cv=none; b=nUeDx3wd3U9YAQ/78hlLrxpetkfNTm/TAmyopDP4hsMdmfAQbBxIUjkVXAxvR+BY47BIzg4PJsARmoa84jHyhhGM2QKyA4aKwLAqqfx8xt0Rfxg0oKhpBB26M0RbDOUUUyJzPW7tZ9X2wiL3Iyt0GJUIRglubtIGkhja+0ssGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907482; c=relaxed/simple;
	bh=gu93BmBgCb/bnhfOQsbr7X2RBUuyKHk3no4b/VE8e7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqEbwem5R19v/LJ+rsd22aC2/it8Y1VVn0DeNMH+sb0eGo2vxcHyLpIkdCxubwJGifPR98Y8zU1yfU2258B1VhsgpCiD35hx+6jRW8kFzxMnx0yiZotCqV2Wgd5LB2HRK6t+9aTVK5OJbW1F+RscBa7V1aGfmcGLSL8iaUb9s2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZMR57RK5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZMR57RK5"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26B581F747;
	Thu, 12 Feb 2026 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770907473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9Ca2CSF/kLzV1R0vXc3KvrJloWNbrBZXsBBFrCA+ww=;
	b=ZMR57RK56UOUrQ8Ri1i5oWu4ntsuJiGpMjdVZ1j6cVz7k6grf/r9CfYbWnudpMZcvoKx93
	+sJa5YNuTuO/4gwPCAscXYqostI+rRO77mvOsia0IBnp/RRR8XGa2RMHXPAAp+6ZKOxXMi
	/99SVVOem9/OACmNwLb/DzdcxQGsf5JuH4k7+9sy63mASdGQmlWNHZFL1MeUA9sl6Xe9Ll
	Fer2QcizWk7cEFE3HbDkynng0hupHpSHYMgfyGxNzgkQVDKunf3YMJToiMpOkfSyXsYN5W
	Z0UR88koHaCCZuOd0KdjdD1Dxh38jt3kz34sSki8r69NvjcRkPphvRwLL86e+w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 v3 0/3] Fix IPI mapping for arm64
In-Reply-To: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
	(Florian Bezdeka's message of "Mon, 09 Feb 2026 10:33:34 +0100")
References: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Feb 2026 15:44:28 +0100
Message-ID: <87pl6avx6b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdeiueehkeduhfejgeejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> this is the result of a quite longish debugging session revealed by some
> sporadic failures seen in CI.
>
> Please review carefully as the code paths around the KGDB and BACKTRACE IPI
> are not part of the hot path.
>
> Backporting:
> Patches 2 and 3 should go into Dovetail 6.12 as well. Older versions do
> not have the BACKTRACE and KGDB IPIs implemented.
>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>

Series merged, thanks.

-- 
Philippe.
