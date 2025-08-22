Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F426B769
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895976; cv=none; b=MZqDHDZWfwz9bxpj1mt3LwGvE8pvuMcggQXXOiYeQ5qIfa7PZEKGsB6QORcIzgoNanRA5WyEAU2gHS4GZ0dXasKp4L+2mpJaGpBCW2cN62YbRFvb7lerdpyYo3/4EWIemcRbDeOaDFhqhmYz8NAMPiOaCWYkNYUBYS+dak/Stuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895976; c=relaxed/simple;
	bh=u0YU4cKt6vAafOP3s3ssrPfgrbZU8QTCwXjsvFG4ZSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bW/kL1OAbXxhTHGplFRFCCR123sLaAlagCz2rWfctNcuQGS5qQ7IRjD/vIageo/p4XRj8UlXodNb9P86YxhaNbOWvXZMrIggv8Qd5ctqtba3IX+qTGJHNPmuPfCCMaq66B70QT/OwuT3xAU2Y6pq/CQE6jHB7Dq84NzvP4lwLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BlD/0XcV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BlD/0XcV"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FD5944107;
	Fri, 22 Aug 2025 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755895972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kDpwBrrLk85zp9z2bfb8U98m2l3jxce29SDXxtNu3c=;
	b=BlD/0XcVMzkMSevoXZGYuULoL6tVThhy0RJZ1G7hE4mTQrCf7LA68SPsghFXAM8X0K7CIL
	gN/TwH1JSV81Pt33oVgUF9/BXBvD1NXloMkUz8W0LRzc++/M5iuiNegKCz4KBVSf3m1IF7
	bGxLRFdEePqKPww2e689BiH7cNN8lcHxTh7/tLMKMGy5fH+ktBExhBPkxxnBlh7728jngi
	b4QsvnBAvb1QA0Z25oUbtqdNAlb5p6l1FKEeMF7yluWps6Cb8d8FvsVQKgF+RAX5d9IqJw
	Vp7ZRojN0PN2brR5HfpN38iKOwdjMefPbuvtrtsHq2X/gM1XbSnrRA9g/RrYAw==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: xenomai4 - running applications as regular user
In-Reply-To: <f71b0364180199360785ffba2b8e08963ea53775.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Fri, 22 Aug 2025 16:29:30 +0200")
References: <a597e0a51e4adb69e3ff9041f83a67d588c861e6.camel@lapp.in2p3.fr>
	<87plcnhlrm.fsf@xenomai.org>
	<f71b0364180199360785ffba2b8e08963ea53775.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 22:52:51 +0200
Message-ID: <87qzx3f598.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepiedtvdejhfejvefghfetteehfefhheeikedtteeuffeljeetueefffdvfeejgfffnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvmhhmrghnuhgvlhdrphgrtggruhgusehlrghpphdrihhnvdhpfedrfhhr
X-GND-Sasl: rpm@xenomai.org

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> [1. text/markdown]
> Le vendredi 22 ao=C3=BBt 2025 =C3=A0 09:13 +0200, Philippe Gerum a =C3=A9=
crit=C2=A0:
>>=20
>> > What is the recommended way to run out of band applications as regular=
 user using xenomai4 ?
>> >=20
>> > In xenomai3 documentation, there is a dedicated page about this, <[htt=
ps://v3.xenomai.org/tips/regular-user/](https://v3.xenomai.org/tips/regular=
-user/)>, but I did not find similar instructions in xenomai4 version.
>> >=20
>> > Emmanuel.
>>=20
>>=20
>> See [https://v4.xenomai.org/core/user-api/#device-ownership-and-access](=
https://v4.xenomai.org/core/user-api/#device-ownership-and-access)
>
> Thanks.
>
> I have created a xenomai group, added myself to the group, changed the ow=
nership to `root:xenomai` of everything in `/dev/evl`, `/dev/evl` included,=
 but still get `Permission denied`. I have checked my groups using id, xeno=
mai is listed.
>
> ```
> $ ls -la /dev/evl
> total 0
> drwxrwx--x  8 root xenomai    220 Aug 21 14:53 .
> drwxr-xr-x 20 root root      3260 Aug 22 15:53 ..
> drwxrwx--x  2 root xenomai     80 Aug 21 14:53 clock
> crw-rw----  1 root xenomai 245, 0 Aug 21 14:54 control
> drwxrwx--x  2 root xenomai     60 Aug 21 17:08 monitor
> drwxrwx--x  2 root xenomai     60 Aug 21 14:53 observable
> crw-rw----  1 root xenomai 245, 3 Aug 21 14:54 poll
> drwxrwx--x  2 root xenomai     60 Aug 21 14:53 proxy
> crw-rw----  1 root xenomai 245, 7 Aug 21 14:54 random
> drwxrwx--x  2 root xenomai     60 Aug 22 16:02 thread
> drwxrwx--x  2 root xenomai     60 Aug 21 14:53 xbuf
> $ id -Gn
> virgo wheel dialout ftp xenomai calcul softs_cc diaporama
> ```
>
> It works though if I change the ownership of the `/dev/evl` tree to `paca=
ud:xenomai`. What would be the reason of this behaviour ?
>

In addition to making those files owned by the 'xenomai' group, you need
an udev rule fixing up the */clone files in each element directory
(clock, monitor etc.) giving rw permission to the group members too
(i.e. 0660).

--=20
Philippe.
