Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C25880C
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 14:19:56 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 6EC40100010
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 14:19:49 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 400F3AC0D30
	for <xenomai@xenomai.org>; Fri, 13 Jan 2023 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673619587; bh=FPbNyIYDdc0Qzr8R0cdhmjZV9BR+goO5HP5KaKZkXeo=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=B9XmCGQDlV6fApJhxHSb/tLZKsIW6YysQJ/L2DUPXzPno/HIUw2ZYh/sRuhu53Acox1pgnKUgRdbRf0ouk67/4alAcxKe6bGJuOG9mKr+SlOrlKH2DWa50BG0QJT7pDQk7Dt5in8rT4cup4fe2pgd7KvRRAtFlMRg5zYGegaYRYQp0jdbwh+kOQyX8gVqMmC3Ah7J4hmiM1oTC9VV+5/QPhwrb10uC29TYwDtpWhK6H+RgVPhTjBMLEVwAmmNHhxPkD7HqL0h51QyhklNgQyQFyrFC1Bm+lD3A6fJOOTSF8TBJdYQhL5HLtwricCdHBwFrYBwYZ4g0FgjAlUhQkk7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673619587; bh=s9zGPPu+0cCcnOzkZ71bhM2GZOvtVDkdP14j8xdQybt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YrY/6ZP1a9s4o8PKA4/yfD7XnQ/oXFIFvBsWRppWYff7tM2BWClYmows8dkBvCEIrXr1SKURIaZ7EPkEkLgH/J+Lq3FB5ivAYHM4vZ+H8ZAuPUGHoY9TlSBSffjsC0Bt8o/uQ3zVutHWbKftkMnTUYEYO1kUiCpeVzBjGnb1UUPUQ3iM0+xXst36Z8cjZ7kDqKLRIkEykFSh4fus+3ScsNZ4rgSsh/rqUi5Ur54SOmPuWE0qRtb/EGfCOyUqBKHws2RCTyisdoxFkdtkP3j7LduyaJQE0vgF4Cun6FaAnvLQyf1fOZF2SqFXWDb3usYQhITte70rdcoa7n+20wJy4g==
X-YMail-OSG: zruphhgVM1kh5bs0e20KCwMtTKhW3FYk31YtWzuHi4GqY3nnRqiUF6nn6xYnCx0
 H_IrM39r6vS8sItUSv023UEVngk.MWmNytKmYcXeUeaIiu0fhPtz3MRM83rRRCn7T2SyVX3pIJ7n
 6U.Rpuz61FJHuuvxie_Xs41n7VfNFaWWD9GccgROoy8aj1gcr9qo8pMNfCelcavDGwdtUmTEnPKm
 3.hkzDKQTwuW_NqwPu5YlpiDnj6.YZ6Etkx2reLJiV9rAc6hWx5ovQM4eQLpjdX6HcOxEK0S49zA
 jxsdHDEJAx5vI3SNAwPwg1u9_DTmrndDRzDUiPQkwWgBsH44mr_Jx51ae4pcG3Y5z96HIstYlwgY
 Fz2O4uFGCmJUrB80dBPa5Ct9iy6CDMR9AL2uME694tl.cKouEyBgmtH.fRldSeVHRczR3r7iJ6PA
 e3A4ih8SRqvCt5FYyhxmFI.XJTPz4xpA3Ng7S4KXqAX0xMilwJYeI_H5tk4HBnlAQjaGo9xyjIoh
 uVA3Jm6QRVQ7CLw.n0D1t9f.JfdJGipTVM0QfQjkLbhQ3Fd0nAXtjBhDmh9HYIjYxyHeBQUIX6KX
 xfJrxTJrNpa8ihfSeOL6n9zn1TsmwQ7b5MPg6KYLoDdHPPM6N_tqaHHuxha.J1cvxOqTjUnvA4bx
 UH1lc21BaLXYWS_wHhkPj8c.nuV.JTXT_iB5PaRJlXspL20UCgIaS2or4PU72.imFH5XC1EP_hK.
 k5BRoh2gQu5nT7v4Kw6J.D4oiYxVzaSOhQ1.UrRsL9OuhmXmUJj70ohySpHin3IeIYEwbdNuRNLh
 YUgNsImb7WbLzb7CJ_OrCvr22dBPE6.R2yu_jOIIPzH_A1aQ4b_AIWmiW8jfMI5fRao0BdKPOkXx
 4nj.mDfXaZN8FCwHgWLJ2_kwe4DFScfhp7hQnjWtluDBd_zGLsAc8CCM6Ulrx5K3X3vLi_vgeleM
 Hd7dsNXhrIt9Xo7Ourc1mXNp9Xvm5GKdk2PWjiIGPCgT4Q5jXsiu877R3mcxJ3J.rUJLK4sWk_4M
 lgBj8kQbrRQDgK49P7tlSF8L1cKRf6oaWc_XwdoqxRIdoDhPkozozeN5FChOqvHjJ7A27.GbK1K1
 EX5aUm2mPCfiMgHANM25iENsIovgMmNyIK2VozG308SPBVzLZSMrVUUrC.FqY2mnSIftK7rm9dZi
 uMF7.4VLzKoPzGKlBNZkTWZcY90wwaBwAVApPdPty7.t_H9_5KhZ3PixcyYyPKgC_BR0bvjrMmK0
 dJqAtiYd6QEBuLu3lAn7cfATd36xYqHrHfTsKY4lriXp6K96IIgF4IC.H2n_sIF9PeitaGNhv16C
 YvZ85_JCGIAldyd3uv._3ZzK5o6jIb5JGhKpeuKE289yanXg4HrQgRbQGasFMZjWPjfpBYAq9dhZ
 v1m.S3mezEUTkpEUY48AOQ.qTNT4jq14af_VsFWG9sUAJ9JvuU65p1QNZOoR9QtK.uJtXNYQoP3L
 uFWMEflKXQ8msr1t9N1c9ooHcs7nGSW5LirlAZUfoTZ5scD6EJhXe40we5xv2RAE9YqyYaRuZpOy
 6IDGyVKecRp9jCKYr8iXTkXu3A4bLOMUke5nMziupVUoFBkOkWciOLL7gOzUMrwEZ7UV29jmLxzg
 2zcqfc0ZERfkxeTiRwE92fL3WSBxxyc8iISkdOxl0XaTpHxwnTOs1oGU3v21l9W3r71MdCp7nNko
 MWZNXXroikCLioR7JkLv_SwxzGRtyoK7IZqBmlH_VfsBtDLkj8s9.B0F2S5PjX_HEeauemFe3sPS
 2KlnzRtGVUa9Z0IAMnrsH8db3JZ91s6I7Yx7oZ3mkB9f9Lxw1tntxHXD1wcDmEPfecrJ07vdJnZa
 4ZFQQNNxihXIrwtmf.B.dsxcGVXYwZLpHPBpnHQ4TjbXB_ujlblLNSMlynsIcBHFSwkz2JsCstP7
 Jxi_mIOYnYq3EWVy6lF6ic8KEXYeUZIlsL.IATWdIdcLgkt.mOkIHWTVETDJPBFRSi0UcYGfu4T.
 Y6aGo8p7gJ6Ad8uYyGKZAqbOX9O4lOvDJ5tkOCVpm.Az7lF4BRJ7lVJQoUWWA4KNCFgJ3e9mPhqp
 V2EffhUA.5kmtUe3rzeHlVY9HmGaCpJvek_iYr1.X._vr8b5W8dHowENRYwVdUbSa1ndaS7d_AV2
 Ah4dwhU2BKyT.xBAkPWVAh6PXXGPrlBovHvwzPEnEbovQKTtJhxYza7vK4rkD3FhPKhV4slfikFp
 utRqHTCQwZYzMElP.btxPCNLt1wYeff_SNKrgonCRn3bXQA--
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Fri, 13 Jan 2023 14:19:47 +0000
Received: by hermes--production-ir2-69cbd7d4db-kqtd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a931b34ba2e1c2e98e73b1bf6588db8;
          Fri, 13 Jan 2023 14:19:44 +0000 (UTC)
Message-ID: <b6b8ee88-504e-3be3-5db5-108898668758@yahoo.com>
Date: Fri, 13 Jan 2023 15:19:43 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: kernel stack corrupted in xnarch_switch_to
Content-Language: it-IT
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <2d50524e-78e9-c696-8dcf-171fb8d58910.ref@yahoo.com>
 <2d50524e-78e9-c696-8dcf-171fb8d58910@yahoo.com>
 <69e67416-2988-813c-6078-c81cccce16f3@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <69e67416-2988-813c-6078-c81cccce16f3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21062 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Received-SPF: pass (spool3: domain of yahoo.com designates 77.238.179.187 as permitted sender) client-ip=77.238.179.187; envelope-from=mau.salvi@yahoo.com; helo=sonic313-20.consmr.mail.ir2.yahoo.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=B9XmCGQD;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (spool.mail.gandi.net: domain of mau.salvi@yahoo.com designates 77.238.179.187 as permitted sender) smtp.mailfrom=mau.salvi@yahoo.com

Il 13/01/23 14:59, Jan Kiszka ha scritto:
> On 13.01.23 14:49, Mauro S. wrote:
>> Hi all,
>>
>> first of all, I had to change my subscription mail address due to
>> problems with the previous provider.
>>
>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate.
>> Linux kernel is 5.4.181.
>>
>> Sometimes (not very frequently, but it happens) this system freezes and
>> a hardware reset is required. Nothing is registered in the system logs,
>> and no debug serial is available. The only useful interface is the
>> screen, that in facts reports a kernel panic, captured in the attached
>> screenshot.
>>
>> Any hints from somebody on where to start digging/what could be the cause?
> 
> First thing is to make sure that you have the very latest versions, at
> least from the respective stable branches (stable/v3.1.x is at
> e6d90930a9, and that can matter here; 5.4 is at
> pipe-core-5.4.228-x86-12). Also note that we do not test 3.1.x against
> anything newer than 4.19. It may work, but it is not in support scope.
> If you can update your test to stable/3.2.x, that could give some hint
> as well.
> 
> The final step you know already ;): Help us to reproduce your issue as
> well, then it is much easier to debug.
> 
> Jan
> 

Hi Jan,

thank you as usual :)

I will try to switch to latest stable versions both of Xenomai and kernel.

About to reproduce the issue, unfortunately it is not simple to do 
because this happens under different circumstances, not frequently and 
apparently with no specific causes.

I will report you if version upgrades mitigate the problem.

Thank you, regards

-- 
Mauro S.

