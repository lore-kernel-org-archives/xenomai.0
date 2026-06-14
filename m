Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387331BCAE
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428667; cv=none; b=SwqJTJUkqfbQPfwzAadE8CrfXLQdcWdGebcdGFHUG6PN/96/FrDAPO2aQ/mV6EtC7jGPG3VnrSENo7bzxrFGZfXui6wua4TCaz6+9IDY0eDeOZ+JdGIUeX17J58448IWP2NWLiAcxkwoC3wXaBvWPzN73RMzICjbNm/c/Ia47hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428667; c=relaxed/simple;
	bh=x4ABTfo5bbGhB0+KrVhjfxgCAJQldFD5zMeCnIqilts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+AJ42O4zHf51PvhquWWPm3X3FSECI3XbC27+1uGyisAcelRfUvnOY/+VuDz3TUy5OC3xFLMYBY+00eWTxwOWEczujK6XD6nF/FVrzpb2lx4VsIjYbOoaFfkW89VUNTvQPZBoO0a6i97coPNdcXNR6Kqy6c3H8HaImjWwm6Ttfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=vVaaQSwx; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="vVaaQSwx"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026061409173514cd21dcf8000207fd
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ncLN5NVKUrdiTW4L35BKr5nYpZeMnZcZIvKcimRDyr8=;
 b=vVaaQSwxMMLtE5ACbCyAv3HKqZv9B5wAXJuXbnVHbJIbO+Lnzryq4FNDmGdHyYQsH78PAO
 F+KgjfvYwpxwzrh3C4jUYcmNQEnXF9xsMN/Quym+SvaemKGWVuxT19Pbd1TB5Z9jocbWfAuw
 WhUesaB9o5oc3CwI89LCekXf6A8JZxI141PbSzMpxxCp4QSzbTwStitw2ZERLv+MdyMGg/5Z
 2SCtTDr4It3k+81rl8Y7w0KK/Y/Fx+6aUaC6BZkJHyjnT1O97p/kUaqxj4jE4pwIVw6Fs0cI
 UuJaB6uneuymmHjfamY8ZLc2ZeX4SEArX6DGF8ZoWZgHuD5dxv2uH61A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/6] Add trace-cmd to debug images
Date: Sun, 14 Jun 2026 11:17:30 +0200
Message-ID: <d83f7b601c031835a822b4222a24fff776f60b97.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Simplifies interaction with ftrace which is part of the debug config.
May eventually permit testing it in CI as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/demo-image.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 7ea4dbe..3133582 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -46,6 +46,7 @@ IMAGE_PREINSTALL += " \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
     iw wireless-tools wpasupplicant systemd-timesyncd dbus \
     lsb-release auditd"
+IMAGE_PREINSTALL += "${@'trace-cmd' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
 
 IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
 IMAGE_INSTALL:append:xenomai4 = " libevl-test"
-- 
2.47.3

