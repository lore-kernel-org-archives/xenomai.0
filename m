Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C415E5BB
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153774; cv=none; b=DP9OYach06tBIaW5kqs2tZm8eDRywPBPGcKI0zGPTbQxgMd7MlaIF1Y3seStsetf0hbfSAlsM++jlXYd69FwRBhw4wo7wKKnu+j67/g2zjT69cZljFIuZA31jmiGEaf1asjF7m13wcNr7NTDOYEkzKBUM1GGc+R3QdSZnezj+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153774; c=relaxed/simple;
	bh=CCtC1oBrFR7+5s3ohuJROMCpCs52DlinjddlbP+DHTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+J+OOwvOMKhVaMfKTunCVAdnVJ8HoZGmYm8JnGTbPYp/Fn73PaH2hKwDwr4UgsEFxFDCHevRRUE4z3Uh5hVa+ZM66hTCSz3Ht+FiIYNDyEAmU5e802jIEuZ1OX8/6g+IfKUiCq7ej3vE4SOG7viy0hXnFb/cpl0e8uqJ42sv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OY20q/fV; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OY20q/fV"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3B1B15818AE
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:52:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 188C73EFFB;
	Tue, 14 Apr 2026 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1776153134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3TtHMbG6GOLigtINVS4E9WW569oam2dlfBxTAqcKdY=;
	b=OY20q/fVJulHvzQpapDzi4qYdi1ZBzR3uvH+D9J+wsrEqXL0PutCYFlxWLxsaxZkAYHwlo
	zMZG0G59bFmqB7Af4cYcy040+K77ZowtI+QgZZtYBB9woMHbzfaWUCwng3eEXYuIM8x9ZZ
	DO0n7ZCN4qr7QVtTfu3tb6IN6o4rZSv/t7o0q3JaeIBesOYLZ+PXXTRW6oftR700wVixj6
	XJygvZXLygIosnr3DnOqmAEUMzyM+zfOzj35Rg3z8H0yhDO8oGzC6EtFa1K+gLuNf7RhEo
	5HG/olZCULX8d8nYTnD6zBQtQSV9/wKecYJLUvj6Qesr/wWpczNI/DajLa7O6w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Brandon Ho <brandonho667@gmail.com>,  brho@relativityspace.com,
  jsridharan@relativityspace.com,  xenomai@lists.linux.dev,  Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <87se8yyomg.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	14 Apr 2026 09:42:15 +0200")
References: <87v7e8yzhj.fsf@xenomai.org>
	<20260413181929.1801013-1-brho@relativityspace.com>
	<87h5pe7lvg.fsf@xenomai.org>
	<e31e14a3ff9eb52ff8db44f23e3a5a5ad29a490c.camel@siemens.com>
	<87se8yyomg.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 14 Apr 2026 09:52:08 +0200
Message-ID: <87mrz6yo5z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGa7uEfCPVVqt9SdW4ka7p/NIhjH+r5tqwnQMGKrhK3IJrQ/Y7XhP0xfIeg2oew61Q46BPv4IFJRTShJPHS21h5mXZf/f28FHe2cVmMO6BwhE0kQIffe2CRRH8xux/2OdABqNCKqn05fCFmqFSXMV7OGvLRF/tXNXCQZO7347ENRz5m+pOidpXcKz8mKivw60/5j+eQpsp3g4gx3qjhYZUrbpjKsxmf2Bdm/DN/JPw7rbpEL56Zzq58sQxRwG0gSli4zdKNL0HyAQ2aBmHtPC/I0qOAnay74ZZyntbmzoC2oKRvbSuxyoxcoJabDEn28XP+jhilogkmVg0Pln2fNYlxqeCXI98waABkEG+4HgU8tz53/u87XoPFIkjCNl7YkK/rddn9FkIj57IfpGXl5RHffSuXGU3+PbS+X1EtggUcrIfG6L9ZMmHKPXqMr80IRUCkMiMzLM2BrhtoKFvJi5pkkg+NAdgkKesIQyvDW1lgiv33+WvM4RiCYoeDa7ZYqj1qNyBst5/dKg7YKoI2rQ2r2mcc8XJk6B21AmPkz8wr6AJGxlEiEM+dM02JNQbm0MR+Gq6u5t8twrgyNivcfPMdfoaOuRRAcsKw/Z0kVIr8NPcSTRCooCA40Pw11SHo0iN/NsaswggDP8uB7V4iRlpWxdjV5s/zvV7e99cYkCcDqA
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Mon, 2026-04-13 at 20:31 +0200, Philippe Gerum wrote:
>>> Brandon Ho <brandonho667@gmail.com> writes:
>>> 
>>> > Thank you for the responses! I recently came across the
>>> > `compact_unevictable_allowed` sysctl option and it seems like it could be a
>>> > good fit for our use case. Setting it to 0 would prevent the kernel from
>>> > compacting/migrating locked pages, which should eliminate the minor faults
>>> > we're seeing during compaction.
>>> > 
>>> > Could we possibly set `compact_unevictable_allowed=0` by default when
>>> > CONFIG_EVL is enabled?
>>> 
>>> Definitely, yes. Thanks for chasing this issue down. This patch is going
>>> to be merged upstream asap, you may want to apply it for a preview.
>>
>> Targeting linux-evl or linux-dovetail?
>>
>
> linux-dovetail, this is a general issue for any latency-sensitive code.

While reviewing all PREEMPT_RT exclusion cases in Kconfigs, some of
which Dovetail may want to share, I found this potential one:

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -947,7 +947,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT && !DOVETAIL

Any objection to disabling NUMA_BALANCING when operating in dual kernel
mode? (CONFIG_DOVETAIL=y).

-- 
Philippe.
