Message-ID: <494772EB.9090309@domain.hid>
Date: Tue, 16 Dec 2008 10:20:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812140905.08103.roberto.bucher@domain.hid>
	<49468ED1.3030504@domain.hid>
	<200812151919.10849.roberto.bucher@domain.hid>
In-Reply-To: <200812151919.10849.roberto.bucher@domain.hid>
Content-Type: multipart/mixed; boundary="------------080605090002040508010308"
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Roberto Bucher <roberto.bucher@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------080605090002040508010308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Roberto Bucher wrote:
> I've unchecked the CONFIG_MTRR flag in kernel, but the behaviour is exactly the 
> same (scilab->freeze)
> 

Mmmh, would have been too easy.

Next try: Gilles posted the attached fix for a quad system boot issue
yesterday (also available as adeos-ipipe-2.6.27-x86-2.2-02.patch). Maybe
it has some effect for you as well.

Nevertheless, I will continue to dig into the patch as I see some SMP
affinity issue for Linux IRQs.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

--------------080605090002040508010308
Content-Type: message/rfc822;
 name="Nachricht als Anhang"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Nachricht als Anhang"

Received: from mchp771a.ww002.siemens.net ([139.25.131.189]) by MCHP7I6A.ww902.siemens.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Dec 2008 19:59:38 +0100
Received: from mail2.siemens.de ([139.25.208.11]) by mchp771a.ww002.siemens.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Dec 2008 19:59:37 +0100
Received: from thoth.sbs.de (localhost [127.0.0.1])
	by mail2.siemens.de (8.12.11.20060308/8.12.11) with ESMTP id mBFIxcYA026077
	for <jan.kiszka@domain.hid>; Mon, 15 Dec 2008 19:59:38 +0100
Received: from hephaistos.siemens.com (hephaistos.siemens.com [217.194.34.77])
	by thoth.sbs.de (8.12.11.20060308/8.12.11) with ESMTP id mBFIxcfi004984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <jan.kiszka@domain.hid>; Mon, 15 Dec 2008 19:59:38 +0100
Received: from hephaistos (localhost.localdomain [127.0.0.1])
	by hephaistos.siemens.com (Postfix) with ESMTP id 16C94E1806D
	for <jan.kiszka@domain.hid>; Mon, 15 Dec 2008 19:59:38 +0100 (CET)
Received: from 82.94.251.216:54138 (from=<gilles.chanteperdrix@xenomai.org>;helo=hephaistos.siemens.com)
	by eXpurgate V2.1.1.1, id=149900::081215195937-795DAAC0-7AAE0A38
	with ESMTP
	for <jan.kiszka@domain.hid>; Mon, 15 Dec 2008 19:59:37 +0100
Received: from xenomai.org (filer16.pokersource.info [82.94.251.216])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hephaistos.siemens.com (Postfix) with ESMTP
	for <jan.kiszka@domain.hid>; Mon, 15 Dec 2008 19:59:37 +0100 (CET)
Received: from [80.118.101.74] (helo=[192.168.1.151])
	by xenomai.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LCIfK-00009r-Cf; Mon, 15 Dec 2008 19:59:39 +0100
Message-ID: <4946A913.1000201@domain.hid>
Date: Mon, 15 Dec 2008 18:59:31 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
MIME-Version: 1.0
To: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
CC: jan.kiszka@domain.hid, xenomai@xenomai.org
Subject: Re: [Xenomai-help] BUG: soft lockup
References: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>	<49468135.6060602@domain.hid> <BAY135-W2875D734AB22FC0E2FD238C6F40@domain.hid>
In-Reply-To: <BAY135-W2875D734AB22FC0E2FD238C6F40@domain.hid>
X-Enigmail-Version: 0.95.7
OpenPGP: id=211B77B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-purgate: This mail is considered clean
X-purgate: clean
X-purgate-type: clean
X-purgate-Ad: Checked for Spam by eleven - eXpurgate www.eXpurgate.net
X-purgate-ID: 149900::081215195937-795DAAC0-7AAE0A38/0-0/0-0
X-purgate-size: 3571/3416
Return-Path: gilles.chanteperdrix@xenomai.org
X-OriginalArrivalTime: 15 Dec 2008 18:59:37.0864 (UTC) FILETIME=[47038880:01C95EE7]

Thomas Schaefer wrote:
> Hi,
> 
>> Date: Mon, 15 Dec 2008 17:09:25 +0100
>> From: jan.kiszka@domain.hid
>> To: thomas_schaefer_canada@domain.hid
>> CC: xenomai@xenomai.org
>> Subject: Re: BUG: soft lockup
>>
>> Hi,
>>
>> please don't post HTML mails, they are not parsable unless one switches
>> HTML mode on for mail reading (which at least I dislike to do).
>>
>  
> Sorry about that.
> 
>> Thomas Schaefer wrote:
>>> Hi,
>>>
>>> I am trying to use kernel version 2.6.27.8 and the latest stable version
>>> of xenomai 2.4.6.1 on a quad core xeon 5400.
>>>
>>> The kernel seems to load OK.
>>> [ 1.306673] I-pipe: Domain Xenomai registered.
>>> [ 1.311242] Xenomai: hal/x86_64 started.
>>> [ 1.316744] Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
>>> [ 1.322786] Xenomai: starting native API services.
>>> [ 1.327580] Xenomai: starting POSIX services.
>>> [ 1.331973] Xenomai: starting RTDM services.
>>>
>>> But as soon as init starts the PC hangs in an endlass loop and I get:
>>> [ 69.793501] BUG: soft lockup - CPU#3 stuck for 61s! [init:1]
>>> [ 69.793501] Modules linked in:
>>> [ 69.793501] CPU 3:
>>> [ 69.793501] Modules linked in:
>>> [ 69.793501] Pid: 1, comm: init Not tainted 2.6.27.8 #1
>>> [ 69.793501] RIP: 0010:[] []
>>> native_flush
>>> _tlb_others+0xa5/0xe0
>>> [ 69.793501] RSP: 0000:ffff88007f849c58 EFLAGS: 00000202
>>> [ 69.793501] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [ 69.793501] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>>> 0000000000000000
>>> [ 69.793501] RBP: ffff88007f840000 R08: 0000000000000000 R09:
>>> 0000000000000000
>>> [ 69.793501] R10: 0000000000000000 R11: 0000000000000000 R12:
>>> 0000000000000000
>>> [ 69.793501] R13: 0000000000000000 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [ 69.793501] FS: 00007fbcbf7486e0(0000) GS:ffff88007f806a80(0000)
>>> knlGS:00000
>>> 00000000000
>>> [ 69.793501] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>>> [ 69.793501] CR2: 0000000000672b08 CR3: 000000007eb84000 CR4:
>>> 00000000000006e0
>>> [ 69.793501] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [ 69.793501] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
>>> 0000000000000400
>>> [ 69.793501]
>>> [ 69.793501] Call Trace:
>>> [ 69.793501]
>> Really no Stack trace available?
>>
> 
> Yes that's all there is.
> 
>>> The kernel runs fine without the Xenomai patch.
>>> I also tried the version in the current svn repository with the same result.
>>> Please let me know you what I can do to help to fix this or what
>>> additional info I should provide.
>> Does this problem also occurs when you
>> - disable CONFIG_XENOMAI?
>> - boot with maxcpus=2, and then maxcpus=1?
>  
> Disabling CONFIG_XENOMAI doesn't help but using maxcpus=2 or maxcpus=1 makes it boot again.

Could you try the following patch?

--- linux/include/asm-x86/irq_vectors.h~	2008-12-09 18:05:38.000000000 +0100
+++ linux/include/asm-x86/irq_vectors.h	2008-12-15 19:48:53.000000000 +0100
@@ -80,7 +80,7 @@
 #ifdef CONFIG_IPIPE
 #define INVALIDATE_TLB_VECTOR_END	0xf2
 #define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f2 used for TLB flush */
-#define NUM_INVALIDATE_TLB_VECTORS	4	/* f3-f7 used by I-pipe */
+#define NUM_INVALIDATE_TLB_VECTORS	3	/* f3-f7 used by I-pipe */
 #else /* !CONFIG_IPIPE */
 #define INVALIDATE_TLB_VECTOR_END	0xf7
 #define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f7 used for TLB flush */

-- 
                                                 Gilles.

--------------080605090002040508010308--

