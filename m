Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF37FBFF
	for <xenomai@lists.linux.dev>; Wed,  8 Nov 2023 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id A82944C8D0
	for <xenomai@lists.linux.dev>; Wed,  8 Nov 2023 17:59:08 +0100 (CET)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 19FBF6014E
	for <xenomai@lists.linux.dev>; Wed,  8 Nov 2023 17:59:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 3A8GwxeG362829
	for <xenomai@lists.linux.dev>; Wed, 8 Nov 2023 17:58:59 +0100
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 08 Nov 2023 17:58:59 +0100
Subject: Watchpoints not being handled correctly on arm it seems
Message-ID: <10236-654bbe80-5-7a7a9700@161802062>
X-Forward: 217.109.173.233, 165.225.20.103
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello,

Working with xenomai 3.2.3 with linux 5.4 on Zynq7000.

While debugging my application, with GDB, if a watchpoint hits when in =
a xenomai RT thread, the machine hangs.
If I connect the JTAG probe, I get core 1 halted with message "Synchron=
ous Watchpoint", with PC being on the instruction that should have trig=
ged the watchpoint. From that point, I can never get GDB or the app to =
continue. I can (using the JTAG debugger) hit continue, but it seems th=
e app stays hung (even kill -9 does not terminate it and I have to rebo=
ot the target.

Can anybody help ?

Thanks in advance

Fran=C3=A7ois

