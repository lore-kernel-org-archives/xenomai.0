Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35719D074
	for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971217; cv=none; b=LQ54cHhfL3m4TXcp0Pf6HqWwVB42kiXhLK0EMap4KtDvjMeOEU2C9t5Fr6Sb6F/PUlg24XuIfVoGw7R8SPPrXEQA5PRBFweptAav2ozjyRMWYAj6EnjQHFCtkahebECgucHFRuSeKoi+Ydyw3z1i5+QLjf9EY9xonFkyAIwjuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971217; c=relaxed/simple;
	bh=QRK0HUIUwVhILaJFc0OAM2RXveJXjjuWgy+3K92VT2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHIhwLWwtUgdq5niWvP+GWhqQg9DGGKKEgS5IevZzHBj44Ntywrp2uAGc1aVafR/iU+NRWk84XmZUCZDxooIpje/TDbWSRcRNcp7r+JVwbiAnYjJ/ElLFjHEosN0ES8b7D2UVnjw+GKdqjmn0AvvkiSCM3kkniRP5HRKimYxxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=S3Gnv+tZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="S3Gnv+tZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-31062172698so18728451fa.0
        for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1744971212; x=1745576012; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2TYZvqeMboitHknr2yrlCpaHuIgzX1W9Yafx5ieo14=;
        b=S3Gnv+tZmPkdNuymbpCzKa4mOiVp/e0nD1cF4KB2cpof9cbO24Bmb4gFoE2rS4ZS6D
         G3iK92h4n/nbuI2LIKOsuhO0wU42u/K/hfbNcTvIbd9+9OgWK8hz7xf94fPI5vN/mgH0
         TBEPbyQApcgdjTcsFjCCaf/FeY3i7E8WPLRMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971212; x=1745576012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2TYZvqeMboitHknr2yrlCpaHuIgzX1W9Yafx5ieo14=;
        b=YulgHW1PmQIQdc45BSowAY6LjJytNXBgFSk2/PN4haGI0rQGZrrtgpS4AJLWgYYpHo
         TRUWROks05tfQinnmCoMkVJte0gfwHB6MZ4DuKJEFuhxEjKS4iDGVbvTFEUIsfENpuQO
         rXg3WJuObkXM2L8GzYM+xK5jFtuYfBjvcTyLxeIDYpEysMsTq7V4pORDiryGut379kx3
         P3wmzp7Has369rfYb57e+JZZYvjL4VzPXDf8VDUfFN5E6oIh3gOtNCWDvtUGCI49UEey
         b7sm6JuQSiruLiejT6TYVn1Jus6TzSwgdWA9j9sf0lLn8AzKo6bt8bRhkIo09fQ3i4ay
         2O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/Lr2VpyQPwuZ1bmqWyTdkUpX2YDnc3QMGu/iW4zv389RUZwkwdqfi6Td0FX3EZlTaTavuKuRC@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7KPXbs+Y1r/D+rhIG/UT92UDiL4Uk/1k43OzdcV2hJ0croOoL
	PFV/BtiE/JS3Cvg4FbT8LFqcY/BAPO5dAUvckEELBs8v9zs1Wf2Br8NC6nRINw1m+dN2CSLj4wu
	jMyB1QBstSoLI3U46P0rGmZIAXRTBUG/fv9mLmQ==
X-Gm-Gg: ASbGncs4iuK9XN5TrrGAoWvS/ImDtvS7awvIfzCVOMwHpQ1WyrGlcK/Al3q1sq0PmnB
	kzDoXe4bUOZicNk4yImVPGVOqsk/clRhZNiiE6jHiYJ8mQ2XUkz+ejklx1l7L7S5sSVAFYPFZjm
	cIPoj5sOL7xU/RVMP60dVnwxWl+qczehvWyN1KJ49Y3h3itKM8dOqsNCP9dP+JgSc=
X-Google-Smtp-Source: AGHT+IFGB6zAo1FkT4izWRB3IOvwuKbRXuOV2D6viK5xZagvVJ2ubeSyHEk2032H3dxr5pHVlyxLYSbHBQPPWIE5aJE=
X-Received: by 2002:a2e:a808:0:b0:30b:9813:b002 with SMTP id
 38308e7fff4ca-3109054a531mr7704281fa.30.1744971211749; Fri, 18 Apr 2025
 03:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
 <8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com> <CAFc1U0s64TakhZUG=ym-oANAnkNsj-L=L2T3pYAtzgEwROtHkg@mail.gmail.com>
 <CAFc1U0s_6A0JKMQ+kWL+hCKGG5GcfS9C721u83Kc_qbxbTXMuw@mail.gmail.com> <87jz7hj0is.fsf@xenomai.org>
In-Reply-To: <87jz7hj0is.fsf@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 18 Apr 2025 12:13:20 +0200
X-Gm-Features: ATxdqUHqCy8p1O2BYV26__murDzGBO_0p74RvsNKeuo-yUSic-gh88EtiQjTn8Q
Message-ID: <CAFc1U0tLUVNKQdE1dCxVj7pRX0MS3inxax6dDH92goLzgUN5WQ@mail.gmail.com>
Subject: Re: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU
 with EVL (Raspberry Pi 4)
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>, 
	xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thx for your help, Philippe.


Le ven. 18 avr. 2025 =C3=A0 11:13, Philippe Gerum <rpm@xenomai.org> a =C3=
=A9crit :
>
> Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
>
> > Hi again,
> >
> > To be honest, I don't really  understand the answer.
> > On xenomai 3 we create a thread in the Xenomai domain and we must not
> > use Linux syscalls in order to avoid "migrations".
> > Is that so different on Xenomai 4 / EVL ?
> >
>
> Absolutely zero difference between both. As Jan mentioned already, the
> 4s delay before the issue is observed is a clear hint that the evl
> watchdog triggered, at which point the faulty thread was forcibly bumped
> out oob mode to keep the system in a sane state, i.e. avoid complete
> lockup.
>
> The watchdog triggers when a rt thread keeps a CPU busy in oob mode
> without relinquishing control to the inband kernel for more than 4s (by
> default), e.g. sleeping in some way, waiting for a resource to be
> available, whatever may cause it to block for a while. This is
> transitive: if T1, T2 and T3 are evl/rt threads operating in oob mode,
> switching between them on the same CPU without any intervening switch to
> the inband mode would cause the watchdog to trigger the same way.  You
> may want to confirm that you are indeed facing a watchdog issue by
> changing the 4s (default) delay to, e.g. 3s by setting
> CONFIG_EVL_WATCHDOG_TIMEOUT to a different value. You may also use
> health monitoring capabilities of threads with evl, see the different
> ways of catching the EVL_HMDIAG_WATCHDOG event at [1] (i.e. POSIX signal
> like x3, or observability which is x4-specific via
> evl_set_thread_mode()).
>
> IOW, you need to check your rt loop code for the presence of a
> blocking/sleeping state which guarantees that the inband kernel is going
> to have some bandwidth to deal with its stuff. This is the normal case,
> busy polling indefinitely in rt/oob mode is not.
>
> [1] https://evlproject.org/core/user-api/thread/
>
> --
> Philippe.



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
