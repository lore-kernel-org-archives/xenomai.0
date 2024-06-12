Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7C16F0FD
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194143; cv=none; b=c3CC7tlsPT+6nJMqf4xwjKdtoPWZ+fXNhAA149wQG30kpwucNp8S0IJau5nt7L3l761tlszan7OOIjk53m8WdThAHAaK43ss4HYISx4rrOJlf5MgwpIFl0TSg02ln12xNM/baGHnPfDWLGaeKDlTCMygqAkf7fpA88wxSmKTO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194143; c=relaxed/simple;
	bh=axQCzyIggzmUW4AHhP//aOUka4YKSihudDBzD2S2m4s=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=QrnTvD3vovEgi6+VA199GeCy5dxk24vd1cJR/7LiqPhXk0r01pxbv4ReQJVOicJZfzCKSMX0qF3yIAXjx77/9mKhSNpD6KHHFiwWYcFHQcVfk6IoW+lLuv4R++Fy/jjahwINXS65BKqe//wqYakHY4pC7/NIcHnvL1cv2oVrwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=VIPmDTmv; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="VIPmDTmv"
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id BEEAE6013C;
	Wed, 12 Jun 2024 14:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 45CC8uKg409204;
	Wed, 12 Jun 2024 14:08:56 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1718194136;
	bh=axQCzyIggzmUW4AHhP//aOUka4YKSihudDBzD2S2m4s=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=VIPmDTmva7FIcD9f5QT1nAFHnEWfq1TRLOZyQwSWmbnqA241hIuEeIG6tl2MYMtS3
	 kPe8LAdNhwAZdbcgXbV5hy6cZ8j7QTxHMFy376fdyszppMohq2S9/Kd9/h4afMRoj2
	 O9OTNc1YIZ3WoZUOL9Mlh9xWUrrg2tZZBFzRAznC75sWykJ7YmHacJH6SddCcmaW1T
	 b0fKCTxLM7rKKJR/bDAD6vKuSYvg1liejdQ55jBkXS3yHEBBMASPA4jroPLtvNO1nR
	 zYoKoUV4adJanocNyAXvhm1T0L8YSWQ5d1H+dZlHOJH5IAmh7XEKZWYlSvMcvEXfoK
	 Y1NgWvGoWGlqw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <PH7PR11MB74994E73E4A092626F492425F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.182.115
Date: Wed, 12 Jun 2024 14:08:56 +0200
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
To: =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1158-66699000-d-2e725200@6131804>
Subject: =?utf-8?q?RE=3A?= Porting RT net driver to dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Thanks for the answer.

Maybe I mixed things up, but I thought that with dovetail, one would so=
mehow use  linux network stack with special OOB drivers, and have no mo=
re to rely on RTNET. Is that correct ?

Fran=C3=A7ois 

Le Mercredi, Juin 12, 2024 10:07 CEST, "Chen, Hongzhan" <hongzhan.chen@=
intel.com> a =C3=A9crit: 
 
> 
> 
> >-----Original Message-----
> >From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org>
> >Sent: Wednesday, June 12, 2024 3:08 PM
> >To: xenomai@lists.linux.dev
> >Subject: Porting RT net driver to dovetail
> >
> >Hello list,
> >
> >could anybody point me to some example NIC driver for dovetail. I'm =
starting
> 
> Theoretically, the existing NIC drivers in Xenomai 3.2 is compatible =
with Dovetail. 
> The drivers works with I-PIPE still works with Dovetail. I just had t=
ested rt=5Figb and rt=5Figc
> on limited NICs and platforms two years ago and cannot suggest more.
> 
> Regards
> 
> Hongzhan Chen
> 
> >to transition from ipipe/rtdm to dovetail.
> >
> >Thanks in advance
> >
> >Fran=C3=A7ois
> >
>

