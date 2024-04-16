Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE584A5C
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258037; cv=none; b=tM30T26IQdLSOl62P2I0TChVDZlYqwXqLp2lTD8OukNvjwdNeNT6Ftsu6dS+Es7cx0h0oEu08XoWaQlQqETN5Bvl8MgkeZfF198T7uVLhBxhmc6MDDiRM7aOgEdqwbcjP5MRmQ5a5RijJaGlSHCmeEo9KD/L5BBoKz+rcJySSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258037; c=relaxed/simple;
	bh=ejDLLEju8ajJY6mjLtgxLDasgNPUOX9NKNdVEv2wCdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQrBlmj35n+keA8SkQ8khQ0AGkxfAtfTvTKCzypz85Q+2hhuXwFapEbqPcrz9Qr95Jg03/8i//oIstFi4QmzbgNrF1tRAqFmecoXQkGKLz2m2GchB81bYtKmpAjnTA+YLGpSB1UR/TUqQw3OTQ/vnM+XMOKopsFADr80eFIQYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=bwv7kNIl; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="bwv7kNIl"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240416090024b963a4e59c5fadd157
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pqfe1A/IKzJJ2LYqW0K4W1cnsRV8judTGnYE0xNCEM4=;
 b=bwv7kNIlVazsYUJ72yaT4QUPKo0nBX7ciIt71GYVjFDLfUwA1enU8LTdG+OO325yQT0BK1
 71MMidPecRg+AKbfRL5n4FuY+oSXvXK6OskIH9INnkLlt0Ev1WVs16J/n0nSCC6HUQWMH3XL
 bcaPfXItQuW4rjEqSWqa0Ne4gQGHQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 5/5] driver/gpio: Take timestamp according to used clock
Date: Tue, 16 Apr 2024 10:59:11 +0200
Message-Id: <20240416085911.62073-6-clara.kowalsky@siemens.com>
In-Reply-To: <20240416085911.62073-1-clara.kowalsky@siemens.com>
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The log of the loopback device shows that there are problems in the
clock reading and therefore in the diff calculation of the timestamps:

----rt task, gpio loop, test run----
index: 0, inner_diff:       12, outer_diff:       25
index: 1, inner_diff: 18446744073699568, outer_diff:        9
index: 2, inner_diff:        5, outer_diff:       13
index: 3, inner_diff: 18446744073699543, outer_diff:        8
index: 4, inner_diff:        4, outer_diff:       12
index: 5, inner_diff: 18446744073699553, outer_diff:        8

Inner_diff, the difference between gpio_write (write time) and
rdo.timestamp (read time), should always be positive. However, as the
selected clock (monotonic or realtime) is not correctly used for
determining rdo.timestamp, the case occurs that rdo.timestamp is smaller
than gpio_write, resulting in a negative difference and in an overflow.

To fix this, the rdo.timestamp is correctly read from selected clock,
either monotonic or realtime clock.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index e41c64050..8ab9ae43e 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -233,8 +233,9 @@ static ssize_t gpio_pin_read_rt(struct rtdm_fd *fd,
 			ret = rtdm_event_wait(&pin->event);
 			if (ret)
 				return ret;
-			rdo.timestamp = pin->timestamp;
-		} else if (pin->monotonic_timestamp) {
+		}
+
+		if (pin->monotonic_timestamp) {
 			rdo.timestamp = rtdm_clock_read_monotonic();
 		} else {
 			rdo.timestamp = rtdm_clock_read();
-- 
2.39.2

