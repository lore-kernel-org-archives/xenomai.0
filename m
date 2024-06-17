Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B01194135
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615941; cv=none; b=THpD1Yq8CA6Af0pJy79470GGkBOEUZkxS4XxHPeKh+HPWCR8+IK3yiHPS0iBEqJpThKITYS7z+tXSCQ/5b7gzYV/v1tay21aCqk0I7O13IwwHbiu2k8HxKPr0ribAssrLZaKKUt8I0X22T4rVEUgeVYb5jPVCJJKpEx4fmZS45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615941; c=relaxed/simple;
	bh=MLvPOIq+rhgmcAgXCXZlbcm+yCSvUDqbnEd379MtEao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6KxMp5/2xSb4z6YjsrO2xHi+Kq4kHYkhsgTFz9HeJ6S2Jvjsm8KVX+Va4a1W5rvrcktPFYZw/bsWpQwFKVbA9EtLh2tS97qnKQssedq9DKOzjvbjYntlZr3mgzBYX3C2MEhZQ6TjRxXKyNWLVtiPS279cEgmLoUTkZl7HDsoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=RXT7q7y1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="RXT7q7y1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so27820091fa.3
        for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1718615938; x=1719220738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38ojOyo6rTAS8oKgvBB02n1T09oHJssipH3yX0aKArU=;
        b=RXT7q7y1FZcAO9zhWqeHESlf3qhtHCiLu7yfr0PM2jn6gHcYtOov4SHZmIBbGAeY4o
         mS+5pzthdCAbHNCczWQdX2syp0kYNqKRsxl7X2yBHhJocJTrj14QGwoWKD//sjOKB+UP
         lhH+WQoateYGi1gfCXnO/lyfpmSbobWiVEps8gkpRHmK7v3KwTDlRnIh29mpPPlF5Yqw
         rmnkRXIpIbxUyH/iBMSaZlEa8WZMQoFns5v85ubkeXY2WenveTk4H3Py9ywXlB7MnnHG
         NraFQ7S1VL7xB+2mmhIr5JCz+TUcAIoRkDkF9UpZ8kopALIU3BFNVMxrEEHwEWRPpkxS
         e3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615938; x=1719220738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38ojOyo6rTAS8oKgvBB02n1T09oHJssipH3yX0aKArU=;
        b=uFldrZwIAGu09mZfZzXMajn6Xhjt3jaMA/desdVQ1HcV3kXm8KwdCPsascJMZGGcDw
         puk95/4EzAAdX5XZHunqOGCKBsyfw5S4RVwRTm4btsQzlJkobxg5YFZN1AfKYXa7Q8LB
         Aiy6J6NTyx+DHTBOUbIrGOpNO22bhTUHJn6xN18bdFM8HtG9m49ikpN1ROIx7GxKbmBg
         2nPV+ubHX0sQ+YA11/Vlo7r194IJsfV7SAQaGxRA+E/6zWEKUTxiZUqaKvitDyUyzckQ
         1grzfWSM/qlhy4GhB6yTY1Nt1jGU/FCfTEpic7C4LfpcgG8XUL/HdGMw17IrMEQTT8p1
         s83g==
X-Gm-Message-State: AOJu0YyhTBbNh4WgSxb9MXaE0t6lv1a5UTDBSe0wQwO6cFfWw5K9So5V
	hvRaO3bgahs0IL8NFzg37U+KCY0komb3MjW/BXkkON5wEN4h3tDREu4zh1WYItrpO3Raus3dgwK
	Z
X-Google-Smtp-Source: AGHT+IHow86GbbuZHWNquq9fDu3RIcfAfgIAlYukqtJ+n4KiAhetTAB5oQvnTNUhxM9c2wTGoWTlzA==
X-Received: by 2002:a2e:b0d6:0:b0:2ea:e12e:bee5 with SMTP id 38308e7fff4ca-2ec0e5b58bdmr60523001fa.4.1718615937809;
        Mon, 17 Jun 2024 02:18:57 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm75591125ad.181.2024.06.17.02.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:18:57 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 2/4] lib/copperplate: Add threadobj_get_periodic
Date: Mon, 17 Jun 2024 11:16:52 +0200
Message-ID: <20240617091654.66342-3-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function serves as a counterpart to threadobj_set_periodic,
allowing us to obtain the expiration time and interval of a
periodic thread.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 include/copperplate/threadobj.h |  4 ++++
 lib/copperplate/threadobj.c     | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
index c8363415b..bf57cf6f7 100644
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -365,6 +365,10 @@ int threadobj_set_periodic(struct threadobj *thobj,
 			   const struct timespec *__restrict__ idate,
 			   const struct timespec *__restrict__ period);
 
+int threadobj_get_periodic(struct threadobj *thobj,
+			   struct timespec *__restrict__ idate,
+			   struct timespec *__restrict__ period);
+
 int threadobj_wait_period(unsigned long *overruns_r) __must_check;
 
 void threadobj_spin(ticks_t ns);
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 0782ffb11..91b7c41fb 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1661,6 +1661,27 @@ int threadobj_set_periodic(struct threadobj *thobj,
 	return 0;
 }
 
+int threadobj_get_periodic(struct threadobj *thobj,
+			   struct timespec *__restrict__ idate,
+			   struct timespec *__restrict__ period)
+{				/* thobj->lock held */
+	struct itimerspec its;
+	int ret;
+
+	__threadobj_check_locked(thobj);
+
+	if (!(thobj->status & __THREAD_S_PERIODIC))
+		return __bt(-EINVAL);
+
+	ret = __RT(timer_gettime(thobj->periodic_timer, &its));
+	if (ret)
+		return __bt(-errno);
+
+	*idate = its.it_value;
+	*period = its.it_interval;
+	return 0;
+}
+
 int threadobj_wait_period(unsigned long *overruns_r)
 {
 	struct threadobj *current = threadobj_current();
-- 
2.45.1

