Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FFF2DFA3B
	for <xenomai@lists.linux.dev>; Tue, 15 Apr 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682444; cv=none; b=R0n3Yj9XNY1Lf6f94o2504Z54BXEVq96MHqxtgFn/MomA9gjo4BtJEM1v6fiYS4FTQR4bkXZfVcMZj+R6yqjVg2K+BUKdmMNhHS2sPKZLNMDPb5z5BRe4VSwvke1MWfcP+pQZuJOiT4FoevHCGGlL3JvZgnRWSw8ioNgZn8z72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682444; c=relaxed/simple;
	bh=9c0a9w0l41hBI1KV0X/phPDi8rj5qR0N1eqcCYtfE50=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYg3A4pDijNnNhvlCTCfo0cWPSKhuITmKtzJf/mtHyK0lxkItiReAAndO1+HUeqxHiUuzwIdWnN1xsWiLDFNghSC4sEcv4Zz6Netw2II4H5eHLcwEzH8lTY3iF46c+yadwSbCi+/eVWqVnmRayqG+hG6sRCwQ16AaZJ/YMDHD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iMTHOLM9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iMTHOLM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nWjR6wHetKgPBRBPZbPrt5qo20qRkAsq+b/VTIC7JC4=;
	b=iMTHOLM9icfKheFFEjJFJeby8aZHcD4mMtED6En0rBOlJxYH+vDXYKc5H9Kmqw
	IiRvMSwOKcr6+kzEsJD74wzIP7a996lrdSx9LjxioDLzWZ8w9TwueWtIvMfkkSyk
	kilyKkw31g5Ce06icAcHsMBuJgM9FrQXjvK2Nd2F9GCj0=
Received: from u2204 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n4TBvf1nj7i7Gg--.46970S2;
	Tue, 15 Apr 2025 10:00:36 +0800 (CST)
Date: Tue, 15 Apr 2025 10:00:33 +0800
From: Haiyang He <aspirestro@163.com>
To: xenomai@lists.linux.dev
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
Message-ID: <2xbsqkxq3vc5lej4rrffz3zyizb2xp3v5xg5uznnxqdozz7nvz@veuog2pynh7p>
Mail-Followup-To: xenomai@lists.linux.dev
References: <20250414153817.1829100-1-aspirestro@163.com>
 <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
X-CM-TRANSID:_____wD3n4TBvf1nj7i7Gg--.46970S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWktry5Xw1fAw1UGr45ZFb_yoW8tF13pa
	y8ta1YvrW8J3Z5XwsrWr48Za4Ut34YyF909rn8XFy8Ary5Kr4IyF4Sgr15urnxJ3WFkw4S
	gFs0qa4kA34xCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv2NZUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBQvcWf9exZDyQABsq

On Mon, Apr 14, 2025 at 05:53:43PM +0200, Florian Bezdeka wrote:
> On Mon, 2025-04-14 at 23:38 +0800, Haiyang He wrote:
> > Ensure shell expands tilde (~) in the --outpatch parameter path.
> > This fixes "cd: can't cd to ~" errors when using home directory
> > shortcuts in output path.
> > 
> > The issue occurred because the ~ character in paths was not expanded
> > before directory operations.
> > 
> > $ ./scripts/prepare-kernel.sh \
> > --linux=~/xenomai/linux-dovetail \
> > --arch=arm64 \
> > --outpatch=~/xenomai.patch
> > ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~
> 
> Where is this "cd" command that fails? Which line of the script?
It fails on line 210 of scripts/prepare-kernel.sh
209         patchdir=`dirname $output_patch`
210         patchdir=`cd $patchdir && pwd`

> 
> > 
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> > 
> > Patch v2:
> > Change `eval "echo $output_patch"` to $(eval "realpath $output_patch")
> > 
> >  scripts/prepare-kernel.sh | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index ecc830fd2..ea7892b21 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -139,6 +139,7 @@ while test $# -gt 0; do
> >  		;;
> >  	--outpatch=*)
> >  		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
> > +		output_patch=$(eval "realpath $output_patch")
> 
> I think you got me wrong:
> Should read: output_patch=$(realpath "${output_patch}")
I had tried but it did not work and got error msg:
realpath: '~/xenomai.patch': No such file or directory
> 
> But: Where exactly are we failing? Just tried to reproduce but failed
> so far... Would help to know where exactly the "cd" operation is that
> fails.
> 
> We operate on output_patch with basename, dirname, ... which all should
> support ~.
> 
> Maybe it helps the script with "bash -x ./scripts/prepare-kernel.sh" to
> enable some debugging.

Here are outputs of line 209~210 when do "bash -x ./scripts/prepare-kernel.sh"
+ dirname ~/xenomai.patch
+ patchdir=~
+ cd ~
./scripts/prepare-kernel.sh: 1: cd: can't cd to ~

> 
> >  		;;
> >  	--filterkvers=*)
> >  		echo "$me: warning: --filterkvers= is deprecated and now a no-op" >&2
> > -- 
> > 2.34.1

