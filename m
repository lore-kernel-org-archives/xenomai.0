Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630F154430
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816052; cv=none; b=iPZGk1sqoXDfE37mCx6+pFqfKoKlBzhKtQQCWOhHBRGvePf7AqzbYEky1t9ct8fqv9cfVs+QiykFdzhEn5gojks1ONklq75JheT142gSvuaUzXYQOimvQyIRS5S/gSOuAjCntlg57zio6LkDnw5SOIYzDzCzPDuHFWEQ3/YYtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816052; c=relaxed/simple;
	bh=8PBVOE6bgjR7ISGFaaDD/VdHAZLsJnBclE6e9Hj/VsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpMPmBoNWEiIi84InpXV6tVVNSHzWknLXSHCtHLTR/wNeIDKGpZRRxrzAC8Fx4iLhRqiREgvTFrqKjnFaaCxP1uZQNpCzNEZb5kJ6rzyz3ZG+vEO/zLFK2rn+smrjbBc4tCuq9iRb1t/jPDfhnj1lhckLyeXqynOrNT3bAc8MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F4M6YTaZ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F4M6YTaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=FNOL64SIQ8PHzz8ZLsbD7qsbdwQsEbmvuIlDMUnAOSU=;
	b=F4M6YTaZhM7gz8zEI5V9fJWXpd6rZfzlif++C1viNffmTKrMdAwFgumx4ivNbT
	yJguAs7FDBWTIV+Ke49HCtm21N5U73H6SFPQFqPiduhks7vhbr2lNwtm2sfXlKTO
	tRIwy1/L91XvIsk7ub0b8fy21wttd+M3f1/YaxFqsP5Tw=
Received: from u2204 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC33qmlx_9nKgCTAg--.27175S2;
	Wed, 16 Apr 2025 23:07:20 +0800 (CST)
Date: Wed, 16 Apr 2025 23:07:17 +0800
From: Haiyang He <aspirestro@163.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] doc: Correct the default value of xenomai.sysheap_size
Message-ID: <bvnm6p65ajubnex3c2m7mqnghy4halsqbfnlvwezt5ybqbqnni@pxlby72ybmew>
Mail-Followup-To: Jan Kiszka <jan.kiszka@siemens.com>, 
	xenomai@lists.linux.dev
References: <20250416135148.1943000-1-aspirestro@163.com>
 <af3a7b56-570e-43b1-8257-9ab99b8c8f7e@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3a7b56-570e-43b1-8257-9ab99b8c8f7e@siemens.com>
X-CM-TRANSID:PigvCgC33qmlx_9nKgCTAg--.27175S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rJF45Jr1fCr13tryrZwb_yoW8Aw15pw
	42v3W0kwsYqw13Ja12g3WkCryYga43KryUCr1UWr45CFn0vr1kGF1qgryI9FyUuFWvya4f
	ZFnYqa42vF1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjGQhUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYxsxcWf-uywM8gABsI

On Wed, Apr 16, 2025 at 04:01:33PM +0200, Jan Kiszka wrote:
> On 16.04.25 15:51, Haiyang He wrote:
> > By default, the sysheap_size_arg equals to
> > CONFIG_XENO_OPT_SYS_HEAPSZ. Ref to kernel/cobalt/Kconfig, the default
> > size of system heap (Kb) is 4096.
> > 
> > config XENO_OPT_SYS_HEAPSZ
> > 	int "Size of system heap (Kb)"
> > 	default 4096
> > 	help
> > 	  The system heap is used for various internal allocations by
> > 	  the Cobalt kernel. The size is expressed in Kilobytes.
> > 
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> >  doc/asciidoc/README.INSTALL.adoc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> > index 60f1f9149..04c102822 100644
> > --- a/doc/asciidoc/README.INSTALL.adoc
> > +++ b/doc/asciidoc/README.INSTALL.adoc
> > @@ -132,7 +132,7 @@ whose members should be allowed such access by the Cobalt core. | None
> >  
> >  |xenomai.sysheap_size=<kbytes> | Set the size of the memory heap used
> >  internally by the Cobalt core to allocate runtime objects.  This value
> > -is expressed in kilo-bytes. | 256
> > +is expressed in kilo-bytes. | 4096
> >  		
> >  |xenomai.state=<state> | Set the initial state of the Cobalt core at
> >  boot up, which may be _enabled_, _stopped_ or _disabled_. See the
> 
> Thanks, applied.
> 
> I just need to find out (again) how to generate the docs for the website...
> 
> Jan
>
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

FYI, I just try cmd "$ asciidoctor README.INSTALL.adoc" and it generates 
README.INSTALL.html which looks well.

BTW, I find that xenomai.watchdog_timeout is not in the table of cobalt kernel
parameters. It depends on ONFIG_XENO_OPT_WATCHDOG=y. Should it be added to
the table?

Haiyang.

