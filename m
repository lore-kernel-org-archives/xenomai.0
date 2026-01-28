Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525F32E120
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608456; cv=none; b=tp4xS4oFsTph3giuNAr6XfZfPrWPUWRwTIXiAoQRdaUvSCKYjsqJHUtp90Y8cNfqn+vvkTXzpqBKLnf+cVr34F64xHauQ+r9BDDt2evN8lv7lI33gr7cUqqwK3GTrDTRQP+hvrLJsHVRBp2TgzVcNY0IoBbx855zxTOo2iRpc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608456; c=relaxed/simple;
	bh=giXAfYXFoVzD2XINKKcM/5Va8eYMrlAh+6zgxL8roto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhpRPF2pRst92l/WInfelnlXrecPtHxcX8xYSA+WkK43VtSw8cVctnYkHmbcjxb44lk7tZqq9ScS33mK8VYl5Up1Jyce2FxGIHh88mu3vwDeXQoaZ06VlhxWA8r/J7gqP7vtAfv/6PdkJlf/iEtCedBUIJi2hhtQqRw+4jO2Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=UGdf15Uj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="UGdf15Uj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801bc32725so52745585e9.0
        for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769608452; x=1770213252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giXAfYXFoVzD2XINKKcM/5Va8eYMrlAh+6zgxL8roto=;
        b=UGdf15Ujk4xEp4DkTtiDVxlzprn0ajnp4gzbOYxr4vYR5rF+ercKFr5D0QxCEqmOkt
         vyG++KK8A9C9/FQFqattYB3eK9Yg9WUQSIDsJ/pYC/T0El9v20OP9OjiVY2Md8PtrGtW
         Wm/Fkr18zFRq8XjoNEVaX50oM2QCYDE3IaKqCbyENNNsqm1VmvaqIDewY1RoRoXO1IDy
         CN9Jbj5cFaEw6KU8TrgT03EzYj6thBDXv6wahuJeXhjWv+oFg1YKu29Mf5o038dmf+YR
         Kt8UWaTsb2Gvk0/i5HGfH15sf8+K6hB9LTByzqBwL6BSPBlNM9GG2kjGAv2u8Xmxkkgo
         Zdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608452; x=1770213252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giXAfYXFoVzD2XINKKcM/5Va8eYMrlAh+6zgxL8roto=;
        b=nUj9ehOTVm0jMxTXm6JTMpWGuKNRoljq6l+kjJVYyDW1WIBqhxhWrf1DH9uGJG3Cek
         LvGHhBH6MnS5iqNeRYg2W+XK66II69TohgVQKncssLdC/ZXkqL6XLXbXuGhf08maljIQ
         sO6OxCNHM3eZfxabG/oSZN2S7TvwQPD8KZHGwF2adb3rd5SvuiBDdrJxsODuIvWwQVNl
         3H7hamasYjzXdeCV0fwDW8Ui74UEQ6EADjbemdlLHFjDakGA1mj0jqNtjHmphjnJs9hF
         +SgIWIwAUzRgVp4jSXI4FFFU42wiLCfKVbcI57PlBJ1aiYpP410XZtiSo4WocCKqI96V
         HWHA==
X-Forwarded-Encrypted: i=1; AJvYcCWw3HHaQynqvxx1zXjkhZtarlfvLQBhd4IFk2jNAE0czG4i9V0/vhGxfAJnmOgiZf/0/77FIRDr@lists.linux.dev
X-Gm-Message-State: AOJu0YwcypOEtmmYHimAeMmqqI4HQx+pDZmBiqoBVbI5CqpXFsR82b1I
	UU7BlhMO2+uyRVHruHFL6rwNdFXYNlNJebGub7XRaAZvjipX5f2qG+8nWexGmr7YhFg9GAmkQ7H
	Dgdj8
X-Gm-Gg: AZuq6aKZI/9TPmq4gwAfF+BUbz4scubaB8GYJMe3WtXTmcaqoRmt5jtm6SSzjKBu+gs
	p65DIGG+D6anVFFRL6i/cDpMpfYPcH72qWmx16TlBefUrqlH8feKHAvd1BpIJrXy+3UqJmBPSFs
	M9TSYQ+tWFFpPlBx19hLa/dJRfsMUB06e32Yv//h0SmcB6BuEqpQ7Xf3xdnQMEa6xyR7B8IANuM
	B5tqJLQDmK6pHV4ZF/vNaqIFroCaxrjpcThAIBgdtvnPVd1VCfew25ZJCC6xH/mqTefbYw14KFO
	j1fdicJwcD/wS9A0By9Dyr17hSsFMdoDCYYxsIYYDh32AYW8UaqqFw6Shw56Kmg/kW185RQwwHk
	GPuN7Z5JlNg9yvDkJxxVsUsy8EdPxAexn9mblpcvWUJPVAUTlrQw/IDqcToIpbxPeJ9jgl1gKaw
	fzi6+RdGfTf7DvrVAmHFwtXLDNPYdKOCUK+AoMVwMvBpxwWy6V9RGqw0w5bILYX78=
X-Received: by 2002:a05:600c:6092:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-48069c3a7abmr68553325e9.15.1769608452569;
        Wed, 28 Jan 2026 05:54:12 -0800 (PST)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e289c1fsm369825e9.3.2026.01.28.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:54:11 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 2/5] Make RTDM tasks behave, part I
Date: Wed, 28 Jan 2026 14:54:10 +0100
Message-ID: <2195484.zVbxSjN2mB@nailgun>
In-Reply-To: <6094973.eUyiRONoq7@nailgun>
References:
 <20260128112821.1232-1-richard@nod.at> <874io5vpkl.fsf@xenomai.org>
 <6094973.eUyiRONoq7@nailgun>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 28. J=C3=A4nner 2026 14:31 Richard Weinberger wrote:
> > Using -EINTR is going to be a problem if xnthread_unblock() is called to
> > forcibly wake up a kernel task from a sleep. In this case, you would not
> > be able to distinguish a signal receipt from a forcible
> > unblock. -ERESTARTSYS may be better for that specific purpose in the
> > RTDM API.

Okay, I think now I got what you meant.
A blocking RTDM function such as rt_event_wait() should return something el=
se
than EINTR upon signal reception?

Currently, these functions return EINTR when a woken up task has the XNBREAK
flag. Let me find out where in the signal reception path XNBREAK is gained.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


