Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2017F4F6
	for <xenomai@lists.linux.dev>; Fri, 25 Jul 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446391; cv=none; b=g6avVpGs9lcJO8VbmwXu94pYYxq6blEVRDvuSJ6C0gW7bj2cihkf5srit23Y+twKDDi7wIFr91n9lWDgPmwcX0WVXsZDob8J6qRP47AT4q9lqUc33T7H6JIfPxQTPbc2RCFlXIcVITbLmwPKLnbr8vVguYwF+2GmR8YWbWhZA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446391; c=relaxed/simple;
	bh=glrBmuiHM4ye9K2zy+0SuhhZWhiele4vrnw8MWz9aMs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaW8GFwTakmSOvqq9ss26zsF5CHClgovQfg0wAJZu7Jh9CoW/P9F2+2RAuJfqZMGPalEWO8Xxs6Vnk8mnq4X5XxY7+LXft/GUdr9Fu7uBH0tJQdov+mKnvYv7rWmgSel859vn3+fEJA6UHs7y25EEYHt6v6WdI7rK7A/kzlaqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BkIus3bw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BkIus3bw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Ci+wEhcs+aD+/zC1T5/Yv2SLjYwb35emNlzzUOUF2UQ=;
	b=BkIus3bwpCeLOeWRZYgIqH1qexBJmQAm+p8HCrRsS+3YUmbyq1x/62qapUP7aT
	4hakiY2AnPg9XTZsMKW79TWTPD5mT9M9NA7Afnh5ZFDckUOpEl83IwfS07szetSl
	Indi9jiL/lhoZjhAdilcI7lnWyY7xmv5T72cNwDGZeODg=
Received: from u2204 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCH2inod4No0ez1Bw--.16012S2;
	Fri, 25 Jul 2025 20:26:19 +0800 (CST)
Date: Fri, 25 Jul 2025 20:26:16 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH 2/2] lib/cobalt: arm64: Fix syscall macro argument casting
Message-ID: <d277uoith4zyzlgldu2226s5yrejlnp3ndfgznayuj2mbg5kh4@lhosq2w642od>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250724120012.1656476-1-aspirestro@163.com>
 <20250724120012.1656476-2-aspirestro@163.com>
 <137f95aabaf6a5916d4abcfa8b4f384234427cea.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137f95aabaf6a5916d4abcfa8b4f384234427cea.camel@siemens.com>
X-CM-TRANSID:PigvCgCH2inod4No0ez1Bw--.16012S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4fWr17ZFW7ZrWrJw4DXFb_yoWxtrgEvF
	WYyryDCr48u3y0qa15GrW5XF4DXwsrGr15W3WDXr93Ar1DArZxuFZIkrZ3Zr1fWFW0yaya
	k3Z8tr47JrZI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtD7aUUUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwyVcWiDa0fqCQAAsv

On Thu, Jul 24, 2025 at 09:09:39PM +0200, Florian Bezdeka wrote:
> On Thu, 2025-07-24 at 20:00 +0800, Haiyang He wrote:
> > The Xenomai syscall macros in the arm64 header file cast their
> > arguments like (unsigned long)__a1. This can cause issues when
> > macro arguments are complex expressions, due to missing parentheses.
> > 
> > Update all syscall macro definitions to use (unsigned long)(__a1)
> > style, ensuring proper evaluation order and preventing potential
> > macro expansion bugs.
> 
> Good catch. If we apply that, we do not need patch 1, right?

Yes. 

And I still prefer both of them. Maybe more cpu arch would be introduced into
Xenomai. The way in patch1 has better compatibility.

Haiyang.

