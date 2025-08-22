Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAA30E823
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872984; cv=none; b=GiO5FlkvhJLXZQEz1XScjM8mhlD56oNwS4xeF7by30H/UYaPQ3zSi4mDZGydNiU0qzlX35ZSuT/+nCTSPNpRBQ+kipGU95ZDQEwRJIPJCr5CpK8P/LyF2EHjwvQStR6Mne0oEW2bC0ZcOlWVeWS45yGIcHTN26giTTeSSTXWNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872984; c=relaxed/simple;
	bh=xcADzGG7F5CyM2gIMoXm++4eqRpn0BYg0lKHDD9Scrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6gWhJ3nWuzXYrq1gMJ8nZrYcTtqQpK6U2dTdxA2imj84cOp7Gp6+vZTdMyoCm6zjW3SQO4a1dQMuMr5VOu08oU9jijuJBf7aJOkz9axsVSsZbib11x65A6ZsYJatF/8AwZJrwE+Tyjf0k611iB4VChATIS//hN2qjO21Ds4l4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57METU20017237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Fri, 22 Aug 2025 16:29:30 +0200
Message-ID: <f71b0364180199360785ffba2b8e08963ea53775.camel@lapp.in2p3.fr>
Subject: Re: xenomai4 - running applications as regular user
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@lists.linux.dev>
Date: Fri, 22 Aug 2025 16:29:30 +0200
In-Reply-To: <87plcnhlrm.fsf@xenomai.org>
References: <a597e0a51e4adb69e3ff9041f83a67d588c861e6.camel@lapp.in2p3.fr>
	 <87plcnhlrm.fsf@xenomai.org>
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Le vendredi 22 ao=C3=BBt 2025 =C3=A0 09:13 +0200, Philippe Gerum a =C3=A9cr=
it=C2=A0:
>=20
> > What is the recommended way to run out of band applications as regular =
user using xenomai4 ?
> >=20
> > In xenomai3 documentation, there is a dedicated page about this, <[http=
s://v3.xenomai.org/tips/regular-user/](https://v3.xenomai.org/tips/regular-=
user/)>, but I did not find similar instructions in xenomai4 version.
> >=20
> > Emmanuel.
>=20
>=20
> See [https://v4.xenomai.org/core/user-api/#device-ownership-and-access](h=
ttps://v4.xenomai.org/core/user-api/#device-ownership-and-access)

Thanks.

I have created a xenomai group, added myself to the group, changed the owne=
rship to `root:xenomai` of everything in `/dev/evl`, `/dev/evl` included, b=
ut still get `Permission denied`. I have checked my groups using id, xenoma=
i is listed.

```
$ ls -la /dev/evl
total 0
drwxrwx--x  8 root xenomai    220 Aug 21 14:53 .
drwxr-xr-x 20 root root      3260 Aug 22 15:53 ..
drwxrwx--x  2 root xenomai     80 Aug 21 14:53 clock
crw-rw----  1 root xenomai 245, 0 Aug 21 14:54 control
drwxrwx--x  2 root xenomai     60 Aug 21 17:08 monitor
drwxrwx--x  2 root xenomai     60 Aug 21 14:53 observable
crw-rw----  1 root xenomai 245, 3 Aug 21 14:54 poll
drwxrwx--x  2 root xenomai     60 Aug 21 14:53 proxy
crw-rw----  1 root xenomai 245, 7 Aug 21 14:54 random
drwxrwx--x  2 root xenomai     60 Aug 22 16:02 thread
drwxrwx--x  2 root xenomai     60 Aug 21 14:53 xbuf
$ id -Gn
virgo wheel dialout ftp xenomai calcul softs_cc diaporama
```

It works though if I change the ownership of the `/dev/evl` tree to `pacaud=
:xenomai`. What would be the reason of this behaviour ?

Emmanuel.
