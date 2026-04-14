Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7123346B4
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152237; cv=none; b=ZIJ0Qh12JpW52V0K7DhMbS9Jmh2T8Uxfi+4SZKuiJbL/60CalpenwmJSh9TxuNJ8d2q5dGHjL8pSe3YU8GVUfugNFw0Hsgt6eKhRg56gxfVE3kJPZYrwhWkuFSAUDYA5J/GgVKwkmcsVu+Y710TasZR+1I1ThWhgte04MdgPAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152237; c=relaxed/simple;
	bh=1Dst37xHVFxIQHbYi5zjlm0TRoOXdU9mv2C2c9nVx7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Av0thkzWrhHNvb7BvhkOALvrf8KYS+UaTpQTbViy+WlH1+WJu5Aru8aIPOtszH9IrSkmfLZAD1eBYfAfMKCqivC4LkL6DHRIkzunjl/nn1Z15UT04CzW2vbqhg2nkk6zQVfUgpRyxkl/e0AG4sNtdM5wiy2luWqVEE2RIN9hego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=g7k3aYOW; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="g7k3aYOW"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260414073703f57b84454600020794
        for <xenomai@lists.linux.dev>;
        Tue, 14 Apr 2026 09:37:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BIqWQ49sVUp4NLEdwXs8lp4pmboRsAjCiM7MDw40cQw=;
 b=g7k3aYOWcvhlffHqp9Ig+5OEiJT7ajc2wB/8SGKXCAdyh6mXhhEcOUIQhkPHXrNTCgvZ5Y
 Eb/JVpqZHMYReKTemtfYEtWnUsspNQavkeiFBVwOxj+6NMyKCfIh8S/FxmG6FkfJjrdmjspa
 8AxCrpG4HSTFotHRkIMXcrMCM+1TLkgNeY3WEgijW7tSEUBxj4ZNCZbsJyNHRZeUzFMfvHLu
 418BFHa9AxLf9ZD8xdblHByLaA7JmVO7RbLndp00nNdNLW9zavKkgFV5bVu0k+quw8YFrhpY
 EnpUtfNfrbDw4BosG2dg9XGlCfXrerHT6M5Jy/PUIMN0Xc4CqbcjQOsg==;
Message-ID: <e31e14a3ff9eb52ff8db44f23e3a5a5ad29a490c.camel@siemens.com>
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Brandon Ho <brandonho667@gmail.com>
Cc: brho@relativityspace.com, jsridharan@relativityspace.com, 
	xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 14 Apr 2026 09:37:03 +0200
In-Reply-To: <87h5pe7lvg.fsf@xenomai.org>
References: <87v7e8yzhj.fsf@xenomai.org>
		<20260413181929.1801013-1-brho@relativityspace.com>
	 <87h5pe7lvg.fsf@xenomai.org>
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

On Mon, 2026-04-13 at 20:31 +0200, Philippe Gerum wrote:
> Brandon Ho <brandonho667@gmail.com> writes:
>=20
> > Thank you for the responses! I recently came across the
> > `compact_unevictable_allowed` sysctl option and it seems like it could =
be a
> > good fit for our use case. Setting it to 0 would prevent the kernel fro=
m
> > compacting/migrating locked pages, which should eliminate the minor fau=
lts
> > we're seeing during compaction.
> >=20
> > Could we possibly set `compact_unevictable_allowed=3D0` by default when
> > CONFIG_EVL is enabled?
>=20
> Definitely, yes. Thanks for chasing this issue down. This patch is going
> to be merged upstream asap, you may want to apply it for a preview.

Targeting linux-evl or linux-dovetail?

This is of interest for Xenomai 3 as well, so merging on Dovetail-level
would be nice.

The same applies for the documentation update. Once we have it for x4 we
should consider that for x4 as well.

>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7bf469354faf3..759af896a5c7b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -648,7 +648,7 @@ config COMPACTION
> =C2=A0config COMPACT_UNEVICTABLE_DEFAULT
> =C2=A0	int
> =C2=A0	depends on COMPACTION
> -	default 0 if PREEMPT_RT
> +	default 0 if PREEMPT_RT || DOVETAIL
> =C2=A0	default 1
> =C2=A0
> =C2=A0#
>=20
> >=20
> > https://www.infradead.org/~mchehab/kernel_docs/admin-guide/sysctl/vm.ht=
ml#compact-unevictable-allowed
>=20
> --
> Philippe.
