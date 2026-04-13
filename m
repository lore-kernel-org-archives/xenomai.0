Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8F157487
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104435; cv=none; b=THgBS2b2i6FD2Inr5TD2hSgXvpBJ7BeweRG9wHMgop6e5uzpbNWYLwo7OZdN+l9EAwULvhOR0c2mq/oCkWj3Nz5zjpASvFi8KQ1pGmV5MfJkEE6efdkRILgOXw2X5Tuox504LrH+nuLHEMxF/VNMa6dE3ocsicFMwA9iuoxlxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104435; c=relaxed/simple;
	bh=QUM2DeSFXry7zmyFrPhoPzcDa6xqKGlxyD51OTE6ACc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hay16EXqKIA9nsEo+wX1j6zrQjO5whKtt1p30LKTaujLDt/K7tr12IXihMKfckjT9L3EWSpYhy8gK2LnIUfTRh1rdsRMOwrpmKmYl7UJXmXBZebzJBVRMFZnFTwp5t/qg+KU1nGZGzQ34W963qrK9bN+aAtD1xofmNecEYcBc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPEPEusC; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPEPEusC"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4764459eec.0
        for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104433; x=1776709233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUM2DeSFXry7zmyFrPhoPzcDa6xqKGlxyD51OTE6ACc=;
        b=pPEPEusCQFBr/65aAOXYHNOxCYKnT6XQN6R92m7AceaVCRB/SRIPgDeDIFxE5iicKa
         J7Tr1q7f9TgJe9Di6sFjRkOjnf5hpf7P0kLZ3uEFGidaHvq7tFYsGYkbDtpmytc0AAYe
         ciiivaX+DcR4Gm3eGRJ+byBit3A3hVm78wxETEl0pOyz7Zcspz9kx3ayLX1LsJeQ1Ce4
         AOzgIGqVl2KehIPfSZudskiwRxx18klSAJAupynAj9RP3/xwn0w9x/fHseEkYNBIeNn3
         CE0hnWHPuYdi+ZCqtEcPnRyhB1Kg0jyEOa48NNnwTcy6QYqLRLp9fX56TWcSEQmNLtYd
         r43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104433; x=1776709233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUM2DeSFXry7zmyFrPhoPzcDa6xqKGlxyD51OTE6ACc=;
        b=r+6L/XhRn4ra2Y9r33bwjy1TXpWVl3gSR8JPNkQuvWgyxWF8la4lR8l+HpVMnG+ogd
         PZsNVreWtVzW8WGCT5/THIuphotFa9C/fDBZONSoBcsJbbwAwGLYjL64oRLKknNq6CCb
         5zzQx5aunlbUHj/HRQHEXiij2tfJxCFzd0ldmUN7HMu/MTfNFM/Fh3fb7qu87t5jeQyK
         +eb7xRDqXd3jIq+vgyb/zx4GofKGqAlDzuSMV0She1auh4h6dwa+LRl5LvBwKb/Lt8d2
         spj6eqJUxkwr26XcKtqAsfSclMVGWlMocKijC3gskntPuFe/NTTltD6RmULpAXTX23Tn
         C4TA==
X-Forwarded-Encrypted: i=1; AFNElJ9y59hR0MyMp5lIPaR5gyDUL10Yck2xrJP5qNG8z4ABCc8ERWdNnARu2cgsgG1+7Apx7qCntYue@lists.linux.dev
X-Gm-Message-State: AOJu0YwpKaMRpdx27/S/tfJT2yOaxj4LjMVIDY+COhJfAI/SQn3aFhx6
	9BdXSMS6cy7FgA+1QgLOg6CI7DsnH2ssKvEf6QicKTxJdr9Rugx5y5cw
X-Gm-Gg: AeBDietanIIAjQASzcQYV3I748JhnSUHBra+ZW69VuLkpB3um1mL1mlc3X/6JCU4fOF
	TayJDMRexAxM1ao1b6fM3dL8O9+KzMK1nuTGSBhlVrI5l7CR9QFhoMyAJqx+uqccolJ/IgYK2lr
	3NxD1nTJGT+w0X+0tQtTYR+Y4tzXbye1dqezfBBvEgeD39xci8OTKGxcdVsLlMsV3IQHLFyzO7r
	oNAubdvYhIcmxczUHWJZbSt1fPVLbqzGQEoztdIRl3/hhKutW3Z9YhFL2MTk2s+SzzUvJt1Lfbw
	ZBH0dilVPrfA8C/qcejedLanKkmMQoHbJa3ypZibwVfW4MgF3InIeqLFEiF/ABhJoRpXDzTnzXQ
	lni0VN0SQlrMuWFnzRR2ZprNqFLzu+BNdF2nRiUzttMgnUrGx/yDuyjRQp6KaxNHwzV1xXZ5GE3
	iO9sZTFadrScB22zxkv0zcammUv2I/Rs7PArqtfHp57dFaspsUMfcF
X-Received: by 2002:a05:7300:8c1b:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2d8b8142df1mr3149245eec.3.1776104432974;
        Mon, 13 Apr 2026 11:20:32 -0700 (PDT)
Received: from brho-desktop.RELATIVITY.company ([136.226.7.47])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2d5621d7d55sm17392230eec.22.2026.04.13.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:20:32 -0700 (PDT)
From: Brandon Ho <brandonho667@gmail.com>
X-Google-Original-From: Brandon Ho <brho@relativityspace.com>
To: rpm@xenomai.org
Cc: brandonho667@gmail.com,
	brho@relativityspace.com,
	jsridharan@relativityspace.com,
	xenomai@lists.linux.dev
Subject: Re: Minor page faults from memory compaction causing in-band transitions
Date: Mon, 13 Apr 2026 11:19:29 -0700
Message-ID: <20260413181929.1801013-1-brho@relativityspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87v7e8yzhj.fsf@xenomai.org>
References: <87v7e8yzhj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the responses! I recently came across the
`compact_unevictable_allowed` sysctl option and it seems like it could be a
good fit for our use case. Setting it to 0 would prevent the kernel from
compacting/migrating locked pages, which should eliminate the minor faults
we're seeing during compaction.

Could we possibly set `compact_unevictable_allowed=0` by default when
CONFIG_EVL is enabled?

https://www.infradead.org/~mchehab/kernel_docs/admin-guide/sysctl/vm.html#compact-unevictable-allowed
