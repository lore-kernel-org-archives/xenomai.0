Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926938C2C6
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321922; cv=none; b=uxK5bEHW0S0YoZI9k5+3puZo7d9Q5Sp5QynCjAIvuHDXICn/ntY8bxyM7F+tFGmvPTtsfyTQ8FFsPHA7tQJ1A0x3aZjBMb+lwrKGrsbJKuP8IckhDlDEZSrDCTTadb2wZBdfma7ZdU74e6qiZM4qiYfb1tnnZx8CQ8QLkkcSMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321922; c=relaxed/simple;
	bh=bDXpLQz2Y1LYyYwbxreAdq0Y9peFP6GXcXRnlZYkc9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeKauvVrPHj6NXVlWe9h4slt+/Maft5zLvxoWzzoAhOjNkEy/vOkKN7viKKjIbl98YLkU42tuhSTKc33vDS9UitJ+RoD/lTTspACxg4SrgttoZ+NcC5oYGfqN5o/9W3GSnEabhrJ49EjWI4hW8NPox+1b3gel+CffIFBEvT5Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFaqHtJ/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFaqHtJ/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-474560436c3so3600100f8f.0
        for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321918; x=1784926718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/duC2k9vKEK+qjkIdp8Ro22V3LRPuH8QoC3OBxrjan0=;
        b=RFaqHtJ/pjCRYejvUAFBEblSbiLZTd7GC2NmF8382FY4owU4CgrwUL1XfvtRjSJ45k
         wlXUWLfxrcXV+iuOJ2x4+AsbrMOYwRoIK2L9vFlPu2kE0F0xmFPT2e0nHuYM/LGKEjsi
         Ha3zCu+G8knVdY47qn2TqpJ+s407sDlPdNpcPqs18JqObePgXRK7xrYCc90W6RNwNdQ7
         r15VJJ3n0+bB4OdN/nf6UpoKZDo+KbJfpEC7v9p84P8EIn8fY2hEnspesgux6AQJG2Py
         RVXi6Th8ssEcCccczXe/ENc8fbsXF3jQeocc+USLUOUPson/2HK7zZvwb9Z6ZAfoLrpq
         b2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321918; x=1784926718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/duC2k9vKEK+qjkIdp8Ro22V3LRPuH8QoC3OBxrjan0=;
        b=e3dCGHeR489igQoc4fROHnsMnEygy0/oBMDWo2DhRhgHwan7DzvbM8RF+ZY3RjYe9z
         mXR0n6LaOe3TtmDtC+qPL6Y4ar5MppIjaUuBVY0oPJ4INIK+kOFyACRqJHi9LQNg6q0L
         qL8eE2DaWbiSd3wG0A/Liw60oRfjcKoprlDi6Bd1i1domJXmXbifujm3XzEoLJV8lkKw
         Ty+tnIeJqbICF9dlpwc4p0jrAlEW4i2RbLFHffnlZvSoVB2tcWxw3k6oqvB7Z9M+EGX+
         nt9d1WlRQSwwhMP5ZTlS4OO7Gmj8XYS/oSpaSG4DMSG3jC3dCCRdk8Qg++NQEecc2moy
         jUow==
X-Gm-Message-State: AOJu0Yy2QG6vJmmdB2z8xhItVnLQ1sKRekQMWgPfyQj5dkZPxrtTadSq
	FebOlarVj9PFf3+igl7cIDM0QDjAk9pl/7VZ/wJdr8LViYtnB6MfKqjwAJIf7pno
X-Gm-Gg: AfdE7clnMwKx6MpE1gt4uV0oKJPMalvwYW0TLL1Bnmpy6HzkkPkEpWssQi4KyUf6tZ2
	7CgZpi52waUXXuJEQMPq2NNOlD25k6HAnox8z4XiJDcYXfm43I9jVj10+czweFhJc+jRB+7AIQu
	6VpAdR9tzRmMAjiJ+LxLVBb7QNd6HyEhXfk+TU40vPeu++hzzT8y/zESLICiaA4wCp1XOsiVWXN
	3J8tWQozYNnx8mQ5WrQx+jSX8ygLVC6dNIoni5M7tgNZuko3gerDzzYHbYNsh6AeBGVHXe+/9uC
	0qDQnYjwpRerRZG7mRUhF8bCQjtmuRflnz5M+H7h+eCqAuXxfrHTtBjbcRFeRgvDfUXG8LaBpua
	xhbLuXH/lEHO6+ZaW4ZVy0jb+9bSZ/2Q0Dbk0ov7y5iTo0AJf3zSnBBLGan8F444ghu/i90conn
	TzZlPg
X-Received: by 2002:a05:6000:2c0f:b0:47e:aa42:4e42 with SMTP id ffacd0b85a97d-47f623379b0mr5530854f8f.55.1784321917670;
        Fri, 17 Jul 2026 13:58:37 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e519f4sm6287816f8f.14.2026.07.17.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:58:36 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 0/1] libevl: Add debian package config
Date: Fri, 17 Jul 2026 22:58:19 +0200
Message-ID: <20260717205820.8359-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a debian package config that allows to build a deb's
using dpkg-buildpackage -b -uc.

The packages are libevl / libevl-test similar to[1]. However, latmus
is placed in libevl. One might not need the tests but still want to
use latmus.

Additionally, libevl installs /usr/lib/udev/rules.d/90-libevl.rules which sets all evl
device files to group evl, g+rw. libevl.postinst adds this group and triggers an udev reload.

This allows to use libevl without root. However, using SCHED_FIFO still
needs either root or setcap cap_sys_nice+ep and possibly some other tweaks.
Some tests and my application work with cap_sys_nice+ep. However, for example latmus fails
due to unknown reasons. The debian packages sets no capabilities but this could be added
if desired.

Caveats:

The test ptrace-sync fails with <timeout waiting for gdb>. dh_strip -Xptrace-sync from[1]
does not help and it is not needed: When libevl-test-dbgsym is installed, the symbols are
available but the test still fails. With dh_strip -Xptrace-sync, the symbols are not found:
warning: could not find '.gnu_debugaltlink' file for /usr/libexec/evl/tests/ptrace-sync

If linux-evl is also built and installed as a debian package, linux-libc-dev can not be
installed due to /usr/include/evl/*-abi.h are both installed by libevl and linux-libc-dev
from the kernel build. However, installing linux-libc-dev from debian trixie works fine.

[1] https://gitlab.com/Xenomai/xenomai-images/-/tree/master/recipes-xenomai/libevl/files/debian?ref_type=heads

Hannes Diethelm (1):
  debian: add debian package config

 debian/README.Debian        |  6 ++++
 debian/changelog            |  5 ++++
 debian/control              | 33 ++++++++++++++++++++++
 debian/copyright            | 55 +++++++++++++++++++++++++++++++++++++
 debian/libevl-test.install  |  2 ++
 debian/libevl.install       | 11 ++++++++
 debian/libevl.postinst      | 50 +++++++++++++++++++++++++++++++++
 debian/libevl.postrm        | 41 +++++++++++++++++++++++++++
 debian/rules                | 22 +++++++++++++++
 debian/source/format        |  1 +
 debian/udev/90-libevl.rules | 12 ++++++++
 11 files changed, 238 insertions(+)
 create mode 100644 debian/README.Debian
 create mode 100644 debian/changelog
 create mode 100644 debian/control
 create mode 100644 debian/copyright
 create mode 100644 debian/libevl-test.install
 create mode 100644 debian/libevl.install
 create mode 100644 debian/libevl.postinst
 create mode 100644 debian/libevl.postrm
 create mode 100755 debian/rules
 create mode 100644 debian/source/format
 create mode 100644 debian/udev/90-libevl.rules

-- 
2.47.3

