Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477028ED
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 09:34:49 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230517093441fa963c1df36fc0f4fb
        for <xenomai@lists.linux.dev>;
        Wed, 17 May 2023 11:34:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=f67F2df80nojnJAtk3B+W1k4CQUD2U5FZ1hw72kCuJo=;
 b=JyIqz0Hy8VvLZkynFokN8X2BQ2jUFwqMf4/A1txGbqilVPGc4ijaNeBYsT+CAIthOX4XFe
 yrk7OYMn2GoG0Q47yjOtRPwBpdKqMp89xWHt/Y5i1aR7dRq3Mip/kNh3gPCSX2zAHE+IFaMA
 erp365bM+w7IvlB9iAKnpEe10aFK8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] y2038: Part three - support for select()
Date: Wed, 17 May 2023 11:34:39 +0200
Message-Id: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+fZGQC/x2N0QqDMAxFf0XyvEBt2dD9ythDrOkaKFFSHRviv
 6/s8Vw49xxQ2YQr3LsDjN9SZdEG/aWDmElfjDI3Bu98cNf+hqksJqT49S4MuJJtuGVjxuDGMNO
 YOKYBmj5RZZyMNOZ2oHspbVyNk3z+vcfzPH/6cHK7fwAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
next/master branches. The full queue [1] holds ~7 patches. I'm trying to 
split that up to keep reviewing efforts low.

This series brings y2038 support for select().

select() is somehow special. Linux does not support a y2038 safe
implementation for select() itself. If the application needs y2038
support the application has to use something like the pselect() service.

To make select() y2038 safe glibc wrapps select() and wires it to the 
pselect() Linux service.

Xenomai (cobalt) does not provide pselect() yet and it's not easy to 
implement that. The reasons:

  - The underlying xnsynch infrastructure is not prepared for waiting for a
    combination of file descriptors and signals. (Let me know if I
    overlooked something!)

  - Implementing pselect() would require up to 6 parameters that need to
    be forwarded to the kernel. Xenomais current limit is 5.

To get select() y2038 safe a "pselect64() like" service service is being
added. The signal part is skipped.

The wrapper for __select64() will be added later and will convert 
struct timeval to struct timespec64 in user space. This way select() 
provided by libcobalt gets y2038 support but pselect() is still not 
supported.

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      y2038: cobalt/posix/select: Refactor __cobalt_select()
      y2038: cobalt/posix/select: Adding pselect64
      y2038: testsuite/smokey/y2038: Adding tests for pselect64

 include/cobalt/uapi/syscall.h                      |  1 +
 .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 +++++
 kernel/cobalt/posix/clock.h                        |  6 +-
 kernel/cobalt/posix/io.c                           | 94 ++++++++++++++--------
 kernel/cobalt/posix/io.h                           |  8 +-
 kernel/cobalt/posix/syscall32.c                    | 24 +++++-
 kernel/cobalt/trace/cobalt-posix.h                 |  3 +-
 testsuite/smokey/y2038/syscall-tests.c             | 70 ++++++++++++++++
 8 files changed, 190 insertions(+), 38 deletions(-)
---
base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
change-id: 20230516-florian-y2038-part-three-3093da9fecf8

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

