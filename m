Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B228750B
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101693; cv=none; b=ZmhDvojTwPgBBJtKfft4VkrXBhrcjQNYsAXfkqA8T1Mu6F10FIRgoOU2Em9n1hyojzbh7uOcER5XbS8nNJJKRMXkpswBuJWoakzaL6HoaOKZfhgetqfhguzkzicfRaTMZlrrzTuVhVpkZ53bUV7WoKJipKfu5J4pBuXf4Ag9Hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101693; c=relaxed/simple;
	bh=wKz9Mi2NYSgOCzxCqsTRT7G+5QA8YErzv2DLpdMwOwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgWZLzcplLND0k+AgVHDoXt/0fcJ9S4KFhuTZ+7fGeOFZcq9KZaHL4+KMFAbTdJ2dDuQeONhi23PhUKCbmRIHAL4rGTvng/R9lmIOlYiLAmufGSxs7D5ypLwVd4EsBMgsr2FoAb7ToN/YYw4z10EyM/3HCwnWjNrCLt29BY1uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=O+qCwPnU; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="O+qCwPnU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25AFB105849;
	Fri, 10 Oct 2025 15:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1760101687;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UMKn0a2m6aG6a3Y68QF6zvCf+JjBm83tbEjBaoMQOXU=;
	b=O+qCwPnUk9biGIvborx8JpAbu+mNnPdkEO9I+YNXax/2HZ8J0ql1+2h4k0GTDHGHagt4ht
	2Oq3Ux8eMb3Vhq8gKN4AjTDjm4FbUyBknravfQ31evBhuweuhLYacUHjI3TFULgEXjMUYs
	Syjd0JqXPIRO3O3l+cpAmpsbeHqs+097erG3xvLOo8ksk2jqoDnYUyrEE8NlvJDxZeRzAj
	d58y0J5tK3qOdRLuDIbTazppiC2EXLa7VJ5WYqHIO1xdlTZgap0BztkQHvX3Rd2Hq+zGcK
	p0W3y8CvNJW2oe0LliD6MCx5qhdDXas7ZMUwuz4872LJW+CYLetvjMj75lLV3A==
Date: Fri, 10 Oct 2025 15:08:05 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251010150805.36a2b683@wsk>
In-Reply-To: <a3af644a-f056-2b99-7671-461681962a0e@bela.io>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<20251010122427.54ebb9ac@wsk>
	<a3af644a-f056-2b99-7671-461681962a0e@bela.io>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

HI Giulio,

> > 2. After the "first" occurrence of the in-band switch in latmus,
> > when it is started again, the issue cannot be reproduced any more.
> > The conclusion here is that the issue is with "startup" or "fresh"
> > configuration of memory subsystem with dovetail =20
>=20
> Do you mean that only the first instance of latmus that is started
> after a reboot is affected by this issue, while successive instances
> are not?

Yes. That is what I do observe.

Just to mention - I do run latmus only on cpu2:
latmus -c 2 -p 1000 -P 99

Test programs are run on other cores as well

>=20
> > With guidance (and huge help) from Phillipe I'm now ftracing the
> > evl core with latmus to check what can cause the issue. =20
>=20
> Would you be able to explain your setup here to see if I can
> reproduce?

Basically I do run in one ssh connected console:

evl trace -e 2=20
latmus -c 2 -p 1000 -P 99
...
...



On the other ssh connected console:
<test_program_10GiB_vector> &
sleep 5;
<test_program_10GiB_vector> &

Then in latmus console I do see the switch to in-band notification.

=46rom dmesg also I can read:
[   94.685063] EVL: timer-responder:745 switching in-band [pid=3D747,
excpt=3D14, user_pc=3D0x797b51227f20]


And te 94.685063 timestamp is crucial here. Unfortunately the ftrace
output doesn't match with it - i.e. there is no operation "around" this
time (there are ones 70 ms before and ~20 ms after).
This I'm investigating now.

>=20
> Thanks,
> Giulio



--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
