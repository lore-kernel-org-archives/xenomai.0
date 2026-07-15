Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845C438486
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119119; cv=none; b=pR8u/O+RF8TBeGazHpxoqahtl5xH+5NELyVSfTf6QLZyV0qSmG018cwvljiPTtxetlcVssLFJCnD8m7Jl4pA7MJVOOXubGjBKcFHMO9EfDDWOptVrfdsIKLTHGwE1m0BeV2aEFStjD3TXeQZnk/JFstqhPPCq5qzXPxHkLTKo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119119; c=relaxed/simple;
	bh=ThWhV5Tv5+pY/4ccYpJPbsUG7nKsAq0o+5Zl2LPPH0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qx5kQzjcOkfPG6LbZomlxAeJQ5jC4ljiNvGsf5lxH5kt/YwRVm2W5UZnBNOKh1/wxncP6MZeGQ+WIUxXrPd6mVo6YmhKND9DWwtWwRaVR6vBh4NzquRJFJYIha/ah743CZuL5SSpMkntg99/eptboOTqvUM1Ry9YDfaekim4gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LkosoyqR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LkosoyqR"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27C793EC91;
	Wed, 15 Jul 2026 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784119114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcSGCf0vdq6j22DN5Yj9lG26J8vsl6rXTpXHhUMAnE0=;
	b=LkosoyqRWAwJDQiT+3kH6S64k6+EbsHAAAmQcW+onMd1nxJHgZk8Gc0gg50Dx2GaLr901Y
	Lt4N79QqgIhzCgHhgjKEw703nKU3DxLNqjWsrSxyLCIVD4dvjBqRHA8Q/vhe/AnddlNlpR
	twuLH+8OXb9nIApgVTghOm4UU6qAJwt5I92EIIDCVQBqFuW+5OnmygeQxPivfU6xhnrs83
	f7cd77/0vu9bUtX+G0qaX33JWi7wIRASPfkcnZ3N+ceI+X45VxH4B4xFke5ePLsi6c1mg2
	qeAPey5h/O8C48P08okewJXS+vUPSSdfaVKvMck8aIZZGuyK/8+n2fecB1KavQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH xenomai-images 0/3] longterm EVL testing under load
In-Reply-To: <20260715092822.223712-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Wed, 15 Jul 2026 11:28:19 +0200")
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 15 Jul 2026 14:38:33 +0200
Message-ID: <87qzl4l96e.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGo/P0vjiFUrhU4TMH47Wbd2iruSTNYEtxQT964nyqrTqT4cFs/PmwaU4J9er4BhGbhqX7T/DOj1yL7cdOQQe+PsieTxQeHKPr2nxjdalNs2k1vH5rC4aWvZQoo4hzUF1rJoDkMGI8dPiqQjnArubKMzhbCPrdtCR7zJlRxrQ58Dn2R0CSjH1qZMMjHqEU7I0yOVqUrkFSHAjlf62r6eO5df7fx1kpLb5uYdxHHR1zATUagyIzp1KRx+oqJNy0wOvjJUGDet24DcIvhQSelVIZNECNCwk38RlzL+y9u4nQq8QYEVsCvvf30x4sYwmkGWRPmaD895G/loFGa9JvclLHHiiQBFDShlB9EQRXAWN1l090gdHn6XKWPio0WXANeOh6bkrchQ+jMQBsTuEFPriaUeX8f/aCDmqN0HePjEc2Lh8zJy20E6P9n8KIcXQKT4YjmL+Vvqbet4+pZudRDsMPJbINNl01XeppfhS9PoCo7z9ma1LfMn8tQeI/18CiopPnGYSlgrzhdEmaaxIKsAhynxkk7uS382ftPDUVegR9W2dOB8gTPsBmF0PBylMfBo+m7U2Z927ePRLVeoMLEjlNpel73IktAhUoeqpeMYLgnKDVwuGPQt7vOfUGwHUk4QhVO6w4MR+ry9Che54xuJlKHS356c+yJgk6tXE4lkisC+A
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

>    latency threshold is exceeded (150000 >= 163.951), aborting.

Even the printout looks wrong.. Fix pushed upstream.

-- 
Philippe.
