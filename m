Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9BB1E863
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384743; cv=none; b=DDtpN++5ACmkh1870TbKw1CuiGEVwc1fWBMyTf0Z9d7BBMUliBiTSbahlxn1ZDcJwUyKI/r8CfCF4JatOnpMsA+D7tlkw+u32F576V9sWCwdrumajneq68qW3HnKOc8hphjqfq64vgyL5qJHrAVy39nyxxVimM4uAkO2/VwVM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384743; c=relaxed/simple;
	bh=PV1TTOfcys/1S02IZXyuMkNTWWIPLEHXXRrQYzo+QYM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iu/9llETWyU7eb0s8rG0iyNu1DVf3rJRSlcqe6NBtLCSlUgCXfekXZgRJC6h8gxRQWwE0K/SOVlXPG4UccZIJuq7VIBL2Lh7/OslHFEqKfKSdCotH1e3lH7Aq98UEyoXZa83E7vv/AziqywAjmreOb2PswG+6XCW56nalPMtJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5E5B36195FD0;
	Wed, 22 May 2024 15:32:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 31HYuZFpKE0o; Wed, 22 May 2024 15:32:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E1BD66195FFD;
	Wed, 22 May 2024 15:32:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N7S-YU8nnP8G; Wed, 22 May 2024 15:32:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C4C8D6195FD0;
	Wed, 22 May 2024 15:32:15 +0200 (CEST)
Date: Wed, 22 May 2024 15:32:15 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <784543910.133534.1716384735664.JavaMail.zimbra@nod.at>
In-Reply-To: <770b74df-11fc-482a-9d2b-119b92e7097a@siemens.com>
References: <20240518112703.30713-1-richard@nod.at> <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com> <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at> <770b74df-11fc-482a-9d2b-119b92e7097a@siemens.com>
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Add reverse mode
Thread-Index: Ok1hzKx+ENSn42bXCaIMjK0O6qXtkg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> In my WIP branch I have glued everything together.
>> https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/rw/prepare_rew=
ork/?ref_type=3Dheads
>>=20
>=20
> Just submit both in a single series next time so that it's clear for me
> which should be merged first.

I have implement both features independently.
But now everything resides on the same branch, I'll send it out as patch se=
ries.
=20
>>> I like this as it obsoletes my local script :). Just minor notes, and
>>> please make sure it goes will with the any-arch patching extension.
>>=20
>> Sure. Beside of other fixes I've managed also to get rid of /bin/bash an=
d
>> changed the script to POSIX shell.
>> shellcheck is now happy up to warning level.
>> Info level still gives tons of suggestions I have to review.
>>=20
>> Beside of that, what's do you think about the --filterkvers, --filterarc=
h,
>> --default and --forcelink
>> switches?
>> IMHO we can drop them. I don't see much use in them except of adding com=
plexity.
>=20
> --filterkvers and --filterarch date back to 2006 and this commit:
>=20
> https://source.denx.de/Xenomai/xenomai/-/commit/b1ef45e37c06a2e62d57cd139=
b410e02bc486898
>=20
> Unfortunately, reasoning was not recorded, and we can't ask Gilles
> anymore. I tend to agree that this is not needed in practice.

Ok!

> --default seems to have become obsolete for the linux path with
> https://source.denx.de/Xenomai/xenomai/-/commit/0886b75af74654682794102d0=
80dfd4a16da1244
> - I don't see that linux_tree could become empty anymore (unless you do
> "--linux=3D --default", but that would be strange). Adding your new
> default value for --arch (all), that switch could be dropped.

Agreed.

> What would be your suggestion for --forcelink? Just drop it and skip
> over existing links or make it the new default? Enforcing the update is
> probably not as safe as using the new --reverse, followed by clean run
> of the script. This is at least what I would do.

TBH, I have a hard time to understand the purpose of --forcelink

It is used in:
                if test x$forcelink =3D x1 -o \
                   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir=
/$f;
                then=20
                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_d=
ir/$f
                fi=20

So, a symbolic link is forcefully created if either --forcelink is set or
source and target files are not the same. "not the same" includes also that
either of both is not present.

To put it the other way around, "ln -sf" is not called if --forcelink is no=
t set
and the link is already installed.

What's the use case?

>>=20
>> Same for --dovetail, since no release patches are made anymore.
>=20
> That switch is for integrating Xenomai + separate patch on top of a
> vanilla kernel. I would not drop that feature yet, even though we no
> longer distribute patches as releases.

Okay. Let's keep it.
=20
>>=20
>> Also, do we really need interactivity?
>> Currently the script can ask the user for the paths to Linux and the dov=
etail
>> patch.
>> IMHO everything should be controlled by command line switches, no script
>> chitchat needed.
>=20
> Where would interactivity still remain after the above cleanups?

If --linux points to a vanilla kernel, but --dovetail is not set,
it will ask for the path to the patch.

Thanks,
//richard
