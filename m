Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502A388E6E
	for <xenomai@lists.linux.dev>; Thu, 14 May 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786942; cv=none; b=Td1kgJFxUh9mzl8W5X2++dJchhjXywRpYL3TKrwFJ6M1fnxJF2tbaU0Uioh8s782y27ausdj2rZUoAvQS89EYSFCQ82LOLSoiMDxROB8lXNvnM3dFlKfXZnYqNW3NrXXGxBW97z/pJbEkWy7ERaZmryFU2Vx9rO8xy08BQhQSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786942; c=relaxed/simple;
	bh=fhRG+cL8Ow6g2NywaN3g9uYcrjVdzGA3XF0W15CiP5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmiJcMHpgY6AMRxaNfJJa/ZtbngkU4pHFuTLPsEIcHShrQ43rZ4fLwTL3l/+V59Y+fr0CikILZ+wmnLcdX0V8ZgZe1yjHlk5ckBR/6trXmXAw4+nCF3AWTRTDF5rC92iCK9wv4ZiX2jWlb45DXX/cBKEtRrN8AQvty+BXDoCSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=eaGe1FEH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="eaGe1FEH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDB043ED75;
	Thu, 14 May 2026 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778786932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4cYVVoYvxqKt6PUH4ftIguLv+GZu9JiMkkaNAJl0os=;
	b=eaGe1FEHKJ2btaTEXPHsU4W9ckJV0nAdtAMDLBt+9hjSeUKQrl7AhAGJid1Ke/i7F9DGkG
	eruJztOX8hF8bpCJR5iPGC2rew0oLhISEHN5z0nFBaa9Er+uOQ5Vr5iVW9085efGTIeozg
	s2AKMhUGt+YrKkDj4OOIpgS3H2SJj8pxj40bQuN+kjAwdxnzdoem2R2eOyPQxKifNLGgPi
	NQlGE0QC2JtqSjn21Y5PqNc0GwKageFQGY/h8BM91/PqvLLeNGdCiLMs7S8OH23NkRkqxW
	fEAoMSkgkFkEVxTHLgieNTYFo/o9+h3oC8EkbS732t9GkMjDEoCvVChUi/q8FQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jay Sridharan <jayasurya.sridharan@gmail.com>
Cc: brandonho667@gmail.com,  brho@relativityspace.com,
  jsridharan@relativityspace.com,  xenomai@lists.linux.dev
Subject: Re: [PATCH] update caveat.md about memory compaction
In-Reply-To: <20260514190207.40567-2-jayasurya.sridharan@gmail.com> (Jay
	Sridharan's message of "Thu, 14 May 2026 12:02:08 -0700")
References: <87ecjpj88r.fsf@xenomai.org>
	<20260514190207.40567-2-jayasurya.sridharan@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 14 May 2026 21:28:51 +0200
Message-ID: <87lddlhjt8.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFyVv12qDPK/RE47zxx4UXknJetQvTFcgMhEMKU0IP2CRa3WYJPVl11J0G4z0tQaVg96B9naKZHQZnrrJ3l5eoH36jdieDVcDQLGagO4pmGIUeQp7ICE++3dwx5e7UEUf9BESC+IWFqGdvx6O6ctFAJrdx436K4PvUyhLDo1erw732SZgrCtk3O/52ElGGNUkCsfQ7itTLrCyewiexYAwk32VwtY4VOVBL7o5S0/+33DDw+TaMtUjVqVXQW9IOmZUUyGHYGZfqsTQeYq9pbkvtdURqMh2h5WsXYM1zN+NMf+EHNG1zq90y4GpNIGpU07OSsjXlRItf7aWFKPkO/R+Xxgz0A6BfH4xWwzoqsAfcrEap84J5OH4A/ktt/fggqRrTf0NUYFJtUsBD3845Kdgw/sw70zI3TMbl9cvfiWuCT2uxq1Gs76Ir4tTDDCQDjDWXgifo5ivskop71m3wPSWl4ntGcgsp4Zio29P3ubl0nxM6UcAen0Ag1YqI0iXOcBeIHF7Hok55f0Vw3EEobIi9oXXROt7RlkD1Jr2kZcKvOqr+DS3zFbULKR3qjBjKrc8EqhJq7JzTpwsNykan6ZTkrsyOjP5CY2RSn4H/BGbzcLLgeAfjnPj5hbSIwn2Jpcq0Z0uM3yAVibmqKVPyTUtpuVwBwgfOrEkIhl2OKST3LBA

Jay Sridharan <jayasurya.sridharan@gmail.com> writes:

> From: Jay Sridharan <jsridharan@relativityspace.com>
>
> Thanks Phillipe - maybe try it now? First time sending in patches via email...
>

Merged thanks. The changes should appear within minutes (i.e. after the CI run).

-- 
Philippe.
