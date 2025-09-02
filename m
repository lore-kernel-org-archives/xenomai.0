Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BE2F362C
	for <xenomai@lists.linux.dev>; Tue,  2 Sep 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806725; cv=none; b=FRXuNippe82tHeU7s7GeLzgALeiUScrxHLEIA7dU6K3NBCE8TH5RuHfc38cFq+3Y9OwXxXd9DvvorkTlibwwu2qA5TkqYyTk7OH0ekQNsLn7fvm25gbxjsAyEA79Z7unvnP//5vZyykjpYiU9NM8F90iIY8t51tBdEMK6NKo9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806725; c=relaxed/simple;
	bh=9uhi4jVV53DfrbTuZ3Z1V5ZZriwhvbF/HIrVW2lrwk0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqNdtvmFTOAVBBg01lqwXRuf5ncSri7nnZbwH6CJ1HzYyPew1x9lleDVgPlpnFzbL87veAUdcOfGiEkFN8UYZrwTpRp4ZIQDP43LdJM4wQJQ1N4kEDRdrBJEdOZvFZ/Xzh2RxJRrP4q1sXcOX/rQpAvOU1/Wr+40Mwm+AbFklB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoevRxxm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoevRxxm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so10520225e9.1
        for <xenomai@lists.linux.dev>; Tue, 02 Sep 2025 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756806721; x=1757411521; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mk2LEl0rALsM1SlLs/D+mxR5zwlRuYJfrcR9EYFmO4o=;
        b=WoevRxxmxaf9LujWi/kUr29Xwwkpq6EA+kuaB35115NTO85jS27PNUL16nl0wCLRUv
         GYUKT1fDUbKe36Enszl9VT9N7ZoIPDc2R6XYL76DJaTXLdsaAyk9ZrF38FCxXCZMEv2l
         FjsNerkVnHP8R4Q3qleA5P3lIRllreeNUUXEXSN/w43rmRL2hmRfiAUP9mZIYjGkHlXD
         HHmvqKfBL7qZW23a7dd3fnWkOHvzWUg+yk7dMrf/rfFpigQ7PG1gy/rH98E11LegS1bc
         9FirJRFYOz+yDIu55jfEu1VmHRJdL7jJkUl+ZB2dP1rWtd7/sul0Vjx1AeO393N5QfH7
         Ywxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806721; x=1757411521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2LEl0rALsM1SlLs/D+mxR5zwlRuYJfrcR9EYFmO4o=;
        b=c3JH0DTsousHPNWu4w/y9VcXOQeV1H6T9R/CgnODtXg1aw1W/p93bfqJw5p6SAEkuZ
         k2dlO33pCfCVmw9oTjOwqUOYTmkQrwOFeBrcdX983AMbpOBPN/wKyIy+jOtDqvymhgUE
         nFnCSZjSaMoUFdb+r7Ol4pGDy7LOUS3Oqr6V5HbJISo+a+K+j0tvENXcxxO0nh+SFxza
         /rzHo75pmxDDx4B7aZho2K47Buw1/z7OYhzw6ItnyGgrpYoMq2ArnZz3X4DMo6anaPdI
         qvR+YBWklI5ZKR7cg+97iczpRHh8PcgNRDyY3F7UYI/K9HX/Knv+nchBTGcqVoOuKXG1
         jIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUjtiz/0WJWN9jkbRnskLDHl9vBzcCvYeR/ooqh4dWEb4b1DLrvC/o9mxdUUFNpYjwUY9/WDp0b@lists.linux.dev
X-Gm-Message-State: AOJu0YxjFht+mM+KFVS2nErE1SGSsRwl6aN2u9V1MBaCrOMdKaU2zqLo
	IGJzFhoga/jvtBdjjuA2h0HAGynTcC3vCaONMwu4rDW93Z2tKdLZ2uopy9CHBg==
X-Gm-Gg: ASbGncuEc5fD0nhLEsacXeOPh3hC1qMSvKEvBkNPDiZfT6bcmR5spo6bv7HMY65EnSV
	903vnOLxos1MbNc9yT6INzK5CfubagtJBZJVxdsSIS+mnBweORb4rSIsjX1t1uIH3UkFt3SkEB7
	3spz73uWmppnkREmRRAHyVHTXAyDsi1mQ8g3uxo8zKT19858S4eJ+iObXnki/UHp2fKvF3ZM3Mp
	vopiPTQgkXfHbQhCRIwj+KIcCvGuZhg2K9NaqEru3/XTw4dQUZRwtSlXX2GrVg9GOq2z+JQ+A0r
	8P7qHCiS2uXdma2ZK9fsDACz76jCZlUMxLq+WL9AmTluD4ZW+zpDJzGf+TnOz8p6+9aq8VRPXOK
	xm8TqV15y8/1VrFLTXNBYT+qkRUlSs9xkbvkfer1YXtluPpedg3T6I0YKnmCe5BHSfw==
X-Google-Smtp-Source: AGHT+IGwfuqXUn0by/ymFZLhwFvgZyrx3hLZAi9wjgK6TC7HuZ76ZNs45BH+QYM+quaTLJjFBDEHUg==
X-Received: by 2002:a5d:64ee:0:b0:3d1:abf7:e1d3 with SMTP id ffacd0b85a97d-3d1b1aef463mr7862441f8f.20.1756806721336;
        Tue, 02 Sep 2025 02:52:01 -0700 (PDT)
Received: from trex (104.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm18838418f8f.61.2025.09.02.02.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:52:00 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Tue, 2 Sep 2025 11:51:59 +0200
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH 1/4] Copy dohell from Xenomai 3
Message-ID: <aLa+P/WR51QDeEHL@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-2-tobias.schaffner@siemens.com>
 <87frtgrker.fsf@xenomai.org>
 <fb5efca7-cba3-4115-86be-0b719c5a74b4@siemens.com>
 <877cesrfir.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cesrfir.fsf@xenomai.org>

On 13/06/24 17:55:02, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> > On 13.06.24 16:23, Philippe Gerum wrote:
> >> 
> >> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> >> 
> >>> Dohell is used as the default load generator in Xenomai 3. Add it to
> >>> libevl to be able to stress the system while testing evl.
> >>>
> >> 
> >> dohell is obsolete. Let's move to stress-ng or something alike for x4.
> >> 
> >
> > See my comment on patch 3: If you can name a configuration of stress-ng
> > that stresses a co-kernel more than what dohell does, we can take it.
> > Otherwise, I would strongly recommend to not do less hell over here.
> >
> 
> The most important stress dohell applies is basically hackbench and a dd
> loop trashing the D-cache. The latter can be obtained with a combo of
> VM+I/O tests from stress-ng. So basically, the whole issue boils down to
> having hackbench on board, provided we cannot generate the same load
> profile with stress-ng with a CPU bound stressor. Besides, I never saw
> any added value in running ltp tests compared to a combo of stress-ng
> stressors when it comes to latency testing.
> 
> We obviously don't want to throw less hell, but throwing more obsolete
> stuff is not an option either. So that's a NAK for v4 ATM, I'll gather
> more information about how we could leverage stress-ng in order to
> compare to dohell. This is worth a shot.

I should start by apologizing for not having delivered a proper,
stress-ng case study yet. In my defense (if that counts), I got
sidetracked by day-to-day work and the long process of getting latmon gpio
support merged into Zephyr[1] — which ended up taking > six months of
back-and-forth.

BTW If you have access to one of these devices [2] (they’re inexpensive),
plus a couple of GPIOs on your Xenomai-enabled board and a network
interface, they make it quite practical to collect long-term traces in
an automated way.

So comming back to the discussion, I still believe that the better path
is to validate and if necessary extend stress-ng. Just as monitoring
tools like latmon dont belong in the Xenomai repository (the Zephyr work
above mentioned is a step on that direction), I think stress tools
should be kept out as well.

IMO this separation of concerns will also help those trying to decide
between PREEMPT_RT and Xenomai for their use cases.

[1] https://docs.zephyrproject.org/latest/samples/net/latmon/README.html
[2] https://docs.zephyrproject.org/latest/boards/nxp/frdm_k64f/doc/index.html 
