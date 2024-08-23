Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36E376F5
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406930; cv=none; b=Qbvkzey/ONdp0Y3Mg4YIvKFCwuY7E6VRkX7h+vbpwyS13tf2uSlQqcnlwnzmUZeGgCyyUyYld4rn/N/bR1od6tya/uktZVJWiAhM6LW0Oa9FGRGRPXWrMOnpUDOx/TROk36LUW2n03d+UoLw8ddTG6dbV7ktE8KkpXpSB9CxEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406930; c=relaxed/simple;
	bh=SKDAFigau/oKtVFzQsG24psmNUpC6caPQqV9/fJBmuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSZFOpA2WSmGuwFYSc/kTxjyUOJHF725c7588O+uxz78To7Iwxv/VBkwysFDzDELCO/+Pms2jrfzBX6zPmWuZvMIF/Dmj38hFI7pPVJ+hnENyJWE0f+KD5JOBfjEjV2H9A39BiA2UbwYStiBHsbaEc0LbLXasqSLhRucsBtGtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=c53gmBGh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="c53gmBGh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso17867855e9.1
        for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724406925; x=1725011725; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXBOxrWC5jAFaf2LBDrbHu99gXUkTe5yn5AOs4ESptc=;
        b=c53gmBGhgjF43QKeGiB3oKVZev6o6rtmwVlMrPAcx4KkyVQLhCwGG9xKplYmuGWgmM
         Gmlr9/qsmYi9EwF7UFkQpQSHO5lnxXN3j4Gbq84jUcPf48b4XTfSBAAKlyUeNR0M/L3W
         VRGpnhT4N9Fom47JmrkWKpEB9An4vHUCxU1XxcKWA+vEY5tpLOigCtbqHZd1mNw+7KKS
         Qqqrqh9VDXunIKNoWT18lv/CYMPkv6bQtKuIuOvCSKpNsXFMN53oTUhhtODsJ6adDbCH
         sD6xTnzRbdAwBVsvebp4q/c5Vnxcz/gOHzZEBMAr9I4yKEsyqhQB+h7PktBq5bBNe073
         kOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724406925; x=1725011725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXBOxrWC5jAFaf2LBDrbHu99gXUkTe5yn5AOs4ESptc=;
        b=O63fNOpCZ4IlVReAYe1Xd1eTSH2OvYMgCCR7+nXxXo96W4InBgDlCQqVjg2PZozeRL
         exZ1HbSAwMFyhiq3LhbuqIzYv73BNPmQr15ji0cyv6cpRIrEvg/H4uHvQca3HXef4IVa
         OmBrGvYkAQXyutuRYieJ2bsWISpgCPBRip3G32mHvReVTuRp40EUWGtzK8hhPzXN1jtL
         lG39AI5oaG+gIUvugkZGj+VEiC3VaUwamajlG2qcJoHH6L8Aq9/DweMQuzc9pV464voT
         ZGzVENDZV3ik+U7i9OGpoa6Jm0P5AMy9++iwejCwxlFrKRRAFaSzKM1/GGsX6FC04etW
         VUVA==
X-Forwarded-Encrypted: i=1; AJvYcCXSslitoWJgOfnb1P3Y/yqfaq5msHsTeMK66VXNYDWunWhosvyrbzeKO+DAeMfwGR025D3GZqkI@lists.linux.dev
X-Gm-Message-State: AOJu0YwFYWCZtRb40+L9X7YjpABfVyEFH/Pav2u3de6R5B5BD36BnB55
	II1Mdodk02JHhSzjYwYds1Cu9C6ToGcHD6xOe3K3uZZMxUGmcV3AvzP5QHpkx15jKEIBrxXbJl6
	8ato=
X-Google-Smtp-Source: AGHT+IF8Hdvn2KUhhhZYU4Xh/8EMg8MqM4jVi3LrU0kAHOVJmq5QCgDlyuY2u9s5hyt+9Ghi3KyfNw==
X-Received: by 2002:a05:600c:4e8d:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-42acd5e69d6mr13075255e9.32.1724406924672;
        Fri, 23 Aug 2024 02:55:24 -0700 (PDT)
Received: from [172.16.0.149] ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc6285sm92840395e9.36.2024.08.23.02.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 02:55:24 -0700 (PDT)
Message-ID: <5fcdcbc1-8d26-418a-b3a9-29a4e8f9c784@sigma-star.at>
Date: Fri, 23 Aug 2024 11:55:23 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] doc: Fix typos and grammar
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240823065247.4884-1-simon.graber@sigma-star.at>
 <a6a3373b-fb88-4d49-8296-ba9d02008ab3@siemens.com>
Content-Language: en-US
From: Simon <simon.graber@sigma-star.at>
In-Reply-To: <a6a3373b-fb88-4d49-8296-ba9d02008ab3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 11:27, Jan Kiszka wrote:
> On 23.08.24 08:52, Simon Graber wrote:
>> Hello,
>>
>> this patch set fixes mistakes I found by running hunspell etc.
>> on the doc/ directory.
>>
> Thanks, highly appreciated! Applied to next.
>
> Do you think it would make sense to install that tool in our pipeline?
> Or does it require too much human interaction?
>
> Jan

Well, the problem with automating spellchecking on technical projects is 
false-positives.

We have lots of nonstandard vocabulary (e.g. gpio, includedir, builddir, 
popen, printf etc.), so we'd need to maintain a very large dictionary of 
false-positives.

There are public dictionaries for natural languages, academic language, 
etc. but AFAIK none for programming vocabulary.

There exist spellcheckers designed for source code (e.g. cspell) and 
they can be integrated into a ci-pipeline. Other examples are aspell, 
neuspell.

But even then, there's some human interaction involved (at least 
initially), to save false-positive(-patterns).


