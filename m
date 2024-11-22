Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7912E7F
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283465; cv=none; b=B8dqIsO9b5LlMCPyqG+eqUcv5PyTOzSAHhQvuL/LGO4gZRcZ491ENQvjtW+MMuXRimUcLrpr/bi9MqoRUA5XJxI0vwPzAk7e07z+t6QcqJBIypdlxubhC4hYfl2U4o8XQJUm5VAUQbh5g/u1+zeKNQKIj9mDpXr+0qBOzQ8E1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283465; c=relaxed/simple;
	bh=Y0Ah+BVza5e2plsZZIJ2f5iVnxPQonQKeGnprNwBbpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ApEdnF9F/WxKjNmrEZqSoYZb9qCHlWotW8DfOvYPGQFqotTdeWZZiIzh0apBvW/PUvEydQ8EgrSS94kidhx3992P6y5raTzJfEI93WuyIf3St+dqejixaunN1M+ELReyLf/5/VdlNym4gL2t5XdiuiNZgKqnKXW1aft2hGkdywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 4783F240004
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:51:01 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7D3C7D8106C
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 13:51:00 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so18398845e9.2
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 05:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283460; x=1732888260;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyOXcR+AtjfgSmHiI89dQIXcc/bCMVYv6byk/Y09QFg=;
        b=CQbzIEU7zBCcc1ZoUKf8w/ABxFYgZEVUEeHZr2ksovMdLGWEZB/MLvjdncaydD93l4
         sjLNfM7E3ThrFMVZZpHDgnv2reY/HWToWWXO7PmJJqPYMTke/NgC3yPWQ/E0/fJUuN5J
         8g2GeA9d0J/3dyh7B4N6otwEZXZ2LlEJ/t/mjfCmF4ncggXvvAFn8tCAhsK6XGJrSxZi
         o7ZC5UdbhqKB7lNM8JMCnUAHGnVSBDSFxJFHVY1/Sx/ubOjTSYUxg5sHuF9m3c/1FjbC
         03ZOkxuPr5eLL2eZA7JcOlpAOYenXH04PKap+xNO1V+RyEvVM32d/SVN1V/99cUxtdW4
         TASA==
X-Forwarded-Encrypted: i=1; AJvYcCXwrGFi118ngziwk+WOprC+BqPdOtVqvGvZJmAGBxA2cQXAJDCS09px/DJHg5U2F5s410/0NPtQ@xenomai.org
X-Gm-Message-State: AOJu0Yx64k3m2VyhjzsNafR+Ldh8H9VaDwDtQB0ZA0ty6KdDwT7ydc9u
	INIToNrb3PgMm0l1ov4xN5KNPWYLnUBTj1rvO2U5BGEQxUYJ87zVF3BU8g==
X-Gm-Gg: ASbGncsRxllV2U/vycKslJFGlzjjITLvIZeqf8jg+d+WtVcO1FZIA8X893vNxneYOUe
	+ywogARkUfSgMWLNNVTvY9PJBkfPOu8rAyjBVJxcv+PfHDQ/M8i3X/V7MQqepHvK2hy2D6IIhx9
	6RG8soN2NpGREdExP1FrkfMFB7IU6csZHEyR6UwM2bByAJ1rAxQJpSsDM1+t4sR63XKkg8a5eKC
	oW4FK7a4tRZdPHfo7JCtuQ6iohW1E9lyow=
X-Google-Smtp-Source: AGHT+IHwRuk3rqKwMnTRPF9jxp122nv267xg6/sWDNNT4CKEbb1pesfnojTYRCv9AQzf3mROi/1cCg==
X-Received: by 2002:a7b:cb52:0:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-43487435826mr19197765e9.13.1732283459806;
        Fri, 22 Nov 2024 05:50:59 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde17263sm28030095e9.24.2024.11.22.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:50:59 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>,  xenomai <xenomai@xenomai.org>
Subject: Re: Xenomai.org + Giltlab
In-Reply-To: <c0d68831-8391-480e-94c3-b5666edac991@siemens.com> (Jan Kiszka's
	message of "Fri, 22 Nov 2024 13:51:05 +0100")
References: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
	<c0d68831-8391-480e-94c3-b5666edac991@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 22 Nov 2024 14:50:58 +0100
Message-ID: <87plmne5rx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.47 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.11.24 13:44, Pierre FICHEUX wrote:
>> Hi,
>> 
>> Looks like there is an access problem sometimes...am I wrong ?
>> 
>> Error 502 on the website, very long access to the Gitlab.
>> 
>> regards
>> 
>
> Confirmed. Philippe, anything related to you refactorings?
>
> Jan

No, this was only related to doc.xenomai.org, days ago.

-- 
Philippe.
