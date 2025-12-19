Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25926A1B5
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163122; cv=none; b=Ah1UimvdMzsFvV+gPJFY/SGtu5nORtrlnmNmfIddDQMm3kKCr2lEpcHGPzRJ+ChV7JIaHUme+Vk6oJZ4fhUOjFmXQNSsrgeeypKWwX8/hJ2m4bJDQV9QS5UkQCWjI6g0Pwaxx9QSqanyuUfYo4LMZqW9DtPweKV6KKttktnqtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163122; c=relaxed/simple;
	bh=KZIY04CV9Js5FAcIP0xkMQu80W057JtNO/hBzgVvvlY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lwYmAzXDkY0dZCEi2KPEHzEhckXYtOgx9zOZqcEzpSwtcmrYj2JVec+vyZft9xecSTiiQiCXT8mk+nZp7NUy4fPawW6xD44V8aRK/rMIsWGxszp+CwcFpIcd17o/uw2FdFOy9MDEP0o7cKSuBki48J/L4Y9JpxbCWRf3GWXIfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=nu0gosfV; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="nu0gosfV"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251219165155ace4538564000207c4
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rHTrD/l7A5hmNQ+6XsI17m/KbOrWQRlSpKHLWbTL+HQ=;
 b=nu0gosfVZB8/UqGoFkG2jJ1oBDSp8Qxgpid9lSeRL9fecvlWXntHvTRYU1PAsz6ZE/gFGG
 kZZrQGMztARPRTvJM/DUHWx0FRqKq5G3pcXEdenz3rtaV3qtgEn0yMKSBwsI5c8HRc49u3t5
 AruMzJO3NppywqSahX5ZDJW8qaropKQhanfEbg/dFU21eNyJ6b2NK6M2QVgJ+lASXa7Kf5t5
 DvFd9LoylcluYYeL8pb4D9rZGofGDMvAkPJ9QJ+6zbA76OGWuJRMohNY3UTDqB0tODNC9ekK
 6pxj6vZVFrvNrAZoTbanUq10WmTmrKaV7zQxkNfoNQ84i0cAy03pW5EQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/5] Update dependencies, account for Xenomai support changes
Date: Fri, 19 Dec 2025 17:51:49 +0100
Message-ID: <cover.1766163114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

See patches for details.

Jan

Jan Kiszka (5):
  Drop ipipe-5.4 kernel
  ci: Lift x86 compat tests to 6.1 kernel
  Account for reduced kernel support for Xenomai 3 head
  Update Isar revision
  Update to kas 5.1

 Kconfig                                       |  18 +--
 ci/compat_jobs.yml                            |  12 +-
 ci/gitlab-ci-base.yml                         |   2 +-
 ci/kernel_5_4.yml                             |  88 ------------
 ci/xenomai_3_2_x.yml                          |   1 -
 ci/xenomai_3_next.yml                         |   2 -
 conf/distro/include/xenomai-version.inc       |   2 +-
 ...tom-support-to-add-linux-libc-dev-pa.patch | 132 ------------------
 ...-building-of-linux-libc-dev-cross-pa.patch |  35 +++++
 ...-missing-Multi-Arch-foreign-to-linux.patch |  45 ------
 kas-container                                 |  42 +++++-
 kas.yaml                                      |   7 +-
 kas/opt/linux-5.4-head.yaml                   |  18 ---
 kas/opt/linux-5.4.yaml                        |  17 ---
 recipes-core/images/demo-image.bb             |   3 +
 recipes-kernel/linux/linux-xenomai-3_5.4.bb   |  23 ---
 .../linux/linux-xenomai-3_latest.bb           |   9 +-
 recipes-kernel/linux/linux-xenomai.inc        |   4 +-
 18 files changed, 95 insertions(+), 365 deletions(-)
 delete mode 100644 ci/kernel_5_4.yml
 delete mode 100644 isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
 create mode 100644 isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
 delete mode 100644 isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
 delete mode 100644 kas/opt/linux-5.4-head.yaml
 delete mode 100644 kas/opt/linux-5.4.yaml
 delete mode 100644 recipes-kernel/linux/linux-xenomai-3_5.4.bb

-- 
2.51.0

