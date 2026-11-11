Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=193.85.188.218
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794398009;
	b=ShmYHxiMClqaSzgONNis6LDlLzGxFhqUw6qsWkVI0Qwx00KQ+9Hr5JTe3cVW+MyXCSBP
	 Pv2ikKPVRM1IGI2gibTCs9P/umGV2pCcRi9zT3YF8iDjxp9jFUo+ZqkeouClWaFjBCPby
	 UmEtHAqY6TUeHcceIvF1D2D/hRe48QWXl2t9u6r6ClczZdB2//QUWsOB/9h+vCsZXqxW7
	 CG35sNFCsJe8FZ1QCuE4CRl0CXXD4rEzD6O9FcpiRkH/n1rT2HzoJUfhy8qvrIabMy7W9
	 +w4ST8a1v/eT08BYh7/UDEMHmsc4yXEGeoONXiyS2EseiJG8PHlMzEUfgVaCBbwrjHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398009;
	h=DMARC-Filter:Received:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:x-gfi-smtp-submission:x-gfi-smtp-hellodomain:
	 x-gfi-smtp-remoteip:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=b7ijsiPs7j943JrljhGcK1EfRLaxeu3dc7lPKbp7l1A=;
	b=pN3Um0eDj553eOsTFpXIdGZJOvxsRGBAf6t4mvpkbaa9nGsFJf7bofdfaAoZ5YBW/6O5
	 /TUd4DmaZxwQDUGj5lzR6QgBqX66L37Tw5POtUGkt0eEhZ1B7P+AB3ikbRd59KQFVFO3K
	 lvC8KZKICrWT9/EKwBUjM9UVR5qbwC3J1qmQbwfeMdov+dV5eqrj143ARrw5dtl8fW15+
	 +zD+Qnm9E0n7rYsYRHOBtEAZc0Mal/obsogyqJPcwPYZg2mTsN5iAkj6f7SDvs8ZlOkXl
	 Cki0K6NVXhpQiZfJ9aeywosWKt2dBCYU86/OA+ZgzIuKx5Xd5Z8siqwnaUs+PJ8HWyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=elvac.eu;
	spf=pass smtp.mailfrom=elvac.eu;
	dkim=pass header.d=elvac.eu header.i=@elvac.eu header.a=rsa-sha256 header.s=fm2026 header.b=VFH6ldz6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=193.85.188.218
Received: from mail.elvac.eu (mail.elvac.eu [193.85.188.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BB606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elvac.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elvac.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=elvac.eu header.i=@elvac.eu header.a=rsa-sha256 header.s=fm2026 header.b=VFH6ldz6
ARC-Seal: i=1; a=rsa-sha256; t=1794398000; cv=none; d=elvac.eu; s=fm2026;
 b=KA8ZxQdxnYvyRpjsekxK/2OPDZuTwe03cAheK5At301RmXYbxxyslrcb1B6WXany6JnA8DWH/Vuh
	ODck1P0DhebnKONX9dcofOZjzWEqjfNBejdp59V0+zWRYSHfk1qUGMLqGwna8SFQPI+h8u1eG1IH
	MXNLUIZhdQNY2J9oHClCP2Ti6owPFTPrgEqC4V+VWVhLAmXAb63DlN/wrjVkW4+oxoh7bXdrt9lD
	K/32rwCV43uojNi5jFrnX94xlh7xyK56qlwQ9JrakZCqKjXYOqHuw2d7uPhYl/1CLpq1/rSdfapN
	uJbwoiRM95A0hPYIE8qNB0ON68Gk7l1NYV6U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=elvac.eu; s=fm2026; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:references:content-type:mime-version:dkim-signature;
 bh=b7ijsiPs7j943JrljhGcK1EfRLaxeu3dc7lPKbp7l1A=;
 b=LOjG+pSyABnprnyyIJgmtPuIYDmpqiFTJ8gkjJdiIcV48qLGTfweUp2OcxsSwiSQs5ythSDUgCiJ
	lYxXGuICoahQMbjoeZql9LJu9o1Y6ZnH65aNhuM/UV3pTKct6HccW04jvrl2OIYTYbMeHGNUCP1v
	wRXCiZ9hyoiMMz77sD5EG9K8IseHL3Zl1WlcBQF5RejccIA1ma3q6XeqZ47aqkBMV6Goax6NP/FI
	9dmJC22TbIe60X38W2ki3l1UlDpv31eMRzirf7YoL9QrGMw/vTbYYbQCVBTzKFfOE5jJoMwdoR4v
	/o4W76S7oC8MeAGjvx/nk59z3Le03tz/69fBUQ==
ARC-Authentication-Results: i=1; mail.elvac.eu;
	spf=pass (elvac.eu: domain of petr.martinek@elvac.eu designates 2001:af0:8002:701::193:17 as permitted sender) smtp.mailfrom=petr.martinek@elvac.eu;
Authentication-Results: mail.elvac.eu;
	spf=pass (elvac.eu: domain of petr.martinek@elvac.eu designates 2001:af0:8002:701::193:17 as permitted sender) smtp.mailfrom=petr.martinek@elvac.eu;
Received: from mail.elvac.eu ([10.0.193.17])
	by mail.elvac.eu  with ESMTPS id 6ABBrKQc008703-6ABBrKQe008703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:53:20 +0100
Received: from srv-email.elcomgroup.cz (2001:af0:8002:701::193:17) by
 srv-email.elcomgroup.cz (2001:af0:8002:701::193:17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 12:53:20 +0100
Received: from srv-email.elcomgroup.cz ([10.0.193.17]) by
 srv-email.elcomgroup.cz ([10.0.193.17]) with mapi id 15.02.2562.056; Wed, 11
 Nov 2026 12:53:20 +0100
From: =?iso-8859-1?Q?Mart=EDnek_Petr?= <petr.martinek@elvac.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: linux-evl 7.2 OOB GPIO NULL dereference in lineevent_create
Thread-Topic: linux-evl 7.2 OOB GPIO NULL dereference in lineevent_create
Thread-Index: AQHdcdM/dg5f4sG55EW8ADvOVqRstQ==
Date: Wed, 11 Nov 2026 11:53:20 +0000
Message-ID: <c67e81ec3fa44745b6c5c13c87fab81b@elvac.eu>
References: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu>
In-Reply-To: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-gfi-smtp-submission: 1
x-gfi-smtp-hellodomain: srv-email.elcomgroup.cz
x-gfi-smtp-remoteip: 2001:af0:8002:701::193:17
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFo8JVpeWFhYXVFcSFhISFpaSBgNHBpGBQkaHAEGDQMoDQQeCQtGDR1IWUhaW0gQDQYHBQkB
 KAQBGxwbRgQBBh0QRgwNHkhYSFpIWl1IWlhYWVIJDlhSUFhYWlJfWFlSUllRW1JZX0heSFhIWEhZSFhIWEhYSFpbSBANBgcFCQEoBAEbHBtGBAEGHRBGDA0eSFg=
X-FEAS-Client-IP: 10.0.193.17
X-FE-Last-Public-Client-IP: 2001:af0:8002:701::193:17
X-FE-Policy-ID: 2:1:3:SYSTEM
X-FE-Hostname: mail.elvac.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=elvac.eu; s=fm2026; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:references:content-type:mime-version;
 bh=b7ijsiPs7j943JrljhGcK1EfRLaxeu3dc7lPKbp7l1A=;
 b=VFH6ldz64Dgwm80Mh57Reqa69UEnDVkv+hCVa3HawwmENXk/bC+DXP+G5tFcrp7hRKrJklexRlcq
	xwi98e6b7jlNa6rnljTQ9cOwPc/CW3Iih3tMgqZm1wVKI2wBcRzaSQG5K0M6StrCeAdtIlT9+wBS
	t/2F6WstPiVn9t3fHYc38sD7b1lFwyejyPwQRhrEEsh+lWEnmkry1cimJI8lfbwCXd7Y+fsXF4J8
	da9N7LDzfktF1hawtr5pFpFQEUXmu8STlWOXVxGp4pe0QCuoK66iWrJCUYjMMv4f4o1Bp0i2wou6
	PuwIkpcZgI57bbWVRRF6xc/rz5nqY+6nffgbzw==

In lineevent_create le->oob_state is used after retain_and_null_ptr(le)
which set le to NULL. Included patch adds oob_state variable
to fix this.=20

Signed-off-by: Petr Mart=EDnek <petr.martinek@elvac.eu>
---
diff -Naur a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
--- a/drivers/gpio/gpiolib-cdev.c	2026-09-23 08:39:20.000000000 +0200
+++ b/drivers/gpio/gpiolib-cdev.c	2026-11-11 10:25:07.714465106 +0100
@@ -2222,6 +2222,7 @@
 {
 	struct gpioevent_request eventreq;
 	struct lineevent_state *le __free(lineevent_free) =3D NULL;
+	struct lineevent_oob_state* oob_state;
 	struct gpio_desc *desc;
 	u32 offset;
 	u32 lflags;
@@ -2340,10 +2341,12 @@
 				      O_RDONLY | O_CLOEXEC));
 	if (fdf.err)
 		return fdf.err;
+	=09
+	oob_state =3D &le->oob_state;
 	retain_and_null_ptr(le);
=20
 	if (oob_handling_requested(lflags)) {
-		ret =3D evl_open_file(&le->oob_state.efile, fd_prepare_file(fdf));
+		ret =3D evl_open_file(&oob_state->efile, fd_prepare_file(fdf));
 		if (ret)
 			return ret;
 	}
@@ -2351,7 +2354,7 @@
 	eventreq.fd =3D fd_prepare_fd(fdf);
 	if (copy_to_user(ip, &eventreq, sizeof(eventreq))) {
 		if (oob_handling_requested(lflags))
-			evl_release_file(&le->oob_state.efile);
+			evl_release_file(&oob_state->efile);
 		return -EFAULT;
 	}
 =
