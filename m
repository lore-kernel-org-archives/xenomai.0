Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94E2E1745
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900204; cv=none; b=jWeBsd9eHrjMnk6m8gnlIsyWcOjebG4YhJivgRVmzF7u9SDwRARmDX6AzXi5lxJHZLEai55hzCvWp1J/kfyvyEbx5cB11+Lf3t6asXOCTD6Ef1Blt1sxuccaz2p36Y64jWycKkLQje3YmLNbt1dIHWivnl3qgGo930A2AY6EIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900204; c=relaxed/simple;
	bh=UQYOgoZ8sRpxSraE/R6sGZhQq6b/l4gRsTFkWFbOle8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc6j4DlhSHYb0SkuSaGUQy0AtnxNjSnxk2nl1R1Idf2QD1Up8co3yUiu80lB3HHiS2GsCPLtYR8iBofp95Lch0aV6qcucwcE3Giw8gcP4uaWP18XSF2LJZUvw2x3M1y4Qu1Hc5hjWo0xn8ZmZrqtFvGW8k/aMZvTDwygExKjhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WRJFzLES; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WRJFzLES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=v1jkZEY8GXVkoFPQtBAjtAo6FA57JG//Qbvc1MNEKZA=;
	b=WRJFzLESJRtglZE7hhfKZMlSSL1oqvESWxL4Felx8+JNeTAYF0xQif+NNLU2eB
	I4BQKbp46CpZwS4RZmZc2Yd8vNVWiA3YF6UpaWcnYXY2F95N10gBABSbEG56GOm5
	xSXh0DIr+jGOr4l5tetMf0pt0I4RgNEvbdpNM8wg03xzI=
Received: from u2204 (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnVwgg4Gto07bPDA--.59494S2;
	Mon, 07 Jul 2025 22:56:34 +0800 (CST)
Date: Mon, 7 Jul 2025 22:56:32 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
Message-ID: <6zsnrkpkohmsllmups4wralh6p673rzchswmymoomlulx2d5ip@f6jkk67xpmfv>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250705135610.217774-1-aspirestro@163.com>
 <3de47756-65c5-4eea-8304-dc56f70aa8e0@siemens.com>
 <yq6xdecuqpn4i3sf2koy72wq24dbfx2qe45v7yrqc73vyrkysa@k7c3eazthgko>
 <588405a0-91f7-49e1-9bf4-a0789caddd51@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588405a0-91f7-49e1-9bf4-a0789caddd51@siemens.com>
X-CM-TRANSID:_____wDnVwgg4Gto07bPDA--.59494S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1UCw4rXw48GF1rKw45Wrg_yoWrGry3p3
	Zxtan2y3ykJry5Kr12vFnavw15taykK343u3WUGr18JrnFyry2qFnFgr18uF97Z3y0y340
	9FyDtas3Gr18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zizBTwUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwaDcWhrkI2WBwAEsc

On Mon, Jul 07, 2025 at 12:16:49PM +0200, Jan Kiszka wrote:
> On 07.07.25 11:44, Haiyang He wrote:
> > On Sun, Jul 06, 2025 at 11:34:09AM +0200, Jan Kiszka wrote:
> >> On 05.07.25 15:56, Haiyang He wrote:
> >>> When configure with --enable-registry, it fails to build regd/fs-common.c
> >>> caused by strncpy. Using snprintf instead of strncpy ensures that
> >>> the destination buffer is always null-terminated, preventing potential
> >>> buffer overflow issues and compilation error.
> >>
> >> Thanks for reporting the compilation issue. But this is not an overflow
> >> issue, just a confusion of the gcc in Ubuntu 22.04. We are properly
> >> terminating in all cases.
> >>
> >>>
> >>> $ ./configure \
> >>> --host=aarch64-linux-gnu \
> >>> --build=aarch64-linux-gnu \
> >>> --enable-smp \
> >>> --enable-pshared \
> >>> --enable-registry \
> >>> --with-core=cobalt \
> >>> CC=aarch64-linux-gnu-gcc \
> >>> LD=aarch64-linux-gnu-ld \
> >>> CFLAGS="-march=armv8-a" \
> >>> LDFLAGS="-march=armv8-a"
> >>>
> >>> $ cat /etc/lsb-release
> >>> DISTRIB_ID=Ubuntu
> >>> DISTRIB_RELEASE=22.04
> >>> DISTRIB_CODENAME=jammy
> >>> DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"
> >>>
> >>> $ aarch64-linux-gnu-gcc --version
> >>> aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> >>>
> >>> The output of build error:
> >>>
> >>> make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/copperplate/regd'
> >>>   CC       regd.o
> >>>   CC       fs-common.o
> >>>   CC       fs-cobalt.o
> >>> In file included from /usr/include/string.h:535,
> >>>                  from /root/xenomai-next/xenomai-next/include/copperplate/heapobj.h:24,
> >>>                  from /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:27:
> >>> In function 'strncpy',
> >>>     inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:248:3:
> >>> /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
> >>>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
> >>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>    96 |                                   __glibc_objsize (__dest));
> >>>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> cc1: all warnings being treated as errors
> >>>
> >>> Signed-off-by: Haiyang He <aspirestro@163.com>
> >>> ---
> >>>  include/boilerplate/ancillaries.h | 3 +--
> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
> >>> index c8c209deb..8de353ce8 100644
> >>> --- a/include/boilerplate/ancillaries.h
> >>> +++ b/include/boilerplate/ancillaries.h
> >>> @@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(void);
> >>>  	({								\
> >>>  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
> >>>  			__namecpy_requires_character_array_as_destination();	\
> >>> -		strncpy((__dst), __src, sizeof(__dst));			\
> >>
> >> What if we do
> >>
> >> strncpy((__dst), __src, sizeof(__dst) - 1)
> >>
> >> ? Is the compiler silent in that case?
> >>
> >> BTW, we have way more places where we are using this pattern, also in
> >> userspace (lib/boilerplate/ancillaries.c, lib/cobalt/printf.c).
> >>
> > I actually tried this method when I encountered this issue. But it still
> > reported the same error message.
> 
> But then why here, why not in the other cases?
> 
> Jan
>
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

Not sure why here.

I google it and find there were similar topics such as:

https://stackoverflow.com/questions/50198319/gcc-8-wstringop-truncation-what-is-the-good-practice

Haiyang.

