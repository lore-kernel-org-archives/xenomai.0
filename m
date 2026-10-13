Received: from mail.elvac.eu (mail.elvac.eu [193.85.188.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D953644A3
	for <xenomai@lists.linux.dev>; Tue, 13 Oct 2026 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=193.85.188.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876103; cv=pass; b=n+R+mJOq4+Kz6ozjcUUDJ3j4C1zXarYD/zMPOS9QKCFENoKaoUyPRnUcpFkFKhNndYZ1mYTNMokynXOw2sOXLlmY6v44cRkALB2zELVtKI2tsG6GW1p5l8jthij/N76N43HgVRoRe2vidJEUFIYHBKd59BlSittSBnNcMerd890=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876103; c=relaxed/simple;
	bh=Wi9FxYZ7byXFGq1Kpk4n6FrE4zlsazwpn6JGLJ+A3pc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jx6oT8mn9i/Uf4IUabcRLI7KVG+i0wynM1mS1+mBmetiB3B3hYGviRacbCJ9C438bLrnD6+psh6o61UNgTJn9rH0T5Nv14nPF3sKSrjTY+gkUpGI6qCqtlBazozRuFWCR00p5w16VTr8sNL7gTJkPtSmmGMJhmRgrS9mRwLBbiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elvac.eu; spf=pass smtp.mailfrom=elvac.eu; dkim=pass (2048-bit key) header.d=elvac.eu header.i=@elvac.eu header.b=n5S+Vf0Z; arc=pass smtp.client-ip=193.85.188.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elvac.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elvac.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elvac.eu header.i=@elvac.eu header.b="n5S+Vf0Z"
ARC-Seal: i=1; a=rsa-sha256; t=1791875190; cv=none; d=elvac.eu; s=fm2026;
 b=J2jX7WrGLkGaT+pfrHKyehrjHcFSJ5GTjK8bX8yPea8IYOifBVbCdbdg78RWHdGn51DS+c4MY4ra
	dLhe5t0Ii639jXNGVz6TnCCKrCy20SBVUNxHcHRlDJ/1xRI8AjeKvaB1oSjyJZWUtNB9NFPzGSRT
	OBO3LV90yCkdhULvQMI2MumBNsJvfwZuA2cNobsPPI9sHjnL9ePvlRHYpkRAHZk2In+lFYJ8DW7n
	/1cJe78cwzJfFH4dun46gnb1CDZxzenFpCTdwEvKwd9fF+Nvonwoh3eEv9UTzyh3FuPFJKk0u+aA
	Cq9zLTeS66Z7SmKhL6B1sTiXh32sDS5bszqWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=elvac.eu; s=fm2026; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:content-type:mime-version:dkim-signature;
 bh=4KC1PFGhtZK972DS17Fa29gfOaBgoRnr1vaeE9e0gqg=;
 b=V35gad46gpryp9YE/xKmzDQotzUprl2tlLfNUpkpD2rnfPPHN5NelKvCaLZAy84NMKmZF5+65vpz
	feWg3BYl5pY4lGFjy3dpI5CSHEArTwH7dqqHz63ZQqaqGEF3CRL2L78lJAXWGahOjqgU9GrUrQug
	cWrLRF8tgG+Wm5BM3bjjr6OLJtlrMSTaglNUl7CfvwgiJAZY0Q1+PyvcEtvGfRdwIa92wDetVJwJ
	ZMuRjsJHKj1Eg1I7NokR/bN23KEabo4TSZEJPKZy+g8r33u+79/HXHOivFBtfA6Yrj64w6MtuXZC
	reJXwxFfTxvlmkTaT1J6Zf3nnmLQ9x2zY2UxrQ==
ARC-Authentication-Results: i=1; mail.elvac.eu;
	spf=pass (elvac.eu: domain of petr.martinek@elvac.eu designates 2001:af0:8002:701::193:17 as permitted sender) smtp.mailfrom=petr.martinek@elvac.eu;
Authentication-Results: mail.elvac.eu;
	spf=pass (elvac.eu: domain of petr.martinek@elvac.eu designates 2001:af0:8002:701::193:17 as permitted sender) smtp.mailfrom=petr.martinek@elvac.eu;
Received: from mail.elvac.eu ([10.0.193.17])
	by mail.elvac.eu  with ESMTPS id 69D76T1P020092-69D76T1R020092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <xenomai@lists.linux.dev>; Tue, 13 Oct 2026 09:06:29 +0200
Received: from srv-email.elcomgroup.cz (2001:af0:8002:701::193:17) by
 srv-email.elcomgroup.cz (2001:af0:8002:701::193:17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:06:29 +0200
Received: from srv-email.elcomgroup.cz ([10.0.193.17]) by
 srv-email.elcomgroup.cz ([10.0.193.17]) with mapi id 15.02.2562.049; Tue, 13
 Oct 2026 09:06:29 +0200
From: =?iso-8859-1?Q?Mart=EDnek_Petr?= <petr.martinek@elvac.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: linux-evl 7.2 compilation without SMP 
Thread-Topic: linux-evl 7.2 compilation without SMP 
Thread-Index: AQHdWuCXkneT9oiTYkKcoI5U64R6og==
Date: Tue, 13 Oct 2026 07:06:29 +0000
Message-ID: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-gfi-smtp-submission: 1
x-gfi-smtp-hellodomain: srv-email.elcomgroup.cz
x-gfi-smtp-remoteip: 2001:af0:8002:701::193:17
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFo8JVpeWFhYXVFcSFhISFpaSBgNHBpGBQkaHAEGDQMoDQQeCQtGDR1IWUhaW0gQDQYHBQkB
 KAQBGxwbRgQBBh0QRgwNHkhYSFpIWl1IWlhYWVIJDlhSUFhYWlJfWFlSUllRW1JZX0heSFhIWEhZSFhIWEhYSFpbSBANBgcFCQEoBAEbHBtGBAEGHRBGDA0eSFg=
X-FEAS-Client-IP: 10.0.193.17
X-FE-Last-Public-Client-IP: 2001:af0:8002:701::193:17
X-FE-Policy-ID: 2:1:3:SYSTEM
X-FE-Hostname: mail.elvac.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=elvac.eu; s=fm2026; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:content-type:mime-version;
 bh=4KC1PFGhtZK972DS17Fa29gfOaBgoRnr1vaeE9e0gqg=;
 b=n5S+Vf0ZxQGNbJqMw6xjn6C334uo+PQig53Gx00mswx1Nqu5MIG3mWoB21WZUVCFR6FfkAeBRqUB
	I/QwPoj+r2NCRe3v4+ctognDGOGA35ajRCNH8VqhNlZGK1pIHM4WJXQE8jUpibeXS5gIFPkPjpBX
	gWyJRW+yAQLIe6sFn73kEX5pZ/Uvu2xN5cuc6BJghFFjlNL6H7BPPt7Wo1MnOeRPf7spASGjx4o6
	WsTeSu7h87sQk1jttUyfWIx2PSoauC1YaCjBUtecP8NLnsI6YICHflNoH2DRAW2ejvxGqrEYqS1t
	saHqSnODX48W+0mgz1iY1PomB51tfdCZjqIsHg==

It is not possible to compile linux-evl 7.2 without SMP due to bad port of
include/linux/spinlock_api_up.h code and kernel/irq/pipeline.c
pipeline_percpu_data being inside define for SMP, while being used without =
it.
Included are patches to fix compilation.

Signed-off-by: Petr Mart=EDnek <petr.martinek@elvac.eu>
---
diff -Naur a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_u=
p.h
--- a/include/linux/spinlock_api_up.h	2026-09-23 08:39:20.000000000 +0200
+++ b/include/linux/spinlock_api_up.h	2026-10-08 14:21:40.410814000 +0200
@@ -62,22 +62,22 @@
   do { local_irq_restore(flags); __UNLOCK(lock, ##__VA_ARGS__); } while (0=
)
=20
 #define __HARD_LOCK(lock) \
-  do { ___LOCK_##__VA_ARGS__(lock); } while (0)
+  do { ___LOCK_(lock); } while (0)
=20
 #define __HARD_LOCK_IRQ(lock) \
-  do { hard_local_irq_disable(); __HARD_LOCK(lock, ##__VA_ARGS__); } while=
 (0)
+  do { hard_local_irq_disable(); __HARD_LOCK(lock); } while (0)
=20
 #define __HARD_LOCK_IRQSAVE(lock, flags) \
-  do { flags =3D hard_local_irq_save(); __HARD_LOCK(lock, ##__VA_ARGS__); =
} while (0)
+  do { flags =3D hard_local_irq_save(); __HARD_LOCK(lock); } while (0)
=20
 #define __HARD_UNLOCK(lock) \
-  do { ___UNLOCK_##__VA_ARGS__(lock); } while (0)
+  do { ___UNLOCK_(lock); } while (0)
=20
 #define __HARD_UNLOCK_IRQ(lock) \
-  do { hard_local_irq_enable(); __HARD_UNLOCK(lock, ##__VA_ARGS__); } whil=
e (0)
+  do { hard_local_irq_enable(); __HARD_UNLOCK(lock); } while (0)
=20
 #define __HARD_UNLOCK_IRQRESTORE(lock, flags) \
-  do { hard_local_irq_restore(flags); __HARD_UNLOCK(lock, ##__VA_ARGS__); =
} while (0)
+  do { hard_local_irq_restore(flags); __HARD_UNLOCK(lock); } while (0)
=20
 #define _raw_spin_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
diff -Naur a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
--- a/kernel/irq/pipeline.c	2026-09-23 08:39:20.000000000 +0200
+++ b/kernel/irq/pipeline.c	2026-10-08 14:30:08.315420000 +0200
@@ -75,6 +75,9 @@
 	unsigned long flat[IRQ_FLAT_MAPSZ];
 };
=20
+struct pipeline_percpu_data { };
+static DEFINE_PER_CPU(struct pipeline_percpu_data, pipeline_percpu_data);
+
 #ifdef CONFIG_SMP
=20
 static struct irq_event_map bootup_irq_map __initdata;
@@ -92,9 +95,6 @@
 	},
 };
=20
-struct pipeline_percpu_data { };
-static DEFINE_PER_CPU(struct pipeline_percpu_data, pipeline_percpu_data);
-
 static irqreturn_t smp_call_function_ipi_handler(int irq, void *dev_id)
 {
 	smp_flush_oob_call_function_queue();=
