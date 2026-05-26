Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5C3AF64E
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811965; cv=none; b=Xh/ldRVx4kHfVgeI8rZ5DZNqf7xa6rkDAFanhpJI8IbNJCLpKA4VRjHZFXzLIxO+uLhpgcA/Hxc7IBWwTH7/7yuAtxjXwHWNLw0cH9vjRIPg8VbPoW4twuUJpYuCEFN7pe0KIO5N2IeGgpo/HqPtYi0ZS0OhoOcdqZdcE5c8sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811965; c=relaxed/simple;
	bh=a0MGPNFeflhWyUWiaYYJzLgtFySQE74vTD1YjiOq0Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTZ+kwZvBZByqfIf8JwwpbWj05jc+E8KjU6k/vCAZIPlKFw6H8/nLEJR4i0NTIBAAW8tblr9ExVrukB5QfcUCSTRFrraNx2jM1K4gvlYZz5SA/JW+WHSx/4LqOWkIgqYJNEKZb5oVAcSaCz+jCgE5LRQVLNENhLmEJq0AKLis7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=g1/Eig7U; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="g1/Eig7U"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260526103201bbf79842f90002070f
        for <xenomai@lists.linux.dev>;
        Tue, 26 May 2026 12:32:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0ifdY4TlmLAHGxKjjexvhxwtQ/4ipdPx7daV/3DTB4k=;
 b=g1/Eig7UDy9OU5dztbJDnD57zARHDwayBFF3DlXtMAVu9LaEMyq6XKEp4fIhiP7b1fuHWU
 fjQw7vaqg6GZu56CojoqjLTy60S0Yqv2HXnZUXhj7UbrXjVK67n+fM1QU5Smgosm5qHueEsA
 dKyA9/6i7xJDUkuKjxsgxsa/iF5vfM4OlWM5HS3DiTrnhCDsPQD5jxl8ksDY83QHenrQOC3d
 icMDnihUZAJlKJh0hlM/Om5UHSE9ET/GC7dV8oFOmT1Xyxy+DddKtCKapRdZI02eb31iyhei
 cGYDQf0XjPR7cNJy/d74WSf7/uak0FuLfdKJ70Q5rayFu04ny1V6Nb2w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.18, 7.0] lib/vdso: Fix build failure around CONFIG_GENERIC_VDSO_CLOCKSOURCE
Date: Tue, 26 May 2026 12:31:57 +0200
Message-ID: <20260526103158.2476350-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

During the forward porting to 6.18 the signature of
update_generic_mmio() changed and introduced one undeclared variable.

At the same time the name of the kconfig variable got invalid.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/time/vsyscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 13f6c9d91045..5fa096452dba 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -76,7 +76,8 @@ static inline void update_vdso_time_data(struct vdso_time_data *vdata, struct ti
 
 static void update_generic_mmio(struct vdso_time_data *vdata, struct clocksource *cs)
 {
-#ifdef CONFIG_GENERIC_CLOCKSOURCE_VDSO
+#ifdef CONFIG_GENERIC_VDSO_CLOCKSOURCE
+	struct vdso_clock *vc = vdata->clock_data;
 	u16 seq;
 
 	if (cs->vdso_type == (vc->cs_type_seq >> 16))
-- 
2.54.0

