Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5B20B214
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636683; cv=none; b=AhYMAMiJ2By1Tt4qL7ucOTfRbRfbaysSh3welKSN4AFF37UXwufKNPLFhu3uHvVBvb3+XPK3dZU/XANzp8DxY3ldzI58JHkTvhVtN5OMIEZE+xq8lmErvWS0RX7MzdcroXOBkUbgolmT5gMmWoAgM/5aTw8BuNAt2Uice+yTvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636683; c=relaxed/simple;
	bh=MN4UCH4c/bjbBobJNGQfhfptc1tyyZqMz7db5Ooggtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKzjvON+XKIpRyTiXebi4lscvBaKWgLcxVJ8Z9jX7T3rFsFXkwOrbDW4bg4wIoGoNk9zY2k306TSGVLeFdI8Nt1FEhxjR8mauIXCe5J9oxRbqdM9myXPNxHIg+gg58wDYToQo4xf3pdINO6t1HcQrSETZTkg/iSmuL7rsoTPzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KwmWa4ZZ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KwmWa4ZZ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241011085117ef7e8dd411a2a11c8f
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 10:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lla19PsMixOhkr3IvFoYZnpEp/krSoKiyqx4rNEtdcU=;
 b=KwmWa4ZZRt1XyPDw6zHxMgSmHtUWCnBJeFrk4Ij/R7rVtj+XeChH9rz0cvdlwPI7EjvsMZ
 6YHY3LtW8qlG2PfbRa1OCKSYKkVTFrnn+sJYw1VHyXz3hIdYXeM6asW47ma3Iv7XtC/EbQN0
 r6lARMguoVeY8cQDs5Rz6REqyrKTBMai5zs+p0Iq5hM8FYjSKPZvDjr/b8a9/8e3TqIBk/jV
 w2ImZq5oE8eErM+kme6WeQHBnf29xR2IcwFbrhZ/CnsV8/S1jWU/tYb/NjXpZ/o1Gnly3yPC
 vgZYpWbedzs7j2opeQpa5gjii/JssNdw91T5Q4pS+nAEFBFoE+EfQCpQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 10:51:18 +0200
Subject: [PATCH v3 4/4] y2038: testsuite/clocktest: Fix link compile error
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v3-4-2657330fad19@siemens.com>
References: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following build failure was detected on Debian sid/trixie:

clocktest.c: In function ‘read_reference_clock’:
clocktest.c:90:17: error: ‘SYS_clock_gettime64’ undeclared (first use in this function); did you mean ‘SYS_clock_gettime’?
   90 |         syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 SYS_clock_gettime

The problem here is once again the changed behavior of the
__USE_TIME_BITS64 macro. Up to glibc 2.39 this was only set/defined when
building a compat application. So when time_t was "upgraded" from 4 to 8
bytes.

From glibc 2.40 onwards this macro will always be defined when time_t
is 8 bytes. So we basically run into the different code paths when
building 64 bit applications.

The reason for the compile error is that SYS_clock_gettime64() are only
provided by glibc when building compat applications.

Nice side effect: Should increase the support of libc implementations
where time_t is always 8 bytes, like musl.

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/clocktest/clocktest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index a611ee889..4d87ee700 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -86,7 +86,7 @@ static inline uint64_t read_reference_clock(void)
 	 * Make sure we do not pick the vsyscall variant. It won't
 	 * switch us into secondary mode and can easily deadlock.
 	 */
-#if __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 	syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
 #else
 	syscall(SYS_clock_gettime, CLOCK_REALTIME, &ts);

-- 
2.39.5

