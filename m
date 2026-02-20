Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DD23EAA3
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599938; cv=none; b=hCJ5FoVqFNxUB/RCBHe8NovsYVm7JyhwUw4+umS568ouirZQ67p5pRg/pza1hYxZ6hRvpjwVqlC3hgk3aiCjoetWY3qFBImHdfdv46SdMeB4NHZVNjJc7hzwJOmNLOFTD5WrYEqh4E70TlcLS38Y8KeFfMJo8/vUSpDuxDLWXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599938; c=relaxed/simple;
	bh=X2kkLrsbCuTP/tsOvDHPRMjng2H6Q+3SBJkAGWCVNFY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9U/fsE2eW6p0haxORkr4r833oiqVrV0qYuUfB2vuZ8nIRvxzRv+ZjHlPlPAyZk+DgTBHLIuTFkXoncFavWpWLrjMI0KfIeiEWSg2bKa05JlVc3c0buhOJ/OGbd6Gd2JdQ60c44eTeFcZg+NUJboqU/8CaDSSRsvYPhGqEKNHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HRBgyoV9; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HRBgyoV9"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260220150530083cf61db000020791
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 16:05:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8CdPFOIdJj4RVOk+nhtPK/fFhW9gy9oMMO6tFKdJM8k=;
 b=HRBgyoV9hCsiyqBg2wF8wxNz3R8WVWiRHXaOTVZ+z+yjloC9Nv8FA9L+PU7KYcuzT+75no
 VaHFA0y14RBhYr1ES7V/JAsj9bZu+pWHgt+fWYoqODneoRskCcvtIFu9sgAd8+DA088KIMh5
 w9J0xhRbDK3evRBnz63/4dHPvjtBILVCWur59k7DBTkwhyq/Tfki7kB9wDL3IvEYlAekL4ck
 k4tMmucXi4H59kSzpNZob0iHRzle/0DvhVIiMA82VTFkHdAnyZM6PimAOBpbVpfIJOPEez1Z
 s2X6eSQEfjR4NKr4F9NotvsTKOPqMesK65HgAD9gc7QdDhSwAH+/zrsg==;
Message-ID: <0379be88886cfdb00041c1427113549130ef7b49.camel@siemens.com>
Subject: Re: [PATCH 20/20] scripts/xeno-config: Allow disabling the y2038 /
 time64_t support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 20 Feb 2026 16:05:30 +0100
In-Reply-To: <420e254e-667f-4799-9e4c-4e4ee2cb4e53@siemens.com>
References: 
	<20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	 <20260220-wip-flo-fix-time64-32bit-native-v1-20-731c773e72cc@siemens.com>
	 <420e254e-667f-4799-9e4c-4e4ee2cb4e53@siemens.com>
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

On Fri, 2026-02-20 at 15:50 +0100, Jan Kiszka wrote:
> On 20.02.26 10:09, Florian Bezdeka wrote:
> > xeno-config got a new cmdline option --disable-y2038 that will disable
> > the time64_t or (year 2038) support inside the application that is
> > being build against libcobalt.
> >=20
> > libcobalt provides both interfaces, so for native time_t and for
> > time64_t at the same time. By default, the time64_t based interfaces
> > will be used. If an application does really want to go back to native
> > time_t --disable-y2038 has to be specified before the --cflags option.
> >=20
> > The new parameter is only useful for (old) 32 bit applications.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  scripts/xeno-config-cobalt.in | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt=
.in
> > index 46b6c11b92fe20e4474e0173a211b18dc5cd7e3b..ecbfefb8f0a9f7ea99864d0=
7e5f717841ef5da4e 100644
> > --- a/scripts/xeno-config-cobalt.in
> > +++ b/scripts/xeno-config-cobalt.in
> > @@ -62,6 +62,7 @@ Options :
> >          --core
> >          --info
> >          --compat
> > +        --disable-y2038
> >  EOF
> >      exit $1
> >  }
> > @@ -173,6 +174,9 @@ while test $# -gt 0; do
> >  	--posix|--cobalt|--vxworks|--psos|--alchemy|--rtdm|--smokey)
> >  	    skin_list=3D"$skin_list `expr "$1" : '--\(.*\)'`"
> >  	    ;;
> > +	--disable-y2038)
> > +	    disable_y2038=3Dy
> > +	    ;;
> >  	--cflags)
> >  	    do_cflags=3Dy
> >  	    ;;
> > @@ -233,6 +237,7 @@ if test x$do_cflags =3D xy; then
> >  		;;
> >  	esac
> >      done
> > +    test x$disable_y2038 =3D xy && cflags=3D"$cflags -U_TIME_BITS -U_F=
ILE_OFFSET_BITS"
>=20
> I did that undef in my mmap patch as well, but I wonder if - at least
> here - we couldn't filter out both defines from the given cflags.
>=20

In case libcobalt itself was build with time64_t support those flags are
part of all cflags variables. Might be that there is a more elegant way
to remove flags but that didn't come to mind yet...

A different approach might be to skip writing the time64_t enablement
flags into XENO_USER_APP_CFLAGS (configure). Side effect might be that
every (testsuite) application has to enable the support on it's own,
doing all the glibc support checks...
