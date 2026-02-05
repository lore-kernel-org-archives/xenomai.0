Received: from de-s03-gw2.mail.cloud.nospamproxy.com (de-s03-gw2.mail.cloud.nospamproxy.com [178.212.92.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8734F27B
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=178.212.92.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280878; cv=pass; b=r7iWl7a975BVF0wJXOBKKNZ/pPcAck43AT+lE6QUDeDmESi+FmXYKLpUnJjo9AKtC385jAtj+HTlmx6XMmkxjCKoUGuIhuKcAqFbqCE4UdJdmHW//EfUVB8M1K8qqXrveFczEz4vwXibgCWhR0z2znfkiCx1MD+/tLvCN6s3e+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280878; c=relaxed/simple;
	bh=SK1ss63CKgfLUIl14cBdXzH1r9+QHeRNRohFo75yI9s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nJHHuPCjPYdchsf07NEgyOz0HpEWbT6M0x5CowKuoeregMS4mbAIiGB36see33/c2+vD1xh99/LC6wlHsRVIGpHOnhzo8Ef2videWrISBt3hqLVI/Mlw0gOEqbvVwRt+c/oJUYm8rSeIsGk4lc9O41jPKdywXnIGdhg0SkNmlx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com; spf=pass smtp.mailfrom=baumueller.com; dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=XG6qjrFg; dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=m3bR/1Z1; arc=pass smtp.client-ip=178.212.92.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baumueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="XG6qjrFg";
	dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="m3bR/1Z1"
ARC-Seal: i=1; cv=none; a=rsa-sha256; t=1770280875; d=cloud.nospamproxy.com; 
 s=arc-s03-251009074454r; b=
 w0+fEtr4vRfAGRt08V4JcJCTtDe0yIjT30q1vtvDFdJknxCBnQcFFTSYOWEBr67AlTNoSy0Gv9wkDbnSjlPl69Zxi3Zm1N+8J0Q8VHxDwihxlD91k5wRSg4AXo6tIiblgEUOYOtgU/VV4vjMFuBdPIQkHvRFACL2BIVpeEUH86c=
ARC-Message-Signature: i=1; c=relaxed/relaxed; d=cloud.nospamproxy.com; 
 s=arc-s03-251009074454r; t=1770280875; 
 bh=SK1ss63CKgfLUIl14cBdXzH1r9+QHeRNRohFo75yI9s=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 fX/8fxMHcJTHYtWhN4WNEnoFzAc9hl6l5MX7yHWNdyfm2IqgJKrpAGR3gqQdAztfijrXWjaU2fBj8wc8/e1LXNuhJ4xEqUH5yBVeiwdMP0cXl2HaX+gBWbDL7PWSni+qn24rIHPhsVUD2bdMBHvX3JhZ0D8ZHciAR6TSymGHLgM=
ARC-Authentication-Results: i=1; cloud.nospamproxy.com;spf=Pass
 smtp.mailfrom=Peter.Steub@baumueller.com
 smtp.helo=nospam.baumueller.com;dmarc=Pass header.from=baumueller.com
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1r; 
 t=1770280875; bh=SK1ss63CKgfLUIl14cBdXzH1r9+QHeRNRohFo75yI9s=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 XG6qjrFgDLoDeo0Z3pVA910rNJ8CrFxVi4Ty8Wp+CnlWgmXUVJhcDjAcupGIAssqFwdU4Pd1y+T4VLc8RTf/VFaUgLEEFlVMVyDl9ymdrD7fuEJK7xyI7WXmUFdOz6EW5+Gqf3rbkBWpQh6/L0/a7ovA7sLBWkdkPhnJFODMfyo=
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1e; 
 t=1770280875; bh=SK1ss63CKgfLUIl14cBdXzH1r9+QHeRNRohFo75yI9s=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 m3bR/1Z1lzkwdJFJ/mzHxaCQ3AFgcgZiIhX4TfZVVnNns2SD3OpjgeDA7GzBmdE+9bqdcbc4ZOMfI1OHdodMBA==
From: "Steub, Peter" <Peter.Steub@baumueller.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: evl_demote_thread() leaves dev file of the tread
Thread-Topic: evl_demote_thread() leaves dev file of the tread
Thread-Index: AdyWeye1/05AW2eHR5K7oedN4Xh97Q==
Date: Thu, 5 Feb 2026 08:41:14 +0000
Message-ID: <09cd2de3c2514bfb8d80ebf969a8eaf3@baumueller.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

In my application I have a fallback solution to kill a oob thread, if the r=
egular way of closing the thread fails and a timeout runs out.=20
I do this by calling evl_demote_thread() and pthread_cancel() afterwards. T=
his seems to work, evl_demote_thread() gives me a 0 returnvalue, and the th=
read is gone after pthread_cancel().=20

When I create a new thread, and try to put it in oob mode with the same nam=
e using evl_attach_self(), I get EEXIST (-17) from evl_attach_self().
Am I doing it wrong? Is there another way to do a detach from outside the t=
hread? Do I need to do something more then evl_demote_thread() to really ge=
t rid of the thread?

I am on evl 0.52 right now.

Thank you.

Mit freundlichen Gr=FC=DFen / kind regards

i. A. Peter Steub


