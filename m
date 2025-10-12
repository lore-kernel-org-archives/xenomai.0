Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2323AE93
	for <xenomai@lists.linux.dev>; Sun, 12 Oct 2025 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760259241; cv=none; b=pxniqSCNrtMW8o0gvZCfiWmIHYKTZsm5HzSj/Ja6Ff+HAq4ljbqgkIaWtPV+7YoCFLBNlq83COWMLgXL1ER4iHWbAZoS8TLg0fLQb5pd+ZqOCxqyHD1D37nm0v9sLWeILi/DhgqWArvToOQQjm2u3zhQjemarhYICXRuHN//LqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760259241; c=relaxed/simple;
	bh=gQuDUUiJhZ7qheA3Wv88pCaRrRL2/+Vke2O5fJyWYT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNH+kAcArIDI7bkYVMaJZ3a1sbvweoQj1Gia/zGWBKe+MiEqpCqyLESCUe3fa0qZl55YDAAewW2oWSlowdDASLHBu0ghzSrnOd8Y873xC0x8vD+d40Khju70JC8aXiWj6k+G8K1IEs8wCT5fq/g0vfGzMJ3bACRI4oUHxrbRkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KtD4YJdm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KtD4YJdm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0107741C7B;
	Sun, 12 Oct 2025 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760259236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/B33fr2CVY58B3VTlJ3qaXd5WTUa+8A3J2hB6TzN0o=;
	b=KtD4YJdmZdvpWmNXzBurmxinO+BReTyB4jS6XnysvvIoH48eV4PJpdimLfMsBjc7xWSpSo
	EQPFpP9G/VqDlJoBf5NYvqid+rfgsEokpotF3h6cxnPYmtJv+W2wz6xqpmezd5X+F6JlD4
	a5AxfuMVFJPSiWDeU6YhRN9Wg376nAeveup6cuICPSsxPSFtaN1AA1RjJFv6QSJVIaj+IB
	tZLNviKvu5PXgYcvT48AZ2P47gvid8vkJHfe9+6h+KS6pSa0D2JXLR1jLOQsRxnxh9JfJN
	VyqvPDhwdAHWhTgtiJ0Rq7ZtSYIDkOeNw3I+u4K7Jn7RClF65qA4+07ncQprhQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [linux-evl][v6.16-evl-rebased][PATCH] drivers/gpio/gpiolib.c:
 fix typo
In-Reply-To: <2458bd6f-cd9d-434d-4d85-95b553600b25@bela.io> (Giulio Moro's
	message of "Sat, 11 Oct 2025 14:43:15 -0500")
References: <2458bd6f-cd9d-434d-4d85-95b553600b25@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 12 Oct 2025 10:53:41 +0200
Message-ID: <87frboijqi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> From e8f89f46672796396d37e2af2c905f8c0e3e792d Mon Sep 17 00:00:00 2001
> From: Giulio Moro <giuliomoro@yahoo.it>
> Date: Sat, 11 Oct 2025 19:42:11 +0000
> Subject: [PATCH] drivers/gpio/gpiolib.c: fix typo
>
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index dcb44a428841..d13b0b82a9ad 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3872,7 +3872,7 @@ int gpiod_set_array_value_oob(struct gpio_chip *gc,
>  		trace_gpio_value(desc_to_gpio(desc), 0, value);
>  	}
>
> -	gpio_chip_set_multiple(gc, mask, bits);
> +	gpiochip_set_multiple(gc, mask, bits);
>
>  	return 0;
>  }

Ack. Naming scheme changed upstream, forward porting issue. Merged, thanks.

-- 
Philippe.
