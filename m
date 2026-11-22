Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379494;
	b=p618ayrzlFus3j31NqYTd6fwgF5RyTfJEoxvV2FR3iUc9VTmz058CBKrG2C99zbsG9Lc
	 jSAii+6gD5PZhm2rA/UulG4HD/PrmcMCGnhfEvEjw90YTc9/tXOew0wJoL9f2pFoBnr8L
	 J5Pm/Y/PR1s3cGbHOwcw11tJ/N9K6WNBMWvtL4SsUqCauiK+yI0Qgai1rHOyY5E6GeZH0
	 hxdqa1DvYJh5BLbStsxUtUF5x81YYLuHlK2bUOl/YeScizfxBvQGzfCQ1takD+IKqvCHO
	 h3oDcMmc4HunufnEIOfZ2LeqwSGaQ4zBxWS3E8jgx/JNmGY5mBs0xSNZzz7nVa25ZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379494;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:User-Agent:
	 Date:Message-ID:MIME-Version:Content-Type:X-GND-Sasl:X-GND-State:
	 X-GND-Score:X-GND-Cause;
	bh=/dbhGRPqySrE3aOS7Wdq6qUrhuKJb6QVnG+5oYzAYq4=;
	b=ZF/NZQ43nNEEWyj+7483lprehTa2VAq0sqxTpagyrgfWHIJZuayGYqwNupEcm1Wr3bC2
	 dVzK0Phj3oDTffzKWLM3Gc0TYPWKusnUl5OMnDx5OzDyWXa1fHqcWV14xIhpcbjLun9NB
	 q+8yeLTUnC178G546S9yMXTrcOpxIhkhiTHzjC43eiEsRWbduylNlc8EgKWMEbJTqbKp9
	 9rHAOcOCrHkumQqKck5/Y4z8fWYBUoENHHLhVi94Ub+bmvpPXNC/AAZnO6F+4ZZRIT7cf
	 LFjnZ63IFPLzy4Dz2h8LSkBr2T4qnboqrx8XucuaxWFFGINpo4N3ymal6ULYDEz6ktA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=jjGvs22u;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E7606A31A
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 20:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=jjGvs22u
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C4843E80D;
	Sun, 22 Nov 2026 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795379484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/dbhGRPqySrE3aOS7Wdq6qUrhuKJb6QVnG+5oYzAYq4=;
	b=jjGvs22uJ+vHk0KI+TchM3lSHUlEu3Wx4XElC+CIS6kLQTNNKKXZDjQW4aEMVD+hBogpCi
	P9+vUeeCC7nlxSOi2paeyWer3LeUTRYKb6dbElcya1w9x++fs6m2mAYhLTA0QzvghUAK0Z
	pqeXRKGjJMcm90Bas+sW6+NZXwVCYE0+kKrtpdQmvJlKyeLma9s9vs8bCwwf47E21TfaaF
	G6tDuztNZAUCmimijxjUO6XGdt4KHh4URBXe0c+u9fJlqM4jEbEh1gUl89VoA0w2POIDSv
	6sipoawnAHshZTQ/fgQYweECCTMBO3LMGUZvIaol5Saqv/24/wMaYkpxTXbxkw==
From: Philippe Gerum <rpm@xenomai.org>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: [EVL] A POSIX interface has landed
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 22 Nov 2026 21:31:23 +0100
Message-ID: <877bi4bobo.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFN7RwvZHMX9OhdZvEugxNm41Cobd4vR1gf3/ay8VNIOIxe2N/iAWj0cMn9xD6YVl8i6RzruuGN2KXc1+2t1eaEMtRZKGeKjJJhjBiE3XUcA53Gk4Nj1sR5YS7fvOyYJCDrpppy/Kg5UbpHKZONq5xO1iKvvNqOoMuBGnM5ULhFyeaM2psAKlCGnEmjFh7eakEFXq8+JcOR9pj10WX7zo5FlOTm2dA+hO4TBZYK7GCzi5Fi5CoS51g9iq5plM034ni8CLdpEFrlg2Y6dufzBq6osXPyN3aty7IILqOz/V3B9ceBspYDNGpAnnWuJ7frgUrVXWE70kNZpeTg88AdlJ5BAWhOu5P/G5CrPDVQoIqejRPqMGvM+p4o8HApsdnFNH5u0MxQ0AjF1qDqkGzgWgNsdXVALUP6xsRf/pwRgF6gKEEOdniyAil3pN7nMEJ5buxUZgzf0cL0uh2bcrDPpB1/pbMihGHBzFKW5Ray37s+siprscoNY1sgzrxAysS/AhmRMGd9G46g3wTpYuAhDWPaxpal/iXytqV3cH+F3SfKXMmM+HHfyLWrASRd3WzlZNPcSrRcioPWNP050ZNqN+YMZwzkDRC19OPmQYdeRLj42xg4utMzrjDrl/eYxKb8SQ49bb6Znrr7a54zNKqav9KUBZrrtw+5yHQTz2bBVNQFSg


After several iterations, pauses and rewrites, a POSIX-conforming
interface is finally available with libevl, alongside the original EVL
API. 'libcobalt.so' is generated and installed with its headers
side-by-side with 'libevl.so'. We can use any of them or both,
separately or combined in a single application. The main goal is to
cover what x3's libcobalt provides feature-wise, and even more in some
cases. An optional compat mode wraps some v3-specific services when
needed. The target spec is a subset of POSIX.1-2024 for evl, although
this only meant adding pthread_cond_clockwait(),
pthread_mutex_clocklock() and sem_clockwait() so far.

libcobalt is not an emulation of POSIX calls on top of the original API,
it is a standalone implementation sharing a set of intrinsics with the
latter. These low-level intrinsics talk to the evl core, keeping the
nitty-gritty details out of the window dressing, i.e. the user-facing
APIs.  They are part of libevl.so, and both APIs use them the way they
see fit. If you plan to write your own real-time API leveraging the evl
core services, go with the intrinsics in libevl, this is their basic
purpose.

Documentation is not there yet (how odd?!). This said, there is an
ongoing work revamping the x4 website in order to introduce this new API
and some kind of versioning as well, so everything will land in one go.

Crash course: libevl builds the POSIX API by default, you only need to
pass -Dcompat=true to meson for enabling the full v3 compat shim. Once
installed, use `pkgconfig --libs|--cflags cobalt` to retrieve the build
flags for using libcobalt. evl-test runs the POSIX test suite if present
along with the test suite of the original API.  That's it (_that_ was
short!).

The implementation required additional services from the core, so
changes went to linux-evl as well. The core stays POSIX-free, but it
does provide a couple of new general-purpose services which are
convenient for implementing a POSIX API in user-space (e.g. see the new
'depot' element).

NOTE: The code stops short of one aspect: it does not provide symbol
wrapping like v3 does (using ld's --wrap trick); explicit annotation
using __EVL(call), __COBALT(call) or __RT(call) [all aliases] is
required at the moment. This is deliberate, this needs more thought
because symbol wrapping the way v3 implements it proved to have nasty
pitfalls over the years, as it comes with hidden edge cases. I plan to
RFC on this in a separate thread.

I merged the POSIX support and its test suite to the next/ branches in
linux-evl and libevl; the kernel part should move to the plain rebase
branches once the CI says that all is fine with its test configs. At the
moment, evl-6.12.y-cip, evl-6.18.y and evl-7.2 are up to date with the
POSIX support. evl-v7.3 is late, but almost ready and will appear in the
coming days (I'm almost late for v7.4 which means that everything is
going -*cough*- as planned). Keep Calm and Rebase.

-- 
Philippe.
