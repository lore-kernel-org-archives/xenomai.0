Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37F148FE3
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350165; cv=none; b=ebIF+tRpwsoUqU/ottUVFoOWkI+Fz5vIkGvEuvtbmsN7xla1gzecZP4LfOFW2kz4Td4lwNAKIt5hK7ILakZqpzBktF+gX9vbu654FRgEEGhGb1rVVXmWDAU+ZY1qv2ZesqBhw2rQPKcOtErUaV4wZnbVhumB20jyntz+hHpb5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350165; c=relaxed/simple;
	bh=0TuRYgZ1xkZ6gKP8FyzOfSpO+E3mQ9hXgdaKzZat9/o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNlpD7izi+v6zxLFuWeQIgsEcqg2gIsoU1Bvv4uVi4QljREGEUv2bntAExVJqcqmTur1KesbYx92o7NJRzsMelSfAEPjTErvQ3ExFiIdx5XCigaACLCqZbR4v+TqodfFTK6jY7cJnRkVzwiY08DUkBXADOUFvilACAsAmmJ7ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdqfDxUw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdqfDxUw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421d32fda86so21141145e9.0
        for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718350162; x=1718954962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqkcB8KM2UuZsLLq6WXp9JSHlaspQMwjHurQ7j0pdgE=;
        b=bdqfDxUwbCm74xPZsuBluRUoAd6nnyoXDsNHENkIHxy0BlhzjjRkwCE/z/RbevtY9A
         F6lGkXvXgyXoc4dOp294Yj9BM6QWheB9nuhrr1e4ZGJIdlGrE6nQrhmsS2r4tpUSpQhn
         0wjU3XOv7YcAanTMv2TxXoiGBDFEGanRt2u92TbRmcvTxiS1Tq79mv+6l5yD+ZWPGzWu
         IdcQf/Lxyv8PHD7eaXurO1OYdeoagRAdTSJjxV8SQCgr3yUIgDMm52lEt+Eqlxy8u6TJ
         VZ1GmVd9NCoGYKTLgD7kGyonZTLjUo2ktr2cmBQF3t6CF8/SbXNh+dbBji1jWxdXEsU/
         +o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350162; x=1718954962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqkcB8KM2UuZsLLq6WXp9JSHlaspQMwjHurQ7j0pdgE=;
        b=Gs5+Gsi2ZYh5+OeotOlxUzHozEmXzY4GZAy+o49iVsNoYFQuKRRODDHJfkGSYRN/nA
         9pbE23JhmVOwlW89lZyQw00jMO5GrljQEhFcyEfkR7mFAjiC4LjPdpdLUa4YKpLradu/
         JtMDmUBoYJkQ1OL7kVnUC0/YDhEFIftRZkE59aBsabf+ax9Y9sJj7lLL/2XPXQG/GJKf
         sNXoE/J7Z/hnZDSgKAIFJz+9C04I1zRa+6F5BuQ5a67Hh8k35YbywZMUVIO7DhKhhUWv
         c5MUk95ai8I1vVVoaAnGti7dAq/86ybuq04IpmFAKr1sPqtlgr9ZABWx0mmzSPFfsw/L
         SOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBC3rjaladjZerOvzcvQmtFSuMscBZJS4z+drmyG6MR+oNJr2Ua7wsVtH5LH6/i693pdvmeCkkqTDSJT9Gqu13cjMr77/xzg==
X-Gm-Message-State: AOJu0YxkOt+++Ndp/aRSQNA7SUVRDBDm1ACyhxOa0aU5kqzlqigMyPX7
	old54SQXWcT0G5ZIz/uyoTdJqnFrsak6tTzQdgSmd/+kPrFii9pX
X-Google-Smtp-Source: AGHT+IEBAP+w3aTKQi+ijOTWLQqdW1qDRAt5mqevHFkr9+XkG5zvy+jPDK8jJdQhEZ9njXMqJN/svw==
X-Received: by 2002:a05:600c:a01:b0:422:50d7:100b with SMTP id 5b1f17b1804b1-42304820c95mr19410625e9.14.1718350161609;
        Fri, 14 Jun 2024 00:29:21 -0700 (PDT)
Received: from trex (154.red-79-145-22.dynamicip.rima-tde.net. [79.145.22.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e95eesm86886145e9.25.2024.06.14.00.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:29:21 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Fri, 14 Jun 2024 09:29:20 +0200
To: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
	xenomai@lists.linux.dev, jan.kiszka@siemens.com,
	jorge.ramirez.ortiz@gmail.com
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <ZmvxUGDwvbyg3vnW@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v82cpvl8.fsf@xenomai.org>

On 13/06/24 19:27:10, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
> > Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> >
> >> Stress evl with a load command while running the tests. The load command
> >> may be set to an empty string to run tests without stressing the system.
> >>
> >> To align with xeno-test the -l command line argument was used for the load
> >> command. Listing of the unittests can now be done with --list and --List.
> >>
> >
> > Nak. Compat with xeno-test is definitely not a requirement if this means
> > breaking the existing evl command line usage. Besides, --List looks
> > strange as an option. Let's pick a different option for the load command
> > instead.
> >
> 
> We may want to implement the stress utility as a separate evl-stress
> command, keeping evl-test for unit testing which has a different
> purpose. evl-stress as a script could generate the load (dohell) and
> possibly check the latency figures reported by latmus (using the -K and
> -A switches to detect weird behavior).
> 
> PS: Jorge is going to look into leveraging stress-ng for load
> generation.

yes I am going to start looking into it. I think that maintaining Linux
stressors should not be Xenomai's business. If we can't replicate the
load with todays stress-ng perhaps we could just usptream what is
needed (stress-ng is well maintained)

> 
> -- 
> Philippe.
