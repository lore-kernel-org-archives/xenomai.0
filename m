Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1342A92
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644143; cv=none; b=UutfRH89ZgVIWGyFCbI2Plv9JJvq7U0bNc0QRDRGP3q7cn1ZW37hs5/CfUNyUnjLobSCxAy9C3WXeRshqmWmMwksTwAWRUOTUxSNUYA0psSifbjIuPE1+0KiD4z+qYignVRlZSHWXoKVgyaNu/bV59loNB3bzeNn0h2WkV9tlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644143; c=relaxed/simple;
	bh=mLA12fx/iYQYxhgp+0XnLIK47apZAXR2CaTvgpwWDK4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEkP+2evdKuxU2kYFMJX9XaNrDCULVlWx3DP3W/pciReAqQCAXaZoeZeYFaO97ofYvartA+r2qSS8l82v/RQ55VKDWi7iCQIXsPpsOSfbKILrAjI0bccRXllwFiKuQw/lNM/1+w5olvNhvJuknZxoApUzdRTpJMvOb3THDMc+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dRrbidBb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dRrbidBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=mWSIyIqBBhTm/tN0B67lMX1yYVY4EulnzwzyW7ZiOUo=;
	b=dRrbidBbS1q1UafmWOhG4CB6hzzU+TymVWRt4mZscgiXZQSQWOjMJIRp7OVTGe
	EyglJnosPOUQUa05/Vdebk2HkZRPs3kEkLZkXh3VFIRprn6b6T8Jq5Yf4l6g/kcj
	4pkkp6dmpAAJ3XBR9j4owpVAqkeDZEhAnNo9zVcilhzRg=
Received: from u2204 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXJKAdKP1nr1EbAA--.3776S2;
	Mon, 14 Apr 2025 23:22:08 +0800 (CST)
Date: Mon, 14 Apr 2025 23:22:05 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
Message-ID: <mie3sh6cx3qn4egjtdttpcrquvnwsqzqevkxybhkmotvezj6qj@bttpgtuzg3sl>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250414141034.1682520-1-aspirestro@163.com>
 <a94878f7d6af9e2c36a7956de3632a70bf286cd4.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94878f7d6af9e2c36a7956de3632a70bf286cd4.camel@siemens.com>
X-CM-TRANSID:_____wAXJKAdKP1nr1EbAA--.3776S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fKr48KryxZFy8Gr47twb_yoW8XFW8pa
	y8t3WYkFW8J3WkXwsrWr48Zr15t3yYyF98urn8XFyUAr15Krn29an2gryY9FnxXFyjkr4S
	vF4qq3WkAFyxCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv2NZUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXA0vcWf9IczJBQAAs0

On Mon, Apr 14, 2025 at 04:22:52PM +0200, Florian Bezdeka wrote:
> On Mon, 2025-04-14 at 22:10 +0800, Haiyang He wrote:
> > Ensure shell expands tilde (~) in the --outpatch parameter path the
> > same way as --linux and --dovetail parameters. This fixes
> > "cd: can't cd to ~" errors when using home directory shortcuts in
> > output path.
> > 
> > The issue occurred because the ~ character in paths was not expanded
> > before directory operations.
> > 
> > $ ./scripts/prepare-kernel.sh \
> > --linux=~/xenomai/linux-dovetail \
> > --arch=arm64 \
> > --outpatch=~/xenomai.patch
> > ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~
> > 
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> >  scripts/prepare-kernel.sh | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index ecc830fd2..e15c1fe6e 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -139,6 +139,7 @@ while test $# -gt 0; do
> >  		;;
> >  	--outpatch=*)
> >  		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
> > +		output_patch=`eval "echo $output_patch"`
> 
> Something like "realpath" should do it (instead of eval), no?
> 
> Btw: AFAIR command substitutions should be done with the $() syntax
> nowadays (instead of ``).
>
Make sense, and this works:

output_patch=$(eval "realpath $output_patch")

I will resend patch v2.
> >  		;;
> >  	--filterkvers=*)
> >  		echo "$me: warning: --filterkvers= is deprecated and now a no-op" >&2
> > -- 
> > 2.34.1
> 

