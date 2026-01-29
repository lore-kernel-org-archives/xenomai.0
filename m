Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F237BE8F
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681348; cv=none; b=lsEcn4CvpvB92yK24sNsJYsSLvOACAqf7Nzm+8MHmOyG52RIwG9VeXdewfqhZjKcgDL+cwnjoOV7aXag6iv8wyhTOj7yPOY0KvDfnJPSom1Gdz63+XXt68X7qMnxz3D1HUGJXALb4oMeeMRIomJlP3+5SXY4gJHLzu3fGznt2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681348; c=relaxed/simple;
	bh=k+74fy5Puc6MeGsE1reNkYPa93XQffXGtUvBp9n0/mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKBaeOzwn7g2kUOBlcALvFu/10LZvo0s6u9g9H9KCqtTLBosrGeifiidNILKKC2DGvjOU5GWpbWeEIGFutnB6dEBbj9e7tC2URYqchJicfiwoWjBaoyQ2y+aqwq0RJCjs3wSGiZGwW/jtMCQpdTy0CsARO/t5owNkeSbnx8TU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Myp5KmMI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Myp5KmMI"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359249bbacso1242946f8f.0
        for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 02:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769681343; x=1770286143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+74fy5Puc6MeGsE1reNkYPa93XQffXGtUvBp9n0/mo=;
        b=Myp5KmMIZDqXd6EPBQVRqG4Rl4yPNBWShDoI+onSgpEqGn8SNs9rgZ05y/ZsY5wXmj
         JwbukgzjChM6A7nQmbDZP+PXTQeuPJfUWlEmXf9hHuwyOFtd8cFUuLuqt8e1h+rjZ22D
         H1AXVea3Hu4zht5GNu9J/hXFHaE4MHSFPk7RfEZpo90W+zLgpw3CcJVQZEtyA6H/sM5Q
         bbdwG9pSwoW+U195MNCEjoZKFO3MVe1uwp70qep++n2IAyf7jlyLUxrWpLjpnpY0u2XY
         HAq6gaAoa8Ci0hUBeUK8R2aaORj2RUtBC5AfnlwsNNG1+N/b+qO3+PFY9DwwmLHfQ7nN
         UnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681343; x=1770286143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+74fy5Puc6MeGsE1reNkYPa93XQffXGtUvBp9n0/mo=;
        b=C5H2KeergHfdnskYp+MrgS8gHzmxU2atXtSPE6dr/U627tzDwMX6hz83MlERJ0VHd9
         2S390O7weJ/n/0M/4FAlfcN/rUhhbMD7WTovKEJuc20llaN3ILKpI6nyHfDDeCKY6as/
         VMsswjkMK7ZhihGP3QSgIRiSzKUdpyJDa/ve1sZsGvcug1TVVlEOSzDYYn1v3Uj7Ne5A
         3r1UR+O7815Safa+KF8Gi8rCKUU1eJkK9XbtNGbJ/TmqfXjWKaaV06o4HZhcFv4d/D5u
         W+AKHSdDecH5eErPMvAl/yvT5QZ/j0w8+ljAeu3vL8IZxgSXZSdr8J5Q5DbKXHIxZRGI
         wnRA==
X-Forwarded-Encrypted: i=1; AJvYcCUK5dxAecnETBkIq7Dw5EkHhaqJNAtgnaAPZN82dTAJqU0In8NWq9CFldDZ+Z+2sY81vqep8LWJ@lists.linux.dev
X-Gm-Message-State: AOJu0YyN7h8VcdNjLKFuossmpmPNfWzHrDUc1gQwdHfqTUwTJQBCguen
	BM7RflxdSr2+O/HDC39FGX1hI1DMDRGSL/TZT7lnC+zdhqcD5u344cJnj8hyfKB6ibIjENLWm4H
	ee5gR
X-Gm-Gg: AZuq6aIg1/CEeGwu+Qp1tz930Xx5dPrkfm4mv/oHMDx9bbAuo5zcBDWXpkG5WOYTXm5
	ZuYaD+/vZIbiXqNQKaYriLDJ55FJTcKuc1bWbawWui1PBO9n8dS3dNaD+9G+owOeIe/NkrI/g3t
	tDbfob0DAy0Ax2D87ELnEN3UNtX1knwgMU+lERhg+0bw5XENauS3ioFVs72EP/eHQOYzvSAiDWH
	sGjzVak3VTtfY6UBpWJGIYKcPgH1nbwY08vDUOMvco0oCsLY40QPKYxaf2Y+j9itbFPyf7QdTOn
	kEhma9E/pB6q8Ma6PqnD6FqyF/pE2xwJxPRIr3W8u4ZtABgbbFrgjtDnMw8KO3msniIUKoaB6I7
	ZCv8emgD8nQ5XqrdyPAgfYXNC7uL1AG21YkxfmoQtuLB87FRoPeC5kPlOb8GKEuIP89P92iOPS5
	ga0KWCTgtIQY3kYVtOgvp5L+U=
X-Received: by 2002:a05:6000:1a8b:b0:425:86da:325f with SMTP id ffacd0b85a97d-435ea0e62b2mr3478244f8f.27.1769681343338;
        Thu, 29 Jan 2026 02:09:03 -0800 (PST)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm13048179f8f.24.2026.01.29.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:09:02 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Cc: upstream+xenomai@sigma-star.at
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
Date: Thu, 29 Jan 2026 11:09:02 +0100
Message-ID: <9873549.lNWL4n7ouV@nailgun>
In-Reply-To: <64c4befa-111c-43c4-ba24-5f079e17c4c7@siemens.com>
References:
 <20260127213927.26960-1-richard@nod.at> <3506084.tBmWVcJkqe@nailgun>
 <64c4befa-111c-43c4-ba24-5f079e17c4c7@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Donnerstag, 29. J=C3=A4nner 2026 10:57 Jan Kiszka wrote:
> On 29.01.26 09:36, Richard Weinberger wrote:
> > On Donnerstag, 29. J=C3=A4nner 2026 08:45 'Jan Kiszka' via upstream wro=
te:
> >> On 27.01.26 22:39, Richard Weinberger wrote:
> >>> Ensure that the task structure remains valid until the join operation=
 is complete.
> >>> Previously, a race condition could cause the structure to be freed be=
fore
> >>> xnthread_join() accessed it, leading to a use-after-free scenario.
> >>
> >> Where exactly? xnthread_join performs some checks for the existence of
> >> the target, and it is locking it (find_get_pid).
> >=20
> > xnthread_host_pid() in xnthread_join() dereferences the task struct via
> > task_pid_nr().
>=20
> Then then next question would be what is protecting the task struct in
> case of userspace task. Is this here only papering over a more
> fundamental issue?

Hmm, for userspace I'd expect that Linux frees the task struct only after
the parent fetched the exit code? So, after zombie state.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


