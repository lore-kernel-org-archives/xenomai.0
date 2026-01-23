Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7A145FE0
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174891; cv=none; b=L+XMSq39W6GbUkwh91DGAqmm/u7VoCMbTmQWL8WOd42iMvXEWLy1rws1gxCN3qpaYxScehq33eNC49N/LQSzRcdaaHeol+M/oaM8r7doANnkwDTz7OHDk7Y9lO4x20zqfK9QIZb0lW9Nh0RX6vAiJ+Qbbnl4DNyoGsdUWkm3Z1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174891; c=relaxed/simple;
	bh=PMskWnkWVPAEP1Rs2NhRu54Sef+xNz6iTO7bec2vLp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buIqCZCgjTinH4Do34JaR1bLpYRt1JLKxqxhc1nhdl2Km0xKN6XvqDCXAk8NnCMKfL+Lzm1yCFomgamzoH14k9WdRn8NxRqdodI8FkOy9Scj6I+OyfkkHGG1swA9ZK1+zByEJZHATS3pmGJSlUqPDrfY0G+sjQR4wiShbEbZjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=R7kNyEIV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="R7kNyEIV"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90E851F756;
	Fri, 23 Jan 2026 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769174887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/m+Z5W/zKzdRBOB2EFVHpv1MuU71woMN4R4QFXBw0k=;
	b=R7kNyEIVmrjf/BNnjurJ6P7WKmGQdJ37iq5hc0nhawla798KTkJDSIEPKYDD4IAjVtBPqi
	01HKyvl39oqtdxoU62hlQh3s3n1fdIWisrWXqZNMpScu/e/GjScyMvIyqn8XD7uYkevh6I
	zZgJA8iG+PfUK47t+Fdm06K/fjh/49ZiJNuUUCOyXrZIMaSGS0d3zRwCZX9QdxcioDsLti
	1d7ol/eAnPdqia1xCugntxoMgGpkhkUnmAvlOr/Eshcs+/a0T84C1Eo7l40Us/PdSC3O7a
	+68xAgLpRkEmhL6HIgV6xmQqEHFiKYbT6Xb4JHvTo7rCQnhY/U0Y4k3yLfo5Pg==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH libevl 2/2] tests: ptrace-sync: only integrate
 ptrace-sync in debug build
In-Reply-To: <20260124114232.1186577-2-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Sat, 24 Jan 2026 19:42:32 +0800")
References: <20260124114232.1186577-1-junxiao.chang@intel.com>
	<20260124114232.1186577-2-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Jan 2026 14:28:06 +0100
Message-ID: <87ecng1ms9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeludeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepledtgfekheduhfejheeipdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh
X-GND-State: clean

Junxiao Chang <junxiao.chang@intel.com> writes:

> ptrace-sync test case needs to load debug symbol in gdb. There is
> debug symbol in debug build. If buildtype is release, this case
> should not be integrated because it doesn't have debug symbol.
>

I don't think so, -g and the optimization level are unrelated in this
day and age (have been at some point though, many, many moons ago).

This is the output log of an x86 build for ptrace-sync.c with
--buildtype release passed to meson, -O2 and -g are both set.

[111/226] x86_64-blade-linux-gcc -m64 -march=nehalem -mtune=generic -mfpmath=sse -msse4.2 -fstack-protector-strong -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=/var/lab/sdk/cpc/x86-corei7/blade-2025.10/sysroots/corei7-64-blade-linux -Itests/ptrace-sync.p -Itests -I../../../../git/xenomai/v4/libevl/tests -Iinclude -I../../../../git/xenomai/v4/libevl/include -I../../../../git/xenomai/v4/libevl/lib/arch/x86/include -fdiagnostics-color=always -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Wpedantic -Werror -std=gnu11 -O3 -pipe -Wstrict-aliasing -Wno-unused-parameter -Wno-pedantic -D_GNU_SOURCE -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wshadow=local -Wstrict-prototypes -Wmissing-prototypes -O2 -g -pthread -g -MD -MQ tests/ptrace-sync.p/ptrace-sync.c.o -MF tests/ptrace-sync.p/ptrace-sync.c.o.d -o tests/ptrace-sync.p/ptrace-sync.c.o -c ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c

~# file /usr/libexec/evl/tests/ptrace-sync 
/usr/libexec/evl/tests/ptrace-sync: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-x86-64.so.2, BuildID[sha1]=7b1a13b097bccaf82b65d49b221ef8c0dd450887, for GNU/Linux 5.15.0, with debug_info, not stripped

Stripping the ptrace-sync executable may be the actual cause of the
issue.

-- 
Philippe.
