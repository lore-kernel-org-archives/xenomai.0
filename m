Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143B175540
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333855; cv=none; b=RhyqIfrylDLvFif40jIHXSOeEuN+RsBnvCXwJ23RLXInPKAOadSln9qLFJGZF+YL0EqSIWOhZaw6PEixBeIvv04xpCnZuCRezHRLs/thaIoIS9Nyg/gJRvhcTcJeRf0O2rGK87tq87AY1KwMoZujhVPV61Q1pq0OsSh9ebIFKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333855; c=relaxed/simple;
	bh=e6RiTDc4O8741+zjyUgDfH/BNsa56/Ns6mB8SDzjmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2tMDEKYO7ktpbTuTSMAuM8e1lyPH5fDx6WWQQ8ox4QaMWoQcpG/eBSxhRZXIk0v5mjBeP3YOHgvMJvGYTj9mjaKpnugbovEOCHGD7Cu+FQrXrgu/MT/QJ6+b9n3exgkoQQaFuZnf3jT06uMp8WPVC4eIp9wsQ4d6yb3yWVv81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=HJgPDBV5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="HJgPDBV5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-361785bfa71so4402065f8f.2
        for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719333851; x=1719938651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV78moQjGehkm6L9XupZ5EaQHHFDRxBbeXk/qBfHokw=;
        b=HJgPDBV5bwYZucxYDOise8VWSAdHx/I3qlNNMptX1Uvk89oKBm2hf6DoadYG/xB1/R
         cZ2zNcuCr9nbWUb78g+GMlMMsZpeBf2O8UqakrtvMnpgH+Qsbm6Ug4WEtO9sYOVKjVj2
         sutL2nBusm1+xpl9UFkSTvpjqKxU+/yIpDeuGbgOapIVP5Kw9G9Z+qW+0xZicY23Oh3P
         mntmcTayncS6V50XlVOSJXPu+LoeUvsrjmus/4kPx4CT/nnQ8yE6kxoV8Z94zPQM4SNC
         hCYLbC4wRkrm5DO4KSUVSSEN7+WSoj66Or7GsNG1Gp0x18o5JtUwybA3b2OrIUZTyfNt
         SsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333851; x=1719938651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV78moQjGehkm6L9XupZ5EaQHHFDRxBbeXk/qBfHokw=;
        b=ICqnv5zs/moQ5ir4Ob+YrcaX2zxbemrMync5MQ3Uvoknlj/MaXGDYmFmRSFLxz7D8f
         XaRFbS0BfIFeYm5+ovy9SPnnVaQSyshydbGvh2SKbb96CIkdkw+xe1+0bvzChx3U5l34
         8lb7moJF6vgSbo6/6TwJKHEuOw6DWHjToeZOmhM6jrVnsIBqZ1QQnrwLm/XNlMbeEv/l
         9/8ZXmZkre3aHGaCKLtYGKwh9pReq4OJ2nmMDsxiPaVG7SwePA48BU1CbTvIp1cFUYe0
         RGO8AHRLU+BceM105jz9N04oiTBk3PsqrI015ooMMbQdOrZG8Se3IHJ+SO4x2RFi6XzV
         IdIA==
X-Forwarded-Encrypted: i=1; AJvYcCWaVPmRErAen7KgS+TcuIhY8cdu7VBjq5K9a/xus83A5PGR3y2fxI8555c9NSP+Vtrgnx4CJ+jjQgfeNglNzZ5Nu+d6u1I7SA==
X-Gm-Message-State: AOJu0Yzcg32zbaJPB/XVSsWsRHj9XUu+t20p8DCps3E909jnVtBCUNJB
	IHFcbu0hAW7mhT5kntA78R/OVQD8EOnn58GeAOT2Y+L5vO7Ec6aNVHsNwyO7N9Y=
X-Google-Smtp-Source: AGHT+IG/So2VRx3cdjmURAO2S8Llef4++jvhTcELfw3xMQ9ILtCwRNjWqCQHwMZ76Py76wCZH3Okbw==
X-Received: by 2002:adf:fd87:0:b0:360:81d2:b06b with SMTP id ffacd0b85a97d-366e79fdfbcmr4829648f8f.18.1719333850798;
        Tue, 25 Jun 2024 09:44:10 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c789esm13436992f8f.91.2024.06.25.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:44:10 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 02/14] prepare-kernel.sh: Add reverse mode
Date: Tue, 25 Jun 2024 18:44:09 +0200
Message-ID: <13437395.lhuNh5TYOU@somecomputer>
In-Reply-To: <d96e1040-357a-40f2-b651-659c715af07f@siemens.com>
References: <20240624203341.6263-1-richard@nod.at> <20240624203341.6263-3-richard@nod.at> <d96e1040-357a-40f2-b651-659c715af07f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 25. Juni 2024, 18:20:45 CEST schrieb 'Jan Kiszka' via upstream:
> On 24.06.24 22:33, Richard Weinberger wrote:
> > There is currently no way to undo preparing of a kernel, except using
> > --outpatch and reverting the resulting patch later.
> > But in link mode the kernel tree needs manual cleaning,
> > which can be tedious if a git clean -f -d -x is not possible.
> >=20
> > The new --reverse flag offers this feature, it removes all previously
> > created symlinks and directories.
> > To be able to undo effects by patch_append(), keep a .orig file link
> > as the script already does for symlinks in the linux tree.
> >=20
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  scripts/prepare-kernel.sh | 71 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 57 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index 9299aaa97..f294ef0fa 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -55,6 +55,8 @@ patch_append() {
> >  		if test -L "$linux_tree/$file" ; then
> >  			mv "$linux_tree/$file" "$linux_tree/$file.orig"
> >  			cp "$linux_tree/$file.orig" "$linux_tree/$file"
> > +		else
> > +			cp "$linux_tree/$file" "$linux_tree/$file.orig"
> >  		fi
> >  		chmod +w "$linux_tree/$file"
> >  		cat >> "$linux_tree/$file"
> > @@ -66,6 +68,16 @@ patch_append() {
> >  	fi
> >  }
> > =20
> > +patch_reverse() {
> > +	file=3D"$1"
> > +	if test "x$output_patch" =3D "x"; then
> > +		if test -L "$linux_tree/$file" ; then
> > +			rm "$linux_tree/$file"
> > +		fi
> > +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> > +	fi
> > +}
> > +
> >  patch_link() {
> >  	recursive=3D"$1"		   # "r" or "n"
> >  	link_file=3D"$2"		   # "m", "n" or some file (basename) from $target_=
dir
> > @@ -104,11 +116,15 @@ patch_link() {
> >  		f=3D`echo $f | cut -d/ -f2-`
> >  		d=3D`dirname $f`
> >  		if test "x$output_patch" =3D "x"; then
> > -			mkdir -p $linux_tree/$link_dir/$d
> > -			if test x$forcelink =3D x1 -o \
> > -				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> > -			then
> > -				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> > +			if test x$reverse =3D x1; then
> > +				rm -f $linux_tree/$link_dir/$f
> > +			else
> > +				mkdir -p $linux_tree/$link_dir/$d
> > +				if test x$forcelink =3D x1 -o \
> > +					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> > +				then
> > +					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> > +				fi
> >  			fi
> >  		else
> >  			if test `check_filter $link_dir/$f` =3D "ok"; then
> > @@ -120,6 +136,11 @@ patch_link() {
> >  			fi
> >  		fi
> >  	done
> > +	if test x$reverse =3D x1; then
> > +		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
> > +			rm -rf $linux_tree/$link_dir
> > +		fi
> > +	fi
> >  	)
> >  }
> > =20
> > @@ -135,8 +156,7 @@ generate_patch() {
> >  	)
> >  }
> > =20
> > -
> > -usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<d=
ovetail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--filterkvers=3Dy|n=
] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose]'
> > +usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<d=
ovetail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--filterkvers=3Dy|n=
] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose] [--reverse]'
> >  me=3D`basename $0`
> > =20
> >  while test $# -gt 0; do
> > @@ -172,6 +192,9 @@ while test $# -gt 0; do
> >  	--verbose)
> >  		verbose=3D1
> >  	;;
> > +	--reverse)
> > +		reverse=3D1
> > +	;;
> >  	--help)
> >  		echo "$usage"
> >  		exit 0
> > @@ -221,6 +244,13 @@ if test \! -r $linux_tree/Makefile; then
> >  	exit 2
> >  fi
> > =20
> > +if test x$reverse =3D x1; then
> > +	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; th=
en
> > +		echo "$me: $linux_tree is not prepared with Xenomai" >&2
> > +		exit 2
> > +	fi
> > +fi
> > +
> >  # Create an empty output patch file, and initialize the temporary tree.
> >  if test "x$output_patch" !=3D "x"; then
> >  	temp_tree=3D`mktemp -d prepare-kernel-XXX --tmpdir`
> > @@ -229,6 +259,11 @@ if test "x$output_patch" !=3D "x"; then
> >  		exit 1
> >  	fi
> > =20
> > +	if test x$reverse =3D x1; then
> > +		echo "$me: --reverse and --outpatch are not compatible"
> > +		exit 1
> > +	fi
> > +
> >  	patchdir=3D`dirname $output_patch`
> >  	patchdir=3D`cd $patchdir && pwd`
> >  	output_patch=3D$patchdir/`basename $output_patch`
> > @@ -364,10 +399,11 @@ case $linux_VERSION.$linux_PATCHLEVEL in
> >  test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LE=
VEL=3D0
> > =20
> >  	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; th=
en
> > -		p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/inclu=
de -I\$(srctree)/include/xenomai"
> > -		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> > -		p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
> > -		echo $p | patch_append arch/$linux_arch/Makefile
> > +		p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/incl=
ude -I\$(srctree)/include/xenomai"
> > +		p2=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
> > +		(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
> > +	elif test x$reverse =3D x1; then
> > +		patch_reverse arch/$linux_arch/Makefile
> >  	fi
> > =20
> >  	patch_architecture_specific=3D"n"
> > @@ -375,11 +411,15 @@ test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CO=
NFIG_XENO_REVISION_LEVEL=3D0
> >  	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
> >  		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
> >  		( echo ; echo $p ) | patch_append drivers/Makefile
> > +	elif test x$reverse =3D x1; then
> > +		patch_reverse drivers/Makefile
> >  	fi
> > =20
> >  	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
> >  		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
> >  		( echo ; echo $p ) | patch_append kernel/Makefile
> > +	elif test x$reverse =3D x1; then
> > +		patch_reverse kernel/Makefile
> >  	fi
> >  	;;
> >  esac
> > @@ -387,13 +427,15 @@ esac
> >  # Create local directories then symlink to the source files from
> >  # there, so that we don't pollute the Xenomai source tree with
> >  # compilation files.
> > +#
> > +# Keep link dirs (4th parameter) descending, otherwise --reverse
> > +# is not able to cleanup these directories!
> > =20
> >  patch_kernelversion_specific=3D"n"
> >  patch_architecture_specific=3D"y"
> >  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
> >  patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include=
/dovetail
> >  patch_architecture_specific=3D"n"
> > -patch_link n m kernel/cobalt kernel/xenomai
> >  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
> >  patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
> >  patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
> > @@ -401,14 +443,15 @@ patch_link r n kernel/cobalt/include/asm-generic/=
xenomai include/asm-generic/xen
> >  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
> >  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
> >  patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
> > +patch_link n m kernel/cobalt kernel/xenomai
> >  patch_link r m kernel/drivers drivers/xenomai
> >  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
> > -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
> >  patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai=
/pipeline
> >  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
> >  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> > -patch_link n version.h include/xenomai include/xenomai
> > +patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
> >  patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
> > +patch_link n version.h include/xenomai include/xenomai
> > =20
> >  if test "x$output_patch" !=3D "x"; then
> >  	if test x$verbose =3D x1; then
>=20
> This breaks rtdm/uapi/rtdm.h, at least. Didn't debug yet, just bisected.

I found the problem.
The order of calls to patch_link() matters in wicked ways. :-/
It used to work before I have further "cleaned up".

I'll look into a fix after dinner.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


