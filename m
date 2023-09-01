Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF079E6
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 10:43:29 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0B050CADFD
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 10:29:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76061240005;
	Fri,  1 Sep 2023 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693564137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ciSqFK6ZwX93DbV820D8BI7YxJpBUIcPar4+73qL8tE=;
	b=EptfeHNSFtvaUK28yuw4wNc6t0bqpoecqqO8Zw2tyalVzdNlpKu+Q9wPBKtblwj8XFlkk2
	+hKfKShPEWgINGZPy6HyMuCxLZ+D20KO8Vtf51cjlVCSfKpK18MyZXaQxr9PngeoS0/i1t
	apQ9GvnFFrTF+Ib65wKu95HLxrchZ+VReZK1Ni0w2xHVOqueEzz8AqKeHJw3ehjBHA/oVR
	3Gph8I95zSsq+98qfwHrZNDzUytnMeeRYsAxLBeNjxVqRgpWzqJqc2AWxHlM6fgSy/65Pi
	iXYNmzonHJXhYwL035Qi/zO3/2fS3/Jz3cGR3KYSbznyyXcJp1czL1N044sZXQ==
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [Dovetail] Intel GPIO pinctrl
Date: Fri, 01 Sep 2023 12:16:33 +0200
Message-ID: <87v8cuuqzb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Hi Hongzhan,

Independently from the ongoing issue with stacked irq chips, the driver
code for Intel GPIO pin control is lacking the usual irq_chip and
locking fixups in order to support IRQ pipelining, for the Baytrail and
Lynxpoint cores at least (only Cherryview is there).

Do you have patches already brewing for these internally, or should
they be added to the todo list?

-- 
Philippe.
