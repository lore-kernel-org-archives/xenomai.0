Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C3214A82
	for <xenomai@lists.linux.dev>; Wed,  7 May 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615433; cv=none; b=ArEU3IiZ3URRE3mx5XidsNhTdCZSL1OKquOfwpMc+v4vLC4Od+IwaH+ac/NL76hthEd4IcmlA/aOyC2CAgR3Sc3Fo/gYzvq411UPrmdT5CoRuV1CcFheV2CHzxveb1FByGMQ6Kt+bXXIUODT7zBXGzNZEp90Gz9smoMOiVso5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615433; c=relaxed/simple;
	bh=zJrN8GMhF+FMMj7upixlzh99iNIV9rbRDmpTwkUbErI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV3NHouWCld8s8N2P2h1HETKCFjk4Zx1eI+5doiqMDLcPaKpp+rJbFWIqFJhKFeR1vj6ND85iKvvThpoK2g8DP8e0o6jzhUcYwngxevM2h54uSLEC2WRjfQXUio7rQWdGfrE1vC4+xp/6piMPuFVIw0lwenJp2EIoQcEsQd1qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NiFsnVYX; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NiFsnVYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XFx/5CklIGIfvNkKZzGR8ztnQeLxNARH/rCJJEPW1ek=;
	b=NiFsnVYXucEhxHXCmz8iM4OGRqPlABlCrW+UX/GQURt/R0b+lwRt7ahRi9fWyi
	UN/6YG3US4oSbR/GS02+gbM4VwCWh4rNxfejGVnVyeTB6Xv5fcCqoI0CnJNMT/lh
	v7/DrgwxvUQZ2vR/nq98WlW4DMI1L22yiVFIknvppWN1U=
Received: from u2204 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBH1mB+PBto4deWFA--.4483S2;
	Wed, 07 May 2025 18:57:04 +0800 (CST)
Date: Wed, 7 May 2025 18:57:02 +0800
From: Haiyang He <aspirestro@163.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] Doc: Add fallback path for asciidoc-icons to fix install
 error
Message-ID: <dlnqafbfesgcwk5tiupzxftaukm7frkc3kdysxjrjqvmesih25@b3yrya6rtxbt>
Mail-Followup-To: Jan Kiszka <jan.kiszka@siemens.com>, 
	xenomai@lists.linux.dev
References: <20250506140443.2492075-1-aspirestro@163.com>
 <6196f5a3-472b-4863-8559-91c2c24a7d79@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6196f5a3-472b-4863-8559-91c2c24a7d79@siemens.com>
X-CM-TRANSID:_____wBH1mB+PBto4deWFA--.4483S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr17ZrW3tFy8CF1fJw15XFb_yoWrGF1rp3
	yDtan0yrs3Xw15CrnYgr48ur1Yvry8GryYqw1UJw15tF15tr1Igw4IyrW09F1xAFZ5Ga1f
	AFZrWa47Kr48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXQ9GcWgbMi-I1QAAsW

On Tue, May 06, 2025 at 05:06:49PM +0200, Jan Kiszka wrote:
> On 06.05.25 16:04, Haiyang He wrote:
> > By adding an additional check for the existence of the
> > /usr/share/asciidoc/icons/ directory in the Makefile.am file, this
> > patch improves compatibility across different environments and
> > fix an install error due to missing icon files.
> > 
> > Symptom when running make install:
> > cp: cannot stat '/etc/asciidoc/images/icons/': No such file or directory
> > make[2]: *** [Makefile:629: html/asciidoc-icons] Error 1
> > make[2]: Leaving directory '/root/xenomai-upstream/xenomai/doc/asciidoc'
> > make[1]: *** [Makefile:421: install-recursive] Error 1
> > make[1]: Leaving directory '/root/xenomai-upstream/xenomai/doc'
> > make: *** [Makefile:472: install-recursive] Error 1
> > 
> > Environment:
> > $ dpkg -S /usr/share/asciidoc/icons/
> > asciidoc-common: /usr/share/asciidoc/icons
> > 
> > $ apt show asciidoc-common
> > Package: asciidoc-common
> > Version: 10.1.2-1
> > 
> > $ cat /etc/lsb-release
> > DISTRIB_ID=Ubuntu
> > DISTRIB_RELEASE=22.04
> > DISTRIB_CODENAME=jammy
> > DISTRIB_DESCRIPTION="Ubuntu 22.04.1 LTS"
> > 
> > Configure:
> > $ ./configure \
> > CFLAGS="-march=armv8-a" \
> > LDFLAGS="-march=armv8-a" \
> > --build=i686-pc-linux-gnu \
> > --host=aarch64-linux-gnu \
> > --enable-smp \
> > --with-core=cobalt \
> > --enable-doc-build \
> > CC=aarch64-linux-gnu-gcc \
> > LD=aarch64-linux-gnu-ld
> > 
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> >  doc/asciidoc/Makefile.am | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
> > index 2bacb7c10..782c7a23f 100644
> > --- a/doc/asciidoc/Makefile.am
> > +++ b/doc/asciidoc/Makefile.am
> > @@ -112,6 +112,8 @@ html/asciidoc-icons:
> >  		cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons; \
> >  	elif test -d /usr/share/asciidoc/images/icons/; then \
> >  		cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons; \
> > +	elif test -d /usr/share/asciidoc/icons/; then \
> > +		cp -a /usr/share/asciidoc/icons/ html/asciidoc-icons; \
> >  	else \
> >  		cp -a /etc/asciidoc/images/icons/ html/asciidoc-icons; \
> >  	fi
> 
> Thanks, applied.
> 
> Yeah, I think I've seen that with Debian as well while updating the
> homepage last week - but then I worked around it locally. Thanks for
> addressing it properly.
> 
> While at that, I was wondering if we shouldn't automate the doc
> deployment further. We have a (not yet public) repo on source.denx.de
> that builds the static doc pages, but I have to do this first:
> 
> - build xenomai with ../configure --enable-doc-build
> - replace content in public/v3/html with
>   - build/doc/asciidoc/html
>   - build/doc/doxygen/html/xeno3rpm
> - replace conent in public/v3/pdf with
>   - build/doc/asciidoc/*.pdf
>   - build/doc/doxygen/xeno3prm.pdf
> - commit and push, CI pipeline will publish automatically
> 
> Would you be interested in working on an automation via gitlab-ci?
>
Sure, I could.

I quickly check the .gitlab-ci.yml and the CONFIGURE_OPTS does not include
--enable-doc-build by default.

To enable CI automation of doc, these actions should be added into
.gitlab-ci.yml:
1. define a new build job which is arch independent and has
--enable-doc-build enabled.
2. at the last of build stage, push html/pdf things to another repo which
builds the static doc pages.

Correct me if I am wrong.

Haiyang.
> We are also lacking CI runs with --enable-doc-build inside Xenomai
> itself. Such runs may have revealed issues like above already. And
> possibly things like
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/49...
> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

