Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C65D51D
	for <xenomai@lists.linux.dev>; Mon,  7 Aug 2023 13:29:29 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202308071329200641ade1e94f192223
        for <xenomai@lists.linux.dev>;
        Mon, 07 Aug 2023 15:29:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7aQ46binIREyYZplruv7eLlw+Ej8UVxBpTBYxeSJv3c=;
 b=LHghxHG5xi37hpXA/YTscrl1OI91FzH41+8SyBBcXd0OiDYmKcVUo2ynsN7p1TjWdEglfz
 Wj9C7RYQbUTfwpnDrULoCYEJi4TEF917SIp+b4kxMqZvwUqkYJNA0CFKCXGVPmhmtProKVN/
 bOXxNVWNJv1a8XKds3tAHVMRz2uTc=;
Message-ID: <6712560bbd3fb1b22960b14090d0a4c018f61692.camel@siemens.com>
Subject: Removal of arm OABI support possible?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Date: Mon, 07 Aug 2023 15:29:19 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Clara is currently trying to enable compat support for arm64. That will
allow us to run arm(hf) applications on arm64 kernels like we do it for
i386 applications on x86_64 kernels.

We fixed the Xenomai arm specific register layout in a way that is
compatible to arm64. That looks promising as the testsuite (smokey) can
already be executed successfully in such a compat environment.

The changes we made affect the EABI only and we left the OABI interface
untouched and expect it to be broken right now. We can't really test it
here...

Is there still the need for OABI support in Xenomai? OABI is marked as
obsolete since gcc > 4.6.4 (~2013) and Debian stopped shipping oabi
toolchains long time ago. Would it be accepted if we simply drop the
OABI support of Xenomai?

Best regards,
Florian
