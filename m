Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F0845E
	for <xenomai@lists.linux.dev>; Thu, 22 Sep 2022 14:47:40 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 62E57D2D96
	for <xenomai@lists.linux.dev>; Thu, 22 Sep 2022 14:35:20 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1ACD020004;
	Thu, 22 Sep 2022 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1663857311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKvPWY5kYnd+RSRgH0nQg6khNVYDcxBTN/EFBdM41V0=;
	b=e8L19zbT6TsjTuIJ7i6uqmaaPDsbGcFbkk7aruuD6M5JVp/R0mMAvVVFFtsC7/+FPLUifn
	XJ3tmkr5KXr6sAQpXN3uKLIcYD4u4vZm2vxy1yxmzMPFPcQEWtdLEbPWbWBtAOUdnJZmJw
	3yblPonjN4sW4lqpuZBo2/YnBFPJFB4oYnqy6iHispRD/ZwDrLpd1iJ7N50kNOyqN70oHM
	kVKkSZ+MVgaJ8iC/ccYBSYcDyU3u0kkOShEWxyZzaQ6azMK9CKq9fZJfONNb8xU+Ivt51d
	VkOoO5XYUsksNfvyuKMZQZk3t1mBGCI9q8qv9mlLwy6JhNIkwUBinphbFPXI8Q==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: System hanging when using condition variables
Date: Thu, 22 Sep 2022 16:26:23 +0200
In-reply-to: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87pmfncw9u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
>=20=20
>
> I have been trying to debug an issue in our app where the entire system h=
angs with the following error from the kernel: =E2=80=9Ckernel:watchdog:
> BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:2:594]=E2=80=9D. This =
happens consistently on every run. I was able to strip down all of the
> relevant code into a simple standalone app that only uses 4 pthreads, 3 E=
VL events, and 3 EVL mutexes if you would like to be able to
> re-create the issue (I have attached the test file). Is there anything fu=
ndamentally flawed in this logic (the same logic worked fine previously
> with STL condition variables and STL mutexes)? It appears that there beco=
mes some kind of deadlock in the kernel due to an EVL event
> and/or EVL mutex. Let me know if there is any more information that I can=
 provide you to help clear up the scenario. I have spent multiple
> weeks tracking this issue with no luck so far.
>

How long does it usually take for the watchdog to trigger with this test
code?  I've not been able to reproduce the issue so far after a couple
of hours runtime (kvm/x86 and real hw as well). I'm going to try this on
armv7, armv8 SoCs for good measure.

In the meantime, I may need the .config file for your kernel. Also,
could you enable backtracing on all CPUs upon oops as follows, sending
me the kernel splat this should produce when the watchdog triggers?

# echo 1 > /proc/sys/kernel/oops_all_cpu_backtrace

TIA,

--=20
Philippe.
