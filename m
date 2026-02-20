Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CB29B79B
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586353; cv=none; b=mJfh00vK6Xyz7ntUzK7JmTdLZrxz5GXCbqpyUBhUFzQc1DYZVp7uZw0mOlmlXDDC88OW0WvSIfyD/GNrODzm17rGzAxjw7eJ5TxVh8Dqgx33Sa0kqJ7NIeVSuLVzmervKBQT0gE9A1i7DPiTuk1arSYnOuBhMZk9IFY0ghTRCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586353; c=relaxed/simple;
	bh=loGDeK7kZffZAIutYDKLut34k8iq8yvQ7mcKWYMh/ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MILs2RT+bgo6GBGnQxeRLnBmKu0wfTbiWzAHic52BHas9pXTP+AgVMXjh8jYMicD0z1iTkZp741ARb6XqVzuZv+C3eZif7OkY0ZVGDXgLruEyPfX/DxcW0lRv7RF2vOIu5EJaX7qcyaExwx2ETCtVhcjX3hKaxhokqYkRwU74Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QnF1i6B0; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QnF1i6B0"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260220111905d15470f1fc0002073e
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 12:19:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fDUIl1wOiLO0Mzx3IBTte25maYujQOtttqadhKZS1vM=;
 b=QnF1i6B0AR0RpaQDKSLe4ErKXFJWRipoms5yEFk6Vvboi66qGD+gdanOVu+Ww3dzPTWi3q
 Eyfkb5QFW32kFPIcHvSXg0Y2ha3RdTvtuKs5A98KkOTfzTcmYztmhmLrMDldnvG3Mzsc6/yH
 E6bRTqDPsD59hp4nVCtIMZ4fj5jYIeg8xQasYAxqGxhjP7f5Jdod0fjpnxXMV1xgAX8YvR+y
 zqCaJmfX9Lg4cNrKdJWzopU9GDOAZx0BhrcPswOt9SnKu+KVU/oJWMb7/ncYkdWUPHwCSgkk
 X/Jvnsrr0wWik3vZmJKYD1vWiwg906VbgrpJsrGCeteSpXJZnMvRZyhw==;
Message-ID: <fdea742b5c4d6d71d7061bd0421981d13b370022.camel@siemens.com>
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Fri, 20 Feb 2026 12:19:04 +0100
In-Reply-To: <87cy1zhdob.fsf@xenomai.org>
References: 
	<20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
		<87tsvbhigf.fsf@xenomai.org>
		<faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
	 <87cy1zhdob.fsf@xenomai.org>
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

On Fri, 2026-02-20 at 12:12 +0100, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > On 20.02.26 10:28, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi all,
> > > >=20
> > > > The current time64_t / y2038 support switched libcobalt to time64_t
> > > > only, removing the interfaces for the native time_t type.
> > > >=20
> > > > With that series applied both worlds can live together in one libco=
balt
> > > > build which should hopefully increase the backward compatibility a =
bit.
> > > >=20
> > >=20
> > > Is this series re-enabling time32 in a way?
> > >=20
> >=20
> > It's allowing to keep the time32 ABIs around without having to use
> > --disable-y2038 for configure. It also resolves that we were changing
> > existing time32-only functions to time64 where glibc actually added a
> > separate one (see also
> > https://lore.kernel.org/xenomai/cd03fe98-7237-426d-91c7-c6eae63a617e@si=
emens.com/T/#u
> > - which probably needs a rework to align with this series).
> >=20
>=20
> Ok, so this is merely to keep the legacy applications building over the
> latest x3 releases as transparently as possible.
>=20
> x4 is unlikely to support time32 for much longer though. With the
> upcoming support for a POSIX API, we can't make a pledge for a stable
> ABI yet - timeouts on syscalls have to be handled differently on the
> whole user->kernel path in the evl core services, in order to enable
> some of them for POSIX too. I plan to use this change window for phasing
> out time32 entirely in the same move, which would simplify the POSIX
> implementation significantly compared to x3, not to speak of the fact
> that using time32 for new applications in this day and age would be
> obviously wrong anyway.
>=20

I see no problem here. If possible - and that seems to be the case - x4
should not deal with time32 anymore.

A possible update path from x3 to x4 would be:
  - x3 no time64
  - x3 enable time64
  - move to x4

That should be doable.
