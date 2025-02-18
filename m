Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FF22ACCE
	for <xenomai@lists.linux.dev>; Tue, 18 Feb 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866038; cv=none; b=l+6mi+j5YTOSYV1kZXKdUmThFmQh+ouogNoh0DAXbxKoWN4Ot7P3kZ915uSSA7uMjlJjIvFnc59nkl6xyZDylVCnPZJR5/GMN2T1WEcrQJ/yG3Y+kXfcuwML57zrHPL2yf1slj/SibJHqpnBg7nm12vtZA8kzH37eS1tRkdvB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866038; c=relaxed/simple;
	bh=Cfht/WCAVBFeKOwfcBShw43U+RjEQzI6PysCQCNG5X0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=q4MC9USDVtN5kavF8G8Xu4GFKpXEKciOpDYySEbWMJIe3KFp7Ep06z0dSWTSFihLy5a89z5H72+k/fbUBG4r/tCfpieh5woHMUgkWisjpVF8keSi/qPhRgaeKgVaSeioTaRqQyKJ3q3Qu7qt78qSxL59hXc2BipaAmw1hkK9zgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BIvfIwkJ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BIvfIwkJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250218080708336932620f724d8923
        for <xenomai@lists.linux.dev>;
        Tue, 18 Feb 2025 09:07:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rjc4AVIyXrJMQAtxiZQK5LVh83TrC8PE8T4arf6gwOY=;
 b=BIvfIwkJJ2hA9J+ZOhlML9UETxmcQTWEaCyOLWMVI9DwdOLJK0SgdPRXf5/6QUGd6rGHwf
 zc5xZE+pQf7opv7Dn/UgrWu2cHX7oydLj824lF/a61lSIVyZLrCvyUmUvynae4fwcTK/pB2V
 0svalE4mJTO8jAyJoAixOC/qmWCT7TH7d1eIYdlN4l6b4zFD3G7c4GclLfCL9huVhOps2Sbi
 Z5vPPp129BqPokxIE2AG/a14eMbe2bQyiMN1l+ghM4QOVEt7C/3Ms0mp9aVDJ7vNwlhWmari
 HVmlhafzx/JJSmi96mqR1CU0AVkTdhhtw4ZGfQlphSTfLmBIv9HWQ5sQ==;
Message-ID: <4755dcf6d428d38e6c7bc3084e730a41899585e3.camel@siemens.com>
Subject: Dovetail 6.14 forward port state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 18 Feb 2025 09:07:08 +0100
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

Hi all,

a short summary of the 6.14 forward porting

- Philippe is currently reviewing a change to the IRQ pipeline
  that I made around CONFIG_GENERIC_PENDING_IRQ. A bit of code
  cleanup will be necessary - once we agreed the changes are
  correct.

- x86 was fine from the beginning

- arm64 needs some fixes to the fpsimd code. Crypto code will
  use in-kernel fpsimd sections which could not be preempted
  by OOB so far. The tree already holds a fix for that. Once
  a couple of tests were successful I will send the patch to
  the list.

- armhf: Tests look "good" but super slow. I'm now able to
  reproduce that locally under kvm. Seems some kind of stack
  miss-alignment. Ideas welcome.

  Intercepting the xenomai testsuite while running delivers
  the following call stack:

  #0  0xc04dd558 in ktime_get_mono_fast_ns ()
  #1  0xc053766c in xnlock_dbg_prepare_acquire ()
  #2  0xc052a0f8 in ___xnlock_get ()
  #3  0xc054af90 in CoBaLt_mutex_unlock ()
  #4  0xc0552fe4 in handle_head_syscall ()
  #5  0xc04003d8 in vector_swi ()
  #6  0xc04003d8 in vector_swi ()
  #7  0xc04003d8 in vector_swi ()
  #8  0xc04003d8 in vector_swi ()
  #9  0xc04003d8 in vector_swi ()
  #10 0xc04003d8 in vector_swi ()
  (seems to continue to infinity...)

  At least the "slow test suite execution" might be related to FPU
  (vfp) again. We do not allow to preempt in-kernel inband=20
  kernel_neon_{begin,end} sections - AFAICT.

The tree (wip/6.14-dovetail-rebase) branch is located here:
https://source.denx.de/Xenomai/linux-dovetail/-/tree/wip/v6.14-dovetail-reb=
ase?ref_type=3Dheads

Best regards,
Florian


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

