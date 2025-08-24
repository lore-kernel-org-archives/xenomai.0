Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544B1422DD
	for <xenomai@lists.linux.dev>; Sun, 24 Aug 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026162; cv=none; b=krjSqol466VRG9y4xE16ZOjLITlYlvzw18OJBzL4CZCtmQ8XRnMwk5sOHgihLByy6wiMqy5zoP//fMQB7CgVXNdKfM3Twp8aV3FPIDG1R2rzQSbBSJqsC2KCp/7AqapH7FOhvu8ws7NSVgXhFANkF0tTSKQoc0lgXchfogF6UOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026162; c=relaxed/simple;
	bh=IMsB3+KUunM6hwxOtUmBMm7LdSukj2BWMHB8aanofU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onmePP0y9NoqtNw0kS84qDkL42Fe9kUkrvj2r7khb1Y8DJPmegF0P81j8IEznCxOBa/AlcA8Grcz57DRh2qTviNHrs+rtSp99PusF+Tv5+OWwNtlWgZSHPteufhawmYuKJvyLzCHdD14b6aA+SeTFmUjX73ilBQ6xEmnYylM4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=UzwAxGng; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="UzwAxGng"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 983EE4313C;
	Sun, 24 Aug 2025 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1756026149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ3qN+GCmYIiWPpupST/OUtXis3O/AxpMjknrbkOdAc=;
	b=UzwAxGngcTIXNcS6MPDZ1ZUHko8hbWoZpwAtGMh5Z7nHNW87KB/EwdFYJ4/EVgPErpFrm3
	eYwv3DwrDHjKeWVZ3RLkEiNnnK1k3e/O9NWcCBruU8gtRqhqUHC09bhWDl9G/IJavD8ROA
	aDcxPjywQCo89V2Uym0V6SH5WVbYMGcvWfaBv4fz5H4drPzwyJi8wGT+mXzA7vBaC0REvz
	9rdh8oCDlex2IIx71vcQKE26dJoMYgc0oWmod2xEiwSplUCvSZUYJu7YqmQYFyD4m5Xtcn
	8mMD/LAzV3AVQMKEc13LCFAoE/T41DVER3W8APAnF2hJru+UvB/tSnq4YSSoRg==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Simple Xenomai 4 API use examples and a question
In-Reply-To: <120fe6031963eed74f04c365c7b780a86af579c0.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Fri, 22 Aug 2025 15:29:23 +0200")
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	<120fe6031963eed74f04c365c7b780a86af579c0.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Sun, 24 Aug 2025 11:02:28 +0200
Message-ID: <877bytks7v.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeluddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgeetjedvhfelveehfedtheevjedvteffhffhgfetjeffgeegveehiefhvdffgeetnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpmhgvshhonhdrsghuihhlugenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghmmhgrnhhuvghlrdhprggtrghuugeslhgrphhprdhinhdvphefrdhfrh

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> [1. text/markdown]
> Le vendredi 22 ao=C3=BBt 2025 =C3=A0 09:13 +0200, Emmanuel Pacaud a =C3=
=A9crit=C2=A0:
>> I have started to work on a repository which is intended as a collection=
 of very simple (dumb) examples of Xenomai 4 API use. Each example is an ap=
plication, sometimes coupled with a kernel module, with the strict minimum =
around the actual API use. Applications and kernel modules are built using =
meson. The meson files are also kept the their simplest form. That was easy=
 for the application building, not so for the kernel modules.
>
> In my quest of the simplest example, there is this line in <https://gitla=
b.com/emmanuelpacaud/xenomai-c-examples/-/blob/8253729aa3eb669576e387bba800=
85c91199f3cf/meson.build>:
>
> ```
> exe =3D executable (e, e + '.c',
>                   dependencies: evl_dep,
>                   c_args:   ['-I' + evl_dep.get_pkgconfig_variable('inclu=
dedir') 'uapi'],
>                   install: true)
> ```
>
> In my setup, I, don't install kernel user space API headers, as it is a d=
iskless one, where I want to be able to switch between different kernels. S=
o I let install-uapi enabled, which means *-abi.h files are installed in $p=
refix/include/uapi. Which means I have to add this path to the include path=
 manually, as it is not present in the pkg config file, using c_args parame=
ter.
>
> Is it intended ? I would have expected them to be installed along the oth=
er libevl headers. If so, I think the C flags in pkg config file should inc=
lude $includedir/uapi, when install-uapi option is enabled.
>
> Emmanuel.

Since ABI 42 guarantees that we have no naming conflict anymore thanks
to the -abi.h suffix for those headers, we can merge them with the
common library headers, leaving the evl.pc generation as is. I'm pushing
the following change to the -next branch to address this:

diff --git a/meson/install-uapi.sh b/meson/install-uapi.sh
index 333122b..2ccee5e 100644
--- a/meson/install-uapi.sh
+++ b/meson/install-uapi.sh
@@ -3,4 +3,4 @@
 # $2 =3D $includedir
=20
 cd $1
-find -L evl \! \( -name '*~' \) -type f | cpio -pdum --quiet $MESON_INSTAL=
L_DESTDIR_PREFIX/$2/uapi
+find -L evl \! \( -name '*~' \) -type f | cpio -pdum --quiet $MESON_INSTAL=
L_DESTDIR_PREFIX/$2

Please let me know if that fixes the issue on your end.

--=20
Philippe.
