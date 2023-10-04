Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC061095F
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 14:15:02 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 18A2F5D82;
	Wed,  4 Oct 2023 09:15:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 18A2F5D82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1696428901; bh=z7g7YG9DrmJSekZvdC8Pey4JuQVSLQdMxqWNyqK4wQg=;
	h=Date:From:To:Cc:In-Reply-To:References:From;
	b=14mzauZrlY09em2l4a5MvgaVoMYZi8OrCOK+Yl9TGDC0VIuGHWyCTvFhN9KojPvzQ
	 A7FXIBgz1xHbAMCX0fNxoiPL+5LGYw5bsN9xCgNGp16KxjzhAgAo+1rmplJLAphfek
	 wH3bW6ZwThn0nxnZ+h7Oph2tpM6f9UVZ+jeBKeIw=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 14A2030004E;
	Wed,  4 Oct 2023 09:15:01 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 1046C100673;
	Wed,  4 Oct 2023 09:15:01 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id EBF251006B0;
	Wed,  4 Oct 2023 09:15:00 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com EBF251006B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1696428901;
	bh=z7g7YG9DrmJSekZvdC8Pey4JuQVSLQdMxqWNyqK4wQg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=fK3GH49/r0iVvYXILUybM/aUuQZyCzXI6ofvWoT/LsPXD6woAIsmuQinGE4nVvPaa
	 BTm/qxQVwBAAcj8YnszDL76iQhtW0W80dImS1r+mqjl8eLsZAf0QoD4kxdPxDb2JhT
	 xwvlygUsFjVLK+G+ca+7WB6d4FCvfmVcxolu/9xSI9ig8XZJiq+JjKOBsWDeooi+Qk
	 Bk/pCPaDfRdG3iC4dJjnpYx3Nr+96kXa3QILbVLtEa3ftYr+91GVuNaiOEPix5EbQk
	 +DTEQyK6X+oTSxEbZ9Cxg00oxA7ZSQAHG1eAOhKEH3TQhLvq31dXw4QwCoEMUFUN6v
	 dqg4sHZxxXB8Q==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jYjWszqBdQgo; Wed,  4 Oct 2023 09:15:00 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id D857A100673;
	Wed,  4 Oct 2023 09:15:00 -0500 (CDT)
Date: Wed, 4 Oct 2023 09:15:00 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Message-ID: <471929520.3420035.1696428900861.JavaMail.zimbra@wolfram.com>
In-Reply-To: <962e9533-26a2-4a02-a5c8-21791e86fdf3@siemens.com>
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com> <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com> <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com> <962e9533-26a2-4a02-a5c8-21791e86fdf3@siemens.com>
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [46.59.13.250]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC117 (Linux)/9.0.0_GA_4478)
Thread-Topic: RTNet unable to handle kernel NULL pointer dereference at 0000000000000068
Thread-Index: 1xrpkXVEyaFVaWdpprMa/DACcw+NSA==




----- Den 4 okt 2023, p=C3=A5 kl 15:57, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 04.10.23 15:01, Per Oberg wrote:
> > I just had another hickup. This is 100 pct reproducible

>> To get it up and running I had to remove rtpacket,rttcp,rtudp,rtipv4 and=
 then
>> forcibly remove rt_igb driver and then rtnet. This gave me another set o=
f
> > errors, also listed below.

> What does "forcibly" mean here? Actually "rmmod --force"? Then you get
> what you deserve ;).

Yes, intentionally. I expected that the "rmmod --foce" would reek havok but=
 I thought that perhaphs the actual havok caused could give more pointers t=
o the actual problem.
 I wanted to see if I could recover from the first crash (not the one from =
my first email) without rebooting.

> > [15018.436248] ------------[ cut here ]------------
>> [15018.436249] [Xenomai] switching rtnet-stack to secondary mode after e=
xception
> > #6 in kernel-space at 0xffffffffb837064b (pid 1438)
>> [15018.436258] WARNING: CPU: 0 PID: 1438 at
> > /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x26b/0x2c0

> You are not using the latest release, not even of your stable series.
> This is needlessly risky.

I am currently updating the kernel and xenomai libraries to see what that c=
an do. I could not, however, find any patches that looked relevant for the =
issue.=20


> There is some imbalance in the reference counter for the socket, and
> later on are complaints about leaking buffers in the pool. The real
> problem may rather be that you didn't shut down the interface properly -
> or that we don't do that when pulling the plugs in the order you describe=
.

To be clear, the=20
"[Xenomai] switching rtnet-stack to secondary mode after exception #6 in ke=
rnel-space at 0xffffffffb837064b (pid 1438)"
happens after a fresh reboot, not something I kept alive with artifial life=
 support.=20

> Can you reproduce this rather generic issue over latest master as well?

I'm working on it. Hopefully not.

> Jan

> --
> Siemens AG, Technology
> Linux Expert Center


Per =C3=96berg=20
