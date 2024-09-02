Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C25183CD4
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273475; cv=none; b=beS4FrySzfMxxnGYf+eR3mBZpexC/pULQJdAK9D1U8iOjWpG2NaByCKj7EsV73nSmdzFdhXCBb0cFe7TcLko6AAv0X84/eSXQcrB9lXfw1Y0l4ad4js434pHEVRd5kBGzq5/mHU0Z6Kl1EnU43PXR6ZJERKGtsEztNhgw/kV02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273475; c=relaxed/simple;
	bh=7mg8bG6ES0JLw0h42cB1QbIGPmZhqk3zTG4JW30IxzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvps/uMLDkoneuUBLLaKjnR4Rw66yx+DpQa9Wvu6rtZmGeCWL+uuBOv68OZ3DrWUU8tU5k59bsEVyoInJ2h5UqJgkL4PpI3rsgSzRpW6hbID6a9gF4St5/tVr378PiUmrS7ljRPGSvtZst4N4u8qdK+s7IQEd+DGHlJnPogeNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ngquEjNM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ngquEjNM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bfc395a5so959599f8f.0
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725273470; x=1725878270; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQocQpA80/eycGlvOOt27bdeSTk3P/B+ui8GaZ7BSrU=;
        b=ngquEjNMpuFLOAqTw3RmGqDaqEW8Yjj+xTZMcyO915vJVA40/giD/D49oCKai6RNqr
         xqwWIiuIsbuL52bS01sCF6rjuvPtj3xyClPF0TLVcQClVVY9A/2y2l++rVn0exjhJeQe
         IBOFt8UcinFRAdk2qCZgwHI0RWrb1QFVv7TF6YhtN6m+LCuX8nbun0Tze0DLWcvp+gAN
         4c1tCmnxIPixq1z0td2p6kANoWWqQesfrV1y2+HEj5Qkjj4j+l0PplvYYLke4w5JKivc
         RlJb4zdGRDb5dpaBlvG5Nms+0YeflyuliRRAqCIJgaDxB1GjjIx7WlRyBUqvDIjb5XGw
         LwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273470; x=1725878270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQocQpA80/eycGlvOOt27bdeSTk3P/B+ui8GaZ7BSrU=;
        b=WcpAzBqFb5SQRGnfD/phHLvlfpIqXNEDrNtrqiUC3+LwKNU0UQJSkjSVy41gpXzKDK
         jSQrIv9yFcsdgNoljGMjqRMhXYXg+9s2sl6g1hjmOPEwv9suPhOlxd4ULBUbHx/ES4cr
         FBIsx26zvwo9t3w0CrAm/bzNdzlTtsfzSuRM6Ch92m6Nhep5aGBrPx2fE+Efle4LnF7p
         vkPUsRFA/gvQXtZz+7RyuRUApv5XUKryTegRNLl5Pe9T/4aDaWKqazXCneqM1uKEDRiz
         cZ9eV6gCJogr7afyHvT+91ERSKvkX/IR9NSBERNDBHvmTK1VUVAQqHg8vYYefJ52alpc
         Rumg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTC1PMen6g9c0jWbH36sD2zfUElNHdoqyDI1tOIywF669RsPoV6JLBaIFJEtBuzT0eHsPhwRY@lists.linux.dev
X-Gm-Message-State: AOJu0YwF4qm5SU/0VG+qjonSolKAfuEE0qFGGOYwLqy49wPbtHom0IZa
	LgosVqSBpAz109N24fR+HAqMQrUioZnhNRyWQOiCrK06nPGHWabf/Dg7AXi4S9Sf1DGriYkLNKe
	U3I4=
X-Google-Smtp-Source: AGHT+IFvDPCU1KM7T9p3rNBPrJQ7QFsqo7Il7yiFOqDIhHzSyhlDfpN/hhgevS/i+COF67Cyj+fayw==
X-Received: by 2002:adf:e265:0:b0:374:cb28:b3f8 with SMTP id ffacd0b85a97d-374cb28b567mr1362461f8f.1.1725273469979;
        Mon, 02 Sep 2024 03:37:49 -0700 (PDT)
Received: from [10.115.255.182] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c231e907sm5448619f8f.86.2024.09.02.03.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:37:49 -0700 (PDT)
Message-ID: <692e3344-9feb-46e4-a7f9-4378c3831c26@sigma-star.at>
Date: Mon, 2 Sep 2024 12:37:49 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] alchemytests: Set cpu-affinity by env var
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
 <20240829083526.24536-4-simon.graber@sigma-star.at>
 <01d5e55c-7fd8-4aa6-a9a7-efdf5bd3f740@siemens.com>
Content-Language: en-US
From: Simon <simon.graber@sigma-star.at>
In-Reply-To: <01d5e55c-7fd8-4aa6-a9a7-efdf5bd3f740@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 17:41, Jan Kiszka wrote:
> In any case, the advantage of the alternative passing method should be
> rather mentioned here. Just looking at the code, one may think it only
> complicates the task.
The tasks launched by run_alchemytests strcmp() against argv[1].

Checking for an environment variable would be more readable and less 
error-prone (ordering of args, -- or single -).

Once the --vm arg has a corresponding env var, the tasks can rely 
entirely on env vars.
