Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8822566DF
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881493; cv=none; b=u4HpCFZbMLGYnB59R3iq9jEeojiOeRjEM32ZBRxU7CQMqoUCKI2NfTOKQ6BuXk1L2/OMjZudqv9hNmsXpYHl7JnqaAT7IomELtGuDrcewGb31gwYeJKbBmFwMAS2JteCXer/17pLj6HpPXxyJneQXt2G+6lTb73txp2ApE960Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881493; c=relaxed/simple;
	bh=vBzK/V35NlMlcROjdPadSMpd6cl4BmWETleX6Xj2zkI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKiRGF/iyhUzTVgTTasI3VfBCJvUqTW2hukOeUzAJtb/ma2GP/tDNMGbrCh+67mfBsclmA1HJ6dUmJTXbFsfBtKoBp2gDHfDceq8NmlceIuqmaGjbLXQJAIQEbYxuz5r5de0cJtRR+tQFjPesjHvlUyAmjOLLdIMNJeMv50zyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oXbB/3Ed; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oXbB/3Ed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=By3j78mSo3wMaEiR3p+gQoOG2qymcPG+iqlKaJDASZ0=;
	b=oXbB/3EdizR3e4uvTaSUKHXZ3xD1GiFkLd/ZqsXPbBh/8QsyzDBQtppFg9nmGe
	CnB+sY4Piacc4IfRw1f+FJvH5E16T5exKuVLhCt5rgf+48pHbFPhMMU27A92u/4J
	dOnMMelXEJOtYQW/WKZqip5pGp+Q+zxIrFovzfglxeXb0=
Received: from u2204 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD339cOl2tox0k9Aw--.55976S2;
	Mon, 07 Jul 2025 17:44:47 +0800 (CST)
Date: Mon, 7 Jul 2025 17:44:46 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
Message-ID: <yq6xdecuqpn4i3sf2koy72wq24dbfx2qe45v7yrqc73vyrkysa@k7c3eazthgko>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250705135610.217774-1-aspirestro@163.com>
 <3de47756-65c5-4eea-8304-dc56f70aa8e0@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de47756-65c5-4eea-8304-dc56f70aa8e0@siemens.com>
X-CM-TRANSID:PCgvCgD339cOl2tox0k9Aw--.55976S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryUuw4UWFy8tr18Cr1UGFg_yoW5uw1rp3
	ZxtFs2k3ykJry5Kw1293Zavw1Yqa95G343C3WUGr1kAr12yry2vrnIgry8WasrXrW0y3yF
	9a4qkas5Gr18ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioUDAUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwaDcWhrkI2WBwAAsY

On Sun, Jul 06, 2025 at 11:34:09AM +0200, Jan Kiszka wrote:
> On 05.07.25 15:56, Haiyang He wrote:
> > When configure with --enable-registry, it fails to build regd/fs-common.c
> > caused by strncpy. Using snprintf instead of strncpy ensures that
> > the destination buffer is always null-terminated, preventing potential
> > buffer overflow issues and compilation error.
> 
> Thanks for reporting the compilation issue. But this is not an overflow
> issue, just a confusion of the gcc in Ubuntu 22.04. We are properly
> terminating in all cases.
> 
> > 
> > $ ./configure \
> > --host=aarch64-linux-gnu \
> > --build=aarch64-linux-gnu \
> > --enable-smp \
> > --enable-pshared \
> > --enable-registry \
> > --with-core=cobalt \
> > CC=aarch64-linux-gnu-gcc \
> > LD=aarch64-linux-gnu-ld \
> > CFLAGS="-march=armv8-a" \
> > LDFLAGS="-march=armv8-a"
> > 
> > $ cat /etc/lsb-release
> > DISTRIB_ID=Ubuntu
> > DISTRIB_RELEASE=22.04
> > DISTRIB_CODENAME=jammy
> > DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"
> > 
> > $ aarch64-linux-gnu-gcc --version
> > aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> > 
> > The output of build error:
> > 
> > make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/copperplate/regd'
> >   CC       regd.o
> >   CC       fs-common.o
> >   CC       fs-cobalt.o
> > In file included from /usr/include/string.h:535,
> >                  from /root/xenomai-next/xenomai-next/include/copperplate/heapobj.h:24,
> >                  from /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:27:
> > In function 'strncpy',
> >     inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:248:3:
> > /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
> >    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    96 |                                   __glibc_objsize (__dest));
> >       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> >  include/boilerplate/ancillaries.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
> > index c8c209deb..8de353ce8 100644
> > --- a/include/boilerplate/ancillaries.h
> > +++ b/include/boilerplate/ancillaries.h
> > @@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(void);
> >  	({								\
> >  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
> >  			__namecpy_requires_character_array_as_destination();	\
> > -		strncpy((__dst), __src, sizeof(__dst));			\
> 
> What if we do
> 
> strncpy((__dst), __src, sizeof(__dst) - 1)
> 
> ? Is the compiler silent in that case?
> 
> BTW, we have way more places where we are using this pattern, also in
> userspace (lib/boilerplate/ancillaries.c, lib/cobalt/printf.c).
>
I actually tried this method when I encountered this issue. But it still
reported the same error message.
> > -		__dst[sizeof(__dst) - 1] = '\0';			\
> > +		snprintf((__dst), sizeof(__dst), "%s", (__src));	\
> >  		__dst;							\
> >  	 })
> >  
> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

