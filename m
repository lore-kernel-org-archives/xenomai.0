Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D635FF62
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990398; cv=none; b=GHU+jL+93dqudEAocs0hXXWt8wqzm8fNTPy28YzRB4Rqv7/d3fo8hmOaWp8Ee+QUzTX9eogZziwe9UfhRjPh0jQnJmgVdTtMBH4g97w998gqqywQkgZv8Nr6BjeToBrZScIwkA1UAehyNepLBPCmAWF3yLRiuSmyt4Vt4jJm6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990398; c=relaxed/simple;
	bh=f4dPNlyxyEaTCkJ5b4XOixQKxEHaK0S+o7iVhhLqSfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMG65SeArTvK98Qf+Qjyy2GucxqZYojN+h6ofk0p84RNTPG0XbZLVdIEpKV7XlH3uBvNUdJRtIuKgSHoIv0euHWPDh103WzY7RhjIsmeYuUGgw/pV2UgyJ+BTYc/wGnz1JupXwuU8HxotFsd20IqQCDT+B2ZVOFLYfdWidt0+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LgMQIZ3J; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LgMQIZ3J"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260213134624ab45f488b6000207b7
        for <xenomai@lists.linux.dev>;
        Fri, 13 Feb 2026 14:46:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f4dPNlyxyEaTCkJ5b4XOixQKxEHaK0S+o7iVhhLqSfE=;
 b=LgMQIZ3Js17ehFe8Ts4XyUtS8wA2B4FSHwD5OAPfeiO4nGNlhZdj2RWoDx8kk2sZq+DGtv
 JLAb3EWvoMca+tZUDLqivGGLc1ojSAQ7o1P+nuZZ9YsjsgJ5E1SF1sIuXSNC/wztNu0OYztK
 1nlsL6uTmPem3x4NUGdLRL3stq3fs0+9gCxp3lmGvRUMWbSZEW/ba49tX2TUljfaLx51IwSq
 NET6vT/4OincmvKELCuZekNGcLl029ILWICo9l+e+8sD4IoPDo3XjBNeC6f4AWD67Glmh+d2
 99IuItXcLIHvYK4uoqtQKVyFAC9hj0gw66LtniDt/Rykcw29b84IGqkQ==;
Message-ID: <bc1676399a0535ff5abded03b8dffc87cdb36c45.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH] ci(libevl): Trigger more kernel
 combinations
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Fri, 13 Feb 2026 14:46:24 +0100
In-Reply-To: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
References: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2026-02-13 at 10:35 +0100, Clara Kowalsky wrote:
> The libevl next branch triggers a pipeline in xenomai-images in
> combination with all available kernels (6.1, 6.12 and head). The
> physical targets are built for all kernels, the QEMU targets just for
> the head.
>=20
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>

Just a minor note to all that CI stuff:

All Lava jobs are currently titled "xenomai-test-suite". It needs quite
a view steps to figure out what exactly has been tested. Even "evl" is
currently labeled as xenomai-test-suite.

Florian
