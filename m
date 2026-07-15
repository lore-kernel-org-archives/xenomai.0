Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A743FD20
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111034; cv=none; b=LVj0ug6XfreSXgiw5SG0UuJZ3EPR04hu0Y4EutrYb7XIkkCiQXQbBST5yQmv+j9cWrdAguOmc74tCpE6m/50sQ38EuF9a13zsdGlqqnuMeAAP3GcXV8pjELGrEScGyZkPJ1pvUR1AykHwvV4svsRG9NgfHvyXVCf7o2gd1MCMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111034; c=relaxed/simple;
	bh=FlgDv82GFrMQhqLhmnfEvzAVHDIq0Rq5jQIbDrho84Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jS5MCHl7KTGdaDg4WZLaD+qp+AWDKY5Qkv9no84y6zBG0BqalVKr/1hQtzEOEkSLYSRWscsW0vPIXRNc9x3epN1VKNSQA+3Umm6grDo1r6FeII6r31B2F1qX/sd2kPGCeHxsq1RfFxFysgX6/6R8IKuHlaGCZIZd0WWf/PAug/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=nNcFA713; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="nNcFA713"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93F8C3EBC4;
	Wed, 15 Jul 2026 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784111023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzecaEnwsMRM1RCRRwerPp4LgpWb7JJ+CF9xUWoNw58=;
	b=nNcFA7130dHBk8zv3KJSCWM8k5rnAxNgcHcPBsMjYiJtXYShtQJuizGEohbp5JtRyPiC0v
	VYijrYsPE687HLO2Xan4XqwO3TTNW9S+IgVSUOWTp9JIa4XpWti/ogtizb++inYXgqTRdl
	n5zqeNXpXVlTij9UPjc0iowPWZtSeNHPwOQ7y6m64i5Kti/GSnVTgZ/OVBPAzHUZzFNoeb
	GssbCY98PLQueIqfhChOPedfMwpbLau/QwKxy5IjbwRudfTop3pfEKWwt+3FYN1mJo913f
	UxhOhHoVkS0KWumsjEVCzJzOPj40woU//CG3NAzykj5Cw7b03n+5oCdw5/RLdw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH xenomai-images 0/3] longterm EVL testing under load
In-Reply-To: <20260715092822.223712-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Wed, 15 Jul 2026 11:28:19 +0200")
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 15 Jul 2026 12:23:43 +0200
Message-ID: <87zezslff4.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGD88pAEe4inAI/SDUclqYRE37rGcdXr08S8uLF2Uz8NNHtMytlwB+iBezAmxprAirGCxXhAUE0td33xFo9NNGWmTkSeGrndQbLreRYk1wb414YfXeYJLZVREUzIQgVzwPSTlF/p2nm/J370tnPmKAGmxEieYNG6shVUwBMOy19BZ/cPXA92zodeKgdJFsyqxuIlJuMOTjT2FOim8hXJ8ylhAZgmvWrw46IFg2afjGYUeDfJYNeMPV83n/6wOxiKQhbLKgxnKaMkavfjBULJyszI2j/Up3slWgmtAVRQ0UPwgbZpEPKFRF9HkVRIdT8eaSyF3y0cc5eO8B4pozo3YlRHM/cKjiwHeZhvdMOWf54Ega8xaWhzqiADjNNe0Be+FeV7WICY7crWrfMrVtXPe4AjbKiAc5a20glPTaQy/nXPwvYKs6GkQa5eRo7kBmslCKEzqD5x46js2ipDquXVGaokOiPmjxlbk/ZeMsqD5MAcSf+h5HLSAuH1xCoEITIsvRATEm20pbzNKWJP9N0D/LHE5dOmrWLabNaoF0dJ2Un7uJkBvSPRmEWVVJHBf0NzwfDssejq1f4vKtIEbtujXA2EcpiiO5QhYzKzIEma32xfo9frkRCfNZCjxzlWa+TRQcxgFSH/njGZHRbIrVRwCSGTy71E/22eXM0VUxc6TTbWQ
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi all,
>
> This series introduces EVL test runs with additional stress applied via
> stress-ng, as well as long-term testing. Along the way, I also updated the
> long-term kernel under test from 6.12 to 6.18.
>
> Please note:
>  * The clock-timer-periodic test currently fails as soon as stress is
>    applied. I proposed "tests: skip clock-timer-periodic on virtual targe=
ts"
>    to address this.
>  * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
>    threshold with debugging disabled:
>    latency threshold is exceeded (150000 >=3D 163.951), aborting.
>    https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174

We should not exceed 80 =C2=B5s or so on pi4.

--=20
Philippe.
