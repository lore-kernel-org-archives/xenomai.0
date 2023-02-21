Received: from sonic307-32.consmr.mail.ir2.yahoo.com (sonic307-32.consmr.mail.ir2.yahoo.com [87.248.110.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AB1C07
	for <xenomai@lists.linux.dev>; Tue, 21 Feb 2023 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676975211; bh=UQ/YTcIOc/S9aoIdEigZn67taNjsGRQzDB+EjgX/6PI=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=ELpvrQn2NQ3pl1r55iUeEMkixAPPWVZjlIXdKLxvn+Sgc7xNNQWXY9gCaXd8A727Bgtzm2t5Kb0d6cpYbOd4AbSnXOiTdFLdt/+HBqVIifC9OeT7z0nj6JwL+mJ3nAld3V4H+OpNLkuN2Nk5MjosNan7osSsgXKu8jOIF5CwkCo93H/QY0SUmkSIXl5s5k0RKGgK2X7AUDs4KXyQe1qZsOBa0ienUjs+XnXEC1RR/EgrfgdpSWKvD5X7aaYYkZkiYrLmugOd24Gu6IQf5SXgiofU99u+/yhuaVqcZ2KYGHqZBcws2DgmyLDlcsengdzybRwDf2d8MLvQIXAeTtNpwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676975211; bh=ZUdwLrujklldjKGV9Y5JaYbYKssrN3dyM9M7MTtel2V=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QxAHXemjqgDo2IVkFKxXt+GKhW4X2lNZLJdulVi3u3EFGxDAsscxC2m/vSE1SeX49iF3q8r0NkXhZLGBBnVL2Xma1BnWwT3ieodfwaZ+uZXaKasMLSk1A8OzIS1L4t8M2pU6B2ZEFYgHZt5Q/E02jGtedU7Fknu6ugHuAnk2dlFLzf7d+Ho4ueDu3nbtQLHVT9mFzEpKsTAzxg0Zr08/I9kNkh4vN2GGl0DX4q7ml+QMj2bWx5g9FBWssuCyvNeo/QIt5pNxo2bi3XEXAwsF5Z+pRL6zLWn56330QYq2MlGmQUtwJbPgwDwEO7jRiy3xQRBejyR7epJztVFZX+q4Xg==
X-YMail-OSG: U6IKK0kVM1kIiiCB7k0OzZdyKJJA60SLvekUxDIq6cVjgQN9_8ePdMeg7Vo3aMn
 epJ4TgBympy74fa3drtTpHJfHn6U.WnRhqbyFA0D_a.dA68ZKrP_v3wuOacEOe8ZvPo3acLC9tpn
 t4grDc9HCrC8ySji0gYZGVfbZpu8ZFgdkvtKQYUdIqeODkhqUy2T1h4C.UcqDI1W7FnqTrcRSFVt
 .wGeq8LDIuS3_XV8xrAdEuEMMiR3K1K3uX2PfYb3dLSwIld5tztT5JmvFoa06yu6ewc7mQX9SGQk
 5FodefpS9BKHz9MtrBpFrwcYEFmoYEdZjcquAvMfr8IQJ5vCZVrY1xcXlrCZUFNzgRGgp7Gyz0ed
 vhPDSFsDyRpEY4hO3yRQMTWwqSnAycJFF42FdEqvDJQht40gjRrwsUv7eywxEDL3HaFTghountqP
 QUVbnPdYjej_6mXAKbNeFLz2Yn.bvAhhdJyBXLF2GREzewM9EDoLAX4qryc2h7kpYfZ8CiEVCMW0
 dNPsaU42aaFg9xckPBulO1LqZIGVWjBrCGU9TAYzDMg3a02vfHtPuSRWFoMsa1Iyc.Rq_.Gl._s5
 SILtn7z3PS6EgnA2oASyhCUU3krCiQHuJVYvXzGemQIRWl4rCRJpcZXDst6TY7UMrnq5wD6Cpl_9
 LjfO0CAoZshoz12m2KNq2_Yolkl782aVHApWTng7f23ExIWEzxjZUWkb6LhWrNjCTBqFnjzvovKL
 pDKSZ0fscvLQdFTIyifW0u0673idxMvg4nZjvKp6YLjyzj2SWFSh..M3xj.EtPUjQ2xy6xBf4wVS
 BDFEIgkzp050btz1WDnJRsaGRy.fFeyR3oviKCqKnzHNrKozNnbOTQ4Gh3ioLHWR7jcR6xVI53g0
 _VHa2BKtraLYWTc31wfL2fJlG6uEpagvfUy78LKP7R0.TkZ5dfwKu12tfW.2BrjCDB.yPjZ.R0Bo
 6JCXR2dqZwVgVigGOZENACy4bxeaH62xv4b0Z3Z_Qne.mixVuUZ7VAgMEyr385kHvogUamruP2gu
 RltFFSX2DQOa0Rd5Q624EIc0hts2qVXaZcW9uXizXuzGq4Wf6dlsq8Vof.A3O9.T0hrKWwTltSKH
 ZyrNun4BxIGlG66aoJ8LZzJxSHJgqaVpSlGaySBeptR5AH9yqW_eJ2H9ry_VUuuyzT6dBqRihwEq
 kHjUY_77xYBMHc6MRz4DrGOZ4YoR4RRb9dwm0Il71jVWWG2EIYg5UkHE172cNelsRyjMpZzfVDeV
 htbCnf4jU4whCPIRtBqAgD1MDsxfQ7fizZWpfsfCI8zqYA5R.1yI2wXqhdtrzzjcY_YHGrL8zwDT
 XQi34XXtcxKJ8THFR1BvHgmrt.dcGQhJjoqiPdlcWq.F4FKskdqNKceo6q3Fcu5ZLahFD6jy9JuI
 edkA2RBT8o.i_SGMbZ5QsW_jigj_A9FY7RAQsuUDbRpxTl8V6IpGiYsqyJkygIuGuYA1zVO65MPe
 QsFhCsLVhFaiIIzpPvddPOSRxg1UIBZvySnu4tqm0NATIPoDOi35U1qmZ54IntyeSu8sMqkC_Q5a
 tAA4GyO4vp175dTp5ESzDdSRbIsRz4O0xkmKkojGt.HJZPn1mmtgmMhqXWeOZaOgnQPE8el1DgBs
 TbkzUHCi2c4HNtx_pdH9MKmLo3yF8ivVXNisrwDA3QlW9lzVNJFhBYv2GyS0C.JOWdkEJjTrDbVR
 dzGARBbpt1qJkZkjcwvPJgjIzEVGdNI7QWtUOcCOX7QbuZNLqADQnJ7bk.LLj.mK8mqrT3lpn6hQ
 hZpY288u2qnFOJqo8Bgx6j52twd2b0Egz308S.tk6fY7ZyPn1JIxJlSm9Gn6zF6ZsByo1a_RCCid
 OvYe3TdPC7kFLmevq4n7E3cZvNPnCe8VjtP1j60Yh1gdbwxsQYWmdMpWQ84kkR2idvnYb7u7LAH4
 oG3e5Bsua9k1AfPD3zblS.APkTbROrgkIeDBXASMfDxgtZT96h7.8d1REOGB5loPpEu0d0aa5nql
 l.48.KXzgZicZc_lY6DTzGFw1MjmNnp6EvM66OXRLi_.8HMsin3Z6eVqj6ojwCGaBgFPZlaWf8Y5
 iN6sZRJOnnrKeehFTPVUgw5CXJvLk.G0gFTdIa16oM2s2UFOFoYgqCIgQ0RfVcHWYHiA9uvle3mY
 LRrAjZRXnkU8kD4xrwYynQNWNrv9HzknBoI0lmcPiry1CVuzYwYq9oqyMj7xJ3KBLyR4FgaaWAMN
 N3FmlObH15V7d
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Feb 2023 10:26:51 +0000
Received: by hermes--production-ir2-65c64dfd66-q88mm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4852639f9dccbf6ce68feb3060d055ca;
          Tue, 21 Feb 2023 10:24:49 +0000 (UTC)
Message-ID: <04a817d8-5792-c00b-8533-488cbc24cb4d@yahoo.com>
Date: Tue, 21 Feb 2023 11:24:48 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
 <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
Content-Language: it-IT
From: "Mauro S." <mau.salvi@yahoo.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 08/02/23 09:21, Jan Kiszka ha scritto:
> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>
>>
>>> -----Original Message-----
>>> From: Mauro S. <mau.salvi@yahoo.com>
>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>> To: xenomai@lists.linux.dev
>>> Subject: undefined reference to `fuse_main_real_compat25' when build with -
>>> -enable-registry
>>>
>>> Hi all,
>>>
>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>
>>> When I configure the library with --enable-registry, I get the error
>>>
>>>    ..
>>>      CCLD     rtcanrecv
>>>    libcopperplate.so: undefined reference to `fuse_main_real_compat25'
>>>    collect2: error: ld returned 1 exit status
>>>    ..
>>>
>>> libfuse-dev package is installed (the configure script finds fuse), and
>>> it has the function fuse_main_real_compat25 exported
>>>
>>>    readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>> fuse_main_real_compat25
>>>     318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>> fuse_main_real_compat25@@FUSE_2.6
>>
>> I do not know if it might be related to fuse version. In configure.ac , it selects fuse version 25 but you are using 26?
>>
>> if test x$use_registry = xy; then
>>          PKG_CHECK_MODULES(FUSE, fuse)
>>          FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>          AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>          AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>> Fi
> 
> That's a good hint. I vaguely recall similar issues when building
> against a newer version and trying to run that against an older one on
> the target.
> 
> Jan
> 

Hi all,

Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
I'm building in Yocto.

I tried to
- change FUSE_USE_VERSION=26 in Xenomai: does not work
- change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work

I finally removed the can utils from the Xenomai build (I don't need it) 
and the build completes correctly.

Seems that the fuse symbols are not found only for can utils (don't know 
why).

Thanks, regards

-- 
Mauro S.

