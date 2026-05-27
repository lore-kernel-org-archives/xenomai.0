Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30F250C06
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857555; cv=none; b=dESXJPor0p9lec89Lc73jvwMwFeNNp6BS6XgmMqz4faaY2Utf238IHCxLONBHSTbhJ1x1hQ6+00Lvg9kuZCy9w6+/a+DnzpyReaQyHKYO3h15ove6etibJwU2IrLlPFKkwkFvSiAA3eBeeGFj9Hn7Rv9lm6ZdZAZtsx8Xe/+9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857555; c=relaxed/simple;
	bh=m90WjmjdDQruApDl7emOOHjHw1Ky9mJF2NYeKFJAh5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptcYgmLlw7D90mKiqSRpK8J6mU0fvrMp3hhKx9/QjI3K0GiTdTj5zYXWpCdTskajtuvgLgD67sdGoCY10lI1aGyHZlJCkOOEdbRf4qF8WIzypGZzHsQFAbGg3P2uk/qiyNTTYKXc9bSrdma4kBMdAeAAuL5p5i9u1AVY7Ij9Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=juU0R/Qj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="juU0R/Qj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4E3B3EC67;
	Wed, 27 May 2026 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779857553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Jr4SAgQKQNqaxa+LntcWTqD84Rl5/aviYL2/oI/eCA=;
	b=juU0R/QjKnvL5mmptNgrfl1LXkW7xE1m8WOyGri9O0tsC3W/ipzivKFwZDZjBVBAnfXWkL
	oGQcrAxv6Kk2+TgAuCaYlySsFKVq4Fj4iMkbtTaDBhY7TfoqRwyBdDTeKvXkwi8+12V3kE
	uRIZcCzfN905JYheexVnoFks/80BqjlpmLc05/L+X6SRn6p/+WaxsD8Azojm4jBcNTdnkd
	AGHsbNnxsCbUKNbsPjdrY8M+5zvwB5Ckjjzc+LaLew2af9CAZ56pGbUnm3VHXFaFQ7pO5U
	Tqb7qGaOVGlaxoQOdvu3GthnlIZEBKGY87jr5LRAaRIFGYbbm/UWWcOuJOlr+A==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: fix error handling in client
In-Reply-To: <20260526182923.4576-2-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Tue, 26 May 2026 20:29:23 +0200")
References: <20260526182923.4576-1-hannes.diethelm@gmail.com>
	<20260526182923.4576-2-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 27 May 2026 06:52:32 +0200
Message-ID: <877bopihdb.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFageP14NpvRAbRz8b8JbcFChAQHU9T5nWiG10D2c+F4hIjNzoHsVeiKt21zptND9lFl/JOUSLyE3qimw+joNrOUEqQ7/LWYFq8pTG2mod11pYSvUNz9+1cLdAs9tMUxefVN51FlVluPDSESTPLNi3oIRWfOf169vfWTYYUoREbYox3K2XaCi81OnVQfZWe2xtGb2OCN4ugNbtwb82loHbhhNh3OgyGQYKp7U9CXzS3Ew+Efgmo/udDi3SoytKPHqTPrNPSlt4RfIr4J0LJNOhuIlXSv5N6nCfKnogtzaFvjulf4SVkggPOBZIHEspUNNEEDcVWfZGnN1NdLoy7pLsLh9diG5CXHmf50N0DFvOjnDWW5uGLUMUND5U1vevwxxRgY8uGKpPy+nU3ajVaKsVr94O1qOK4Rbmdn55zpY9LOYxWYvgNIvweji4+zKAsX8vzXLw/yShayl+Xb85XdZL5hLLCoAtMtvEQVBelvFO3OftjpvwNsDiW2AshfUAFLqOmsTI6PJ2xD9sm9+Y2Favoo9daEsQZAz4AOSh4fw0PNWACUCr3VvNVjVPMNBMK8jOOO1/KYAXRfNSXxYL1VjOmm4EX7nlxGYFZOVN48XLOdZ+PuIVquIh6s0DL6C7JNHvCUxwjxVCVvGHEgZZwNCx0ZNtSuYjY0GvrcQe7AU/nRg

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Also fix mistake in comment
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  tidbits/oob-net-udp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
> index 3cd7cb2..11b8459 100644
> --- a/tidbits/oob-net-udp.c
> +++ b/tidbits/oob-net-udp.c
> @@ -8,7 +8,7 @@
>   * The server mode [-S] receives a packet from on a given
>   * port and sends a response to the sender's ip/port.
>   *
> - * The client mode [-S] sends a packet to a port/ip
> + * The client mode [-C] sends a packet to a port/ip
>   * and receives the response from a server. The round
>   * trip time is measured.
>   *
> @@ -443,6 +443,8 @@ int main(int argc, char *argv[])
>  		 */
>  		ret = evl_net_solicit(s, (const struct sockaddr *)&addr,
>  				EVL_NEIGH_PERMANENT);
> +		if (ret)
> +			error(1, -ret, "evl_net_solicit()");
>  
>  		client(s, text, mcount, &addr, iter, delay);
>  	} else if (mode == SERVER) {

Merged, thanks.

-- 
Philippe.
