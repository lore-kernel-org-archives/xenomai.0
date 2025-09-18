Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72903112DD
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210975; cv=none; b=Rkrg6r+JpWRqynGeXp39kch70YbwB7UoGGQVFxQO6HsGNjwWlGUW37JAQwoZdAD0DlOusIgV6xu6HzwfvxX8fmbnz44NopD+LiWIck8+FOMg2oWS9b55egwFgWStjDzYUv6U+d9Q8Lb/SknU0gNsAWMxhbL3E1w3pSv6jMR1wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210975; c=relaxed/simple;
	bh=WPXLiwnGDkBHnHA4eIV+RC2sO6oCNmo4Hc6ndOSsVTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G/cxtXbplg5A3H5ds6AwQgbnlkBYMrarEIrd1xlosABFl9iKZ+1LOFQCP4uwMXImYESHdoBff7yFCGg4DCtg6b8VZctO3CEAbH+0gCuXqzEjlvkVhlh31VGpyIKX+/MCu1RM7JCOqZVBXOtmyVlHZICI7QU9jbnYDLKd6EdnaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=HsLUjfG6; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="HsLUjfG6"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155608c74b8dc52f00020716
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=EDrKQs6QNXrrTye1YFmWpbKuRJVfCmvBK5ezI3xjZvs=;
 b=HsLUjfG6IS97Q9NhQXMOyW5JYlbC71pSAyjmNf2tSK0BHk3K020NTHLAHKKTh1QC/YX1Pb
 0iaGCu7ARLclZR8PALo4DH67IlotbGgMAXYIFzRfS708//Hum7BvCdBkgLQw7QbWphWGBLk2
 izgXii82WTSdOqmZtNDPsnLc0Rxh669YfeR4mAdpaSqYdnXWrDcVYIqcqasjidRliADkeS1y
 fjzS0/QjnHklTmLIg2iBLPCdcM0R1hv98+w75bAXwmubxRDNRZ0y5qAeSV4PzFXe4x5Jf9wj
 IbjutPV2vAIYkSqfOKdrJQzLBTnF/rGbXxa/KJLO5oFKcfZzE2MG9kOg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 00/13] CI fixes and improvements, version updates, switch to trixie for head
Date: Thu, 18 Sep 2025 17:55:42 +0200
Message-ID: <cover.1758210955.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Several fixes and improvements that piled up while originally only
wanting to switch the images to Debian 13. That only partially worked
out so far because a few backports from head to 3.3.x are still needed,
plus a release of them.

Along that update, this fixes several glitches in the Xenomai 3
pipeline and brings the kas options to build all latest stable 3.x
releases.

Finally, this adds a build-only pipeline for Xenomai 4. We already
regressed with that target again, so this will hopefully help to keep
its build alive and will later on allow to plug the output into our
automated test farm.

Jan

Jan Kiszka (13):
  ci: Fix compat pipeline for 3.3.x
  start-qemu: Fix grey console font for x86 machine
  xenomai: Update to latest Xenomai 3 and libevl releases
  libevl: Unbreak build of r51..r55
  Update isar revision
  Switch demo images for next branch to Debian trixie (13)
  Prefer term "head" over "latest" in menu and kas options
  kas: Use same local_conf_header section name for version settings
  Add missing options and menu entries for stable 3.x releases
  kas: Restructure option files
  ci: Drop unused variable
  ci: Enabled build tests for Xenomai 4
  ci: Improve lavacli container generation

 .gitlab-ci.yml                                |  16 ++-
 Kconfig                                       | 130 +++++++++--------
 README.md                                     |   7 +-
 ci/Dockerfile.lavacli                         |   2 +-
 ci/compat_jobs.yml                            |   4 +-
 ci/gitlab-ci-base.yml                         |  12 +-
 ci/kernel_4_19.yml                            |  14 +-
 ci/kernel_5_10.yml                            |  14 +-
 ci/kernel_5_15.yml                            |  14 +-
 ci/kernel_5_4.yml                             |  14 +-
 ci/kernel_6_1.yml                             |  14 +-
 ci/kernel_6_12.yml                            |   6 +-
 ci/kernel_6_12_physical.yml                   |   6 +-
 ci/xenomai_3_1_x.yml                          |   4 +-
 ci/xenomai_3_2_x.yml                          |   4 +-
 ci/xenomai_3_2_x_compat.yml                   |   4 +-
 ci/xenomai_3_3_x.yml                          |   4 +-
 ci/xenomai_3_3_x_compat.yml                   |   2 +-
 ci/xenomai_3_next.yml                         |   4 +-
 ci/xenomai_3_next_compat.yml                  |   4 +-
 ci/xenomai_3_next_long_term.yml               |   6 +-
 ci/xenomai_4_next.yml                         |   4 +-
 conf/distro/xenomai-demo.conf                 |   6 +-
 ...tom-support-to-add-linux-libc-dev-pa.patch | 132 ++++++++++++++++++
 ...-missing-Multi-Arch-foreign-to-linux.patch |  45 ++++++
 kas.yml => kas.yaml                           |   9 +-
 .../board/beagle-bone-black.yaml              |   0
 board-hikey.yml => kas/board/hikey.yaml       |   0
 .../board/qemu-amd64.yaml                     |   0
 .../board/qemu-arm64.yaml                     |   0
 .../board/qemu-armhf.yaml                     |   0
 board-rpi4.yml => kas/board/rpi4.yaml         |   0
 .../board/x86-64-efi.yaml                     |   0
 opt-ci.yml => kas/opt/ci.yaml                 |   0
 opt-compat.yml => kas/opt/compat.yaml         |   0
 opt-debug.yml => kas/opt/debug.yaml           |   0
 opt-evl.yml => kas/opt/evl.yaml               |   0
 .../opt/libevl-latest-release.yaml            |   4 +-
 .../opt/libevl-next.yaml                      |   4 +-
 .../opt/linux-4.19-head.yaml                  |   4 +-
 opt-linux-4.19.yml => kas/opt/linux-4.19.yaml |   0
 .../opt/linux-5.10-head.yaml                  |   0
 opt-linux-5.10.yml => kas/opt/linux-5.10.yaml |   0
 .../opt/linux-5.15-head.yaml                  |   0
 opt-linux-5.15.yml => kas/opt/linux-5.15.yaml |   0
 .../opt/linux-5.4-head.yaml                   |   0
 opt-linux-5.4.yml => kas/opt/linux-5.4.yaml   |   0
 .../opt/linux-6.1-head.yaml                   |   0
 opt-linux-6.1.yml => kas/opt/linux-6.1.yaml   |   0
 .../opt/linux-6.12-head.yaml                  |   0
 opt-linux-6.12.yml => kas/opt/linux-6.12.yaml |   0
 .../opt/linux-head.yaml                       |   0
 .../opt/xenomai-3.1.x-head.yaml               |   6 +-
 .../opt/xenomai-3.1.x.yaml                    |   8 +-
 .../opt/xenomai-3.2.x-head.yaml               |   6 +-
 .../opt/xenomai-3.2.x.yaml                    |   8 +-
 .../opt/xenomai-3.3.x-head.yaml               |   4 +-
 .../opt/xenomai-3.3.x.yaml                    |   8 +-
 .../opt/xenomai-next.yaml                     |   2 +-
 ...missing-initialization-of-query_type.patch |  41 ++++++
 recipes-xenomai/libevl/libevl.inc             |   4 +-
 .../libevl/{libevl_50.bb => libevl_55.bb}     |   2 +
 .../{xenomai_3.1.5.bb => xenomai_3.1.7.bb}    |   0
 .../{xenomai_3.2.6.bb => xenomai_3.2.8.bb}    |   0
 .../{xenomai_3.3.bb => xenomai_3.3.2.bb}      |   2 +-
 start-qemu.sh                                 |   2 +-
 66 files changed, 422 insertions(+), 164 deletions(-)
 create mode 100644 isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
 create mode 100644 isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
 rename kas.yml => kas.yaml (65%)
 rename board-beagle-bone-black.yml => kas/board/beagle-bone-black.yaml (100%)
 rename board-hikey.yml => kas/board/hikey.yaml (100%)
 rename board-qemu-amd64.yml => kas/board/qemu-amd64.yaml (100%)
 rename board-qemu-arm64.yml => kas/board/qemu-arm64.yaml (100%)
 rename board-qemu-armhf.yml => kas/board/qemu-armhf.yaml (100%)
 rename board-rpi4.yml => kas/board/rpi4.yaml (100%)
 rename board-x86-64-efi.yml => kas/board/x86-64-efi.yaml (100%)
 rename opt-ci.yml => kas/opt/ci.yaml (100%)
 rename opt-compat.yml => kas/opt/compat.yaml (100%)
 rename opt-debug.yml => kas/opt/debug.yaml (100%)
 rename opt-evl.yml => kas/opt/evl.yaml (100%)
 rename opt-libevl-latest-release.yml => kas/opt/libevl-latest-release.yaml (79%)
 rename opt-libevl-next.yml => kas/opt/libevl-next.yaml (79%)
 rename opt-linux-latest-4.19.yml => kas/opt/linux-4.19-head.yaml (79%)
 rename opt-linux-4.19.yml => kas/opt/linux-4.19.yaml (100%)
 rename opt-linux-latest-5.10.yml => kas/opt/linux-5.10-head.yaml (100%)
 rename opt-linux-5.10.yml => kas/opt/linux-5.10.yaml (100%)
 rename opt-linux-latest-5.15.yml => kas/opt/linux-5.15-head.yaml (100%)
 rename opt-linux-5.15.yml => kas/opt/linux-5.15.yaml (100%)
 rename opt-linux-latest-5.4.yml => kas/opt/linux-5.4-head.yaml (100%)
 rename opt-linux-5.4.yml => kas/opt/linux-5.4.yaml (100%)
 rename opt-linux-latest-6.1.yml => kas/opt/linux-6.1-head.yaml (100%)
 rename opt-linux-6.1.yml => kas/opt/linux-6.1.yaml (100%)
 rename opt-linux-latest-6.12.yml => kas/opt/linux-6.12-head.yaml (100%)
 copy opt-linux-6.12.yml => kas/opt/linux-6.12.yaml (100%)
 rename opt-linux-latest.yml => kas/opt/linux-head.yaml (100%)
 rename opt-xenomai-3.1.x.yml => kas/opt/xenomai-3.1.x-head.yaml (70%)
 copy opt-linux-6.12.yml => kas/opt/xenomai-3.1.x.yaml (55%)
 rename opt-xenomai-3.2.x.yml => kas/opt/xenomai-3.2.x-head.yaml (70%)
 copy opt-linux-6.12.yml => kas/opt/xenomai-3.2.x.yaml (55%)
 rename opt-xenomai-3.3.x.yml => kas/opt/xenomai-3.3.x-head.yaml (80%)
 rename opt-linux-6.12.yml => kas/opt/xenomai-3.3.x.yaml (55%)
 rename opt-xenomai-next.yml => kas/opt/xenomai-next.yaml (93%)
 create mode 100644 recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
 rename recipes-xenomai/libevl/{libevl_50.bb => libevl_55.bb} (77%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.5.bb => xenomai_3.1.7.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.6.bb => xenomai_3.2.8.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.3.bb => xenomai_3.3.2.bb} (90%)

-- 
2.51.0

