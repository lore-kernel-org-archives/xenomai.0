Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BB212FAD
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781952090; cv=none; b=Jv9TbYToCl0Tmh2Ycui72nqdQOerJ5p2UBNfYiXnrWnFOWCK90nsq9ZX1owIcVfU/xNCoaQlMeyXuLWVq9W9lubAZ6M+Gt1x0BpH30yeoZt4rqcoNLTZYukMa1cdC8wCazq6/PPWD/ejTVTkFmCIqlv4aXfCpq1zNuWFHNGkGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781952090; c=relaxed/simple;
	bh=GX3ml1TEBvAdQZLTEtWgYUfewigx9aeN8EhZ5VZ7IF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TikDCb8WfS53uteBuBugUnpIut+8sqTIvm3Ixt1sVVmLd+tTWHn7Nd0GGT6KaAF5d6mM2+UnjZ4ikkGTa7S84Lwd1wDPypTDa/TApw2gmD5VmZVeQE5QiCcjZCmBKtrkAP3XcSMq+zmhp288andxqwvBELlDCOhaIbrBVnsbbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WWeaEYot; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WWeaEYot"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 406903EB9E;
	Sat, 20 Jun 2026 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781952081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+ILiETipg/4WDsQ4qqsBuF3r43hQyxjqmu9hHqUgg8=;
	b=WWeaEYotQKiuc7QDDM71EDT4D1WvlvZGhKOFF4CG9p+tW7EzqMQAa9cKcntl7GloeBDyKa
	P9KZ/6Dv3b2J9rTAXwZsL5gyRaOaQFdiwStPV8FUKgvJXXNZJ/Z1ItRsiPVxwG6NV9KPXd
	yC4r1ySn2X+ao2v46/cAaczgBweDrKQMECmhcV+1LTUTUIPX6KZZa/IraFLQFoL8fu2yzP
	xXGGAEqsH9A+tyf+NrtG9DB/2oy4CMY18hf4a6yD8EhirdQPNwcNHB4rCc/k2LQG+zW02c
	hAwSfyeKrIHVS9svJ/CPbHWtlcPaBDyOcXfssaH8XUvXXBLngOOUsgxVm+cnqQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
In-Reply-To: <38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com> (Jan Kiszka's
	message of "Sun, 14 Jun 2026 21:37:26 +0200")
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
	<38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 20 Jun 2026 12:41:14 +0200
Message-ID: <87cxxlbik5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFD5VdmTy6F3Mh7K52s/r0LaCqPYDqazKoK6nwaZlR9OQyjgCbseUaSXOA5pV5s1q9nb6y2URqroBV4+L30hjijhkS17eo+scU56L8M1I6ZKp/SNi0ijSWd5jcCMDQhDioeNnWCbQYU0iUvjCXx7SGwX1J5velziYAenPBvr8VpDyctWIJQiflzUbfjlSJ2GEKywk4X+kwlmU8Ga7qZnAXn2A6mR7YRrIvmHAnLFUE0XfdNrUe3J4lZomfRRaeKvV1T9hjWtaDLvGDtkfYZ0RAhdzCgm/yqi9wghZW68LLAVyYJmYl6ZeO3FJm1fwiU38Sk2/SeiZIYTKUKFnlMyjUaA0l+PQv/B3cY2GAUUHiZehBXTlul6HmPndxWMu4KrSGuaU641L45UViFFuAv5G70t00IVvgw7RgZsj+KY8Armanp+hpXJjqWxJyOW956eguN1QqU+uCTRWEbG8bUfrZ7eMNUwV9+l0JCKRM2iReB7ohzFPorKxV18/T2neHHBjZ7tvfmBbBNHcwcGHj2xWOjt3+xZ++6ULmznjtqnKIlbzekzNjuP46TC3ZlHRfPgmN39L0cmJrmGBlTM34eyDbuel6QFiR3eyyK0qS3oaymC3vBMHRLoj8FP8XR8si4KU7NVP3BDeDmoiYXORfma1emTmt2HDBR3TPlSBx7SLCvAg
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Test that higher-prio SCHED_FIFO threads do not run on the bill of
> SCHED_QUOTA threads and that their accounting is not otherwise
> disturbed.
>

This patch introduced a regression when determining the accuracy of the
policy with respect to allotting threads the expected runtime budget:

root@phytec-mira-evl:~# evl test sched-quota-accuracy
sched-quota-accuracy: 494.0%

The proper result would rather be close to the following:

root@phytec-mira-evl:~# evl test sched-quota-accuracy
sched-quota-accuracy: 99.1%

-- 
Philippe.
