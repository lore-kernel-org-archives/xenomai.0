Received: from sonic305-20.consmr.mail.ir2.yahoo.com (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A102CA2
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677586207; bh=o6ielnwdsqGJbIae27xQhxIA6uLphRH2/ptHQSR2Goc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=FDEpv+4+Sjs3rLYAfskL+1Qlj+CHBQOndb/lZpTjEiIrUZSwtaE/+u7KKgScPqkYqCtLYpbqWqNZKKM4pfxOQdM7jCspCrABdMU5+RoebJ0Ie85qnRBFIi6nRfxGyH3ZDF0bbevyG8l+PPT+1anqhRBQvSqqoHXy4sjnVdxZw+OCfLfKi5Iynp04CVL3QJUX2IH7i/esvcB83Ch3FwNGd14fSyK4vVmnFOqMjDGgRy8ou6rZUqkLN4umQP2j5Nb1SE4D1GGuG1OwT7DebxYbi62JnZRysPUiFQWdlBxg15wEFasHQLExGhzu2zu2PBMzakfVXHz5drWqPg1KpgMHSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677586207; bh=ivglpkzEtPdAu6YxXxaSmKH8XJfyWAZiXhLI9DMVItg=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=TsyA/k+uoMLqIpXzsNa12m/9ME9dp/BWN6Fgr1ZKwRYl3J0CC79kf4jktH/lbo1ydPBlSdAOXGO8FyCmA3rK8o5cgcoJVpW3YQH9ilvIAWwwCA6ESIw9T0sRaSNvnjENzb7yoGRdKQQ0HWIxGH9PydS4xnj4nHAbbenQw9FhwwhGQiXXoAimrHRA2iOCZCuAE/7fmpjYSnEfMPSlT1qS0QbLVXasnaFL/mLKr3OaN+T/PgS7bXLR0eK4V7sjnHp3USVqCgETACltDs7B7GyAhU3T5zEpJ+Fe9HJ8K04Olatq2dNz48B2NAZO9YNVV9KRATl7wivFJounZKmHRzlYjw==
X-YMail-OSG: ZomJk_4VM1nyIFuRG.ZEgRbVLCvmpiVnJgbZTvPgleK9pvD8y6rdFWgZrCcjr0a
 L_ehcIpGCD1fqDutd2MsKQt0M9HMFywYF.CFbx.V4frC3G4dhGwPw2WRn2OvYQAET2dZ9R0B2Ldt
 HAmbt9hqJngTxTMMYqn9dQVHtONYTjdW6UlYV2F_H8YIo3pz7Y041ZlvSUceyfDGnALhwB7REsG3
 kaCjEphF1qCysCl7DZTBNeeb2YW.fuiV22sl.PuVY9PJaYGNhAFltmWSY17mTA.4ONraLBU2Wg6s
 h7lAk00acbZHFZuM6l3ZWxNrCa.zgQEHnMtWqjo7mg6kG4YXGZYVH7t0hM0lOKTZa9CIpS.07rac
 d_277FrFYoInyes9Bm3YxtMhRPfIxCRIpKwY8g0Cgv9M72Ysf0lS4Q3T24HGlOIarjlO7jqxMlsp
 1mrklch8KWdRN42NMJiqc7UqAAk8ByF6y169U8asRQ9.SZv3ViLUSIuSBrD8SLkxBCHQJMS7Drom
 ySa2ykxyX5hTAymAUPdBq50oCohxR89LLGAKXDI5cbFeyduJIvTe1oiJD_oweDUZFkD1ElNtOK72
 AUJQfceRvu4gZX7xHYoaIQp5d4ediaTB0_2xHwN_FlsjWzi_zMXmtz8dA2Q5GMXeQh0H7ZQ_KhyT
 phxXgbeoc43ch0h9dkztjSZFCIzyDDx9nWuEVI6if3nWi4eNoXU1Elcu2BvQq3BB7qocaD83dI4L
 9cGdoLoljf65rf3l1R8gfW5ot07_YWngR6MtVfJwo_wd3Nho_N2s7Nw5O_0niXXEaaj1AxK5j1ju
 ssDZEKpLinIYophcUhvbxoQ5teWvhSp_3a_.nFxHgzX8.EgIkMrdMCBzH1.nklTgMZooLTy6Z7so
 _7WIRZmOUbYUZgmUvGRmUQ.gQ.lHf6LdlpXL7xFryKA7TXPbt4GKRvxY3mehbxfyFi.S8Y8AesBM
 dYQNOMJrLWlTUHDXRrYNrwgHwCXr1CYwy7ModcmbTHEWK0ZofSp6wg7kqGnGh_0hVtRGOKbvZaZp
 Q8U8unzd9z7VBv1Hb0ZFheqX.2Sa0h7_fEbCdWIcNEP4hw.ugc7v1H4d0LHh4qBHMaplB2kCW.Gg
 gPiWC3Dcq_S_uDXBSuKq.UfgcBFGpFUFQrCebuwZWwkCZponZEQO2krApi.1ogWgckQrpIfaMQat
 tIrwt3rDns71gqYtaqOzzIeYrz2_4Nkp8pgzpKv1AFhhDjsKEm9wCjBrbHrJKEJfLRzcEIVwF9Wv
 X5q35Vbzzbgx1Ccw0eJ36VEfmVqpPCiYblRgZ3awX2rcXODrSWaqJ0Vkp.CYlhJKs0cMHEa9w5vB
 VW2OOm2HgVTS.6tXPpXaRdCAEVcU_7PYEgT8FzGEW8AefrhP_uL7AtEP3aXM55J6j19KeI5nEGx6
 Xzs9NHgr4Ht3zqyAOVF05fjgueM3I2AaZQkSMDIwVddV2Jzf.Njuia_shVQYyIJr.x0.1M9rpegG
 BYTFEVhNE7HE.mCFmZdrI4gl8xBwlGxvhjEy5ZqsK.f2CeZZX4WHHCk3cnWAXi6SKIgCC7.BnqHh
 FifdpL3z_cRwAqfFvrow5n5RlU8l1JWI0vCileYx9WRtjIB_Z99mT5Sjou5TvGnUESm1cXUDfVMi
 ih7NSuOA_OYx3u5BS.EXxvDZ03_vXstb_7o98tv6Ver3fp00POgfxU4ov7ksBElauagTKCtvJIQ4
 djQJ2CIdl6wsvhG5cTon377ZUh59KrEZXBF.W8I0gxoi3jch4NeVOBD_h9fzIA9uvMIQp2GlwIu.
 v2juYaWD_uuvkWw12_eRDKjwiWo9bJwoN0iAf0kpBMkRuLO3ci9_saB1Kz8oufW9QODVGOc7FmCw
 KtjfThzn1.djuG1yeSqjz1NfkwBnKlJWo8SukihckoQv3An6DynVU162gyp18X5A8oZKsLBKowaS
 bMrwaygFI_zpQ.NjBruM615TIqBtjNGndxLwXpSl9Ncmn6cnlJIslYsHE5_Euhwt96PEUGr05Ku4
 3meFg1Shila1mIi_3okeDrKiKSVzhMOT1zKHsepuNsjw7RbnaJig2aynq1eQrUohTk52tGNnr7oH
 mJ.AexP89c8qEj2zp8bps.hRfoOk9f.wwYy_fiY67pgEviicWKBZjR16sJJ.iemVvcgl4K.v92JV
 00siXHdQYe6NUXuZQZswSQSdrPHgKUCuRHX20Nf0t7o7GGpGu9GSjo_kugGbT5Z8-
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 12:10:07 +0000
Received: by hermes--production-ir2-65c64dfd66-fhq4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a40cbac568c271306afa417cde737cb3;
          Tue, 28 Feb 2023 12:10:06 +0000 (UTC)
Message-ID: <645dbe21-4dc6-1449-bf73-ea83165fa4d6@yahoo.com>
Date: Tue, 28 Feb 2023 13:10:05 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Segfault on exit after commit ec804ffbd "lib/copperplate: Release
 main threadobj on exit"
From: "Mauro S." <mau.salvi@yahoo.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <233902a7-0911-06e8-a54b-dd7a1d568264.ref@yahoo.com>
 <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
Content-Language: it-IT
In-Reply-To: <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 21/02/23 15:13, Mauro S. ha scritto:
> Hi all,
> 
> I'm using Xenomai 3.2.2 at commit ec804ffbd, kernel 5.4.228, cobalt 
> mode, on a Atom x5-E8000 x86-64.
> 
> Since I trarted to use the commit in message, I have a subtle segfault 
> when I close my application.
> 
> I managed to reduce the case in the simple code attached to the message.
> If you run the script, almost always the 
> xeno-test-session-segfault-mainproc generates a segfault at exit.
> 
> Analyzing the core, the involved code is always the same:
> 
> #0  0x00007ff729498400 in __hash_key () from /usr/lib/libcobalt.so.2
> #1  0x00007ff729498897 in hash_remove () from /usr/lib/libcobalt.so.2
> #2  0x00007ff7294b49ac in syncluster_delobj () from 
> /usr/lib/libcopperplate.so.0
> #3  0x00007ff7294ce06d in ?? () from /usr/lib/libalchemy.so.0
> #4  0x00007ff7294b6774 in semobj_destroy () from 
> /usr/lib/libcopperplate.so.0
> #5  0x00007ff7294ce216 in rt_sem_delete () from /usr/lib/libalchemy.so.0
> #6  0x0000559ca0298651 in SubDummyFn (arg=<optimized out>) at 
> main_proc.c:55
> #7  0x00007ff7294cca0a in ?? () from /usr/lib/libalchemy.so.0
> #8  0x00007ff7294b5ce9 in ?? () from /usr/lib/libcopperplate.so.0
> #9  0x00007ff729494f7e in ?? () from /usr/lib/libcobalt.so.2
> #10 0x00007ff729461ea4 in start_thread (arg=<optimized out>) at 
> pthread_create.c:477
> #11 0x00007ff72937859f in clone () at 
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Reverting the commit in object the segfault disappears.
> 
> Applying the commit to 3.1 branch results in the same problem.
> 
> Seems to be a corruption of the session memory shared between processes 
> caused by the atexit() callback introduced by the commit.
> 
> Some notes:
> - seems that it depends on when the xeno-test-session-segfault-secproc 
> exits: if exit happens during the SubDummy tasks start, the segfault is 
> generated, otherwise no
> - seems to be related with the number of calls of the 
> xeno-test-session-segfault-secproc: with only one call (change i == 2 
> with i == 1 at main_proc.c:139 and remove one call in the script), the 
> problem does not happen
> 
> Thanks in advance, regards.
> 

Hi all,

just a kind ping.

Is there anything I can do to try to solve this problem / do you have 
some indications?

Thanks in advance, regards

-- 
Mauro S.

