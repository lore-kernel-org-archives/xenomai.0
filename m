Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DDE3E8668
	for <xenomai@lists.linux.dev>; Wed, 25 Mar 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451524; cv=none; b=TQ2mpuvkbqBoPoVeQB7e7UkegMfU+yXK/iy8v3f88ccWg7zAVcSjHWGk16u1DFCM1zYOJBGVqXnDUNNvVsHT5bKAB4X9R0p727eCzHBcbRpp7EEtjNEQikm6OJhOZBT3wQwO/fbD+eXit1jn3AFKa1/4KRjIRwMhfmIv7NiHzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451524; c=relaxed/simple;
	bh=9kRVjKk3VaxykCMfmBBmLmbF4H8XGT5gUJHV9JWRzQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DvnS9O96Gwp2qeTwHKK/l7UbUe1cGZYPsYBj8d0vg0n4BPvzHhZJogRKfhMTiiKDZug2sqv8ldTnUFdyD0Ic/AOfwnqNhXO4Aphnzjzzj8uPWMED1vBUS3+3AfeWTXskscNG5FS+IFF7n1izhngw7MLkfDGfm/eKbhBmL+XzrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KXRq9SCs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KXRq9SCs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9D9D3ECEE;
	Wed, 25 Mar 2026 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774451515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjsXQp+B+2CDDE3Ob8eTxAsUBVM56MkSjyUJYreiDHk=;
	b=KXRq9SCsnQw2ykhp33ignpgzujF1L2K4baONgEsEnsz/FRx3/btZLQ4DJ93C4LwLlmP+5J
	BGp9wIb3Tq3kFZVnNevHZjkrS8hHSnUoZ0wqRZqY6Xm29PR04kjxfgkWHIqzx129W0T9c3
	DTck8wN/ROUYODdsSec9XsByH11JXToh5rx0nSFnxfdrZzmO1rv8dbZK3CVZh+x9VtPz6d
	vZFM9ZEW3GUAhajf9zo31V+BVWAOq/nTtASNjED5WSSONC8ctO85m1Nog43ujrScylDuO2
	MiYHmen65tDDeGNSv6ENTg3qLex5L2c4tjold0HiMChBSbKL9l2e0UJhC847mA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH linux-evl] evl/latmus: fix spurious overrun on first
 measurement sample
In-Reply-To: <20260320211713.2150855-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 20 Mar 2026 22:17:13 +0100")
References: <20260320211713.2150855-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Mar 2026 16:11:54 +0100
Message-ID: <871ph8j64l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepveelffelffefgfevgffgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> This delta is not fixed up during the warmup phase leading to spourious
> overruns in the first measurement sample.
>
> Also apply the fixup in the warmup phase.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  drivers/evl/latmus.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/evl/latmus.c b/drivers/evl/latmus.c
> index 9a0295044443..9c581d80db68 100644
> --- a/drivers/evl/latmus.c
> +++ b/drivers/evl/latmus.c
> @@ -166,14 +166,23 @@ static int add_measurement_sample(struct latmus_runner *runner,
>  	ktime_t period = runner->period;
>  	int delta, cell, offset_delta;
>  
> +	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
> +	state->ideal = ktime_add(state->ideal, period);
> +
> +	while (delta > 0 &&
> +		(unsigned int)delta > ktime_to_ns(period)) { /* period > 0 */
> +		if (runner->warmup_samples >= runner->warmup_limit)
> +			state->overruns++;
> +		state->ideal = ktime_add(state->ideal, period);
> +		delta -= ktime_to_ns(period);
> +	}
> +
>  	/* Skip samples in warmup time. */
>  	if (runner->warmup_samples < runner->warmup_limit) {
>  		runner->warmup_samples++;
> -		state->ideal = ktime_add(state->ideal, period);
>  		return 0;
>  	}
>  
> -	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
>  	offset_delta = delta - state->offset;
>  	if (offset_delta < state->min_lat)
>  		state->min_lat = offset_delta;
> @@ -193,14 +202,6 @@ static int add_measurement_sample(struct latmus_runner *runner,
>  	}
>  
>  	state->sum += offset_delta;
> -	state->ideal = ktime_add(state->ideal, period);
> -
> -	while (delta > 0 &&
> -		(unsigned int)delta > ktime_to_ns(period)) { /* period > 0 */
> -		state->overruns++;
> -		state->ideal = ktime_add(state->ideal, period);
> -		delta -= ktime_to_ns(period);
> -	}
>  
>  	if (++state->cur_samples >= state->max_samples)
>  		send_measurement(runner);

Merged, thanks.

-- 
Philippe.
