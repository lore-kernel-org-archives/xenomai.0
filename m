Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0D224F0
	for <xenomai@lists.linux.dev>; Sun, 29 Sep 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577300; cv=none; b=ZdjZ0ksiOFkWojMmwab9W3OSRptdS0ZAPJD7BBBPrDGNGsO08NzVhUENzNPH0Fy0uZVcK7GUc6mXEvBBAJIf2YDItz/KJCqJwPnBl08frf+Pou8g5XbDs6s/noHNbzzbhlg0qlrfbp4oEiukDKJv45PSjiXjZxTh7IXOOkSUJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577300; c=relaxed/simple;
	bh=OfkABSE/zti+O1oiTx9C+3iLAMcG2TBsWqbHah+HwiI=;
	h=Date:From:To:Subject:Mime-Version:Message-ID:Content-Type; b=qTiiWzdepDKFJPG/x6Ih+Il0EQxL0Y88drbwFH8Kf6u/cCyvwPAND//AeMZzuNGjkWtrkJXfeVQ451eEXfHlr9vOuw8bXoIQkpCtrVmV6mGcWlhvE4ep2mSRrAdy95BOIrSAXmJln+DELy4IvIJ2tncewLzyhLYBofH9303U2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from Liu(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ZVd6DHH_1727577286)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 10:34:47 +0800
Date: Sun, 29 Sep 2024 10:34:47 +0800
From: "liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>
To: xenomai <xenomai@lists.linux.dev>
Subject: M_CAN support
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.301[cn]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-ID: <202409291034463951884@sinsegye.com.cn>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SEkgeGVub21haToKICAgIHdoeSBkb2VzIG5vdCB4ZW5vbWFpIHN1cHBvcnQgTV9DQU4/IHhlbm9t
YWkgd2lsbCBzdXBwb3J0IE1fQ0FOIGluIHRoZSBmdXR1cmUgb3Igbm90PwogICAgVGhhbmtzCgoK
CgoKLS0tLS0tLS0tLS0tLS0KCgoKbGl1eWFuZ0BzaW5zZWd5ZS5jb20uY24KCgo=

