Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AD17BA1
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881071; cv=none; b=alvvMroeJRgEIT8Ifkj4P7v+cqKSEi/LyJvhSj0tRYngurKWRlbCbfjayzQafAnnRdS9Kb++TVCHkejWymr8Nje1rqR4onc7mFTsUyYHKToGKIUz7BfPV1t3bCnTDET1HS+P/juHtzTlRoojsW2utv5BgVHMCAX7X+Cje0/qFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881071; c=relaxed/simple;
	bh=8EaKAGlZ+f4vmdLwmanPkc3gUumRuNLRqLA1wy4cyh8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbssLmnXlcxCq782gOR0LQ9zHwhupFq9eir/lU1jjzravFrwWklrrwabQGAVsjhRBMjHG8HfhR9woj1LFI1OS1Wh5rJfBrQWHMONmQmeMG2BXdUIcaDp5mrdjllQH7m+F6NVZScK6CMozxCREe0MQHddWEdAbJR+HX3szQfx5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qeE/OqOO; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qeE/OqOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ycOHWcOBUC5tGy4HQfOEB3EPk0nqwYhS+jejnaq2LEs=;
	b=qeE/OqOOKsXroSuh7MqEDOFm9/ag0osYc5ULHbH7MQ+PdpSo/fm0d1rK1So+5p
	MnrBIOmIaONYwhyU/kS2H4nCoIb6ZI+unfOn3r8/DI4Tr5ZG0hTd/2Nm3oG/v2ZF
	Wqy/sBorsXiTrf8qukLuCgaNVEHTTiuoNmNQuBd0jmE4o=
Received: from u2204 (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXTqlilWtoZX6KDA--.8427S2;
	Mon, 07 Jul 2025 17:37:39 +0800 (CST)
Date: Mon, 7 Jul 2025 17:37:38 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
Message-ID: <u26x3ade7f5g2o5t2stqvb67k36o3xhpyo2ppuuoat6dfzy7yu@fdk6gbnresb6>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250705135610.217774-1-aspirestro@163.com>
 <61d4d7521138677983a987639ebf6dad4fe3ae72.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d4d7521138677983a987639ebf6dad4fe3ae72.camel@siemens.com>
X-CM-TRANSID:_____wBXTqlilWtoZX6KDA--.8427S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryUuw48ZF1kWw47XFWDArb_yoWrGr4Dpa
	nrta1vk3ykJry5Kw1Yv3WSvryjqFZ5G343C3WUGw18JF42kryj93sIgFy8uF9rZw48tw10
	kryDGas5JF18ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zizBTwUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwGDcWhrkI1wjQAAsz

On Sun, Jul 06, 2025 at 10:35:03PM +0200, Florian Bezdeka wrote:
> On Sat, 2025-07-05 at 21:56 +0800, Haiyang He wrote:
> > When configure with --enable-registry, it fails to build regd/fs-common.c
> > caused by strncpy. Using snprintf instead of strncpy ensures that
> > the destination buffer is always null-terminated, preventing potential
> > buffer overflow issues and compilation error.
> 
> Hm... I have --registry enabled most of the time, so I'm wondering why
> I did not face the same problem yet. Some questions below:
> 
> > 
> > $ ./configure \
> > --host=aarch64-linux-gnu \
> > --build=aarch64-linux-gnu \
> 
> So you are building on a native aarch64 machine? That might make a
> difference. Does something change if you just remove the two lines
> above? The compiler should be selected / detected automatically.
> 
I remove the two lines, but it has the same problem.

> > --enable-smp \
> > --enable-pshared \
> > --enable-registry \
> > --with-core=cobalt \
> > CC=aarch64-linux-gnu-gcc \
> > LD=aarch64-linux-gnu-ld \
> > CFLAGS="-march=armv8-a" \
> > LDFLAGS="-march=armv8-a"
> 
> Same problem with the 4 lines above removed?
> Just wondering if we set a nasty flag somewhere that breaks the object
> size detection of your compiler.
>
I remove the 4 lines, but it has the same problem.
> > 
> > $ cat /etc/lsb-release
> > DISTRIB_ID=Ubuntu
> > DISTRIB_RELEASE=22.04
> > DISTRIB_CODENAME=jammy
> > DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"
> > 
> > $ aarch64-linux-gnu-gcc --version
> > aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> 
> I have no aarch64 machine for compile-testing at hand so I tried the
> following (cross-) combinations:
> 
> x86:
> - gcc 10 (from Debian 12): already fine
> - gcc 12 (from Debian 12): already fine
> - gcc 15 (from Fedora 42): already fine
> 
> aarch64:
> - gcc 10 (cross, from Debian 12): already fine
> - gcc 12 (cross, from Debian 12): already fine
> 
> Result: Unable to reproduce...
> 
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
> > -		__dst[sizeof(__dst) - 1] = '\0';			\
> > +		snprintf((__dst), sizeof(__dst), "%s", (__src));	\
> >  		__dst;							\
> >  	 })
> >  
> > -- 
> > 2.34.1

