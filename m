Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261D30170F
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932019; cv=none; b=tZow0Ce96TtyEVoMetuElKxiCWZIav/oS01CQkFMXQhfUJsAhKxYRpuzXRkd+AjAUc0WxTjTWhhSzRwbMJF+jhW5x7iTZMnFjLi1KEXx4Cdz//dJkg1VOVcuQFRzh3HwwCCH+Rrd5z2NW4gnPq+dGl/PliCrxK7tzQJdqLQ3/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932019; c=relaxed/simple;
	bh=FJVY+t0josjHmpE/GP3sedyUFEVmoDCNbwYgVq+wR7M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBVzQQfnI0ERLrND12M/dBgFMLlGkrRVE4xEqnJPjlx0EtHio6Bn8E3QyKKlmqguKN9+//q8c+t6Tu2vyJlGX1vGFNXZ8S/MeVvMZLZz2OIfq7RR+VLoOrlJ1BDTgC4n8uX0AI2RcoOSnKm/HD9vlJNZDXmsYMoZuegM2QhOLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jvYl9843; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jvYl9843"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251205105325038fc29ef5000207aa
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 11:53:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FJVY+t0josjHmpE/GP3sedyUFEVmoDCNbwYgVq+wR7M=;
 b=jvYl9843qhW7m22bcuSRYdJb18LaLGRdFPhaUs6yG544utLfAXviBGFQzdWEg2/c1X4pi/
 DcHixbah2YC5ME9WCbBb+/u/fFl1mO3THEW4BpxZQdwtQRqDghD8GpmmUGW/Y0ANJI+kS5SX
 RzG4NArwKcTrg/8GH8j5zNsRdzsHlmOA4dWAHmcFhB08z839zOtQ+6uC3DfhKEV8GkjVw9Z3
 tYImNOCjneUImh0QZMH96EsPtyxh1AOHjvzFPN+qln4KdmcSjWGFTuV23uQ6oCfPTYsrutvI
 uF1lMZJf+2ohguvxwedJNZxOK6dFXmBIbZ6BhkISPkEufwaDRzCpKeig==;
Message-ID: <7bf94e8c64a09fc98850d7bc923e2ce47e713f9e.camel@siemens.com>
Subject: Re: [PATCH 0/6] Some fixes for the select syscall
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Andreas Ziegler
	 <ziegler.andreas@siemens.com>
Date: Fri, 05 Dec 2025 11:53:24 +0100
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
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

On Fri, 2025-12-05 at 10:03 +0100, Florian Bezdeka wrote:
> Hi all,
>=20
> this is the result of a short debug session triggered by Andreas who was
> staring at some strange select() behavior.
>=20
> The issues were introduced while working at the y2038 support, so
> backports should go into the stable 3.2 and 3.3 series as well.

Still true for 3.3, for 3.2 some more details:


After looking at the problematic user again, we realized that there is a
different behavior regarding select() between Xenomai 3.2 and 3.3.

3.3 comes with the following commit (see Fixes: of patches) which
aligned the cobalt select() implementation with Linux, by doing the
additional normalization.

faef02b5e76f ("y2038: cobalt/posix/select: Refactor __cobalt_select()")

That was done to make sure select() behaves identical under Xenomai and
Linux.

To harmonize 3.2 and 3.3 in this regard we need to backport the
mentioned commit upfront. It doesn't apply 1:1 but seems doable. Not
sure if all kernels still supported by 3.2 would build, though. Needs
checking. In case some users somehow relied on failing select() calls
they might be surprised by a stable update.

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


