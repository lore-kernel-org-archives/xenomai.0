Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABB3F54A4
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519024; cv=none; b=PR6V+uoULhB0a9RZHeo/Rxuyr/4Q2Zd7bR4JMPoEznAgfIYmmypDHfoWDH8SUeuU1w9yXQdEk8eZ3XOY9ilgU8Tf1ipUwoenrvSIajQqHL1lzx5lhiUkuC2KqzKhDZUBGZzl6AxFWaCHTQyVo79aQMOyCW7AGRS4XCBaiNd8X4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519024; c=relaxed/simple;
	bh=1IWPjZ5HeGI2ZZ7lqy+eDj/jVdYodBQ5spbAom15Ew8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tK0wWq2w7yjslR+ecbzjiuT1/0eHBLrrF5329v82ytDZCuMFnIaHVbclaSTfYO5bZTgdlN9sl1jrnWGcnV3+E0Ln7K75IfABLB55c+p/N1ygfzbSkBIpwOz7cRLGdiGOf0enIxYQYL4YC1VsJBZzOvuWGIGju+bC2zFGo8QMrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=R0rQt/Z1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="R0rQt/Z1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 822D23EB86;
	Fri,  4 Sep 2026 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788519013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CvhLk3m79m3fR5p0/zwelekhjfXxLVpU6EFIhB1RZ9g=;
	b=R0rQt/Z1EEhGANvd7DUzpdSIq/IRNXr4n3KfZH36I3daOr9CHvfp7uFVu21B4zVHiR3jUP
	Y/f53nxk4l11O6XARdlq6ktfM2EieBQHQ/DiimBz3iPrAMZPKppgZ4U0lV9d/q0A/1kB3f
	4wKMsKV9pM1sjxcrWDdpZKdLjaq+Gy9OV6xbHLYsOCp4uHfQEIVfdsDDzhd61D9ie7/IcF
	AW+fiQO3Te6F+G7/wfYOBb1Bcis+rP18MUoRSgDTWmBpVhbj6zi4YPb7H5yKoGhxjrWJuO
	EWbZsepPDeRrnCG0UbG5VGXjtquiqEO2z18l2v9GoR579Adf0de6Cl5RMNWsvw==
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Dovetail + EVL: RISC-V + 7.2
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 12:50:13 +0200
Message-ID: <878q5he1ei.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTE0Ksx0k1g4lm5YfBPxmCIKjUxSU/GDqq6aDsky16SZ05O65RlMdoyy/b0TdCA4mCZ+/Xw/x8FSckerPY/2VwJm0kDNZ9NWO9euPOZiqqnj9+bUSTGoREQWvFJ4JVPkkEdmVPlzrM72zCPEEObUKTRKpRB0al7R9PDnYR922TGdKFLRCUuGOYWntBU2Eu/Ho2/WRW+b40AC+Bch56RqVZcYOkolXb7wPWlaad9pkP3xuPrkT196nr9rqux0et8u1tbVUL1THqxpRgyGpXAQSMa0lYvzO5QZNvChnGvqo8wZuN77rVUiVfWzj2+8yVu8Kx/h//vdYVZBbttg4sOZmiGdXafgF8PxzwKKuc5wyaLFdepZxEjrIbH/WtMWmc+kaQGY/dH/SFCzkvQ+RWo2TU/6WPuYAjP1uxRjZF7uQHDXGWm5fFWFkqpUc4t/YEuzszb3EeaZNc6WvPVbHfjLRuC05YvjZo548Ni/m6bpFckV7KP23noNy4rqHeCCd4PRWx2J+A5Hk1yIkmo6gV08hpPawZh4ZMnDz7pm7mbM/UGr2WvCfgt0zOlm65NTyJqzC56/V8fUbCgtTrLOZbh/4v1dsgdFj16OMUkEw19qg4s8yjQM+ZMTeX/90/8WEHdn0P5hW3hwN0s70Zqh+XxdKZHQLWC/ibmOKmhYZVk9jGX5lg
X-GND-State: clean
X-GND-Score: -100


The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
implementation targeting the 7.2 kernel is now available from our
development trees [1][2]. Starting from this release, we support the
RISC-V architecture, thanks to Tobias's work.

Building applications for 7.2 requires libevl r61.

[1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-rebase?ref_type=heads
[2]
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?ref_type=heads

-- 
Philippe.
