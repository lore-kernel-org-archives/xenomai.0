Received: from sonic306-20.consmr.mail.ir2.yahoo.com (sonic306-20.consmr.mail.ir2.yahoo.com [77.238.176.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6CC14A94
	for <xenomai@lists.linux.dev>; Sat, 11 Nov 2023 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D/dxLPuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699715003; bh=SjNAdEbw1S2YyWxKKSE62XZQ8dFc2BQp2uq26M4Em9M=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=D/dxLPuYv3FLRdkCUmB8Rxyh86OtJDN0xl+Ou3/h9gtkxYK0tbE7Rd+mDdJbjJxEqp6QM6TncBTkiDN7aHZ3VjX1zEdlhZ26Kq/qxEWYVkF7I+DvjAk6MTXeR8c4Ni0OoRJvLqdTI6ApQmP5ocCk4OXOoRQ0txHjkfi2s2oIZNrQjt3oy8tZLUOE36EpOjGpKeqy/TzXZjVAMNmccHj+DKN6AKCAcrDEBDnROIlIRQq0JS10chFI3KaUwfwxad+h7wPlpi0aGK0JB5xjacZ/iBSnAe+V05xLEtoXwQ24TOLg2fPq9qNO2DySQCWJsb1hQHIlkypP1VCcSYd0lDxbTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699715003; bh=MkM0foRkdPvnMPRIu8fOWD28C8lowmDLb5foPL6iw9t=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=q6wOa2P9Z6yZVao6o44wYKjtWuPfest3C3wT4CPwQS6PDk+RRvJr5Vj/YkWcPjNrK+nlILw1NLT0c5qil171aSnZvOSc+K7xga30LUmRQND8MifA3IvQd0zpRYoAQaPQyQmDOjcYAFGqSAeEVMED1hOCtqCrKjCiU9nJSBKmcOxXLYV3pulUWv7K6zcAX9HS+pv9qCxkeydXvQxbPas+OofOs6u1ciD2PzrVJGk7r4xdjy0AoP4DQS+TeTQmi2L67fTYGuuZttgxcjw6W4jMOiY9ISjydmbhbmmvzpDC1Hn+01xefyRqGj0fJNOgxVV1vcCD43IeY7g+ArRTiUtg9g==
X-YMail-OSG: DG6cgucVM1lALWxDRy6K7GfsH7zXVc6JJq7dKjQKRs0wIVotgloYKPd9UtiWaeV
 grsXl.0COvDsXdxLkHQm5tP0yianC0rdBp7rEaRBOjRR9w24rWrm2AsOck7ykNpi7XAeuDpBZ8KQ
 BYqqyNGvRK9qIxEsT1b8siCSkxClOqeiSNzLqNSh.N42JFUkEM9XXsaliU.LfUvzNhypZ4o1YRW8
 2sbYDCeKwXNJRWm6sGoqya0pzhcLfPHRgIuoJiT.Gr.EkGIweP8P.nUo2cJBgXa2DxsGcmZLJWN5
 erjVCh98S6ztuuiP8lmz4kGcWhg3kJZZk.zyXPR582TpFOzKTX2M5_E.wICD3v5P.8B3TDeVeumR
 HXmJaBDKf506rFx.gXuB2HFZbQKYctTQX79GIexqKCLgnijhBtk7WeHFkg8S.2A6FWCg5gNq.4oX
 tSvuKF35tgDWIXXzpKJ3zT76XBvoISyQQr2erf0ZPtz4ynvuXNcqAKNsikWYZnfVFQfIlB16R5jk
 ts4OdQcdQN7PKtBSElM1LCjVk0aVxsHGTEFDmuUz_De44DdWONF7UWx1rRfLbelQfM__m0Uwmkoh
 18WGjISwrieGBW.Bf5YFvMK3GZ8kzcVLjm5xeFOfZqGl4UfD3xijDcaNUXyllav0bDLuSxODM1r1
 Brs_JkNpCa6Jus7ef5AlGxu.y_cQI2MovYgE35QXKvmf7zi7fEE7qs_o5oaAs9dmgIof5xtyGvjJ
 ksozMAAQG0xk6Udek9KA0JdxZB3Vnmv2APLX2M5d8Sn5KMIb7r9gBO1pQ3jhLGTxJZo.jj2lFLVC
 nuAjzkocxzzVzGzOkzLcBrB3d053t.fQZvEcQK5yqM5ORUgfXGumnnM6woXktWW4YZrmtRDrOtNd
 3hZ4GOnrLw3Ggd4J_ddMC1S6qOEwGZVTZ1BXa8k44oVJqLUhuQaA9nSKp2MG.WJNjFSHjOhSZ_vd
 cS3cCWCJqTLDDY6zmaF83NPBXGxAFcAJkn1jGzr7P9qcLDk_N8L8vBedSsso8mDQDu0KfeoDYhlL
 35TM3k.eUEfbjGkUldfl3x6AA7e1_ViUwdTPUuQE_q3.KXWro7hVWiOBgZRDnkw3nWxw.YcicVOI
 q8pITwJ8rufZLezKComVJZFXIIVnE0CgIDp0ed9qcUZhATr8qCq_7f4joDv_Kn.wnOw4LGzRNbFN
 z7A03LdQVapYUvSZz5DIjKElaRG7AnnSZmaPJrnS9f2qIcinpPC8MFmws1hXsOFfmF1WxApa3EIK
 rl4_zBEqJfF6V9f0Qqgf57eCEKK66BwO9T7_TJjr0gT1yxRZJoATS3yZITrB8MPRPh6ppxbP3nZK
 6.ACka3TG7YCr8M06Vil.gahmPxEdP8KY1FDadWEyQIWInA44P3V3EPHYRxqQ4XzATwawpP0oiN5
 da6qh0rNcqgJ4ozdRmNouZnO7iCNzbt_b89nw8QPboQzg1hcOD2TKlG51q8ErCFI6Rnjq3ZH5Nmj
 PP.ydYGHt9yNdN0XyU1gGiMItD41A3klHSQu1SMUGgVaPQX3zhhBQdoPv2YRmGDYywdVVluhqKVO
 Jj_qBdaPkU1f0W_k0Nyg1Iqkc.5zyoooxsnV8oZ9rCAknHXH8b3OFnsocHb.RvZn.yaE3U_xPuFd
 dBlvo7uR7x1dj7pEgmQ4eGTjyJHJG0PFb.DDmZtuHWDjDBWSMYv5Q5L.wNaKnBeUkF2cihHMqbPR
 uVX3Z0yYBNVK4W_j22ypnwogmSPyMaJfGFsjMg6p3gMBRe0g7EB.2faWFS7f6fy4pU3shH7HYu3r
 d.iQUy5O2S.lXLmLkMRCwBF5vzofT7tyUkfkab0gRUMbfKCf110sKOGmojnbhvFSIH7nC68S4ZMg
 Io1H6CImVUunwxhNhyMMOp7yqeJTBpKgwGhAecmkJtZSks_yuhJtjS_Y6XVaxCh9Q_Qs.orFfRtC
 9MQ6R.JoyWC.FGEmmCqhPYU900MBkZ4cIE4pjm6PiMgrmnmiMTdEtqeY.J210YmJ4WHQm98UHcVk
 pZw9tTwROBvKeypLX12UE5.isW76aPLjoseobtVRNVoGmc20XD._AWuokBakUAasN.5gtmk9zbKK
 0aQQBHyQTmuSLzuNFZ.BxrgOonZibSplNTQsvM3U6pEHP154Th3cXS93MVYqIF51z6.i5rJRNofO
 emcjvInLXsoRBgSRhA4oHl576tuU5V4H09Q6sDxOYZqdfjdUu.2P1CWjvkcOzDXbJiYBfpSjb
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 0be43693-ea4d-4da9-8876-e88484355a49
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sat, 11 Nov 2023 15:03:23 +0000
Received: by hermes--production-ir2-6755f9ff7c-2s8jq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f35ebb6f57f0f5dee1391d8f3f76b3b1;
          Sat, 11 Nov 2023 15:03:22 +0000 (UTC)
Message-ID: <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
Date: Sat, 11 Nov 2023 16:03:20 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
Subject: Process stuck in cobalt_monitor_enter
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.

The application I'm running (a complex application, with about 60-70 RT 
threads) has a simple loop in the main function, something like that:

while (stay_in) {
     ret = rt_buffer_read(...);  // with 50ms timeout
     if(ret) do_something
}

The main loop reads the buffer to receive some commands from outside, 
and when the application gets a SIGINT, the custom signal handler simply 
does "stay_in = false" breaking the main loop, and then the program closes.
During normal running, I can see the timer associated to the 
rt_buffer_read() timeout get fired and reprogrammed, calling multiple 
times "cat /proc/xenomai/timer/coreclk" e.g.:

0    291/290         2ms970us           -           myapp
...
0    609/608         34ms860us           -           myapp

I also see the thread in "w" state (waiting for a resource with timeout) 
doing "cat cat /proc/xenomai/sched/threads":

   0  16328  rt     cobalt     50   21ms279us         w          myapp

Sometimes, in a non reproducible way (at least for the moment), when the 
process get the SIGINT it never exits, remaining in this status:

/proc/xenomai/sched/threads:
   0  16328  rt     cobalt     50   -             W          flxcore

The state becomed "W" (waiting for a resource without timeout) and in 
fact the remaining timeout is not present in the row, also in 
/proc/xenomai/timer/coreclk:

0    291609/291362         -           -           myapp

(BTW, seems that some timeouts got lost, because scheds are many that 
shots, and this happens also on other timers in coreclk)

This is the backtrace in gdb:

#0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from 
/usr/lib/libcobalt.so.2
#1  0x00007f5b15bb0748 in cobalt_monitor_wait () from 
/usr/lib/libcobalt.so.2
#2  0x00007f5b15bd7497 in syncobj_wait_grant () from 
/usr/lib/libcopperplate.so.0
#3  0x00007f5b15bea691 in rt_buffer_read_timed () from 
/usr/lib/libalchemy.so.0
#4  0x000055d2d6e7e689 in rt_buffer_read (timeout=50000000, size=19216, 
ptr=0x55d2d6e82180 <Request>,
     bf=0x55d2d6e82168 <Flxcore_ReqBuf>)
     at /usr/include/xenomai/alchemy/buffer.h:129
#5  main (argc=<optimized out>, argv=<optimized out>) at myapp.c:421

Do you have any hints about that?

Thanks in advance, best regards
-- 
Mauro S.
