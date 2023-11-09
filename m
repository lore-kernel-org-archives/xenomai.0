Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827C2903
	for <xenomai@lists.linux.dev>; Thu,  9 Nov 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id DF62760132;
	Thu,  9 Nov 2023 15:38:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 3A9Ecc6v407393;
	Thu, 9 Nov 2023 15:38:38 +0100
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <bf9d4965-6f5e-4862-a24e-9c1748bf9496@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.20.103
Date: Thu, 09 Nov 2023 15:38:38 +0100
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10237-654cef00-d-68598f00@146937372>
Subject: =?utf-8?q?Re=3A?= Watchpoints not being handled correctly on arm it seems
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Jeudi, Novembre 09, 2023 12:22 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 08.11.23 17:58, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > Working with xenomai 3.2.3 with linux 5.4 on Zynq7000.
> > 
> > While debugging my application, with GDB, if a watchpoint hits when=
 in a xenomai RT thread, the machine hangs.
> > If I connect the JTAG probe, I get core 1 halted with message "Sync=
hronous Watchpoint", with PC being on the instruction that should have =
trigged the watchpoint. From that point, I can never get GDB or the app=
 to continue. I can (using the JTAG debugger) hit continue, but it seem=
s the app stays hung (even kill -9 does not terminate it and I have to =
reboot the target.
> > 
> > Can anybody help ?
> 
> Do you see the same issue with 5.10 or newer (Dovetail patch series),=
 or
> with 4.19 (SLTS-based I-pipe)?
> 

I can't tell for 5.10 as I have some custom driver for custom hardware =
that I did not port to dovetail/evl yet. The same is true for 4.19 (whi=
ch lacks features I need) and I'm not sure I can easily test that. It w=
as OK in 4.4 though

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>

