Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3101F19A
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258014; cv=none; b=ahRAj3z4ZMDN+EH0r/krwXoFeFESR4XVh4jxA/6Glaf3fF0SJlhtnardxI7lpE7wyL5XMS6vkF6TajhBiGtHyO8Sd8dJEFWbiMuhZwTGAT1Pj8TW2akVZBgxcixsJxHV7E+XDZgGt2LnhB0hTGBtapg0mboXUkYZLhZEctCKtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258014; c=relaxed/simple;
	bh=ABI9YgfhUFET1GnYv4iDfNDvfhrWNDP4O05yEEJm8DE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TQzipdzihQQsxlfMPBjmcEIWZVkCIV5R7yeuHIQE+XI/l3+Jjwt/2+xp18cQrZRj5a5blXY2Gew3XrZKfzwKdAUpjvMLxHtWc6hxF8Ja5KEsLyW9CiEfaUM7I9OuJJlyZE3ISbVDcRX7+uskaVwOQVUXGx0Llz90m8B3QOvREFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=noc578wC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="noc578wC"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202404160900009cf98aba5043e1e572
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tBx175fdd+XBRHHZ+9a9kNVFBU4yBxO6Mj3LL/eAalA=;
 b=noc578wCkPUedfgbpW8utWlH31fpBpidxNBwakGimd9yoB1/CqSHw6R3+MjoJXDpd1CP3F
 9kNXjtvsvfpYfSJOds3CfqrdXeX5+mlXR2a3ROEnBYbbpKPTaDfblBqOttpcwaiZtuDjOXyA
 W9m80v3mihGTaTsBArsi1zA2nabHI=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 0/5] I/O benchmark fixes
Date: Tue, 16 Apr 2024 10:59:06 +0200
Message-Id: <20240416085911.62073-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi all,

as mentioned in one of the community calls, I am currently looking into
generating some data from the I/O benchmark. I had to make some changes
for it to work (again). For testing I used two rpis 4B.

Best regards
Clara Kowalsky

Clara Kowalsky (5):
  drivers/gpio: Add driver for BCM2711-based SoCs
  testsuite/gpiobench: Toggle output pin in react mode
  testsuite/gpiobench: Synchronize index of loopback mode and react mode
  testsuite/gpiobench: Fix calculation of maximum latency
  driver/gpio: Take timestamp according to used clock

 kernel/drivers/gpio/Kconfig        |  8 ++++++++
 kernel/drivers/gpio/Makefile       |  2 ++
 kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
 kernel/drivers/gpio/gpio-core.c    |  5 +++--
 testsuite/gpiobench/gpiobench.c    | 17 +++++++++++------
 5 files changed, 51 insertions(+), 8 deletions(-)
 create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c

-- 
2.39.2

