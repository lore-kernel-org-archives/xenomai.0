Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649402F3E
	for <xenomai@lists.linux.dev>; Thu,  6 Mar 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226542; cv=none; b=snsJ6yk3DbnPjs0NQ9CGWJypLNly6/ky5GvxQAT21NTbDCA8zHBYUDmtdDVWpVYRFEs+pcsCQSGUYgBOrEMKhUCnP/acL4y3RdanhNW98fx0rTWOmmC+D9qsx81a2I0xibeLzEfBMCQSo1jXOB9l5YxVUXPvGAYgC2OHuoN0e+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226542; c=relaxed/simple;
	bh=6PIrtYx1KKcAX8Ra97+pk3MWTW06kTeQd2efUQ1wedE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZwW9AWrCe0ZHmg8hXk2VZ8qksw/2VHeOufNkgqXUaMt19nhnSNqCCOMlENp6ASd03ZWSfgd/EfelZeEqMT+tZXNUZ0D0bL4faisBJmmC0KbPia15n7sG2naFGLH53GD5w00swLlPLlwiBdx06k+5VMjp74JP+p4RhXNWnlJ1r2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aim.com; spf=pass smtp.mailfrom=aim.com; dkim=pass (2048-bit key) header.d=aim.com header.i=@aim.com header.b=Cn9cuqF6; arc=none smtp.client-ip=74.6.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aim.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aim.com header.i=@aim.com header.b="Cn9cuqF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aim.com; s=a2048; t=1741226533; bh=6PIrtYx1KKcAX8Ra97+pk3MWTW06kTeQd2efUQ1wedE=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Cn9cuqF6Tzw0bBhajlVs9dKDxJuC8O6DmeE4Fzr7XNRIaL9Q8BsaHfX3ii15Vx6QTtUEhoWmaXgOjU9EBqwDYEIIbWsFvernl/WTWdAGTN4uLXxLB8g0yol+4ZzCqCApVEupSAmf44ex4GCQIqLvvq/Cm58+GpyUlzFCxJCHJMo15MMTrlT3Uf9JImqjXxHYva4FHRHz+8JB2cytU0D7wZGgTpgqJtVNUXJkZMtpVKX/ChG4PeSSuxp9QNCchka8P98IBgGBxkItatq3FE8QYutq7S82GeWxWbeuU9uOblOtRohL9okcuVH2l1Ok62jK4dKR9HBbChnKBb30bXzwvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741226533; bh=i479F2UeilCsaxfCAxOCZQwO/DTnfok7LbcKa+hXhKj=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=GO8Ef6Hbojwz32w6Y4C19ulcbbsQ5MWCj+B7OfunByJhXMKzx9w868DVhVK268VeF7IZGNU/5rjHYLKxAtL5Kd3RhAcC3gAdaW5dxHpF0DjJrErAf3ntBCZ9T7C4TofRWmMbxrIRHQGyYHTjPXhPZj6uzfkw8wAu31E3Te5wkgsCNvUJo0iX0fbhsyRGWbOs1hkNtETBL7XkKK9Qu0eVFKp/sk87JjK9M7PPISxUpINrHLpno5UnUT3zMVFSprhbXAyhNLMH/Hl2qUc5rcBrFjWjHdrrl59fvaBDlPTB8oQDGU3yR3xheWBWEwZb5MTeNClmcCvYIzWyNuY2P4Y+cw==
X-YMail-OSG: lwtj3IwVM1mnOsSrSM2uR4hSYsNbom5KxnYJn.HzywEmW5RoelD53rJ5d7lmYIz
 cJWOG9AmgEwa81TgIU6j8Bg.p.kP15kMkPx2UToENzOcwCaqJd3tolmlodjIhDgoPTqDCzp2k1eO
 Jb9GadO5Bn2EkcmeGvCL9kwOHPZFNWmP.s7671v8XfF7DCLR0_lrUfQsSdoj0kk3e0h7WH.0uv_r
 yzwrPVkjLniuMP_2DYsItp.N58mKXTXkJkOGXXyxMOKy20eUIJ.FQiuSkol5vi.KfjhV0689gLeZ
 KG.HBYZ2NKIqtRPAIXQlM5AT4TpGEJa1Im.9chmI196AnDvUTd88RTp9jS8QvQnyYPrIvX_ZYqwL
 f7ZRJk6qh34oHmlSP_bdFcE4UqeEbwpEb7WkFQWorX9aua6ry6QeAbmU5WJiCo1L0C4QTOm9DKGi
 tNCNgDU1u.tOnt9jB06qvziRWdCJtxeRMr._z0Avv1h8O.5DoBf8.78qB.I2JR_r9bYllo3CtSlc
 JLYza74oA34f0OLabl6Bq5PGymubOR6gdIWVxspMvmoveL8Vb1SgfLa3ikHuop_0YS.6_oKavq_U
 m4z0AX3N5ylThCP4zcf2o4nDOZTGm0EnJFAKosyO2I4ctKdPpyEzTFG_lTvodN17WMyyCVuvQpIG
 IvkvVZzjj6LsvilK29DdJkSLFbW41cBvUjfZafnc1c_V3SEQUOtzN2bw1OnJLDnDb7nSM.3ptWEv
 7aNTnL5SH9tO6jL.uwvLlovB2U3OFjWrlW728wnOm3sbZmIr0QZBh4Td3AF8B_27z98SOmfUY6J2
 MajnK9oa2DjQyDR5Kx_lAC8nZe0U6kfJMf7kJgfcOTLsOw993wfaxNGK5Eg882_dPuIEOjdUA9Uh
 pfZ6iyHkt_IFl6ra_Yf_CyGBd0EkI3QxZyWAAXABc6oDpRSGy4xvQl5qvr89udvD_dbIqzzz6j9Q
 9d3sfLjcha9t_5ruE7UFccD9dktfTqkjPP_zmLHgL0M1v4nVZjP2PJg3rWptiulKV0p.VrhIZPpv
 GWrgaXaqYY0.tfP38sQfbB5vH8ee3hOspgv_2gmPrtK_5JUM0O9FBPsJrJhsmnRbJXRvKPsTbkNg
 1URsARDU1tKjm3P9gbNCaW4KIwuKFsXQwLfWrsA_llOgkfSccA5EVgjsBurU0SM1L0fPRF2tinht
 GL5RYyobXsLrvDIHv8IstE7qM9.LsZGZmIe08mkFG6JBqt7jZNMWgQcUn8BuwvJJJ6ZNp9mAJE4h
 ZWwsnKIa00AikXgI0_EvTLz5RTwUSxw.43y8L89MrNZKe.YOgnTLccNHx0vCYaE.ZxhSJIUVBDKG
 6b_XczrfsLyPzNgQXU7Zf7vMBI8WvaoZzaqRVtZfeMMeYsdi.j37ElTLXwpkfIVn7.C.IG_VkyDC
 IeidPl0.W1RkP49IBKfD7s6HJp7Im6OU9NupeOP3TNH8ZwYMpl.y0a90HfO0QBBZ_7augEvc5CyR
 WvKBjCAhyFgW3kkWSaTT5YmZyTT5tUyscJUum4S4oRoZzBT6elHOMxlguxpCFgE3mpLUXIIfufY3
 jnG45zXCaVX6INwGVvWntKViyZwZ8o7.1CM.JB3rSwRlqq7tFDtHCYablsIWg466ANjAUg5Ns1rW
 xMOl7Ng2PjgpTOxP_ox1IBxyE05aNTf9vUN4B7VI4xkz3uNRss1FXIV6MTRNjMCzP86.3nPZigaL
 txEQpRlMe9i3tnAer4UCYh51CCtNx0HvLR8cZ3ZXeUO1mBwbcr3W6QHEdY_6Bt0yJZuChJKHmNtw
 rpu91wbA1hqGj0QsVSAwX5V84i5VmSJR_GYntVw0ypnINBkpOGhPFv8DecV4dgupgqyZvMnlxiVM
 ZtVY9KdPYYIAUoWIQaOgoXhiVOQ.cYjJ4tNe8hXjXUw0oEQylVTUO9YGj8rD51L2Ip9aeTCHdnFJ
 OwwzNKxoVlU8mFqsNb9Ew50mzF2Sx5qnkNd9hZaI8DDdIb32y4Pq_FADbP.W5z2bTANuWpHDS13l
 bi4aHWRBe6qT3CWDLS8_WKkR7ckdVlSnrO78MHFiX4XlPa4O6Q8cZFKeG9a73aXDt0UffpMVUjll
 hjgsEi0F7AAv24tzA4tVa6haO3jKeBmVNErm3lSIaaYRcQKwZ1AAMl8gPjDxyTZ75BOd.D72hdx7
 OLtC911SnhWMxIUkOueAxhdlYT.V.ByMNQfydkiyln7PchrpMwByyjyrr8rq69eQ-
X-Sonic-MF: <mazenarakji@aim.com>
X-Sonic-ID: 4ee31160-89d5-44af-a112-beb72d71ddf5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Mar 2025 02:02:13 +0000
Date: Thu, 6 Mar 2025 02:02:12 +0000 (UTC)
From: Mazen Arakji <mazenarakji@aim.com>
To: dev@mynewt.apache.org, canoncustomersupport@cusa.canon.com, 
	questions@rowebots.com, ecos-maintainers@ecos.sourceware.org, 
	info@enea.com, admin@evidence.eu.com, info@freertos.org, 
	info@highintegritysystems.com, info@ghs.com, info@intervalzero.com, 
	kingstarsales@kingstar.com, info@tenasys.com, inside@lynx.com, 
	info@weston-embedded.com, info@digitalresearch.biz, 
	contact@siemens.com, dev@nuttx.apache.org, info@altreonic.com, 
	alalias@avaya.com, info@microware.com, niisi@niisi.msk.ru, dz@dz.ru, 
	contact@phoenix-rtos.com, info@sysgo.com, info@px5rtos.com, 
	info@blackberry.com, press@juniper.net, 
	shark-announce@gandalf.sssup.it, mail@miray.de, infoibm@us.ibm.com, 
	office@tron.org, inquiries@windriver.com, csiroenquiries@csiro.au, 
	xenomai@lists.linux.dev, devel@lists.zephyrproject.org, pr@nxp.com, 
	roberto.bucher@supsi.ch, lorenzo.dozio@polimi.it, 
	support.intl@keil.com, support.us@keil.com, nokia.iar@nokia.com, 
	evidence@pec.it, tradecompliance@arm.com
Message-ID: <36840942.368160.1741226532894@mail.yahoo.com>
In-Reply-To: <1603998256.5125515.1738863144780@mail.yahoo.com>
References: <mailman.829.1709756598.95024.users@rtems.org> <1186003914.2868885.1710554468422@mail.yahoo.com> <52215972.3321292.1712263719558@mail.yahoo.com> <2146568861.3322644.1712263800004@mail.yahoo.com> <413796231.3322749.1712263878817@mail.yahoo.com> <1228452397.3324560.1712263957883@mail.yahoo.com> <1890949027.3327361.1712264034011@mail.yahoo.com> <981313733.4351127.1715104497826@mail.yahoo.com> <987436961.1798571.1717784494936@mail.yahoo.com> <1860876160.631758.1720118931641@mail.yahoo.com> <2033909205.2130935.1722891034328@mail.yahoo.com> <1966769734.2505516.1725640729801@mail.yahoo.com> <875139804.8664061.1728066102266@mail.yahoo.com> <225730382.1497662.1730762872592@mail.yahoo.com> <1985768102.3451851.1733381726743@mail.yahoo.com> <429650945.4089656.1736103905811@mail.yahoo.com> <1603998256.5125515.1738863144780@mail.yahoo.com>
Subject: Patent Infringement Notice
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 AolMailNodin

Do not, in the United States, benefit from an RTOS that does not proceed to disable interrupts in order to insert a task into a collection of tasks.


If you do, you will owe me money.
