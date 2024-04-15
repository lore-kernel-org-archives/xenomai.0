Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E55158DDC
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225426; cv=none; b=KkBZJ1hvjpS+Gh8u0hN0CuAYTDrpCcX8kbobHqV52jF6J/M3DcruyT9tMszR4v8H2Or6f7uHIon4NooqRgDTeFSBCdxpohdFFxx8bbHMe4D5IRb6vc1B+oUADJ43QCH8phn/rSu91nPYH8ObiwJnI3tXvAyrMt+tM/mGJVB8LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225426; c=relaxed/simple;
	bh=6r1U2qT7c2X0vLPL6ni3WrXpsK+Go4rKHrNMKuPxUvk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=gdvxJYbdfEGpIf22JYCdzW58jGqiQGAl5s7SSDwuQ3S9yRMOUoxyGEN97Y2CzCJFzGj784V7dcFRxboil2qCs8G6enlkZ1qbDgt3qQcjukuH7e4qLaeJrU7YAM4iDJjdGq32LXEdxoJLuwD+dVOd11KcXYYCEXfaLz14JztvRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fdNtHNlN; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fdNtHNlN"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202404152356511e3cab0fdc66aa2dde
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 01:56:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=n9h0XQDynuWRpT7QNv4PLy63fwU4toLpKu5wIxjfHjA=;
 b=fdNtHNlNg52WV0qQYLRUXx5g2riMVJ4jv1s+F3mMaPIq9eHDsXDplifIs2Gqqp6LGr48dI
 9H1Hv6FOVLrB/aiUIz0+l8iX/WEYm+WIGvBHm3Pr59TBienBXoVYPgyytxrhwQVwnfgjBYSS
 O3j2d/TC7HeDW7ctY8kQJAGvJQ1BI=;
Message-ID: <1a3749dd96651b4977094900c76feaf704e2314d.camel@siemens.com>
Subject: compt regression in dovetail 6.1 and 6.6 branches, testing a
 possible fix
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: jan.kiszka@siemens.com, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
Date: Tue, 16 Apr 2024 01:56:48 +0200
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
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

Dear Maintainers,

at least the 6.1 and 6.6 branches of Dovetail are broken regarding
compat support on x86. All syscalls come back with -ENOSYS at the end.

The reason is the following upstream commit which was backported to the
mentioned branches.

be5341eb0d43 ("x86/entry: Convert INT 0x80 emulation to IDTENTRY")

The reason is that the entry point changed. We do no longer end up in
do_int80_syscall_32() which would have dovetail specific parts.

The problematic part in asm_int80_emulation is the call to
do_syscall_32_irqs_on() which basically overwrites regs->ax
unconditionally. Linux does not know about the co-kernel syscalls.

I can confirm that the following diff works on 6.6. Further testing for
6.1 and even more recent dovetail branches will follow. Once I'm sure
it works as expected I will post a proper formatted patch.

Comments already welcome.

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0220ca163a32..42e8cb036fff 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -212,9 +212,21 @@ DEFINE_IDTENTRY_RAW(int80_emulation)
=20
        local_irq_enable();
        nr =3D syscall_enter_from_user_mode_work(regs, nr);
+
+       if (dovetailing()) {
+               if (nr =3D=3D EXIT_SYSCALL_OOB) {
+                       hard_local_irq_disable();
+                       return;
+               }
+               if (nr =3D=3D EXIT_SYSCALL_TAIL)
+                       goto done;
+       }
+
        do_syscall_32_irqs_on(regs, nr);
=20
        instrumentation_end();
+
+done:
        syscall_exit_to_user_mode(regs);
 }
 #else /* CONFIG_IA32_EMULATION */



Best regards,
Florian

--=20
Siemens AG, Technology
Linux Expert Center

