Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3213B293
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882290; cv=none; b=sgTT4I0R/oXbiWgLJv3IhZKmO15Gj94ZTu7InMtYoFokZC6dOg/p3m6sxf3dCPI53T1maX2bKTswv6nVOvr2lxxn3uss/rjXxHUpoVPeZUDogFWiS62rpJqqjkHWPWPkxlhio9ut8U8BbPxqVtSIozbghDVvo1Z6eBThCYevJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882290; c=relaxed/simple;
	bh=M/9uqwvwEptm0uJKf/cIaaPi9hKi8vBhCOxdbtHAFns=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=issC2bHiZUkkIgtzoP1QkD8+deBbsKMCXwEbzTmny6nBDNUzueVlwzFsCNUbB+ywIZFkTK8wY4EkZVHq2ZrH0O3m3V4KfGPUwMpJFVDH7BhWDyl1Qt+S5/mXu1+kjaw9qt4JjXWsCgmUV9gXDANIAf3a5wl1W48Ev1O4Ssngnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso18379045e9.2
        for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 07:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882286; x=1714487086;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N4303RhLk18yYWBLVwejMDMPncGCdmAXpmGvhL/YdI=;
        b=HYxr3nww0rotOJYH0uu33yGlF9BIyiOd0ZIobEIQb3M8PjTOAgvFHe7MorKV6PvVzV
         28nxebd0glnHZgVj4mu1ASsZwAmSBAzmpHEr6jwXbfB/0r5h8aeOytNn4w7tUzNJH5w1
         O5/PLGylndfQutUbn2QrViH/x5iMBn+zUlPFb+coMOVYukl9019csP809RadEyaWPyLL
         nWFNF2S7JiqGa+uLnLP0qZBpmyjPD2bl9e2iUebqbHAp3gYP1JWbOzyzGfv7TVylg9IW
         5PXitb3rDkuOzuSTBoJ4q34iq1fKOtVJG1/EBEnurFfbH4g80Q1eyQxgXL5BCk41lRH5
         wahQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzmuzNMCGQllPd8HTXiD9clepEONHvOtsWOvka91AUXLvjm2Irb6IhJlG6rEf4pegiBgvyuRH+mQ7MT5K3OnlTzc3VLNXncQ==
X-Gm-Message-State: AOJu0YwBmX4BBSf4Fym9Ym0Kq/VKMBxCI2wKJJb0+jQ99d2NeR443oXU
	6moV9Amc1CYr98yX12uyqXkU692YfcAAPThuDiDDSXPi92YGpvGdMTSTxf69
X-Google-Smtp-Source: AGHT+IHgV7uD09Rp+VwKUh5NdgIh0ItNh/V0wlt9hsmTCV7HgzbKNVlLPf5JjLc8jwO6EqF+p1+ilQ==
X-Received: by 2002:a05:600c:4ed2:b0:418:16c3:499 with SMTP id g18-20020a05600c4ed200b0041816c30499mr8769577wmq.37.1713882286232;
        Tue, 23 Apr 2024 07:24:46 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm24031169wmb.44.2024.04.23.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:24:45 -0700 (PDT)
References: <20240423104111.32385-1-Fabian.Scheler@siemens.com>
 <636c38d0658c7d1148e3b434351492a1375cfa6d.camel@siemens.com>
 <87sezcz13o.fsf@xenomai.org>
 <1a6970a988ccc03de89e9839a7af11c04b979eb5.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>, Roman Hodek
 <roman.hodek@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail] x86: irq_pipeline: Add missing definition for
 !CONFIG_IRQ_PIPELINE
Date: Tue, 23 Apr 2024 16:21:12 +0200
In-reply-to: <1a6970a988ccc03de89e9839a7af11c04b979eb5.camel@siemens.com>
Message-ID: <87o7a0yx5f.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2024-04-23 at 14:59 +0200, Philippe Gerum wrote:
>> Merged, thanks.
>
> Don't know if that is important for you Philippe, but the patch was
> missing a proper "From: " tag in the body.
>
> Fabian is now the author, but the signed-off-by tag is from Roman (the
> initial author).
>
> Fabian, when re-sending patches (maybe because the original author has
> no proper mail setup) make sure to add your signed-off-by and a "From:
> " line as first line of the body.
>
> git format-patch --from should do it.
>
> Best regards,
> Florian
>

Let's say that the signed-off-by tag is what matters the most to me
along with a source channel I can trust (in this case siemens.com), but
having a fully consistent information would be better, indeed.

-- 
Philippe.
