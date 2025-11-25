Received: from sonic309-24.consmr.mail.ir2.yahoo.com (sonic309-24.consmr.mail.ir2.yahoo.com [77.238.179.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212A27467D
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075242; cv=none; b=PRxGJMQMsj6PqfnnDW6z9Qo3jxn1ZanExen8bS+2oA8+jdHR9End1bAq7a/Ggr76H0jDCT7+tTe5XjXtdDCyX1OUuZ9a/a9I0fn5iIjnBdcBlUnk2tzfckYA6lswrqsRcbd3IELQ9W1yG4CxM7kBOAJJUlsVJMibKla3X05iEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075242; c=relaxed/simple;
	bh=lOEjNa1y+o/lKoE+0tmT3Hcnbetg8ZyjWPrxVlMDvSg=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:
	 References; b=chK9gM0Z1czFCgQe++A0PIU8FKrgadffiOZ5p74G02bbIfUX/6tlaU95H0doY8dQM9vJ3LR2iSVPa/dHU6ek+vpQ7/Ss9EBj39q1Kg9h0ZwsDAOh/aMclU5bFh0OiejTEhGprThvJJ0MbxuUusfGsG6zTc6h1ooNzrQKRznFRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ccrDyibz; arc=none smtp.client-ip=77.238.179.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ccrDyibz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764075238; bh=uqCqO4EyMw6/cnHk4l6aAPjWHvgvuFRWI2b04EWvtkQ=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=ccrDyibzLKkhXQLpBrpkwdJsBz4v1xs9b9aX21SLVc6fMNVrnlYmM5PhQTZBOU8ifi9Qdfrp3k/pMh50qPHAqWCVw86R8XaPhlomuEI2l+6t66CITr18sMkdxPB9Bg4UXm68yqwGQhbf10a7AG7jfyyqDXoRepQwCJG4Mmr5oH/05f9E/8ZC+H2rknNQo/yFIcuQFWJveeXmB2Ufq9555ExMQrsJso3bfoHHe6wcj+2cd/Fy8FrDdOZI9vXbiCh5MAw0JPaxW+vAVCaIYjTcuFOHNfqv3IA8LYOlKZdc+P2gPEktPm2r+gfHAVgY/9IFfs+w/KOB8bOvu04fUAm5tA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764075238; bh=9IZaKmmG4ZuTRynR9elMDqW9HW+uk4vmE+PKlwVAwwB=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=oa9s4BluOAD8zTKKa1/N61SRbhvvq2PLxxKYTimX8g3TFcs8UWv2Yx9VABuxJRIzedvGohX4pMjRkwTXHPY0UglUaslenbgel8Kizo6rXlGibawBFa7hdo+7MYbBo2Zl28PaE5cAW8QmhG0tUDZdDiyzWTydUGSTelhfd4X/sc7BENKpuN2ihL64tW58rMXosWZ3qi+/IASuuh8bMWP9xGdkjcZkPDRHNcy9U7ku4YSsU0BvyGOuJpprHpYhMQPXH4RUQqQogkXJfChF9kKLwZRYBanY1vPJ/GfOWRVEaGjfbin3RyX1+KjQqZer+xOPOIcqYnBwDCZjPMUou8j72A==
X-YMail-OSG: O477n48VM1kBre_VwYUD15NqVQnkZ0_voHUVWYiG2y226dPjdBOWSiu3xtQ1ii0
 3VZIYhL_2OFHXjwaN039Rn7Vjg2QCIbnn0vdWxkPda0IvWaLDclubQDNfH9y.UINN4qDUOv9xoLc
 .hfQi3sfxigRcL33oXM.LceXe3dnw5eo.Mdfu05hFTZhnq8YD4iJJ12GqlWN29JrdvWOZaUkwt.Z
 dz2o0ec1Ip45als3L0T12SQ9361JFdRvAm6AL7K1eY5xYTPfldYoUBSGT.4Wzj5fbsxIP5BCQRZZ
 OtNpg7UWj3_fhcPYNVxBqQvhFDqBHGraI1M_WCdBBROPBcEzKoW587S5TGhoyTZ1Rng8ChttC.8W
 JCvT.ICQCXsVq2QXbKOyPxLTLL1pG6p.aomhfqX9tC5xX6PPmpR.HbFpjUnU0_cZbtGvIn_56xPc
 8gVLSuroC4xjvKUOFgUJsY0ceULEF3C4FRMHU96TU_qC9p3XNE20zzv9gZ1yoXexKZQlysbdQlUF
 ZdUlVncx25NBDrR96_7ZTFuOP1q5iIJ76.s0XgpvZTE0rd2yOQyhqK3Jptc7qgu1hMRSrWsmLmee
 0yGc.5mmNpyqhYeQlE9eeBKaittVqYWIvU6vm6u1Vxde7vIkPFMglk5mzi9jCptnvhO_ggyO3AFf
 5M0mfglil7ljupfcWRMh9OPccpw4EVav2SApyJoa_04Fgp1ZkJNvNPsGgklI6KztlAnt8Tb5HiMj
 jGA5jdznvZhiWXDzy_nWTHB25weCDxeOgRV4hCRPK6GM8fVHcqh0rz3JQ0NcYttQg9CbIDcG5JxG
 NaetLsKE.gDdwUWcORqcKK1hcwWCmBDIBXLTImECdL5e3SRy0Ynpk6GgmzPYhH9WNV33WnQZs8VH
 J_itrje_OwBcTfC2Xz2PVYxKIWBgjvI1aKqJGyshqhLwlNDQ0Rh6NZB4CAevq38.dILAFWzy0guB
 EYhJ9V0kC1aD4uG4d27T0ULPcZfzC5ihqcSpwZBIeXpMWmOOJ8p_Vwd.J4hGt0mMDQJbKtPhLOo6
 OIgnxzTAjYDpEZIoX31Amb6ZBiWCGVh95vW7z01.0k9B1kCBGpItWzuYlEs2nIejX2r4i1ZJtkc1
 NNAgy6pxxYWnpSnUGQ3BoMj7WUhmcVwXE9gU2KtXMi5jx0Zo3rImNdnk0TiSKA.OIgLAsdtnJ3Bl
 SXIbAs10UkaglwGFethDCWkpPkf_ucVGmX2hVnTrzVGKZfup86JL8tyHUzQ9SCbZ_xrHaUZK3YLz
 .A6OCgytIgJSGibvvwX652ONkEGyNhls9cRJrqLf8EbuJheieNa_NyZsagkyif7GU4nHnPl5BsLC
 p0gCdLk9tDzqjPTGpnAJUnoEyPUWpe9cGndB9_GuGsiho6CK15TC1R8BKsik28FV.x1X_yLNG7q9
 HQZqT3q8ONu5B2fXMiTstp4j9aAi.4AzjAtASKqnmqn6Fawp2EdgJ736CQ6MFDcDszbUWvMQKBmj
 gl78OZJSQNCkYn5Qwsf1tn61SP3G228wphMByPGL3UuuE5tXz2MtXzckoAxSkD4MxMYLUJFQ2deC
 wpGT9qh9HpLgzB_FNSztT0MIzb9dHm1oDXHPVtLEiL6BRgShxHfJyiDWUN3tlghtUlAAIvhYsrbF
 iYqFzFpNPSr5d1AjsNsdnVA7LWSQnn9n9URmnbjRgLkHQci7wMo1aWmJLH5tl7ZqLvnp3ClLNwh6
 ZpCWUHMBBaMzgISguTTCc4Q..pDrczcs5VyKqym0L0y3p7jONJHYgmHLwdPmcyDhfv61ltbDW8wG
 y9dp8zGaIpqG45SFxXPHGZr_.WzHCgCkBlLlK5rio3bXiz9txOSxzCY4k10a2ax7ErP506xZRni9
 jcMT_Y1hxcqNq_Uk6VODtdIFg5cYdQzXEtw.mJ8PaxQE23mo.nXRLHgOyE5ILSPxdlYLPe0k5Mkp
 m.F.nGrwF6RZ8dFHY6awUSU2xVip5KE0ykZNPCk6ERye0y2UUjtoDHnBRturFgbRSISF1yUgYe_X
 B6i8ybtnMjybd08cbK5hStP9lGJUkrkJtaCYvIg.7BM2ML1WtX.Q6TVne_RoUOKOn4Md6BgzGv9j
 IwYPhvxB9D2oPZaD8Qneh3xVytuymt.ZaBxoddLZC6hk_0U.8DdhqJKFjbw2gh1qIQZjwIB2f0IA
 3piHaEYx_6tHsrqXsw.XSqA_Y1eCkzVI_GqUyibXmrDhTbbuXOuFNLdBm6Wk2PCVkrCgduhA6O2w
 ePsULJXhqyg--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: e107f98f-6d55-4484-b0eb-7a8afb1a0bf0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Nov 2025 12:53:58 +0000
Received: by hermes--production-ir2-76fb978d99-5lpjj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dcfb004b100dc52cff403674ef30a2b2;
          Tue, 25 Nov 2025 12:23:30 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------M005xXwHCfeCDyEKvImSXdq3"
Message-ID: <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
Date: Tue, 25 Nov 2025 13:23:33 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mauro S <mau.salvi@yahoo.com>
Subject: rt_task_resume() resumes a wrong task
To: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------M005xXwHCfeCDyEKvImSXdq3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Not sure if I found an obscure corner case or I'm doing something nasty.

I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
Target image and toolchain generated by Yocto.

Please find attached test case code.
Program is very simple: the main task starts a bunch of joinable tasks 
that immediately suspend theirselves. After starting tasks, the main 
task resumes all tasks. They do a small sleep and then terminates.
Terminated tasks are joined by another task, that was launched at the 
beginning of the program execution.
Subsequently, main task continues to recreate, restart and resume joined 
tasks, on and on, until a CTRL+C is issued.

What I observe is that, when calling rt_task_resume(), the wrong task is 
resumed.
Please see the attached log. In this log I'm printing the .handle and 
.thread data in RT_TASK function as hexadecimal.
At row 19 you can see that Task1 (that has .handle value fc1c9, the same 
of the terminated but not yet joined task 0) has been resumed when the 
rt_task_resume() was called on Task0. Task0 has been terminated its 
execution, but has NOT been joined yet: if I'm not wrong its resources 
should not be usable until join is done (at least this is what I 
understand by documentation). I expect that calling rt_task_resume() on 
a terminated-but-not-yet-joined joinable task should return an error, 
not resume another task. Am I wrong?

I know that is some of a stressful test: in fact if I call the 
rt_task_resume() only if task is not terminated (checking also the 
executed flag adding "&& TaskList[i].executed == 0" into the if) the 
problem obviously does not happen, but as I said I expect an error 
instead of a wrong resume.

Launching the attached code, you should be able to reproduce the problem 
on your side. When the test detects a wrong resume, program terminates 
automatically.

Thanks in advance, regards

-- 
Mauro S.

--------------M005xXwHCfeCDyEKvImSXdq3
Content-Type: application/gzip; name="xeno-test-resume.tar.gz"
Content-Disposition: attachment; filename="xeno-test-resume.tar.gz"
Content-Transfer-Encoding: base64

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
+A/eHZGbACgAAA==

--------------M005xXwHCfeCDyEKvImSXdq3--
