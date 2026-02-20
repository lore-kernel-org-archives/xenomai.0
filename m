Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EE32F757
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586874; cv=none; b=Y7oN4id2riMy5dITacesQZs7nh7Flw/WLzuw86dDfeIWyNbDFrS7fPqDSEH9zEMHAM2I2gjdpAEjd+H8Ii4WMe369upBhnBan4NC191uorSKZBWjK9OkBrB2n3Uw5fCuFnp0vNjajMvTYuVHOUVRqK/268RuM0QEVraSokQKYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586874; c=relaxed/simple;
	bh=3MOh+daK0YFTeneLkoooOH4hZRFRIiLrhEEFpGqKjLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dG7GshOlFeZNZg+CxkQjxXy/2g0CHuCdT02+DLlnoFYz1c1+1aLTiolOnMjVqoQMwz8nhbINZjywbtFYeVI1E8mrnk2YzQNJ9WhWOlJzwaWvEnCkencC5M9/iB3xHVOZRwzCQ+fPVdoqWw2pf3yZjQjxDO4MEhG11pEMRH26XAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LJyXnMlE; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LJyXnMlE"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202602201127484bd4567c3700020772
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 12:27:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xjhtgW92/QCnMiyHO061tUeJvcM/wzXmIQPMyLgd5oc=;
 b=LJyXnMlEzzzaY/F9A2qoeLRdagU7N8OtZIRBCyDexfU6DdpS9tslATL78W55UVpxYuXwyc
 YKhCgALhZWfCE7wYwU3118CiYMPq037EYeP32PPc9CPdrf5Q4ZqIQFbHNkOyBfQBSSQ/1Qr5
 fkB2+TuGcc3KcjjxipfRhoetcgx4SaJy8wQxcMzuf//PoWMifjOUrXdF3MJgBAJIzu3E14ps
 Rm/5sXupYb9MEWc+Fkuf+4ZtVxDVKjVs4IekQACYGH7Cgdg8J0KT8k44t6TWzXItVD9lZCp2
 yWrmMZlEx5aiwll9kAXdm6gWmrA+msbr4WOTcCpZu1DyDlI9JPapt4qQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 12:27:49 +0100
Subject: [PATCH v2 2/3] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-prepare-for-6-19-v2-2-222effb01976@siemens.com>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Since 6.19 the signature of mm_get_unmapped_area() has one parameter
less. The (previously) first struct mm_struct *mm parameter has been
removed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/rtdm/drvlib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 86788743fe47b228662ef16831b4281ddefd04ff..0258100db5bbcc04880ddc71632b7992e50168dc 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1907,8 +1907,12 @@ driver_get_unmapped_area(struct file *filp,
 
 #ifdef CONFIG_MMU
 	/* Run default handler. */
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
-				    flags);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+#else
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
+#endif
+
 #else
 	return -ENODEV;
 #endif

-- 
2.53.0

