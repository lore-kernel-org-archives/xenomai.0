Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070523958A
	for <xenomai@lists.linux.dev>; Tue,  3 Jun 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960526; cv=none; b=EW39AbL0U0O0vYXXUwwlTYmBHwLIZOaW2zAhjn9JmxW4jyFhJ8LcvKhpOPXhOScttb62TnI7guh4bN9bEpuhFXBSQGMz67/ubzsiXebVzSX4E06ZGKT3O5FqdoqsbiqALZnhEsPlbkMRxBzkZKnYFtNp8hDZhNUHtNE+ET9S1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960526; c=relaxed/simple;
	bh=fpUrRDFhqlvrla073/WFCe894SqwKFMZ61eloLLaAoY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uT6iMbpv6kjIoDioNW2wrzko8fEfuPWMucyPIuchWc93cC51g53Hp6L3bYSynFXGCiM/8nOovJbPXe0NfUxAu8Cu76NM/DF/vDDvzYNXTAhBc/nC7QBGaC9WpKWw/wHDmAGZ7hizQuYcyxbfYPPH8eIc1Ki2AtHPrPTaxhilWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=EF2AIznf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="EF2AIznf"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so2106841fa.3
        for <xenomai@lists.linux.dev>; Tue, 03 Jun 2025 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1748960522; x=1749565322; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IcxPq6GtNdwvr+m8+XJv45mKkp1sGPEw/QR79gPPFg4=;
        b=EF2AIznfK1SI1mKHAww3Kr6hE4Vr1FWaP4m+zGsvlSxT7QKy/JjPvI09J7Yh6q8KF8
         I+++XpJjA6M+LlNVYL7kZjdHOOBFajC0plDDnwrKgMOt1hKU0F1EhYIPbMi4tEIWFh8Q
         XTPOOZqhZKZtXHM/DHIc6kUj/TtaiJr21XQP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960522; x=1749565322;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcxPq6GtNdwvr+m8+XJv45mKkp1sGPEw/QR79gPPFg4=;
        b=wsCBuYMJJ/f9w/OLPDreDam6i4iemX/hqq7XV02G+1oFePR4uMfxKnRi6rYCZ4NSX+
         g9SRZTEhd+xnn7eVxSvkthoreF9/SH9IrK4X6zOFQch+YaqJr+zuFttHVK8G/eDKgcEu
         ur7NIF7tfPCQlVJlsmtG+4EYF/Z/19cbT8sXowwc6zC8kwOjlj8My1zVguxgoDxhuxyp
         crE0XvkG6b+WhSBUpRfVPR2dD29LqCxt4qb69vdlzYcfZZGk9FP4xmCMsFVU3bf1mjog
         3DhIEVdQXl2bbI9PgQ+TjIupmSg0EuyXnWdTOlXeo8IrJn5WEH5Gk1e3okEVq9B9sEfE
         lZIA==
X-Gm-Message-State: AOJu0YzDxGf48bzQIlrDX8XbhZwXcJvNJpGSmnEXu43cljEUDX6aJVGp
	7/HEK7Or76JCbR6X+0dPSY2KY+8OqjgXydgDe29AZHU8kElxWrcBhT5UYVbxSimWjZ/Eg6sJjnp
	1jm7/XQLWDQ/J0tTGvTsYOf3jWjdU/F1YEVXPSxdoOysqgpQQ/+hd
X-Gm-Gg: ASbGncux1xPc/RhPAiJQwOLiZvcuMAxHxCR1ndvi26k7qdzF80t4L+KTCwyGaVscgPt
	EWLJdZuMoeCj0WJouzvAo+dyjjiZj6FQdV5aGhpXg0f0Wv8v9mA8Uc5jq589UsqjxZZsa+3+bGR
	/UiTJzQ0rqucldS8IbhW1mX8rYYFCHiq99kq8=
X-Google-Smtp-Source: AGHT+IEfgeavYMKKDZ7OFKh3lCJqfTMoh/t7r5z5dWWqlpdrZSVQtflcn2PFWmQwrUUIEjBFW6gFQOg21nexjSkJ3Qw=
X-Received: by 2002:a2e:a544:0:b0:32a:7951:554 with SMTP id
 38308e7fff4ca-32a9067ac02mr48028501fa.11.1748960522366; Tue, 03 Jun 2025
 07:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 3 Jun 2025 16:21:51 +0200
X-Gm-Features: AX0GCFvtdsBbFrpYLEzKmHfHQvS7NC4njbGEEgg3X0bxVrqvWGilAJgi0M5Uaao
Message-ID: <CAFc1U0uHLPf4n0hg+PYLLRB0UHzCJhKOVsrje1Afjc2aJEHq4w@mail.gmail.com>
Subject: Testing RTnet
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

Is there any example of  "round trip"  test available for RTnet ?

Thx

-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
