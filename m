Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028237F
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 18:43:03 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 320AC200002
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 18:42:55 +0000 (UTC)
Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2B2CBAC0C82
	for <xenomai@xenomai.org>; Wed, 13 Sep 2023 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1694630573; bh=jMm7u+6lcPUb+YS4cCeyHOZbvFjPdZsBMjq1cErcTN8=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=oNPswnXS4Nfh38HVo3UuPh2YE5uIxNicVePUi2zs+L8MOY7ehTUNhRYmxmt5F1PJ5q2TMHkiMokudO+67NE3Bt9fpBRfKc7aW9qDqSQiV8S02LG+sIq3swYSK/yBykEL3Gjto2P/bu55NHul3NrmfCMUUcLw07gSZGD/5168re/nkQvIRznYTJ6r6aUKYKEcGmTkat6KhmGCb2jGsLNcu0Fs9arM9Q9p5Ng21+bK+o922t9XE3CGUvwkPbM4f5u6S90k1B86xUt/LLkm8YCjd2fdNNkmAux2AQokbBAchBDi7UjeahyG9jFBldtf8O8KPCXixysdx3dUahJyzx7xvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694630573; bh=bwS2UxLKwTC3D2pQWVIVaGhMtdGXqtTbPGD1GK9ECUW=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ajYVlPcWNqtr7OWrsK1DeWVA2JU+QfymWVByEjloRSlDB+k46hYTSbMB+DPGUaFXYJVSutlEeUUx6FZizb1oC0bfnsYtNs99Veea9eo9X+qxdaNmnQNMmLrJlDmTQ0UaT+++YUY3ORe+I6Vlzp3sS83y3PE1smXDxnOsT6/BqCAn0QDo3wN6QSUm43qE4dygACT7SwYDQZkQpJZyRxOAKJ0/Z0vk/oZ48qmmr81yfbRyjOm/Z9k/mI3b2UlveIRgGmys0JdlWUI/7xa6S5X/c/gOYdcd51HXmsa6XtI+ElzSHS3ZYAedzGNsCGgfx7TH4SIsFp36C3HZf2jSePi/mQ==
X-YMail-OSG: uU6UmtUVM1kuK_9Qpa8NG89Pxc3.ixL0uSrQXR28ZLzN4OE5XNWEXHoCbm7Qfwe
 wrHpPaSfeInpwHOM2ekPlcRchQfQtId5TRDXZIaLY8XP6uVOlKfpXvPUDLs013zaqfGDWfqriNrQ
 57LmK1n8fv9zhR5yGOwgMCh3T114YzyyV4zCY2zHhXKJs3zCQ0GFNOQrP5D7Sm9Q1AYQp4ytGRmB
 Hnk1UhKOVD9LQRbzE4AFYCnu5DjH4S4aSmse.LmEsovnDqFCMjWFyuzb6BSTSScfJOTMCvyq.V65
 mOhbrLSVb8GnYX35D.zgSPLu7Yte69njjtLR1acjx_qIzaBH65VtOvb41cKJ4ahcp5_0ZOlOigJ3
 QSrX5AjJgazuIIDYeaq.yqpXDeUEhvn0gLnZYKtFkql44ykwwRd3zoqoMoZX2j053jJNZFSMgU6O
 yO1LAhebnZ8ngj2A755z.jQXHDr7J3lxltNXSncZkLYcvaKpwfnvPJCCUHK47d2w0waVMC.DLTSY
 8IoFuDHgv1tS.NBz2RlUXCvGyfSPwRneGUqcZfeOzCBv6pZZfjK.ICr6xRqNmLu2SrJQlC8hyimG
 caxdW_2VHz_s7ztI3y40Qcrl1IG4VGJlUeOFScoQN.0tMeKNU6ARQKlMECwTbIxqfq0NiIl42P4A
 vkH33jnWNzUNx8NCLfkNi4YPfLcdoGhzRNwFTUhW72hu0dWZ5whNKhQKiBHM6lCvy5JV5GqbUqdZ
 PiHhUG1QpGZlNpFXO0SZDb3aD9G52JuBeO.E_WqrTPehplJcoguwUSdLKMJdzoqCNb0K20IoTMmu
 mTRt3XDTl4uMUe10j7ntQRXqtM_LJDa89SCQwCtIn7WXrg__FBB9lZiP3VvOt4uWG_PGRgq9mI4I
 MYFkX9b5Icw9zpL0WzFXx51NDRxObKQYBKdbIIQ65Kap5Mrbc7UwmUsPAsnl4KS5DlbVM.HhAhlh
 3F0ZkIW3a39LbR4c8lAPpyX7d5dI7mgqWoKnHe.aEbcC_hpAJsLJT35AkO2BgUgI_rsBG.RXdzBh
 S0PmZ6DOHbcAA1t1Rnln_Vrq88FBTUFe6cNEwX02cN04YVJSJDpMXrfesZYykbr3VKnFO.wxjkr0
 ndRODlKMSuGLcXTdvToLv2xGbQCmfl5nik1y.YtbMW6cDGgqXAyZjBFl3bvnOF1tAejRFv65r.1T
 YONdqjdhnyO4wOEbADQNVzMA_Y1_dRan_axwEnIhSq9UQbEtFqieRvkhm1TA9UYqo05g2YudERpc
 KeZS2Z7V.8vT6sWlfLRVUD7fweZFoee6_Hd0vf8bXHOxrWwPqcj5i3rX6CJlRmNa1PlDdfFrAeJ8
 xxLW5gAY5j53eSfdU_Q4E9LYf1DNijbALWyZM9YzvK2tsMNLVZJbgKdXOw3GrjIovKxVNaqt5XfH
 _hQo19Er4J34MZwhKWX98kM3Wr2hO1YQCF2Ka.jCxvkoCilsL9EdPnXx9EmCoS5aMnlNMJELv3Zn
 _Hf2q_wU6Ppk1QiTh1DxiSazNGAKH3M4HjBd7yhGOc2GrOYBzZBtgipS7MFaRYONOQp6qfrC2TMt
 17TYzqS9Efb2SGbG5tyP9fWiqScdzMFzCuISNX9gMG6CMxdIjGMc_39ktRipxZK4L7L5cZI1sjKi
 Z36n4UAPOca2LIMJUwavJLbtgpPZh_rHDPEdZSJD81ejZi3fQojPZvP0YlnuqFP2Q3YO6TIdjRi3
 ECRKh7CG.iqzdKvy4Xhw37AYp7rtKYFrxhODR3rOSDOxgIDSIjwoCnq0BwujMuISvQLQsrETPuKm
 6dvWR.RSUEOOpsB0g5ret8q2prcFG5eY.gFoO6QtDPVBkQBN.0Yae2T6qCwIlWavbXcqMuGO1mAz
 QS3_oonxLAPzKFXZTvGrVx0TdRZOA.a4GV_CZk6zrLJvFCqhl3Htnlf_D2RpimQSAeKxSMftUWwt
 cfD6In9qQI_6U_GeopCJauGCzDOS89X3hZC7ddKobi1IIeUvdiQs8TT8xwCnQDiPwErQv9pnAhNu
 ZR_cwVxgn23nT79sW8ajy2U7ls4hzSgBxd919VfKG2NWEYVI.MFNme4MoO4QGGNu21k7zlBBP5MD
 k9dWzNjn92yRrRDkJzOs6cYJL7C4BuL8UxOixnTeDXYwtZycjYCnoUkxYlMSiSTMz6OY_yIWLzWt
 HGwbS8A3ceuhYZ5AKbB502zvnn.Z2Uf1kbA1PPAhHqWiD5c2oXV8FwVUamF7S0kP_5SSJjUBKX3n
 JSyrRz6ZLlAKLbOOo7o7nLB0k
X-Sonic-MF: <neotheuser@ymail.com>
X-Sonic-ID: 8897cb4e-f9b3-4faf-bd1b-2551a01a0cc2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 13 Sep 2023 18:42:53 +0000
Date: Wed, 13 Sep 2023 18:42:52 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Message-ID: <2099512930.605027.1694630572180@mail.yahoo.com>
Subject: Downloads and mailing list pages broken
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2099512930.605027.1694630572180.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21797 YMailNorrin
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=ymail.com header.s=s2048 header.b=oNPswnXS;
	dmarc=pass (policy=reject) header.from=ymail.com;
	spf=pass (spool.mail.gandi.net: domain of neotheuser@ymail.com designates 74.6.134.41 as permitted sender) smtp.mailfrom=neotheuser@ymail.com

The following links no longer work:

https://xenomai.org/downloads/

https://xenomai.org/downloads/xenomai/stable/

https://xenomai.org/mailman/listinfo

https://xenomai.org/mailman/listinfo/xenomai

Just letting you know.

Alec
