Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94C1D1F67
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066497; cv=none; b=dT6JM/KkGzRIjnxOSUWobabFlX0fKqFPteLOT7S2UWNO5c1yPa8kcZ+VvFdab6M5tE7AIe9RsciJwLkg85J6RdfI1dR9ZzyPF4U22C9aC4r6PcTyWJ9m3oNDBd7/TJZDgNf5TVvBibR+v0T38dW4w0hwSRYdoYYb3tPgJW6JN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066497; c=relaxed/simple;
	bh=SoA4tcTyrfXKKObW9RYsaYgQNLuNYGFTEaBZobRaOi8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NSCx5QeporT9tN6Ownhlj9XWzVCJLiR3oDjU+YQJWYzoiqK2WJrh0HNtnbKMv/rGTFUFk3qAbU51nzC/hmgC6svx722PVopjVLMHCB1VaIsIATNf8ba4mEL5RLeTUbpafNGA45iABF0lxlQXgNEq6Y8D0GLgYElwDclqGygfYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ZjrC1z._1729066474 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 16:14:35 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Subject: drivers: can: sja1000: add F81601 pcie can bus support
Date: Wed, 16 Oct 2024 16:14:32 +0800
Message-Id: <20241016081433.917945-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
	This patch is port under linux kernel 5.15.51,only use the can control 0,have tested in intel J6412 and Hygon C86 3330 platform.

