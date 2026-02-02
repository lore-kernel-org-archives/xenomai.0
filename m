Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7036654D
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040657; cv=pass; b=TXgx5U0s723u/UGEhCe2TjP/klKYM9icf3dAR5GQHdb7VfgWX0lZudN8rNJjWh9P/K3eQnTu7sGAOJOEepiHmeJUKdLEDnlGFgAgWV39CZn4Oq2XnUA0FH9FS06czdsfngTCt7a5MEpLQfEQSY/OqmkHWnnyXbDA7MXjZCPNMf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040657; c=relaxed/simple;
	bh=pP70bYZALUDw3u8hDTZeRyoVRl36yOdnU202dKsNBks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nwjV1YdIp4ivmBMtN30Pc/+/V5qFcws9/vs9IbHzlimqNV7abDygW2xz2Qiu0+h7pd40NDZQGDy3SRJlPwWTV8yyHvnpVPA8S2IYyA/yanu9al0WlR6GNNRQZELJStmxfSikMoMGX6EZRhYvktfci3J3PdE+AjTOrTydFrchb8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=BgkswBG+; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="BgkswBG+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fed090e5fso3586070f8f.1
        for <xenomai@lists.linux.dev>; Mon, 02 Feb 2026 05:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770040653; cv=none;
        d=google.com; s=arc-20240605;
        b=SAC3kpKnUQ7Tf7N2px8bzXikUtpQCAJuLayq0RdG5Y2ROhYrKiM3nKyANvA780xSJu
         nWfF+iiRxEcpxLC9euiYzCusId8gjSHJNE/1q0Z1nHRV0/roY0IHDeSVMNUPzYwSb+qv
         9TgRzQnJQfSOwwckHdzyMNZx4Gfn1YCbGdSaYjYJQyVKYWRQ3BddiHom/s5JESIsHkRk
         TNohN89UTZ/c/cP/+X9nc8zSpj5dTikpdrUJTcPy/xypowx0L4wBS2n/O83IrQnQfTze
         vIb+u5SL39YixjW7HnTfYboUHaWMwbLKj9FJbK0qcHqPBmB+rh69GKMlkzdp9CbIaTby
         xIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gQ5d/aDh+h3eCOQh7lYu9yL5n1BDNLbHAKA427Ir8kI=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=G4lzUgo3qhfna+9BYymVt6mo4uxgpheeMcLHj+07CPpIjSUsUbL4UWMY7Ji8xFOkwM
         kI0c/sFXLZ1JoBJzrTekWoyQXX4RbMB6PqnXB1jIFqNziEjG/wUa92UYMm7xfVkxbwEL
         dl51OajTPxoYtAt2dA+fpI4uw8pM3XtMBHKPH+1yynI5LYM8waMfmiQ3Erd03/p4tTBJ
         xjlPm50leP586r0AqOgdaR88hm4+VCzR8qDN4aPvGUuwbS5ietQ6iJcU0B7+t+kqMCNf
         pKHrR6LWyo2KidVH92GJ+BktVdzmv93m20XgO+4DDcyndRfvv6PbmYLYbb9d0YMZ6gim
         W4Rw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770040653; x=1770645453; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQ5d/aDh+h3eCOQh7lYu9yL5n1BDNLbHAKA427Ir8kI=;
        b=BgkswBG+a5rzgr0wwtk0eRnX/6l7SG14YnvmgmHAHJ/A7DVRgol2+AxGqviT46th8v
         sgkXAQH0XrG8H8QIVWSE2QAvuAMW8xurO8uVFoo4NdpX5oD3Bzdz8ClQq+dBM2SEQYVO
         Ag0ONikB3le5m8b0TjEVZ/FS19HDiTjs1LlHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770040653; x=1770645453;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ5d/aDh+h3eCOQh7lYu9yL5n1BDNLbHAKA427Ir8kI=;
        b=GQICFJDvaRHEw/BAfsL/TIfB74iVHnhUwsx3kpf0txMpO7d5OFOBGP+k6S0+KtCWS1
         9hKmt6LVcILX3a6rBQT7USJWoK++7O7K7IqV4mS7gGs+9PFehX3Kcoll+FedYjyY5no9
         FqhQ2Co/7a89TrU/MLTy679F76GggWZsSNb+ddF5wyYacqwrzluV6cVzrdBsRlRa7P0h
         ry/a6x5sSt+aXaytao5oN9tfbN5Yz0SfrBTfkceMIM23X3yw6n4Z2TTbMAFjZuSJq/v0
         N0sinuJck3BLGkXy9+fx7gWbVFByKtFRDaOo144yQFelgqEg1VerevZ6Vb9Jd4EYPwqJ
         h4ig==
X-Gm-Message-State: AOJu0YzPqfv8B22OadGXrTnqswX6nNgRFzM+9pF6ZMZbJMHkE/jUwna/
	bzF8csZtJoqmMHAH+W28C5LKGDtyhUbmN6kXEz2PwutRYBwobDy4+1tTgz4hZOS2aFmNHdyhgFa
	1cj6UJrXSwJ67GsEBP73rY341xZ2QvD1aSD0Uazcfi9m1irwBhBjITrA=
X-Gm-Gg: AZuq6aIyaEA+PJgO3DSIFJNNFGM2Aow8x2N1jLc6oYU4No775+eJVzi0GsA5RwWCdn9
	pIY6cKuE5aK2vvcWBhL+abpVQzmrCptFen7OOJ3mTvd9iUxJOCbHrLU55H4x89Zva+An3LYDebP
	pplFc951sqLKM9xMVvcE4ubtOKR+Nx8JdT6HQeO6VeMrPwU59BNNEZLLZjmyHIGW18UtW7CPSfn
	XE5zRxI9MdwooHby0dBrqhszQ4LDW/88Kaq+Ab+dje+P5tRxi9i2OzKydMxQ5HuoHERvXnGJuvP
	ikhGO3wD/h2pvE1GbuEqiUQrvHFs983ys5pKHIPt2U2DddswGwrFoaAVXgRRRfI8K9rEFK76
X-Received: by 2002:a05:6000:2c04:b0:431:5ca:c1a9 with SMTP id
 ffacd0b85a97d-435f3a8b7bcmr16788011f8f.23.1770040653539; Mon, 02 Feb 2026
 05:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 2 Feb 2026 14:58:42 +0100
X-Gm-Features: AZwV_Qjo0HPl6n9Ko1rJRqC3dCi_0Ui2xgy5CxnnxyKFRB9Jyi5nkbKAMWGP3Xs
Message-ID: <CAFc1U0tqO9SstMLehsKRhNT89fp0_U-9Q8_nKj4VeD8C5A5ZtQ@mail.gmail.com>
Subject: /proc/xenomai/irq for Xenomai 3.3
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

I notice /proc/xenomai/irq is not available anymore (?)

What is the way to know the IRQ used by a RTDM driver ?

Regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
