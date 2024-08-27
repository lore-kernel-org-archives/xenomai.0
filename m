Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26C1CD31
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760076; cv=none; b=M5FC6m2c31V20whKwxV3hdCZejVOnERnZnS5NUPKftK5LaZyYkDJfzP4QPyQum+wjIky6OB5/Oh0muuUi+tIZqY8NXKAa27OA52sCPUKK+sjpVcbx7mdo/Kxtl3ykwcVyZqOBEDpMTf8M3qv4zULI/LlIUXGh83J6+YdnvgSk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760076; c=relaxed/simple;
	bh=7r4UntrwBiuxi8DvZr6KYJ9sYSFTNErxkzNyKLMVFEM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DgTppVJMeP7v9mW5+9Mz+SsW+t00Sc4Pg+z0/I6FUsSZa+0hYuOA1kWAbT4bYY3kjwxjPI6fmXQn4Z4oHDfcQ1nJNzymse1SOnGBfJZG/atPl+yA3qeHRuxpU17z2w6Ytby8251lVk7J7CPGHJ+GG3Tj/sIkri5BCCbkQ9QgYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=fMq36C9a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="fMq36C9a"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367990aaef3so2536372f8f.0
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724760071; x=1725364871; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABt3Pgm+lBvzonLHKbU0paDK3YbpLZbE/3e6RVwEK0s=;
        b=fMq36C9a2SkQBA+5GVVaJ0WCAHWQx4hgZW92vMdJXBuLYtpp1AuMGHuZ3Zap8h/gbg
         w6/KcVnqfvHyhbrz+3bFTpnlN5NavpZY9SDrqzM0OXuUoDZBwrRU67jNhVuzGyicZwlm
         4KmzOt+Th88S84PIgUoAFSxQyQ6CdKhDCmDG34T9yIuA8NOHgxKkl+DuP/OhZ/iYDQhQ
         6iSK8Aw1EtvVh2zFCgP90aYse+WlhrimIiIkKjUzEHYSLyIFm6wqjfTcOqNPgLetzZIP
         Gtxas1kspXrMA1M/a1U7sFqVlFpfeiYWNSUhSjPLvR27N88SBduWh6iUQxyCgxwqLvFU
         GqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760071; x=1725364871;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ABt3Pgm+lBvzonLHKbU0paDK3YbpLZbE/3e6RVwEK0s=;
        b=lAgfKbeYIkqkvmLEok+WDf0JC/aOWLDxVJm/W4jG4sMMvFx8U4lemA+XhhM9hGw4tF
         v/0ATVOaOj0aOKsfJ6m7v0BChE5PqRSGzTCqCZqs1Vs/cc3ZQy5T7t75zCSWnBLuWGTO
         immFc+8/we6mZe+ZLpCrsPMd9gY/ZNKKvraT3cvSP5UtGZn71+6IxpYueuHeAmZB5fYo
         WJi/W6mBqkC0yrs2h2JKT6TqLSUKFJWjGXhv1LEDZ9w973tLlTFcZm6GXogpHncODIQM
         IMFh+8fyz6vLVuDpIaJQM8meT/jhxgvnOkBDWAqt1e1M4tulrlfb06SxGqsIISbqKcdb
         M3VA==
X-Gm-Message-State: AOJu0YwHpOaezNPxPbjpdwPecZH500nmVA9yoSIn3Uc8XqLxrEfKg0Ji
	IRmWh+nOPNyD2SO0LMnyXQ9AGJvGN1BFMOiHyaqn2/IVwBw02awq6K8ihbcqBilgxp2kh3h8T8V
	31zk=
X-Google-Smtp-Source: AGHT+IFTJrsbGyVQvE4sKCS49on1Jb5Z180jjYFMCfsJTzDBzZL+XMn/ySsuo1i9aAevv6eQtXBb6w==
X-Received: by 2002:adf:e44b:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-3748c835e08mr1861109f8f.54.1724760071121;
        Tue, 27 Aug 2024 05:01:11 -0700 (PDT)
Received: from [10.115.255.182] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b666sm221439495e9.1.2024.08.27.05.01.10
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:01:10 -0700 (PDT)
Message-ID: <17376680-65b0-4f71-a002-046d18221b7c@sigma-star.at>
Date: Tue, 27 Aug 2024 14:01:10 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
Content-Language: en-US
From: Simon <simon.graber@sigma-star.at>
Subject: Re: [PATCH v2 3/4] alchemytests: Set cpu-affinity by env var
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/24 11:15, Florian Bezdeka wrote:
> On Tue, 2024-08-27 at 10:45 +0200, Simon Graber wrote:  >> -    const char *args = "--vm --cpu-affinity=0"; >>       const 
char *const mod = "xeno_rtipc"; >> +    const char *args = "--vm"; > Is 
there any side-effect that I don't see here? The result seems the > 
same... My question is: Can't we drop this patch?
The plan is to get rid of the "--vm" too, in a later patch. To stop 
using strcmp on argv further down.

> Btw: If we set something, we normally have to clean it up / unset it  > again. Can we safely skip unsetenv() here?
The env is gone once the alchemytests have finished.

Can't change the env once threads have been started anyways.

