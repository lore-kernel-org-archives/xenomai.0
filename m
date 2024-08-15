Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35993BB50
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711606; cv=none; b=OBD7PN/s3+2izJbBDF+7NAMXfxcCUAGq5+4K74ZMbYrX3COvvtj7rIeg8/iLlIbT1294EAXdCQjvQf5uSCfksfgtvbh+A/ldTbYXgAcuT3RReuC+I9HI59LHu+6/AUKx0XMTbBA2DspL4Ze+uahv9tzJvTMhMUiEbUtkcfDc7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711606; c=relaxed/simple;
	bh=nRBOTqdpKt9QTl1qW1IPqQ3oawrcKjen4EaoBGGaC30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HeWrYoBKf2HYoEc/efW3gLq/7dZntMIjKGH12phKyLv0KO7jPnfl1ZFEnBxHquhM8cG8CIFlx0QoBjpgu+nPLVmYBkYsaOmTRyud5kK0uTCNsyO6izDAwlTbTrKLmE8MIeFPs5CmqmAlJ2PyqEAhJSm892Y3uktp9Rgt6pFE7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8PdZBXb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8PdZBXb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so504824a91.0
        for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723711604; x=1724316404; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mt9bUZHRqMY0+8bv6/54FbkSnQ0N+CbgqUlfmqdHboM=;
        b=k8PdZBXbYSNg5DnHX8JgAtuUqIQubVDko5g07MHGEIavcjhPCJaJ3agqxoHu6ZU5bb
         hLFxAqUU2ZRHdrdQHVVXme5yW9lByhYztqp6prYwPol3uttEGLsrjAN/8oYtcnz8Tuae
         QUNBVjerqCOZH22gp1n6OUXoTV0CyVLPbQbh3plTepZzT3xLxueqL/ulEbEYMeSi3AjL
         BBhsu5NQnPIHuv/9qmKCn1lfT7CREe9sS1WYmrTZiZELSHrwX8psE7GNDyErYq+zSO1q
         w7tQbYGDNMGovvgJe22OsUg+tUdWM3Q18/W9kOHXMigI7A6IrozxwVAMgRs2cdQ0bJZ5
         e47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723711604; x=1724316404;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mt9bUZHRqMY0+8bv6/54FbkSnQ0N+CbgqUlfmqdHboM=;
        b=EDwCJdsGAW0CS8f9pkykdbRasZkSNmnSN89Hn9LmuZk/jUJm4qP6ZGuqCz667I9qvW
         +la03jj60Q5hzfSJiVCSIGetkHrPMi2ggltYYeOh9i4OpRmzODVa1AhEFyDIXLcrYiYf
         URkYpC7ossHTOwO9pLOFaTdyrlvTx2Jr255VUBkK0/UjD+PryfOboh1V1E+dbXMyHSav
         JQDZOvCPpbVeNL9w/c6IWg24kOGyeB76q2My2xbxKE6Yp9NGgVZdMIMhF76CX8kYOsJl
         LrFbGaNvHux7MOElUlGjjlPumkD9oJdClIvPRJRFWQpuWX8WaUuJAOekLGduVdSWwD95
         8wrA==
X-Gm-Message-State: AOJu0Yy9EkzGo01/0A1aSVGhQDySZXF61vZcD+ExDG3PxJ9brZAaSN9r
	Ws/n6hlyw/HMSqOOAlSxyKsW2vGu5Mo+8e91BNQ1WqPJ2GleSN0HneULYzJBhuhcKZOvkpO0wAP
	QmPVr+zW3xTFuxoMGo/TeDIlcZtl0BbSU
X-Google-Smtp-Source: AGHT+IFyMnvTQjgK/4nsXbGOi2GYR3U3sG/7swNgjCadjMOj5edGHQpPSS86JipsE2bmLIDCxPa4fD9iCQ/F4/1IKU4=
X-Received: by 2002:a17:90a:a605:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2d3aaa7a0cfmr6130200a91.4.1723711603953; Thu, 15 Aug 2024
 01:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 15 Aug 2024 10:46:32 +0200
Message-ID: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
Subject: Xenomai Meetup at OSS Vienna in September
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I expect that some members of the Xenomai community will be attending
the upcoming Open Source Summit in Vienna. If there's enough interest,
we could arrange an in-person community meeting at a local beer
garden?

-- 
Thanks,
//richard
