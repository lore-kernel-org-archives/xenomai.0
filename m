Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E702E370F
	for <xenomai@lists.linux.dev>; Thu, 24 Jul 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384193; cv=none; b=J5d+QXomgyZCW5xXAxRKvkdr4KLzT8agt5OCd6Zr2EWAsITsa5B6X8UiBNVUn+vseDi4raUtEvyZFKtiyknYhfPtbXg3reJirjgWfmQPWYNULZcTQho8HIZqL2mkIlC0gfjEayn1wDizBB323ysT52pw3tJBSoYnz/fk3N2ZNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384193; c=relaxed/simple;
	bh=sSCY0Xz+PBrwQ8FYM+RoQgMdncTaEiax/Cak0O9PDJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbCIiHyTWmF2MF6txb8OM8umn7B+nVBrDw0XFGojyPS+S/ei0Z4pCT6tRaAavhe+uvo4+Bcd/4APVXzo6+6uF52qvbb2J2Ma7xUK9/mg5kTHgwSq5rH9+eM6dIfoopw9iIuo2o4Jr49G5V0PqwYcjurdHYlp+J2Sbw6okP0riIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VgwIb6rv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VgwIb6rv"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025072419093997202f89377ef2f3f1
        for <xenomai@lists.linux.dev>;
        Thu, 24 Jul 2025 21:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sSCY0Xz+PBrwQ8FYM+RoQgMdncTaEiax/Cak0O9PDJM=;
 b=VgwIb6rvBpTstJTwR49/VcCwauVCVns5ITi8idFcDz0Ddes4C+gCA2q/CchmvOICwjAlzH
 mARtjRxaft4ItJ5un8iTJ+NDvYxPZ8BrODaN69OaWO0YLwy8OJVhupbLR+ZGuAM4zRN8nhWn
 udFUbOnchoRATQYj3oHX7WjnLhESkCMTk1nBVsSyAzPhgQYB724B/+eC149Va7/mZzzMitIz
 rsp+ykY7IFqN3diOUv8kUAmNfb9CE1IOwdZy6BZ5RTzVFOD3zHoO4XgchyQveTK5XFgW1J6+
 Z7Exx5iP0wCoKXgnuvmuQ7bHbJ+AML5vGnw6cR5XQTovs3VL4VcGUMuw==;
Message-ID: <137f95aabaf6a5916d4abcfa8b4f384234427cea.camel@siemens.com>
Subject: Re: [PATCH 2/2] lib/cobalt: arm64: Fix syscall macro argument
 casting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev
Date: Thu, 24 Jul 2025 21:09:39 +0200
In-Reply-To: <20250724120012.1656476-2-aspirestro@163.com>
References: <20250724120012.1656476-1-aspirestro@163.com>
	 <20250724120012.1656476-2-aspirestro@163.com>
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

On Thu, 2025-07-24 at 20:00 +0800, Haiyang He wrote:
> The Xenomai syscall macros in the arm64 header file cast their
> arguments like (unsigned long)__a1. This can cause issues when
> macro arguments are complex expressions, due to missing parentheses.
>=20
> Update all syscall macro definitions to use (unsigned long)(__a1)
> style, ensuring proper evaluation order and preventing potential
> macro expansion bugs.

Good catch. If we apply that, we do not need patch 1, right?
