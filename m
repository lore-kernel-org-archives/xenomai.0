Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6D357CF7
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687227; cv=none; b=jgLQ5+dVQwFhSkEJH39f/ABIFWdEeW6c4LHro9mUBmahzITj4ylOLil66PJ9AhR18oi1xIXYURAV9xyvWpsfL1tswoLjS9wfPEeuEnv4PvZq/9UKzWrLUscF07mu/zUGF4lHtn0LMU0DRVMGZ5E18069lQg/LyM604F3gGiEGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687227; c=relaxed/simple;
	bh=VxsVLExoKd1brRWAHI6a2wShN6blTe3ip8PhoIYQ1kc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpN6dLN/mTdTfCYRE8nCkYo2uGiI/pSNpmF5VzrtIbDfUuxIiPnxu22Ib68nc6I+MXAbEusE37V/D+X079B3trq+0Nc0TvAAyOSAu1kPy5uUBiw374/6HO+Y/ExmVd12E0oT7xsbJnE9lDq5j9zvmJgPlLuld7Yy9dFGCSmPs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WD0+KFzH; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WD0+KFzH"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260513154700d5ee35a72a00020786
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 17:47:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VxsVLExoKd1brRWAHI6a2wShN6blTe3ip8PhoIYQ1kc=;
 b=WD0+KFzH55zeBv3utAVjH5LtQ4Fkjp3qv+XCqWgV48L025VbVLFzuPakjEKIHlCItCc8re
 nBG6MO8g1v74A2J4022kn1QOf5484f9ueD/8Ef1ygaEQEJ3iikPYx5frSoYyW8+dHBx4uZib
 kMEZSH/+o83CGVQqzGpwcHvjZe3o58qN30jrvEvM24ntOqdnubK/Fw0tMJi63mAntETvl+Ld
 PIxBbRD2y1HW00tuUc3O0c0CZe4yGXYHTipEguWuhA6jBubY9mALgeCtwb6Sha2NC0dj0VM2
 XVWNOWuVbtMaHBqXJfOBZao8fx5wIrdFZtpp3IBfdHAKq0aCYTb3m5Sg==;
Message-ID: <71d64b13cad700b14b699bf794fda4307d03418b.camel@siemens.com>
Subject: Re: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 13 May 2026 17:46:59 +0200
In-Reply-To: <295a77610687400d43dc4f05dbbb9e659afe4c0d.camel@siemens.com>
References: 
	<20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
		 <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
		 <bc8ac763cd82eb8f2d2ab53efc0a7b0275ec2551.camel@siemens.com>
		 <a23d90ac-e797-43d3-80fe-4fa15df47e43@siemens.com>
	 <295a77610687400d43dc4f05dbbb9e659afe4c0d.camel@siemens.com>
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

On Wed, 2026-05-13 at 11:32 +0200, Florian Bezdeka wrote:
> >=20
> > I tried some more exotic build configurations and e.g. Mercury fails=
=20
> > when --disable-pshared or --enable-debug is used.
>=20
> Hm. Can not reproduce here - nor in CI - nor with my usual compiler/os
> variations. Which ./configure line in combination with which compiler?

For completeness: That revealed a build configuration error that exists
since 2023 - or since ever for the alchemytests as part of the smokey
testsuite.

v2 will take care of that combination as well.

v1 silently migrated a compiler error into a linker error, v2 will
finally fix the build.

libalchemy contains some rt_pipe_* functions only if build for the
cobalt core (--with-core=3Dcobalt). Some alchemy tests were build
unconditionally, triggering the linker problem.

Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


