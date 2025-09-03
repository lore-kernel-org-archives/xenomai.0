Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B1EADC
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889160; cv=none; b=oWsp45AGn4e2272UTv9ufCxh61r8tSs7Rxo4BVQcy4aZwNjMnNZFApdvOjcI6R0e8P4pUSef8Sb1ZhmkbDp1I2GZffeXMQnUemFgp7jgISo+koReuVnL+V0hQoVodjRxobjbvP3DJpneTnhf8c3HSH+lsi9bVSccSGUe5VT9zGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889160; c=relaxed/simple;
	bh=u2qeXBLZSAQMdOz7UqRJFt+wyXQUKMZclCsbdZrz3gQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD64tTe8TvIcOPP+9w+ujO+cSpRx6w+V4cELabD9C6glVB7z6VXzAa961Ddc/p46OAojHRLvLjtJn0yBQYYucWHlTTbQPGFXgNeWLshZHR4KeeIJOWtIaH0ssN60wIPkGEwxmYC/XBIUzdNqTt70fvhWvIq39JrxeMPtqRLmNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb9wQj7G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb9wQj7G"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3cf48bde952so4411606f8f.0
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756889157; x=1757493957; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECplUffrDoSXXesACH1mYW0vPWeXcswMTJXy0zzCzEw=;
        b=hb9wQj7G9v6C+bT4J1Rzz2GZh7nVPvXjcRdvOeSTivYAYQGquT6hGL465Y8Nk6LnL7
         Qgg9hNQNMaGtih9B+B8ULZlzvnUaXVIhwJSASjPPQ3AalK+04vtDxVBhz0p1PThEvIQZ
         as3y0e0+Q0Jv6kqNDLJgSTWqT06Z0ZbX8qaWwxDVW4BQ/Gg32IcMCwuztlo52RDhO0M8
         kODJ15EKH8nivJ+7QN9DJFyzU9n5bm8eqKCQGcL+5blCWC+hYJRe1r1mpia8D96NJo60
         9eqkp6uZo6C1Lp8d0izUyZwdaJ2YtjsNqoMu1xX+ekP0s4EYXqirOgpeSrayMonf4St2
         QvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889157; x=1757493957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECplUffrDoSXXesACH1mYW0vPWeXcswMTJXy0zzCzEw=;
        b=vPElv2oUvazS9c94V2le3I0cKlUxjqGV2qqBXDP+sBbx4crXjINclq+VzxGfAyiPgK
         cmtViLGEZESvZX5YYDnk3z+9V7e0AiEA9EeFD0V5kmNS7SbRjb8tC8rOJqpin5d9aAFD
         45BEwQ0jpSsADJaWrKrckJesIj3OsovM/cNhs+6BSvbcmr1vr/iERB63CcSwzPvWUMiA
         WIDBqGgcVFdH/leLUQIBSM22OmAsmFOfLpxZLewI1ZiR1Hq90WAU4Xefkwoj4TXvpORq
         lGcsVBziRNl+p7z5MywPVMGEM67K671M7qyVX5QvkWtWM2Qgp+s4GIKDSc/PJxfb3Ss+
         KGeg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYV353q02VQjHBoH0ee5SMFR1QOvjmIjXshAfB5qxZU2sJ9vq7DVgPsfoiIiZD81PCRKnrQh1@lists.linux.dev
X-Gm-Message-State: AOJu0YxoSlN5bjujEe40oFapMO7jma0aO8R4GrEQnUaFGI8whv15VkGv
	XQQp6r1gYk+OpB84hSEB2fGoZk9F6Az0Q9foROJLSvPJ3wP0JEINkUDq
X-Gm-Gg: ASbGncvlHxZJXHCIRKISTCniBWEspmQpbQjDLChCiIjaqxrNKuIu5gaPZHLXNcnaeox
	lmPPipvJlX1Z/1UJJ4blrVBBZLtZzriJxYsCyealZHpeq555xyR+C9LdvOx3aJ9HQIEqlYaa2wB
	VDAkT822F0/u4bDos/V3WPBDboJRZlahlmvDhnN31IcaphQam7eVo+XeFSInmQet7feKjwAXsPZ
	Snw56qvv3RsN8wSyMsyKzBBMGuLkTvi9alwBT+VigYt/m1cHaHumgYVKz7DZtsXdryuuW9NNA2T
	ko1zmD9vRO1yR5VBcY35AwOE6lI1MopESiUYT0hAIc8T/GQ/jDBzmBzJXQ6cQenm5wCmC1A1eVo
	Zo3XRwZV/hBpg+rrMt98Z99LpqNNSFtHU3o1QZAwipI0Y4TQiwfkOmoJrBmn+G4i2jw==
X-Google-Smtp-Source: AGHT+IEd5udPtz+mzSYEVkp3NkpHbvnTUhesN/gCeuzDKp1ympS7ObyKujHr6utlus2zI3X5m3VtNQ==
X-Received: by 2002:a05:6000:2087:b0:3dc:3cc3:978c with SMTP id ffacd0b85a97d-3dc3cd2da6dmr1597424f8f.37.1756889156934;
        Wed, 03 Sep 2025 01:45:56 -0700 (PDT)
Received: from trex (104.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add504sm22438396f8f.30.2025.09.03.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:45:56 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Wed, 3 Sep 2025 10:45:55 +0200
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	"Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <aLgAQ9fTlpvQ6wbj@trex>
References: <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
 <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
 <Zx6QxE+CNTmQqZDk@trex>
 <ZyUH7BV50dlhvc92@trex>
 <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com>
 <aLf4UwoftyHc5pHS@trex>
 <f8763856cc438efa5c6db68eaeccb2b801d15237.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8763856cc438efa5c6db68eaeccb2b801d15237.camel@siemens.com>

On 03/09/25 10:20:01, Florian Bezdeka wrote:
> [snip]
> 
> On Wed, 2025-09-03 at 10:12 +0200, Jorge Ramirez-Ortiz, Gmail wrote:
> > > 
> > > I think we should split these activities into two streams:
> > >  - short-term: setup of a well-defined but not necessarily 100%
> > >    finalized test environment for EVL so that we can run that
> > >    automatically in CI
> > 
> > 100%. Do you think it would be at all possible to setup a simple LAVA
> > lab with some reference hardware - unless Xenomai has one already?
> > 
> > I am not sure how it would be funded - do you know ? - but it could then
> > also be connected to KernelCI so that Xenomai enabled systems avoid
> > regressions.
> > 
> > https://docs.kernelci.org/intro/platform-testing/
> > 
> > Is this something at all possible you think?
> 
> See lava.xenomai.org.

nice, is there some document that I can read about this lava instance?
boards, tests and so on.

since it is maintained by Siemens, who can get an account and access to
the test definitions? 

> 
> We had two labs in the past, one operated by Siemens, the other WAS
> operated by Intel but has been decommissioned recently. (Hardware)
> Contributions / further labs highly appreciated.

ouch, ok. Does Xenomai get any funding ? maybe we could setup something
with Liberapay to get donations for a company independent LAVA lab.

sorry for all the questions, just trying to understand where the project
is since I think there could be value in having an open lab - or maybe it
is in the works already?

> 
> Revisiting the kernelci topic is on my TODO list for dovetail
> maintenance reasons. No timeline yet and unclear how/if we would
> integrate that.

ok.

> 
> > 
> > 
> > >  - long-term: evaluation of background load profiles and tests to
> > >    trigger maximal latencies, with EVL, Xenomai 3 and may even
> > >    PREEMPT_RT
> > > 
> > > With the first item solved, the second could even be automated and may
> > > not need some poor intern to press buttons and record numbers on a piece
> > > of paper ;).
> > > 
> > > Jan
> > > 
