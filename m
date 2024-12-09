Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE288BA3D
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761924; cv=none; b=p9AASZqBVqBCSHTAC0lK3X4e9ahkYYf7AW9HyY9HkRGJApq/kE4KpnxrmryQSCwdmhpb5JnJ+NTzDjLDwL40Dvwu26qNpCkyCnbi+meo9HNSnvh11BIJWQ4aM/gAZSC2Tk3UJZ9F9YF+7JD1ffsdHSb3/8x/M5DutXOtN3/5KMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761924; c=relaxed/simple;
	bh=bx8OVpvSCFqzUO0uA0yi5jtTs0G+B8d7r//AR2AEVdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2BqTMCMR95ZlihW/R4GvLwRzxqPCUUpWMAmiH3/Z5TjhaWp29utS9c01ZWvhL87d2A/Ydw4YwTCMM7jMh2AsNrSMFupGE0gxuOTk7EAPsLtLAjkFdIUvBN2Kqu1rZynaCVTMAnU19srrK6xYOP8SzLWXPuK/IK0tSRxeyaq5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjXE9S9a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjXE9S9a"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216585cbe1eso9868125ad.3
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 08:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761922; x=1734366722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx8OVpvSCFqzUO0uA0yi5jtTs0G+B8d7r//AR2AEVdU=;
        b=PjXE9S9aUcv9FirZg/9APxN2DiLWMBwKD1ifw0fVOdjdF6R8SqWih0Ui+xL9qve/kr
         38y0xfdb9GNxvwxnaIUrzq5/tzQhg8rqLvnkhoFhVh7S0j7aJf0FwDQ+9/6cQkbQ/cwr
         2ByJKvbr5O7ooPpmkIxKxWxt8HGP3wCZms/TIoCc36iXDxmRUW4/P66g1QFcKU7gkRX6
         uyBdnY8GEAbVzLmqVZyjF0kKBTfKlng6MA2z0Mz9G6k7n1cAoESMUYZAlwckrhB8F5S+
         JH/57bQa0A/aiKu34wbU37zYLXwnSqx7jB+8p/pFowP+8Myq2IBNSpA8RmocBW1Q8qUL
         MAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761922; x=1734366722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx8OVpvSCFqzUO0uA0yi5jtTs0G+B8d7r//AR2AEVdU=;
        b=aa4dcTRRzt+i26JQm7HcFmdIyMVqrpYjZFXFlyGcsYpkHQizIj3G+lvphnqdjp0l1J
         YHnoTwWnVG9x/satgQ8mwy0E3mYcV6nwtM1mvsVdujv+H1ovXkbdk9+H5GpVEipDIprc
         qDd6AzK+VxLtxsP+HF9SgpiPPRkbr+YgbXclcXuDTvboOIxJeI6paysPaMUQBBlppCyN
         W5afxAKqkmcha43ruYB/mwoWcdHw9RzjkrGjdJ9evlV9aI5C5Ncv+UZKxzVQnl6bZx84
         cOjSp0hYT1fagLGwptQdt850mXi6BQh3NaEIkK17hKQvxFa/3/3pxYF0u/OLr+Ah89At
         8lDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm1TiqxPB+RO3n4A4EqdQDDGO/KnC6ueogn52ej1kZsMFBR3Q48c+QUBwcwt3q7AI/dSxnAGF0@lists.linux.dev
X-Gm-Message-State: AOJu0Yxii2+ytQk4CRblKZQ0wRScz4GIQvCJB72pOBp7jLL99cKSRTgo
	4Sock9Ne22wc7Ks4lyXES6gcKVQNrVMNE8nw+rjuYSao/RTC2gWR
X-Gm-Gg: ASbGncsIL5TBzcVmcO1gMHCl5Ske1yJRo11GZHBMJkxcnlS0y9vH/SmE57keBrdwOsc
	j9is0T4+SJm1coeiWfQZY8KeQ6AW/pz5Efm4BYhjhNsTlVy1KThc/o1MMxR6hN5b5eTUewzU5gT
	nhlYLdLzqYXkJzQXLXrt4e8KFeCd+NRAWQrEopXsWdnFHGBmDdzhzaORtm2Ldu3ILCquIAPzaTz
	12dB1MU753m3LtevBWaswYRhywWEBH8VpcnwMSKw9XM
X-Google-Smtp-Source: AGHT+IFryy2mdtW7DNs1NJ2qTXWCwgSULh5R7wK9ZALaNYUpexUNMdd8f+Q34W+TfnFtJHMGi8J6FA==
X-Received: by 2002:a17:902:d4cb:b0:216:2426:767b with SMTP id d9443c01a7336-21669f9938emr19439055ad.10.1733761922051;
        Mon, 09 Dec 2024 08:32:02 -0800 (PST)
Received: from localhost ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa1acsm72622895ad.126.2024.12.09.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:32:01 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: rpm@xenomai.org
Cc: ruiqurm@gmail.com,
	xenomai@lists.linux.dev
Subject: Re: [PATCH] evl: fix the gdb accessing control buffer issue.
Date: Mon,  9 Dec 2024 16:31:55 +0000
Message-Id: <20241209163155.771044-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734iwc334.fsf@xenomai.org>
References: <8734iwc334.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> There may be another (version-agnostic) way: simply obtain the heap
> memory from the vmalloc space instead of kmem/logical, then use
> vm_insert_page() to populate the mapping, which would drop the
> requirement for an access trampoline to pfn ranges. Dovetail deals with
> vmalloc memory pinning appropriately.

Thanks. I will give this approach a try and see how it works.
