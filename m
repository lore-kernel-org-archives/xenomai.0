Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EA23AF
	for <xenomai@lists.linux.dev>; Sun, 12 Nov 2023 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aim.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aim.com header.i=@aim.com header.b="agxXQjrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aim.com; s=a2048; t=1699772116; bh=mG6EKMH0HyQ1/aj7NfGD+jDqtCnFLRU5RKSafmMNDa0=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=agxXQjrQyVI5H0CaZb26RcfE1p3hQsNWAtkW40DCOpT7vLDOT7hVYb604HBOleExEn+FGHcA3BTusgJ4sEf2muxXbx0kEzMilbRe8jTXoAS3RoxFB4Qo1SMCra89Emwz7+ul+UWwL//ic1AQn89qubclCDZBnW0HmSKYWarn0au1QDud1ECz7IhdR8PyqrXztTGz/hJsMn8L4V6HPJofuERs+HBaKJOgQI9xLTqY2xOA285BrlxDChRtm9BY3SCemaK8eKJseOtW9Pk967rvz7hv7hR/BRQbtVzfQ0/t6n45YJnLTv9YbwdbuPhTZptbCs1vW3lG2Py8i6Aw9xAzcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699772116; bh=uvL9ZFvdwj0h7EM4C+fKtS4av8ALPQwpMjlVeML5jUy=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=hBFPutnH/j8XiChiVOI+c+9StIzHtN439E5+55AvKJTj5CLe02Wb3iLEtBQ8unWWkR7uvPEggZLV5L2hUYcKQ78GwZui3QIn8ZSno0YygxVVQTHAOI2lqxA3rKS2q6zbAsIw0C97gKDIUukVsqp9QG0ngG89sXDceB6FtYkWxhfuHRa8ELA+yhlabN8lDRRe1pcFBtqGhyW/CFpmrK3DJaaQVeN+KUw/4EeMuhUV7aLhspZ4mWePnpyOBFmsBd3kYJIjbIIO+hU+VTTDM9NiXPyplXz9RMo1m8jlLnDu6STgFWXsXR6cmTFtBDvMjlwoQ8Ni+pNRnoaIsCa1Q7n19g==
X-YMail-OSG: kfyH7EwVM1k3p3ePOBV25F2J96Y.O5ooMttPtZmKNGIcp55fFnkAlzyiBwpLCy_
 6c372SPAzxBlCMM6ATkNr5ChgxU2oiPdInY_k0g2TJYchKPnRe72pD2F2b3KylYqyAonwssRbt6I
 wKS7mROH4Sh6svRPUYqFCiBw7OLvsmnpB4zBlQi5VzcRvIHQDoVIA7YuD4EE.wpkg30v1tvH8az_
 w3mrRtkHa8TSAYpCpR6IAfSvnbNyM3vhrU7hwYp8Igstud7chcDSRB_TI7VoVU2rlGX9A8luz.cS
 TEldSvQBsFh3RUo99imfpGwa6OsowsXSmuk0XaQRscQgMK99JCBEVeNlX_h5291l8IbCOGxQB.vx
 ne.p5X6AxDCOmsTD.78NQ0F6VARsMxtTMQQISwfAXSkyI8SgA2qP3prHnQ1wyZRnuycGD4Tfv2.R
 OF_YCE65Zq3G6vi3aAEnlPr9eVp8CdnpRYq56G4OsnnLrubgkx37eabv.6cbsmKhCbsh3DAHaSxU
 laj43JIbeIyFUDUvAcBNr8EU1Qc25cBxBCVud9rIK4gbKwYRo4PJVxXKHV4EEN9HeV10KDK9Osb9
 jNW.PzDofatO1xjYfpVFMblZrEvt9zBnMysk4cDONdWDEelGVwX3Auj6i5nQIR2Lj7mQm5sHFsVl
 sjFgWEW1sKBFi6Do48bmmu1qc3UypzoExiEJd7bFQVv41wkUcEBr.Tp.MlnWbrU.AMD2l7x9B1BS
 rSeLCnv54R3V7lYSaof_IlTKMW4GJTJXuJeHMHGzpmPkGA_BBfbrsWnKug.oYe4uZNjhB.TiEohQ
 jG8r8T0Fq00f8T.ZXt4_Ukj0lo9Ww45OkOzIFJ4oNldlJ6wYlWxNasOuz1T5_d.IIo7p.Itr1bCg
 D4MgmEquYp9cNcAdQBWYDG6jvTnCvHd1CkYuifMXWfrCepJycvWzGFi1tMtUkIKGeKE3LSTqrG29
 huSr03SDMnz5M0UQlHdK8GZUxwYKykPY2EQc7.YmOKVMTa7q0mnXI5eMFxJsIAxF9Li9gK0qKQks
 XyffWYIZy_g2XfxxG5rs2nEv18Opb3P3S6IsG1vEcphsQBmrorrv8ojOBnWUWqedrI6fe_CkRB7O
 XUlpdxo64jC_L9LRp.tszVHc.hoLyo4a24YPnga6B1p4qRBan6NiEMLIImvN.blAEv74Rah.NH0v
 CyP3dzPBksNN4NiTJu8.KdWrPSy75lsI.0JlM7UDJ8K__iLzWv27DKjz14gP44u_7A9mzxFgyGwW
 gCL.JbuNj6qRbExh_uXjsvRo6EZVWVIeModRL3VZBIhEPcJ024kFDIFbd9CoUoK4BQ.vTLFwPmCT
 gX28.vmnbTJ2sk6JW_yhA_Q6rCrqr_Mo9lV9kCIVzBynZhzyDhFT7w7QLk3XInhyzXOGZYXfDhAe
 O1FlFERhyASeCP4S.WsbGq3Ub3KOX19nKnz1rk9RLCmldg5JG8Hq_3MxnkYSWiwoDnZh7YrZYX.G
 yePF3R_OEAJkDy_x_A2D7e9BBdAR8eSBpx8zUnuwoWB14KNCdVksCIXbNAcL5gbiQu7Ub6Jk.Ko7
 VHpss1kOBKJM5vlLwZwZBEXQoktqWRWqvFnDp83x8O3ZDr6Iea3Oco6KEC2C5H7UnJtrYQzCEXUE
 MPU4zGYM8bSo.vM6JYpSSYIE9NmqGjU.2nKyoq4RJB5I9mRBSw2cksWXlwZXOA6zCdPRaVvRxFvk
 fLvw3b6VJ1wVk5ioMPD9kMraoJfCqUfYy3w8HyqzQoLyRfDHpRK7ZKbiWg3WOqLMC01OsLw5RLye
 nD.kA9R_C73Yz1mV92EEERlO57Kgct04xesXGWwT9gYTuUPBjYteQ3NJpaw0H4juKolz6dQa6we5
 iaYJmyjZe8xGpasLPbSnO2wdIvcOkO9IJFFNSytLDcVGLsQHVsJZhToqFxUyVZ9CVlx3W83jC76y
 Vb0Ru3xHDwqv.q3I9ZDmN5gY5lgzyVCePgEucLDbtXL.oI.cc9lJLtE7T6HhLu8D_Zv3MVVwLLSh
 1RD9nINxgvL..WGClJwd7N7D2FngAsf2Y8oS03O5AiuHmwuwpsC2vFwB1PewHY356yvetdVZTo6x
 ao2c0lEG6eLt.bAHPpEJ2n_pETAxbNw3LfQppS7PSUtWMSj8uxMy.W67J.MntXGASQoBv_LXlk8n
 hJeiMRJBqkq5kuFbKF44UPG1QAXVSPrA8NXLBow--
X-Sonic-MF: <mazenarakji@aim.com>
X-Sonic-ID: d1054aa8-e640-4e88-be1b-0bed29b6352d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 12 Nov 2023 06:55:16 +0000
Date: Sun, 12 Nov 2023 06:55:14 +0000 (UTC)
From: Mazen Arakji <mazenarakji@aim.com>
To: dev@mynewt.apache.org, info@chibios.org, 
	canoncustomersupport@cusa.canon.com, questions@rowebots.com, 
	ecos-maintainers@ecos.sourceware.org, info@enea.com, 
	admin@evidence.eu.com, info@freertos.org, 
	info@highintegritysystems.com, info@ghs.com, info@intervalzero.com, 
	kingstarsales@kingstar.com, info@tenasys.com, inside@lynx.com, 
	info@weston-embedded.com, info@nxp.com, tech.support@nxp.com, 
	info@nokia-bell-labs.com, info@nokia.com, info@DigitalResearch.biz, 
	contact@siemens.com, dev@nuttx.apache.org, info@altreonic.com, 
	info@avaya.com, info@microware.com, niisi@niisi.msk.ru, dz@dz.ru, 
	contact@phoenix-rtos.com, info@sysgo.com, info@px5rtos.com, 
	info@blackberry.com, info@state-machine.com, devel@riot-os.org, 
	support@rt-thread.com, roberto.bucher@supsi.ch, 
	lorenzo.dozio@polimi.it, devel@rtems.org, info@intervalzero.com, 
	info@quadros.com, juniper-info@juniper.net, 
	shark-help@gandalf.sssup.it, mail@miray.de, info@ibm.com, 
	csosoft@us.ibm.com, fednotes@us.ibm.com, office@tron.org, 
	inquiries@windriver.com, csiroenquiries@csiro.au, 
	xenomai@lists.linux.dev, main@lists.zephyrproject.org, 
	devel@lists.zephyrproject.org
Message-ID: <797142864.1347764.1699772114971@mail.yahoo.com>
Subject: Patent Infringement Notice
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <797142864.1347764.1699772114971.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21896 AolMailNodin

Do=C2=A0not,=C2=A0in=C2=A0the=C2=A0United=C2=A0States,=C2=A0benefit=C2=A0fr=
om=C2=A0an=C2=A0RTOS=C2=A0that=C2=A0does=C2=A0not=C2=A0proceed=C2=A0to=C2=
=A0disable=C2=A0interrupts=C2=A0in=C2=A0order=C2=A0to=C2=A0insert=C2=A0a=C2=
=A0task=C2=A0into=C2=A0a=C2=A0collection=C2=A0of=C2=A0tasks.

If=C2=A0you=C2=A0do,=C2=A0you=C2=A0will=C2=A0owe=C2=A0me=C2=A0money.



Mazen=C2=A0Arakji
