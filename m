Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642473;
	b=quFB1YpaQQs2LaqAKlsAK7/VDI2jqi/BTZS2l+pADrNYbOcxIehm8hGwGAvpB4edMOaC
	 VH6kkKAeOCkUkF26QkINuXPLsWeBuw5N4mVWwgIJnxDORQK+WXUZi+v46Cfr0N2n/tjaJ
	 R/lazKT7eRiSHP7MWrKOCoZLo3gxDR5E4t8H/Nh0r2QEV/yd6uVjSteGiNSzSsyTS6Sqx
	 Og2DYo83SnPhE/jnhk4HjOQk0yCZchBHVjQYyZCPz43LmyEarh9JqvmNsnwB5dkmM6cEP
	 rHcXgC0GIT51k7SBHES4H0ZY33KA8YRUez4OFy315x689UQSEmyHBgcx0tR8K/WqUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cRQwgvwyYwHVqPS/uenPIX5KhWukZxBssNh2xKaEdeg=;
	b=MkFrufx+jbHYTGDMWAXWBZmcnuta60UXjvwhQkINtNGmcZZj9t6HssJLV+8QQt0W08Ad
	 ZMHRH1n8qimjSCraMRZO1y4CrWgDxLJpTb0cQSlWVIDj97fPL8nfP1MEoE+2ZZPeEaOnC
	 LBKlc++yZUvL1qwtvxlk6vG4FpU+ZwsyctQvRIBeMGYObQqxCrjbgx0N9WGzjuAtcGJBf
	 bhh8Ic8ba3PPjNNF15RLF1Arc9NUIocigGXuYzda0xYG/ZOblL4PKg8b8ZJGuHyCIiJ38
	 bDWsn3OkiPYVYP4ddzXYe8srH8r3P/mKqFuXDxywxTED0af/9YIRPJ7AMqSIfowbOBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZjPz+qt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E2606A321
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZjPz+qt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB71F000CA;
	Wed, 25 Nov 2026 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642473;
	bh=cRQwgvwyYwHVqPS/uenPIX5KhWukZxBssNh2xKaEdeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZjPz+qtaP113Pu3vXlzT17X6pVmvlFkUVugeHS+43+FCwwTNgGpuq4PwrJBbJ4Ui
	 5N2GLsyovWh7P9aHXTEYEQP3qQJPvpHkoPTE+JNxB9UMp5GGRcIJM4aM6k7N193TDU
	 M+8592YVhhIBPxKxufsIAbOXUzyIFHbXs30BPKwAU+1ycrIGSttaaXLVbSKyRYGofL
	 iByv4bta8/R8SuJJbu1CEUAza32VKPRQxq2znYmjN8SNk1yJ33VkkLRBX4MpxuSAmV
	 SGtdFmQM0hBOt8nJDfFuMsYlaL8QHV07jGUMmk+hMRbYdWFm8m4NkPbBKwuo8hbXum
	 3owOuSmRYk0DQ==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/7] lib/alchemy/pipe: Do not require a Xenomai task for blocking reads
Date: Wed, 25 Nov 2026 22:34:16 +0100
Message-ID: <20261125213419.2363742-5-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125213419.2363742-1-rw@kernel.org>
References: <20261125213419.2363742-1-rw@kernel.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

rt_pipe_read*() block in the RTDM socket layer, the Copperplate TCB is
not used. Allow any Cobalt thread to wait, only reject asynchronous
contexts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/pipe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index b5ada2c7d..a289f150d 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -327,7 +327,7 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
 	if (timeout == TM_NONBLOCK)
 		flags = MSG_DONTWAIT;
 	else {
-		if (!threadobj_current_p())
+		if (threadobj_irq_p())
 			return -EPERM;
 		if (timeout != TM_INFINITE) {
 			clockobj_ticks_to_timespec(&alchemy_clock, timeout,
@@ -420,8 +420,8 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
  * waiting for a message. In such event, @a pipe is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was called
+ * from an asynchronous context.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -442,7 +442,7 @@ ssize_t rt_pipe_read_timed(RT_PIPE *pipe,
 	if (alchemy_poll_mode(abs_timeout))
 		flags = MSG_DONTWAIT;
 	else {
-		if (!threadobj_current_p())
+		if (threadobj_irq_p())
 			return -EPERM;
 		if (abs_timeout) {
 			__RT(clock_gettime(CLOCK_COPPERPLATE, &now));
-- 
2.55.0

