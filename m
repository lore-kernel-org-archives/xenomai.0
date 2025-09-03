Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0228315D
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887128; cv=none; b=CuvuncvYDDr5ZJo4gort4mJ5SR6hY3kRZANqYSuORm6GvIy/dmMBZGJzKLu+pI0JDwvnCE63o7jsteU/elUOk3foEqhmOn7uNj2/YRqOYCp3s/8KfVlkAeRbatEckj4PRppEQUNWA4iq73f/HYvkRoeCCbhvcluWP+66o1f1nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887128; c=relaxed/simple;
	bh=nXi/LWHMKVqXtVz7xsVNtRAL8hKc2hagKij5soyHwI8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLfFNvXQl2Unts0JoBx9sa65zrg0sVOOBIy2T+gkPdpABjsXS/iULiGF5I0+iviXjGvfqpUaiq01HO+hlcq20aXK01xva30KmfYJW8p+zSD9AVVENgmtnyAD6yBm/N4+yMZhMizw1ItdnKHY429nDYtSbb+osexA5/iyyWriF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzM7DXtg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzM7DXtg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df35a67434so134457f8f.3
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756887124; x=1757491924; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MhkiPUEUTPhc0+ALJiTYvsDxMJE5m8Y/DvVItsPqCE=;
        b=VzM7DXtgPwvmypP9JsJOE3Ug1BcIYasUsyanbCDmIx+UL7gzm0Q6fDNrsIDnw8o9yr
         nfdBfe9H/6EWlO8iAXCfBQ1Jo2kayyq8bKKONUGWQo3tlN0Qcwx2Um/enQTFgYRrzgQF
         wnnrMMxcSUb3psRAfd2jQGlWsmWvxjvIVb5O27UGw5lvzVWMmWILV+ZI9tS/7heDPqiZ
         e5o/NO+r7D36rQ2TOt59JgAan2HCuGz/FSYCfCX0kAC2f9jLGisZFNnKX+Ix40AcFARx
         rIgdjJx1kTbkwBm4X3qGhgcDNBZx1nxIYa6ftagSqFTX0sdggCCm2cqD7LLcDhskaoO5
         FNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887124; x=1757491924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MhkiPUEUTPhc0+ALJiTYvsDxMJE5m8Y/DvVItsPqCE=;
        b=Wj+2vIuqPX2/m6LaYNbH7jdiMNjiNdOoxGL/Enno6ke5p30IbQ3fTgzGHihCVRNX9M
         Ta0gS8nZFhENXBsMkzIhlAAh5eR8oFwCPaqoaqni4OWtt+urq9iljicwdQFO64iXd8V1
         oOb0wLT4G5RZCb/C/CZqHXyc16TOx7wHGzyPlbwSXmO58QlZObeHhthQUs7u5uy5/akH
         Ot7tkVbm2q6cSUrigAX6cl1OlqE/uxVAka9WQnvuOHCo50FPoBo0GtrI+TIFuGxHnyf7
         oCl404VOT+bd+4+5bTGdV6lCrVGwI8X0TvD+eAQfkY/FpAjIxFn+82DZ75czs/yPiFk4
         7cgw==
X-Forwarded-Encrypted: i=1; AJvYcCUYwKaag43KDnQ9Juxt8VIumyZpdvvBc7dns5tqpJLDR0bioGWlyMIgerHlVfKaXiFRSOA920Y4@lists.linux.dev
X-Gm-Message-State: AOJu0YwXpDThENd5P0b7CdqvwDsjVZAub7icSVwzOYVQI3rQxQDNl79P
	uhpmkP113lJg6X+DqlfgnMYptx9QstoPGi2FEFxpbre0WgATHk4uPwzUFa3SaA==
X-Gm-Gg: ASbGnctwNGVmLO4CO0TgeK2fshDqK17gvqdAWNtE17qNFhrup+jJPtsm2vsAFM/rCeb
	1lgPG0ef3MNW/leps27H9OuTxONO2U+bJGRPYpCAWkyCWWXS1/CMzjSWM0eBf6JJcXm/iOdUFCc
	5FgnNoG3FJ3pkszPktdrtt0ncc8Nfs4yBHGwmcn0EXTY08gw2MiHsOu5FSsSvIi7yNmAh7aTwsd
	U1mMHtNvAOZKi/fPw5o2dE61KyqFkwSnMevWbZIkgC8amg5F7eDFJuntT/H5Pa7ERb2hETFEhce
	GX1bFEhIee5Sj4xOHB/MqT+hZFM5gcKp/rkzT6Xv3aSZNb9jMxT3fUyVX5G+37b0aY6H8rfR9H9
	Hgje5f+eo4gq2Y8QlxJLy+ZIKzuoC87RWPUQ75FWDzYonnGHr9dF3WNb6y79cdEnYRg==
X-Google-Smtp-Source: AGHT+IEtUbdADeCR8rAqFFr7VOAXxTyj4MF+Im43iwVKeL0+SQRNyqitHtQGwiudfVI4Oj7sq1tA9w==
X-Received: by 2002:a05:6000:4210:b0:3d5:9efa:fbf2 with SMTP id ffacd0b85a97d-3d59efaff51mr8258889f8f.22.1756887124238;
        Wed, 03 Sep 2025 01:12:04 -0700 (PDT)
Received: from trex (104.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c22sm315282485e9.13.2025.09.03.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:12:03 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Wed, 3 Sep 2025 10:12:03 +0200
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
	"Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <aLf4UwoftyHc5pHS@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
 <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
 <Zx6QxE+CNTmQqZDk@trex>
 <ZyUH7BV50dlhvc92@trex>
 <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com>

On 03/09/25 07:29:07, Jan Kiszka wrote:
> On 01.11.24 17:55, Jorge Ramirez-Ortiz, Gmail wrote:
> > On 27/10/24 20:13:08, Jorge Ramirez-Ortiz, Gmail wrote:
> >> On 24/10/24 20:00:12, Schaffner, Tobias wrote:
> >>> Hi Philippe, hi Jorge,
> >>>
> >>> On Wed, 2024-07-10 at 09:18 +0200, Tobias Schaffner wrote:
> >>>> Hey Jorge,
> >>>>
> >>>> On 14.06.24 09:29, Jorge Ramirez-Ortiz, Gmail wrote:
> >>>>> On 13/06/24 19:27:10, Philippe Gerum wrote:
> >>>>>>
> >>>>>> Philippe Gerum <rpm@xenomai.org> writes:
> >>>>>>
> >>>>>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> >>>>>>>
> >>>>>>>> Stress evl with a load command while running the tests. The
> >>>>>>>> load command
> >>>>>>>> may be set to an empty string to run tests without stressing
> >>>>>>>> the system.
> >>>>>>>>
> >>>>>>>> To align with xeno-test the -l command line argument was used
> >>>>>>>> for the load
> >>>>>>>> command. Listing of the unittests can now be done with --list
> >>>>>>>> and --List.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Nak. Compat with xeno-test is definitely not a requirement if
> >>>>>>> this means
> >>>>>>> breaking the existing evl command line usage. Besides, --List
> >>>>>>> looks
> >>>>>>> strange as an option. Let's pick a different option for the
> >>>>>>> load command
> >>>>>>> instead.
> >>>>>>>
> >>>>>>
> >>>>>> We may want to implement the stress utility as a separate evl-
> >>>>>> stress
> >>>>>> command, keeping evl-test for unit testing which has a different
> >>>>>> purpose. evl-stress as a script could generate the load (dohell)
> >>>>>> and
> >>>>>> possibly check the latency figures reported by latmus (using the
> >>>>>> -K and
> >>>>>> -A switches to detect weird behavior).
> >>>>>>
> >>>>>> PS: Jorge is going to look into leveraging stress-ng for load
> >>>>>> generation.
> >>>>>
> >>>>> yes I am going to start looking into it. I think that maintaining
> >>>>> Linux
> >>>>> stressors should not be Xenomai's business. If we can't replicate
> >>>>> the
> >>>>> load with todays stress-ng perhaps we could just usptream what is
> >>>>> needed (stress-ng is well maintained)
> >>>>
> >>>
> >>> may I bring this up again? Any new developments or opinions on this?
> >>> I would like to see a solution that allows to compare xenomai 3 and
> >>> EVL. Reliable numbers are necessary to make an informed decision if EVL
> >>> is on par or even better than xenomai 3. Imo we are comparing apples
> >>> and oranges as long as we are not using the same tooling on both
> >>> platforms.
> >>
> >> Sorry about this, it is being a bit of a crazy year for me at a personal
> >> levely. I am start on it this week.
> >>
> >> My setup uses some Zephyr code executing on frdmk64 I wrote years ago to
> >> benchmark evl
> >>
> >> https://github.com/ldts/libevl/commit/905d1946ca117e3889c53d1150a1334cc91033a8
> >>
> >> I will load my evl system using stress-ng and measure latency figures
> >> and then replicate with dohell loading tools. I should have something to
> >> share by next friday.
> >>
> >> feel free to ping me anytime. In IRC you can find me in LiberaChat
> >> #u-boot (nick ldts) and since recently in OFTC #edk2
> > 
> > I was finally able to get some numbers on imx8mm (an Arduino Pro with
> > the Portenta breakout board recently contributed to my lab by Wim
> > Taymans for audio testing of the Xenomai4 Pipewire-plugin[0] for
> > realtime audio)
> > 
> > I am using dohell/rt-tools/ltp and stress-ng on EVL - havent tested
> > Xenomai3.
> > 
> > My test bench runs with the help of an external FRDMK64F running Zephyr
> > very similar to what is described in the latmus/latmon combo
> > documentation [1]. Given how cheap this board is perhaps it should be
> > more widely used (?).
> > 
> > [RFC]
> > I would like to update latmon[2] to the tip of Zephyr - it has fallen
> > behind - I'd like then to propose it upstream (if accepted I would like
> > to propose that it is removed from EVL). Anyone disagrees?
> > 
> > IMO We should also take latmus to its own separate tree dedicated to RT
> > benchmarking and extend it to support scheduling latency metrics based
> > on GPIO data.
> > [\]
> > 
> > So:
> > 
> > * stress-ng --vm 2 --vm-bytes 1G --mmap 2 --mmap-bytes 1G --page-in \
> >   --matrix 0 --matrix-size 64 --tz -t 60
> > 
> > This simple command (VM and cpu load for a 2GB DDR system) hits the
> > system very quick and my externally measured GPIO IRQ latency peaks
> > within seconds.
> > 
> > stress-ng has FPU, VM, CPU all sort of stressors but I didnt need to go
> > into those just yet.
> > 
> > I found some info that RH [3] is providing interesting - still the
> > stress-ng code is simple enough to work with if needed (really good
> > encapsulation and code base)
> > 
> > * dohell -l /opt/ltp -b /bin/hackbench -m /home/root
> > 
> > After five minutes of run the latency is still contained (far from
> > peaking, 50% below the peak) but I assume this is because LTP takes a
> > while to run all tests. Without going into more details, this difference
> > in the invested time seems enough for me to switch to stress-ng.
> > 
> 
> I think we should split these activities into two streams:
>  - short-term: setup of a well-defined but not necessarily 100%
>    finalized test environment for EVL so that we can run that
>    automatically in CI

100%. Do you think it would be at all possible to setup a simple LAVA
lab with some reference hardware - unless Xenomai has one already?

I am not sure how it would be funded - do you know ? - but it could then
also be connected to KernelCI so that Xenomai enabled systems avoid
regressions.

https://docs.kernelci.org/intro/platform-testing/

Is this something at all possible you think?


>  - long-term: evaluation of background load profiles and tests to
>    trigger maximal latencies, with EVL, Xenomai 3 and may even
>    PREEMPT_RT
> 
> With the first item solved, the second could even be automated and may
> not need some poor intern to press buttons and record numbers on a piece
> of paper ;).
> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
