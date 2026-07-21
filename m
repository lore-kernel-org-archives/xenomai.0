Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6543F4D5
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621613; cv=none; b=i/hAKaLKQYRdAJ9I84eIqpuP3h6VuCaRlU2NB1Vl0SOsUoz1OwByHVjjUp02PWOZK+IM84HzaDhDbSMR64PrVZqiS3rUgRkKzFMd4v9GsOgpNLF8W+Md2vkE9xSzOpFm8La3dBaGiVE58I54dj4VWH5n0RibbjPDIgNQRQMnxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621613; c=relaxed/simple;
	bh=/HGvTDhWy317dMefYJbUDup+CKIYwyj+3wbe9P7LTIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sV/7RmZjiDl6FNO167WXLJtVMjUHgqNWnOarNX/zjhQDY7tzoiZBY3qRiOppYK57XIbzGlIBfdajThDeATpuN4c+NMFl8h9RzW7/xshyRCQKLh5cTQIyiJfGw5PT+Gd8CnIA/8ml8taZczv9syBWyr8Xcilt+78YWiziGLGhqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=UbPjqwOx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="UbPjqwOx"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 947971F6BE;
	Tue, 21 Jul 2026 08:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784621603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASuRREcBpabsCJelz7ARqu9SUryPxVbhrpNZ122adkg=;
	b=UbPjqwOxd6C2lpdslKKpn7xO819jM4n2LoEO7zlZtnP+0QxUWvGTNcXs6zY/TjSEVqyRgD
	BbkhW89CVVWtnqQ12GOHBMCZhbRzvJvIt3LkwX6jIQ+I1X1F6v79dOZ17Dz8AgDCDKnLoV
	gRFKttxjZgOwj502R2/7Ukx7kInB9ztZzKxSLKWwXHhPwQnEEvM9ah9GivmKfaYmEywFSH
	NkBKGWLUuS/+3E05vbM5wh42meDndiCZ/pmCof9BSGIE1wtjCtmFg4SZvj0wftE3dcabEV
	YTNS9d64YNpnNpq5Qud7lWFg4Aq1SV/a9nBy/MbY1OlnZ1O8pGbFG53TihzFXQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev,  Tobias
 Schaffner <tobias.schaffner@siemens.com>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 0/1] libevl: Add debian package config
In-Reply-To: <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com> (Hannes
	Diethelm's message of "Tue, 21 Jul 2026 00:22:59 +0200")
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
	<60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
	<2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 21 Jul 2026 10:13:22 +0200
Message-ID: <87mrvkkbfh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGG1GYAstYSVyG6awa1VPXhS7lwb0F52mjnhI6qvnzEzn59jAwjzMbO/jYcC/hYko5O06sUeRLK/0LyP3bIJYQhIBA5dSPicNdzuksWw3iHbNUOmMJKr+to27PF/fZLbiRMQPgAUZbOsHyEVUZLLoQ4AT54gR3ziqurei+zCq8PNNftPd0tYDijAkGZmpJHn5b7iTVMYopowAEx8hmkTNlM1UDJdvbC5Dobn+oBrwAlIUkwG+LMqPHdJaIeFk1rAKOwESaHJRrUhSHjg2KSNEn31HiohhDgHsUy0epUS0blYF85AbPFbK/fyzQrq+uRuArJUXjCVzsjU1BsoicDZ9DoV+mzu2T1f8zvZ0sPcI3YNluyB62lhJob+rg7w/es5b+rfWIwja5SIE7CS30AY5M/2eip4l2qiHSqFYh8GTqO4bpxSgS8s3pBmeNAkiGqUn8xYiE7/Nyv7OKA4VVhCq+eBGq7ZilYipo/gupVIXmggcor7uPy9jHPB2cooEGmoqaOaOqBBguFVD7C/SEJoSNgAZlQpsdejdYbTctuRmP44yp6QvbTojfo536Zz1rHcUzmFsYct/ed1CUKdtslJ/GHLpT4jPpnomrG4pMWjOqQr76ZnY579bWucjcbOUmxi+V8Uw2jtUFRg1Jh00M6shk0sfk7NEDcUVMH/Z88tNI1Eg

Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>
> Version 59 is not really correct. The kernel has EVL ABI 45. Libevl has API 36, needs API >= 45.
> For kernel dependency's, the ABI version is important, right?

We have two distinct revision levels:

- the ABI level between kernel and userland (syscalls and definitions).

- the API level which is specific to libevl, allowing apps to determine
  whether some feature/routine/behavior is present or not. This is more
  of a source-level thing. Multiple API revisions may be compatible with
  a single ABI revision, and conversely.

You will find EVL_ABI_PREREQ in include/evl/version.h, this is the
minimum ABI revision which that particular instance of libevl can work
with. This is what you need to keep in sync with the core available from
the kernel part.

-- 
Philippe.
