Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5D13B7A3
	for <xenomai@lists.linux.dev>; Fri,  1 Nov 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484826; cv=none; b=MsWK/O0hW5QzKaqy+tmmNxDaFAmgnTrm35nktPdCMsbcopsn3czkZZNcSidB9VT1BmgWFdijKLZstxZjSQRWaGdkivnYGGVobJb5XuayTkKm/Cc4gEERqtJ8CbahDpA09ZSTBTlKhv79jgwxSP1A3I/KyAjvhY5pj9iR2q+sGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484826; c=relaxed/simple;
	bh=3tssCZyibpqrT3YWzSS+9RsO4puFkQ+LWjUXlb+1VvM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfVeTy98U75bbm2+CwO7dKdzL2YRT3Erhtp6FMqtx/n4YnBKMUycUSyznWjeJmQ+HiOxh0JmxItFmmFi4O+PxteqEmY8492ouj5ReiVLTyAaq4QBjvU9Ra7kF2DlK9cV1ce9+NtAlIn67posU7Jt3gzHQcDnMbsGMvVV/sMrAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDOJhnVg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDOJhnVg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so1299104f8f.1
        for <xenomai@lists.linux.dev>; Fri, 01 Nov 2024 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484824; x=1731089624; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tssCZyibpqrT3YWzSS+9RsO4puFkQ+LWjUXlb+1VvM=;
        b=DDOJhnVgfY3scOKbILI9Kx9LverAAPIjmcb+M1bHxPrEVA2ok7TFnvSiO22jFW6pw2
         ulLm7sOGVd+BRNNcAefik4PIstgy7QR6GqOdqPdDbnDRuvMZBztgrvB3BVOufefHp+rW
         d/6g5PFtGH1kDJzCiQBwsXqi6h+vfwZbzF12uNykLbTTpCrROluNUdjAb7dCsLCVKOOl
         wDtsEMrl6hgHxm184Ldeib0GattGOes+c4WQV9QPVYUzsR3leIuYKG49Qw1fVlnp+7wB
         hP/tT3z8iXijFTL3N8g8Z70/3AfKA3xTlDLxsXcSKuh8/fEf60fc/Y4I6fdc5AhTGrae
         uF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484824; x=1731089624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tssCZyibpqrT3YWzSS+9RsO4puFkQ+LWjUXlb+1VvM=;
        b=OHLNEcvwMAvZgH/jX6a1hcc98moYPuSQfJH7yXwN+kIuLnLSEL2YbaSM7FWAPTPdOl
         BwKmHpebSdY4nOMTl2gU7oDBQXvapZUaazu8EhVhIQV/l2MCE2SWWdYNZiKfnQ20MrKd
         dSksYeSf1cA4gfDoOg7VuuKNcRfXwSStPxNpyrcp0zP9ay60QLdnPp4JJALBL177JkUC
         ptKd4Yfu+8C0kE7+s9/bJMTesL5NALxaGNM/1AKZogHuQHGEeSwyMu8vqOWFsA9l1Lq+
         Ug9WjhoWfhEQt7GSvHyWxM6EhTEJXxM0iWoyiNqWzLDShssGu2fXdNhqNY0RzVY2jjbA
         jtQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQOV8LjYyEFJtZY1etxyrmWBaqw5T6GeR0tynX1NkbxOkfyK5E4CpmNLvluAGoEGTeK3m1Ioo0@lists.linux.dev
X-Gm-Message-State: AOJu0YygPDqtUnEqhRDdJx8OvplFYGLTvmTHZY5kGIbUj0PC1Y/ucIOx
	VcAk0wEm/PVeHhUjOyAQpX+/r2/JvRhfpoSKvjOx/ibhYu5ZFo2H
X-Google-Smtp-Source: AGHT+IHO+oDK307KiZtcef2KZH/iNyHzwRP6e3C6JkymF3ex+Ux1wOm8qZd2kf0b2TOzozghiuLcug==
X-Received: by 2002:adf:e0d2:0:b0:37d:493c:f7b8 with SMTP id ffacd0b85a97d-380610f245dmr17053727f8f.2.1730484823625;
        Fri, 01 Nov 2024 11:13:43 -0700 (PDT)
Received: from trux (228.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a7a6sm5838149f8f.92.2024.11.01.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:13:43 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Fri, 1 Nov 2024 19:13:42 +0100
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
	"Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <ZyUaVn5UNfGB88TK@trux>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
 <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
 <Zx6QxE+CNTmQqZDk@trex>
 <ZyUH7BV50dlhvc92@trex>
 <87msiig9jm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msiig9jm.fsf@xenomai.org>

On 01/11/24 18:15:25, Philippe Gerum wrote:
> "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com> writes:
>
> >
> > [RFC]
> > I would like to update latmon[2] to the tip of Zephyr - it has fallen
> > behind - I'd like then to propose it upstream (if accepted I would like
> > to propose that it is removed from EVL). Anyone disagrees?
> >
>
> Fine by me.
>
> > IMO We should also take latmus to its own separate tree dedicated to RT
> > benchmarking and extend it to support scheduling latency metrics based
> > on GPIO data.
> > [\]
> >
>
> We would need to make it evl-agnostic then, assuming you want the latmus
> <-> latmon (Zephyr) combo to be broadly available off-the-shelf to
> others.

yes I think that would make sense. Xenomai3/EVL/PREEMPT_RT or any other linux-rt
could be easily compared with an off the shelf el-cheapo benchmarking tool.


>
> --
> Philippe.
