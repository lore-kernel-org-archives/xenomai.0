Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70337D106
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675789; cv=none; b=D+elJ30vrYNNtO3yDxBBY9e6zJgk71DtobOsARKTYnE/I+wCvp0icirDsEFyAGmZCVt9xS+xGaFbCqsYjY//HK0wJzpSpI1mu3JaoIyPngYRJAL5YpobQsXCchXfoRv3OYflKmhRh2HASaEb8oIjV1PMxB8c+kjxu5TY31JTjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675789; c=relaxed/simple;
	bh=eig+2CBdKUP29WqyaN99kqyLWh8q8Aq7jXnFbpcDnfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXteJzxPL+/MuKwaVjHBXnWLMSqB+DznZtAqR8suFFW9xTThfsRvvE8b3cwahF+2l0RzOOLZ4HQ6BIaEQC7truvK0QmAw+bSrn9ydhFt6CN8GUAX3xlUc6MncMASFjZSPuOJoMaoCK3jGfsBsrDCnGhWgYii2jIRo6s5hFzBdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=EpSFwsVv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="EpSFwsVv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso5771425e9.1
        for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769675775; x=1770280575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eig+2CBdKUP29WqyaN99kqyLWh8q8Aq7jXnFbpcDnfc=;
        b=EpSFwsVvQLGzzODWLf0M+R8dNeOMkN9GI/iYHwif0Fal200iLSvR6ma+lWOqQdzvcC
         lnw/6Tppnl7dJDvKPF66KZB1nC/YtS8YNJRUBE4fSmYNTzfp0/7KOHQSvCTWbJPTLB+j
         uw7epqyIrU54o00PXKzyBwNgn4ZKquen9d0DYqcS/yekaOnMDy10Il9xuogRiJqOKOoA
         NpXjr4GtUrP9m90lPKLoyhjOviVxgRQ/EJGBC0repcsywttbQPKPEC7H61AP/5+KGGtN
         ptqIfUSF7ef41LU/Yc93QbU7Nx4Xlm/KGibJ3/fA7s1BommP/rH1ZNyy+kNxTbVZbFNQ
         5pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769675775; x=1770280575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eig+2CBdKUP29WqyaN99kqyLWh8q8Aq7jXnFbpcDnfc=;
        b=Q5IEc0EX5Z1hFoVyiUB1PuVZGNviVCS3n552hKU5w/cNB/C9M/3jxdEMAMtGPySGv5
         3dAu3peLU6glXHX8GTcjmPkWYi8fp/uRATzesrT6BgGpf33D45d5H6YYQkvp0ZHcjr5o
         CoPH/FeHnldd3JgEAQUVCLIkNVcL/51sNJuZIgZlAiEUvp+8O+bK0jiTi3g1sK4fLQMS
         Lq/0M2wmeCanbUP9e2A6vTCHXd1wOaNuT1mjwOeqnFdWEZj6BOMPhkXz5JQOvrD6bGeM
         2NZak91uQxZU7/5IvlrsUHAHts1C9pdP/HsdWQqi2mv4LZ0R2mvA1fYXk8cbubJ4hu3h
         MDTw==
X-Forwarded-Encrypted: i=1; AJvYcCVs6UPxDm73vVFWSshvVpOSbKVhRVYBx17xA2Y0YWgqgumXYyYeuRLyYKPzWG2T27KIXF4EnBQ1@lists.linux.dev
X-Gm-Message-State: AOJu0Yws8A5/LKS2SDcvLc1fEJ8nTTwX9YFAozBmCxpVi/rKrboUdzwR
	KklWeaVffmKqTtCab+Cj7ZA4qIvqPxfnC/XRu/k59dEpIeqYprqUFbnWZtsuqXGFcWc=
X-Gm-Gg: AZuq6aIKCt5i8Fos6R7TFrG6TILGBa8TwkaT8tpG9mC3GRsF2pOa3DAFsrspA3pOZsG
	mb0QYYoPy9hulY3b4Qol/+7G+k2rMjkR/Za7rHR6Ko7pAS8ctMb1jT9uaVaXC8gl4qBwitp1Mjf
	+tf8kjU6G3pLfMGd1wyNers323YlkPTLN7G2Xerrbg/ZNksu2pXiq3s2tv/V7r82EYbLnUHoYqg
	fbaAUl0Luh41Br2vMmwNGyRJxWod9X2VTF7MqTEfNjXEO9SHQsMJsRXsNWdPQLX01G+0As7SQBh
	lWQd6UAy7bdWSz4iBKt/T11y6QBHvRseQY65lHamlIgknJ6LnAK7CfkYfitjm3+di7aDTBzY9gz
	NjMNhC0ZZMzu3gb6JaIYi2KEH8M1NltvlpN7Zp2PyAkllveeAV7MM2MFx8xBeeMq/6JDBlHPL39
	JpZg69N7N9Bcz1PBvbr+uOKwg=
X-Received: by 2002:a05:600c:4e91:b0:47f:1332:e5f with SMTP id 5b1f17b1804b1-480829b5cfamr28792555e9.12.1769675774960;
        Thu, 29 Jan 2026 00:36:14 -0800 (PST)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm165178895e9.10.2026.01.29.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:36:14 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
Date: Thu, 29 Jan 2026 09:36:13 +0100
Message-ID: <3506084.tBmWVcJkqe@nailgun>
In-Reply-To: <2c9f0b74-4e8c-4542-b0ef-ee13ad21c2d0@siemens.com>
References:
 <20260127213927.26960-1-richard@nod.at>
 <2c9f0b74-4e8c-4542-b0ef-ee13ad21c2d0@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Donnerstag, 29. J=C3=A4nner 2026 08:45 'Jan Kiszka' via upstream wrote:
> On 27.01.26 22:39, Richard Weinberger wrote:
> > Ensure that the task structure remains valid until the join operation i=
s complete.
> > Previously, a race condition could cause the structure to be freed befo=
re
> > xnthread_join() accessed it, leading to a use-after-free scenario.
>=20
> Where exactly? xnthread_join performs some checks for the existence of
> the target, and it is locking it (find_get_pid).

xnthread_host_pid() in xnthread_join() dereferences the task struct via
task_pid_nr().

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


