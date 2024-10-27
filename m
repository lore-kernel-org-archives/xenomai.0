Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B891BF37
	for <xenomai@lists.linux.dev>; Sun, 27 Oct 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730056394; cv=none; b=I6EXCauZNmKvgYGnzPVl2+0l9XkzT7WtsAhzXEKUZ0usAbCj8mTgwws8vfL3UMB18a2B7EVf1e/SkrWIm3QWsFRE/amZNOmyPvFLg43KVpHuey1ZMC6RIFu68LGJEWZvFQMIR14UBgPZWCq9SC0kOrI0BOSMnLUSpr2RjMUrDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730056394; c=relaxed/simple;
	bh=6To13mOs7opG9mDoUPNrgyhedpl6iuOCX86jXSut6Cg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElSWUQCdlNaSRPlW78AIgcCviNpJYm80gKI45UW5H17M/fqDBxAGPFxNJpo9EJsBF6GYYXmInXLfr2w7gE0ZVF5VNqtcenot6x2cyp/JIyElIiJczEBt7VUS8sTVQSsQ9gHt/bTvlKHO7WXrA8oRIgcIQcZeS1aVQl133qcRvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw8eYvW2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw8eYvW2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so37839875e9.3
        for <xenomai@lists.linux.dev>; Sun, 27 Oct 2024 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730056390; x=1730661190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru70jKeYrx8StFrhExwhDSN7fZGHIruFM+Sq9nPZfOM=;
        b=Gw8eYvW2kPRcLH2N8hJDQqda+zyB+jtGxI7YcCZnJZ9t+sZEbBN/F+YQMQUnOGRttD
         WerQ7ZdP2BuXgqiCazCTiBj7uHNnWgktG47D/UvIEchzURml42Sll20iK8mduo3R5HOy
         MI6H2kLHkxCSsJrvYBPMWz9kizr2ymf0yK9yNdOeKbIIKBofLe51uquQZyQHs4MUsbZ4
         RjhKN/trOZXyM9on9ynxZ/iNyMwlp4oo+WZ1iNSQEZPAWhFpDTKfd1j0Xb2O6slvlRx/
         heVnZNzoQyaTHsxSp3Qfj8bXzwQAKtbyriJRCxUAQWkXjUVhimy6TQIzZl9tX36t0p2u
         3MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730056390; x=1730661190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru70jKeYrx8StFrhExwhDSN7fZGHIruFM+Sq9nPZfOM=;
        b=TtniBDD7dGZipK04WamcH/hH138BKJm68EkBcZZrny1PDkAxv2hbfJBGSPSf62BfwA
         4niZ+yVT4i1AJNVQGFaXCCI7Ojzj1Jnw3/AoFWLd+sJiD1Fsr2vXKf0SgZ6Xj+dr4994
         pJcNsyatL8K0PsMFDReYMr5B1M+5V574Q1u1PwHJ//gOYMcqUZSUF7lsb96yOClAxyJX
         M9C3rBb+JTwnrpfUEhpI6XHYJgfj/sxO/SGWrObjXC0FcwS3qiSN3zGB71o+7PlBbV+i
         zNByR4JCbVcwGK0uS5lnWkrGYRMPZXAOgv8IyvUq5yP7djfsIFqNTRqbOlha0f2+L92k
         o8CA==
X-Forwarded-Encrypted: i=1; AJvYcCVicT6mucIrDmoGQq5eIyX7uC+9jEJWsZh4SnhmKqHQne1z7Zs4Wr57p/GdWAVlGSgLcjv7nNQF@lists.linux.dev
X-Gm-Message-State: AOJu0YzdkytZeHgggzsQZVEcL7vG0xki36MAGBpUGb6ujoAneCTOhzAb
	H3oIUYaUgVjnaiXUl5WXEf780qytT9B0K6z9Q2RytTLvpOw7dWS5
X-Google-Smtp-Source: AGHT+IFiul67L3vZ+6XkH9Udgq5pLp7hp7xjgs+UKxbRg8HIKmigyyiEiY2OrJ83V0H+lajH6WURug==
X-Received: by 2002:a05:600c:45cd:b0:431:5970:806f with SMTP id 5b1f17b1804b1-4319ad34bd6mr56404735e9.34.1730056389975;
        Sun, 27 Oct 2024 12:13:09 -0700 (PDT)
Received: from trex (228.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430edsm114697675e9.2.2024.10.27.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 12:13:09 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Sun, 27 Oct 2024 20:13:08 +0100
To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>,
	"jorge.ramirez.ortiz@gmail.com" <jorge.ramirez.ortiz@gmail.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <Zx6QxE+CNTmQqZDk@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
 <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>

On 24/10/24 20:00:12, Schaffner, Tobias wrote:
> Hi Philippe, hi Jorge,
> 
> On Wed, 2024-07-10 at 09:18 +0200, Tobias Schaffner wrote:
> > Hey Jorge,
> > 
> > On 14.06.24 09:29, Jorge Ramirez-Ortiz, Gmail wrote:
> > > On 13/06/24 19:27:10, Philippe Gerum wrote:
> > > > 
> > > > Philippe Gerum <rpm@xenomai.org> writes:
> > > > 
> > > > > Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> > > > > 
> > > > > > Stress evl with a load command while running the tests. The
> > > > > > load command
> > > > > > may be set to an empty string to run tests without stressing
> > > > > > the system.
> > > > > > 
> > > > > > To align with xeno-test the -l command line argument was used
> > > > > > for the load
> > > > > > command. Listing of the unittests can now be done with --list
> > > > > > and --List.
> > > > > > 
> > > > > 
> > > > > Nak. Compat with xeno-test is definitely not a requirement if
> > > > > this means
> > > > > breaking the existing evl command line usage. Besides, --List
> > > > > looks
> > > > > strange as an option. Let's pick a different option for the
> > > > > load command
> > > > > instead.
> > > > > 
> > > > 
> > > > We may want to implement the stress utility as a separate evl-
> > > > stress
> > > > command, keeping evl-test for unit testing which has a different
> > > > purpose. evl-stress as a script could generate the load (dohell)
> > > > and
> > > > possibly check the latency figures reported by latmus (using the
> > > > -K and
> > > > -A switches to detect weird behavior).
> > > > 
> > > > PS: Jorge is going to look into leveraging stress-ng for load
> > > > generation.
> > > 
> > > yes I am going to start looking into it. I think that maintaining
> > > Linux
> > > stressors should not be Xenomai's business. If we can't replicate
> > > the
> > > load with todays stress-ng perhaps we could just usptream what is
> > > needed (stress-ng is well maintained)
> > 
> 
> may I bring this up again? Any new developments or opinions on this?
> I would like to see a solution that allows to compare xenomai 3 and
> EVL. Reliable numbers are necessary to make an informed decision if EVL
> is on par or even better than xenomai 3. Imo we are comparing apples
> and oranges as long as we are not using the same tooling on both
> platforms.

Sorry about this, it is being a bit of a crazy year for me at a personal
levely. I am start on it this week.

My setup uses some Zephyr code executing on frdmk64 I wrote years ago to
benchmark evl

https://github.com/ldts/libevl/commit/905d1946ca117e3889c53d1150a1334cc91033a8

I will load my evl system using stress-ng and measure latency figures
and then replicate with dohell loading tools. I should have something to
share by next friday.

feel free to ping me anytime. In IRC you can find me in LiberaChat
#u-boot (nick ldts) and since recently in OFTC #edk2

> 
> Best,
> Tobias
> 
> > Do you already have an update on this? I would like to resolve this 
> > story to be able to integrate standardized long term tests for EVL
> > into 
> > the CI.
> > 
> > > > 
> > > > -- 
> > > > Philippe.
> > 
> 
