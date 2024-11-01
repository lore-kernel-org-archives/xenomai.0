Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63151CA81
	for <xenomai@lists.linux.dev>; Fri,  1 Nov 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480114; cv=none; b=WPUbAyZOBOrDPalp1jkC8T1thLGIfIP7ni6HIQKfeshTf6sry/s3iN9PxvSIa6h1Ew2yxZW1Q6J1S+9g12OL7Zd4uC22AkSuK9kt1kF5dKBWbJuuqlXz5MQkeDfW8AH7RBkzCEhAGJ+SbSiZ2vGeqzMK0SxVIbVa799ZO+H4Wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480114; c=relaxed/simple;
	bh=EQa80jEfhNXLkZjlS+VPCh6QTJcj4Ids8LxT6++UvlU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlzrAalr4FFLV6Zdcp9vZwVY6KWElp7Ie8Dfayow7Xivsx0DGcwKz3Xzt61udChVH7zH5gHrXMgwYIPG3k383he1qfSQCeATqqw2VWCuGO7S6xhGP4SQ+xxHo0OaU7spPAMVSDenWbSmYic7mlr8TN3WUt07hUSsaKZU3KVMeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQcTxrUC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQcTxrUC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d41894a32so1216803f8f.1
        for <xenomai@lists.linux.dev>; Fri, 01 Nov 2024 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730480110; x=1731084910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQs/kGiJlkIl3nhgutV9JwyEf4uxc8f2ByCBn6SKnH4=;
        b=BQcTxrUCsCwPn6/n0hpmRRb/i6qZB+SRPcQs7xAt6nsOKjMPvIK07ZyDmWJlrogCjs
         1vJae2WZ6y71CExtgE9kEss9AihD1hvgt50eY4jdl0AgGrWW/QkuHALaszsJsrDsCm7O
         St5tP6bbC6kBoVpqr5QxlDCp0q6xGRvuv1llJGmq7wI9m78QtNHEvIuG2GFHBlkM5T0i
         dPgWXNrqIIlnpU+DZpTq6ALT6YWJpTdoPnJQCIZjSI2gmH2LqX01EWYi0I48K8IvXtwh
         GfxMSreTzwbU81jMm9gOCYnXeVWFvurXbUmSObqPeZF7iBZjKXprksKRqwqybmKF+D4C
         WzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480110; x=1731084910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQs/kGiJlkIl3nhgutV9JwyEf4uxc8f2ByCBn6SKnH4=;
        b=utU8odvo1+SrbJcRh3Uo9CasbmgKQ4teW72SaY0/MJt6gPUFlrQveJE/z+AoW9Jvwj
         6akMJ6EFnsxlrUhpuZhSsMh0LOpFDryOGdns16bh5CeiehJKcwD7HKcYQew1J0a8l8iC
         M6LrY0Wnmc4kfUSV4qG0jsxWysr9+r+TU8X9k28xbn4vHLwZyBobsAP6eMzz9Hm1NhZ/
         R5ODU1xb8R09/djfefB/2ZkGeTXhnRzqGlwJbHq9VEs0mCNcO8i0E707L6yjQF+1t1Ut
         38cdVFnlRXAyJLh/jSpv+iU1U/qg3DOoRW2WMBl+Es1wMn48rctUkIzAO9bqTWuPiAhJ
         /6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuI10lXWhncmX1so6SQQNpX/eyt0yNhrQw8AUwVXBb4Ou63H7Gsg0e5G3ccVS3712Dy1KAJ7+f@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf1naFTvfaX+xSQpM/IpFuxsBmJBu8gTdT51GdCOtpxIBEkECn
	BBLth4JS5ckaZA8zjOLc97o3HN9+QtVHXy/cDbs4uyiudlxJy4ek
X-Google-Smtp-Source: AGHT+IHSYywna7wePZrBU7gPoliKUxaSRmLdxuUcG7niji1CCnOgNZ0cRkpjI9JWiuSlR+HCDm2YNQ==
X-Received: by 2002:a5d:6487:0:b0:37d:47ef:17d0 with SMTP id ffacd0b85a97d-381c147aa50mr5626940f8f.13.1730480109820;
        Fri, 01 Nov 2024 09:55:09 -0700 (PDT)
Received: from trex (228.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b0dasm5720056f8f.102.2024.11.01.09.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:55:08 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Fri, 1 Nov 2024 17:55:08 +0100
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <ZyUH7BV50dlhvc92@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
 <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
 <Zx6QxE+CNTmQqZDk@trex>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx6QxE+CNTmQqZDk@trex>

On 27/10/24 20:13:08, Jorge Ramirez-Ortiz, Gmail wrote:
> On 24/10/24 20:00:12, Schaffner, Tobias wrote:
> > Hi Philippe, hi Jorge,
> > 
> > On Wed, 2024-07-10 at 09:18 +0200, Tobias Schaffner wrote:
> > > Hey Jorge,
> > > 
> > > On 14.06.24 09:29, Jorge Ramirez-Ortiz, Gmail wrote:
> > > > On 13/06/24 19:27:10, Philippe Gerum wrote:
> > > > > 
> > > > > Philippe Gerum <rpm@xenomai.org> writes:
> > > > > 
> > > > > > Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> > > > > > 
> > > > > > > Stress evl with a load command while running the tests. The
> > > > > > > load command
> > > > > > > may be set to an empty string to run tests without stressing
> > > > > > > the system.
> > > > > > > 
> > > > > > > To align with xeno-test the -l command line argument was used
> > > > > > > for the load
> > > > > > > command. Listing of the unittests can now be done with --list
> > > > > > > and --List.
> > > > > > > 
> > > > > > 
> > > > > > Nak. Compat with xeno-test is definitely not a requirement if
> > > > > > this means
> > > > > > breaking the existing evl command line usage. Besides, --List
> > > > > > looks
> > > > > > strange as an option. Let's pick a different option for the
> > > > > > load command
> > > > > > instead.
> > > > > > 
> > > > > 
> > > > > We may want to implement the stress utility as a separate evl-
> > > > > stress
> > > > > command, keeping evl-test for unit testing which has a different
> > > > > purpose. evl-stress as a script could generate the load (dohell)
> > > > > and
> > > > > possibly check the latency figures reported by latmus (using the
> > > > > -K and
> > > > > -A switches to detect weird behavior).
> > > > > 
> > > > > PS: Jorge is going to look into leveraging stress-ng for load
> > > > > generation.
> > > > 
> > > > yes I am going to start looking into it. I think that maintaining
> > > > Linux
> > > > stressors should not be Xenomai's business. If we can't replicate
> > > > the
> > > > load with todays stress-ng perhaps we could just usptream what is
> > > > needed (stress-ng is well maintained)
> > > 
> > 
> > may I bring this up again? Any new developments or opinions on this?
> > I would like to see a solution that allows to compare xenomai 3 and
> > EVL. Reliable numbers are necessary to make an informed decision if EVL
> > is on par or even better than xenomai 3. Imo we are comparing apples
> > and oranges as long as we are not using the same tooling on both
> > platforms.
> 
> Sorry about this, it is being a bit of a crazy year for me at a personal
> levely. I am start on it this week.
> 
> My setup uses some Zephyr code executing on frdmk64 I wrote years ago to
> benchmark evl
> 
> https://github.com/ldts/libevl/commit/905d1946ca117e3889c53d1150a1334cc91033a8
> 
> I will load my evl system using stress-ng and measure latency figures
> and then replicate with dohell loading tools. I should have something to
> share by next friday.
> 
> feel free to ping me anytime. In IRC you can find me in LiberaChat
> #u-boot (nick ldts) and since recently in OFTC #edk2

I was finally able to get some numbers on imx8mm (an Arduino Pro with
the Portenta breakout board recently contributed to my lab by Wim
Taymans for audio testing of the Xenomai4 Pipewire-plugin[0] for
realtime audio)

I am using dohell/rt-tools/ltp and stress-ng on EVL - havent tested
Xenomai3.

My test bench runs with the help of an external FRDMK64F running Zephyr
very similar to what is described in the latmus/latmon combo
documentation [1]. Given how cheap this board is perhaps it should be
more widely used (?).

[RFC]
I would like to update latmon[2] to the tip of Zephyr - it has fallen
behind - I'd like then to propose it upstream (if accepted I would like
to propose that it is removed from EVL). Anyone disagrees?

IMO We should also take latmus to its own separate tree dedicated to RT
benchmarking and extend it to support scheduling latency metrics based
on GPIO data.
[\]

So:

* stress-ng --vm 2 --vm-bytes 1G --mmap 2 --mmap-bytes 1G --page-in \
  --matrix 0 --matrix-size 64 --tz -t 60

This simple command (VM and cpu load for a 2GB DDR system) hits the
system very quick and my externally measured GPIO IRQ latency peaks
within seconds.

stress-ng has FPU, VM, CPU all sort of stressors but I didnt need to go
into those just yet.

I found some info that RH [3] is providing interesting - still the
stress-ng code is simple enough to work with if needed (really good
encapsulation and code base)

* dohell -l /opt/ltp -b /bin/hackbench -m /home/root

After five minutes of run the latency is still contained (far from
peaking, 50% below the peak) but I assume this is because LTP takes a
while to run all tests. Without going into more details, this difference
in the invested time seems enough for me to switch to stress-ng.


Jorge

[0] https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/ffaa365beff0e7f1d1f395800c14b1be26d8d007
[1] https://evlproject.org/core/benchmarks/#latmus-gpio-response-time
[2] https://source.denx.de/Xenomai/xenomai4/libevl/-/tree/master/benchmarks/zephyr/latmon/ 
[3] https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_real_time/9/html/optimizing_rhel_9_for_real_time_for_low_latency_operation/assembly_stress-testing-real-time-systems-with-stress-ng_optimizing-rhel9-for-real-time-for-low-latency-operation#proc_testing-cpu-with-multiple-stress-mechanisms_assembly_stress-testing-real-time-systems-with-stress-ng







