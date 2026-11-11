Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399058;
	b=y8FcFQCgIKj/YYSV0N5kNinUJSWf3TTqN3ySCFVNEdtliPm6Iekt31uYd8ZNB3Xvd9X4
	 yMlwOQ4sJWbAHn4LUkjRS+KEPZH0Zlp7XzrurB04pEWLKuImGjHjFO9zOYsgolGsQm6UJ
	 ZgQGiuJ41fHLKQZFDPzwQHYpr33D2+XrdLlUwF7UHbjWMErNULi/egup2P1SC/2hkIjfV
	 kz/B4EwmisTYjpYh9yO4BSmv/pxCqK1evGztFN8oZZnhOzKLt1pb+K+yvZej7s5Qyl+wX
	 Lz3pNR0wbXqM5hyhd+qN7NFUg1ombQtJDH3V42+JFi69SXbUfmpNouqsaI9how+dpKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399058;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-GND-State:X-GND-Score:
	 X-GND-Cause;
	bh=I8otwS/eVDPGBRG6FQ80TuKfV+4z2ibmXqGEWoTYlU8=;
	b=sIqXn9i580VM5nloUW56koUiTDK60jLRGFeTPXAiAQ27q9KLq2YTT7+07R/zxaHqvIDm
	 Vfr9XBXMN07fgj1wEzJmS23iLESvGoG/ZC+NuFtPGVRNWp2LL0HU6fEhkFAZA94GZtrX4
	 PMBFfpUayObMyczclJ5sOcCrMLd/TpiGa+h11Z6LdqxWbP/SQj1PKvDYiqZWbP9nKUnK7
	 XdUVFQMEmyRqUemV4voxsnkdEpt3876a5lFv0jAcDPFoh5KYYR79FGYiJxhQdgfnQTdZh
	 3AQizArsxk6uSX8OmpQ6o/4x6v0ygyEB/RqVONfQ3X1UGLkhBoM6TZgTebqckDkvASA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=RZxtQUMn;
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD42606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=RZxtQUMn
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 94EA73E978
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3C65BC00482
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=RZxtQUMn;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202611111210493d8672ea4b0002071c-_CDm8e@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-294854-202611111210493d8672ea4b0002071c-_CDm8e@rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202611111210493d8672ea4b0002071c
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=I8otwS/eVDPGBRG6FQ80TuKfV+4z2ibmXqGEWoTYlU8=;
 b=RZxtQUMnL770Bomdtvj36vY5VTQp1bLxMOtBE95jU4S9OZdB9Z6zfrm2fg/VHg3iOANrrJ
 joxp25HtoEeGFYFf3EW0336OUqs3EvMk3u0os3/u3enntsNofvjqDkT1eUYHl0d3woNqTu+K
 yCQR9aKE8qnNisZsvqKdTvlcpr+x4sMoy8gnXj+BAQr48bL/pdcF/cSpsxeMEQnC0eS0Hc3s
 b0lKzE6s68vz6rlHwu4dEZcMGADIQsX6wH/5/hPU1tLGYROsMYoqQgg0VLTH4DaR9PMIfo5i
 IS7lPV02ST6/OETtQMBfFsQo307weNaUA5CTqLSVOSZX0NFYblQNAB8w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of trap nesting
Date: Wed, 11 Nov 2026 13:10:43 +0100
Message-ID: <cover.1794399047.git.jan.kiszka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFHEZzFgGXpZZfr6IAOmq7ola5WNfyQSnYF6LCb6f1KMkgZa4qHjCqK2uwNi5lo53zPGBo7LDHZdet9q5I/rBsO7mYZPYcUHmDnRSBj3QTHGK8XCfIUabA4owcyUCpat5SDL5jtpg/EzlPTAvfZ9kMTVx+Jq5Yn6Jfc3Gnwik48nyq3kK9u6OYJSbOlHdYCLeVfGLKic5i7LqDCecBujBJwI6Hv2Y60PpP3d9XNM7x4j7rYsPbpdKfxriyrV319I1tSDLB8CbioxqfT3ZiYNYFu+c1MkaVsWVtH6E9BGta/ZC7ZZO8e6p8wxp2ltCtBWEMTtu8sJmVrWp3JyOv5sKtDjfXKu0rDRBSgrE1MNAFf5tv7b2y4Y4h0bJq36ku2wuT8Cx1GatEvSffpQ7vxqiVAGpA9jfNLT4TpAxq5Kb+qj/2gtyE/pR2X3JZzudv60DC9RgEyAonsy2oss29dD+H4UlHu00q2vUXGMLvaQ4hzrmoV7fnBelzdABScn2iWHvjbw0n1zcNOnwl4ISJfXn8snoH/3R/jDy1DBkdDaMxUy4k9IMb6nSCKFcNAqERu6Zi9B4zco3yTHN7uDpTCSy4fPL6MWz2igVrFGaUqCAThDXRW1aDwIqtJrnWPB343pVyHlNajvFrELj1+7ct1WeWtov7X7HLuETkjkxS8Laaslw

[v2: rebased without changes, resent due to delivery issues of v1]

This is both an expression of personal laziness as well as an experiment
update about AI support for Xenomai core development - and it seems it
was fairly successful:

After noticing [1], I simply prompted in Opencode using Fable 5.1 to
review the ARM trap entry paths for inconsistencies:

"in arch/arm, analyse the annotation of trap entries with
dovetail_fault_entry and mark_trap_entry regarding completness and also
corresponding dovetail_fault_exit / mark_trap_exit"

For that, I just presented the wip/flo/v7.3-dovetail-rebase branch. And
the model came back with finding on [2] as well was these patches here.
Next, I asked for a review of arm64 and x86 as well, but there were no
findings.

Finally, I asked for the extension of smokey with some trap test cases
that demonstrate the ARM issues and test similar paths on arm64 and x86.
That turned out to be quite wasteful - I should have filtered out
irrelevant traps first, namely:

- ARM VFP exceptions - no hardware exit to stress them. But I'm leaving
  the related kernel patch in here because the code was already
  instrumented, just apparently incorrectly now.

- x86 Alignment Checks - can be enabled by userspace, but everything
  left and right in common libs will then explode. IOW, they have no use
  case in modern software. At the same time, some patching of libcobalt
  would be needed to handle SIGDEBUG for an #AC migration.

I will share the lengthy test case as well once I'm done with stripping
it down further (if possible). What the tests already demonstrated is
that unpatched kernels crash.

These patches here are almost completely generated. One of my few
contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
of having oob_trap_regs as a nesting detector came from the AI, though.

As usual, AI is still rather verbose in descriptions and comments. Some
of them I already shortened, but most is still left. We can cut down
further, but I would first of all like to have another review round.

While doing that, keep in mind that AI tends to ignore issues left and
right when being told to do a specific task. It may have simply missed
further preexisting issues or even created new ones now. Watch out!

That said, it is definitely impressing to see that a frontier model is
able to build up decent understanding of the Dovetail architecture
without further hand-holding. I would not blindly trust them yet, but
they seem to be ready now to act as debugging agent or at least
companion, even in complex scenarios. Giving some LLM access to a CI
pipeline may even result in automatic regression handling, probably
already today. Also, I want to explore what is helpful and reasonably
needed to support stable kernel maintenance.

Jan

PS: If someone is interested in the token costs: Due to my inefficient
model usage, the counter stopped at about 170 EUR. Most tokes went into
test case development and its debugging (#AC issues, e.g.). These
patches here likely costed about 40 EUR with Fable 5.1, checking the
other archs maybe another 30 EUR.

[1] https://lore.kernel.org/xenomai/8ecd3d1a-86d1-4f39-b175-b712c0be6eec@siemens.com/
[2] https://lore.kernel.org/xenomai/2e3b8eec-7911-4abe-8082-97296000e88d@siemens.com/

Jan Kiszka (4):
  dovetail: Track the owner of a trap notification by exception frame
  ARM: dovetail: Fix trap unwind condition in __und_svc
  ARM: dovetail: Notify the core about undefined instruction traps from
    user mode
  ARM: dovetail: Fix VFP exception trap notification

 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm/include/asm/traps.h         |  2 ++
 arch/arm/kernel/asm-offsets.c        |  2 --
 arch/arm/kernel/entry-armv.S         | 20 ++++----------------
 arch/arm/kernel/swp_emulate.c        | 22 ++++++++++++++++++----
 arch/arm/kernel/traps.c              | 27 +++++++++++++++++++++++++++
 arch/arm/probes/uprobes/core.c       | 10 ++++++++++
 arch/arm/vfp/vfpmodule.c             | 27 +++++++++++++++++++--------
 arch/arm64/include/asm/thread_info.h |  1 -
 arch/riscv/include/asm/thread_info.h |  1 -
 arch/x86/include/asm/thread_info.h   |  2 --
 include/linux/dovetail.h             | 12 ++++++++++--
 include/linux/sched.h                |  5 +++++
 kernel/dovetail.c                    | 10 ++++++++--
 14 files changed, 103 insertions(+), 39 deletions(-)

-- 
2.47.3

