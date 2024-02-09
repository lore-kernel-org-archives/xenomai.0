Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798331A89
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479477; cv=none; b=oZXZoVZa1Y5pzkg1TGTLy9lL5D3d5Oo2VEAeoHqmZ2DudZdhXqe4D2reBmj7jmeNB7s02CXnnnWIrttaJhdrSOSo0NdtkgvHj7qmSNlmXwQO1UDHzLCzQ1+j2LY0bQwx5XttykcPi5pSC04E/sW/wPRdSkmSP5veI3BP+ng6TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479477; c=relaxed/simple;
	bh=apqbQ+MUcLeUgyirMQFUwV95MP16avxXUv2g20yTHXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRAb9EfONhZGq9tJJkmJjRC9PfC9WWp6RuvWrKpxYPl9w+w304Dz+Nqk4bkdt1gVcKuZB8jXqrSMKYn20QxJZkTDcWkNH9N9l7QsaC25nnwhdVhvTM0SSNKAIjBDuxpfGvZf1XY8UdLVDdkQ5t/xWktW7KIFp6dyEE7CXCa83e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=UKyUlCJJ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="UKyUlCJJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202402091151158a24b577b41c864633
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u22knRVoB4CF9IFg1+Tfu/pESd1w5xUSNcr93GCBiC4=;
 b=UKyUlCJJJnI7ug7L4wrwuvN6dEyyHio3SDcEXQKKuf1RRM5/G0D8Z9lxhrr8LZ3yw809/X
 s2zOe86eas6aBG1w9widX9ycnsHJN/+sZa9m+5NMW46TR1j4IDDwfbn4Jtlf/Rhr6AXqRzrJ
 bkB6tSRghpdI+PN0JkOBf3I619IwA=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 5/7] compat support: cobalt/posix/syscall: Use syscall_get_arguments()
Date: Fri,  9 Feb 2024 12:50:23 +0100
Message-Id: <20240209115025.1884451-6-clara.kowalsky@siemens.com>
In-Reply-To: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Use the generic implementation for fetching the syscall arguments.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/posix/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 6e1f15ea5..1d37cb279 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -584,7 +584,7 @@ restart:
 	 */
 
 	p = current;
-	pipeline_get_syscall_args(p, regs, args);
+	syscall_get_arguments(p, regs, args);
 
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
@@ -733,7 +733,7 @@ restart:
 	}
 
 	p = current;
-	pipeline_get_syscall_args(p, regs, args);
+	syscall_get_arguments(p, regs, args);
 
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
-- 
2.39.2

