Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.177.7.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390391;
	b=cOrNjQnYLN55RFS/8bkv2BCTOULa0is+EZZ/KswmPR2yJRS76gfoQR6N5HZKXkopld8A
	 FQrVLQjijI0cRKmG6FzTlq8V74hmouNIfkcG93csAxPIprcF7wihkpOyudyemFVkKn/Do
	 8/dVmhv/bsguKHldHWtElEH9fnQh5ZabEJQ3dDb57UP0U/SdFLuovmgkhQONBxHeJ7Y3G
	 bjB0OIgQ8CHsMdS0tfHYlU1uAHf+vxK0AalLe9+AUdG+YYvB77rJkJ5VmNEVceaMK8zMM
	 E29//8eD6hBW6npF/B0oIL56Q7+TECFOz3WwNuLEOWcGPaFU252l4FLTJ0tvv9JigAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Received:DKIM-Filter:DKIM-Signature:
	 Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:X-Mailer:
	 X-Zimbra-Message-Verification:Thread-Index:Thread-Topic:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+O3lZ+f2Xb3286vGXAmSL7JkS/qUr1lDABH4HbZuLTs=;
	b=fnFhGE08o/ZFZ8S/OLEbekAyPYbhAMqqqaB+8gfAjDZZNOmUHtKNeefSJ5bnKYL4vTqo
	 mJmw1K4AwZeTqhK+xD+oQF9JcDJ1pSR4QpW+xj3c65R/y7nUvX4GjtWj5bKF8iopD4rNJ
	 2JiwT3eGq47gpSjqjvYlT5N7j5QsMZlopytb8yf/RsIO/divojUzc3rrimZPoNcNgJOko
	 oHS08Jf8KSdSUf5xmUO6Enl9q+Hi0FtV37k9LZkXLifEUzf4LM1Zb6+Xil10ysPKJ+7ep
	 7VCe6PYt/n/LUvzPGLWEplh6ejxd86V9jRJXGPaYoU7gJlsOcMoDfAA7deXRxpeY1wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wolfram.com;
	spf=pass smtp.mailfrom=wolfram.com;
	dkim=pass header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=proofpoint header.b=WmR20MEv;
	dkim=pass header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=relay header.b=RP4yWGqj;
	dkim=pass header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33 header.b=Oz0+OLLC;
	arc=none smtp.remote-ip=140.177.7.254
Received: from proofpointagent2.wolfram.com (proofpoint-proxy.wolfram.com [140.177.7.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CE606A327
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfram.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=proofpoint header.b=WmR20MEv;
	dkim=pass (1024-bit key, unprotected) header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=relay header.b=RP4yWGqj;
	dkim=pass (2048-bit key, unprotected) header.d=wolfram.com header.i=@wolfram.com header.a=rsa-sha256 header.s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33 header.b=Oz0+OLLC
Received: from pps.filterd (proofpointagent2.wolfram.com [127.0.0.1])
	by proofpointagent2.wolfram.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB86Vn3682671
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint; bh=+O3lZ+f2Xb3286vGXAmSL
	7JkS/qUr1lDABH4HbZuLTs=; b=WmR20MEvMCFy15WlU/Zb7q33ESJO03DmyUEjt
	b7110Pl9T8gUGCT6amiSTRA03Xo8NDjiQoNmFgIJoF33r5yBfteBzxcyCrTBrcjD
	PghfbISLSlryX03y9fEDS+7yPqUGvw2KSMWIDOVlLq0Rb+7yVMZ1tzGUc/hteTef
	uDkx42jmmYMfB1vAphyFnFNy3IhIYLkn6EGV9hgkUXgcllOGTaeYEdai/JJMthYY
	iUNGs/y6ubCFzOhxOxZFuOblBY7i3nUm09fR3frrsft9ReI95JgVnks2vXjg/qBK
	Ehqg6Vdd7EzvjuULw/izxWOdimbf1fH8Qz5OLS4KfRaWk88qg==
Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.10.52] (may be forged))
	by proofpointagent2.wolfram.com (PPS) with ESMTPS id 4ht0vwh8hq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600 (CST)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 389297EA0
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 389297EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1794390383; bh=2+FEW3cT2DCiYzPpp9vEq85k9jHESll5/5oGdQhB2/8=;
	h=Date:From:To:From;
	b=RP4yWGqjC8BrXmHz7Ah6RNpEHIXyzwQJiL0Ix3sku58MHcbqwQuYPesZVQFsAtvvO
	 ywvj5HoJSpQ5OctdB/K8yxY7hSiES5jDGzuw8B4fShxYt8Jw5HS5gJ+Yu4Wrgnas7y
	 e2rqo8DSq6iHM+fHnBQN5Y9PRfVnA4/tUTHKIVZI=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.205])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 1EA9D30004E
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:30 -0600 (CST)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 32EF534069D
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 1302C3406C2
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 1302C3406C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1794390383;
	bh=+O3lZ+f2Xb3286vGXAmSL7JkS/qUr1lDABH4HbZuLTs=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Oz0+OLLCB44riFKiPvnkpmFmIEOi9UClFH3b13gfoSC64Rk8PVVkxjnjZjud6deKq
	 9CLqmppwc/5uyZmaSHLj9zls9AvLgqFBHUfXKEiqRPTGVzJ0q7L/OOlwaSRAWbccFZ
	 Mn82So3yib2jqfG+nbzEiaixj00y7ym0OpuJiqOJSfcbP9orTF4xGXkSGpEWtg/F8r
	 bb8Kb8PH1enABViK43Vd0A1eDxsYj13m7N6Q1rCWV4zzeAaS/je82xiLzHlCQTCGTg
	 bBgUAPbeF3QFoRPNm5ojnvz6Bp0xJgzAAlC0bqOZLcABwIGwYvBPc9lF4xVk+eU/cF
	 WnznrWLXT7x0g==
Received: from wrimail03.wolfram.com ([127.0.0.1])
 by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id PkLyf87kHHKu for <xenomai@lists.linux.dev>;
 Wed, 11 Nov 2026 03:46:23 -0600 (CST)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.205])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 009FC34069D
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 03:46:23 -0600 (CST)
Date: Wed, 11 Nov 2026 03:46:22 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1870198685.2308659.1794390382989.JavaMail.zimbra@wolfram.com>
Subject: Xenomai 3 - Closing rtnet tcp socket underflows RTDM fd reference
 count
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.21_GA_4899 (ZimbraWebClient - GC156 (Linux)/10.1.21_GA_4899)
X-Zimbra-Message-Verification: hash=SHA256;guid=YWM1ZjNhYmU0NWY1ODQzYWRkZDNmYzQ4ZGMxZjc2M2Y2MzFmZTlmZjdhOGU0NGVmY2Y1OGY0NzY3ZTg2YTczZA==
Thread-Index: +U41jSWxfj+ckO3h+XPrOBpsxYqEzA==
Thread-Topic: Xenomai 3 - Closing rtnet tcp socket underflows RTDM fd reference count
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNyBTYWx0ZWRfXyFaMNJ7bkHrq
 7DMpFUuvAjTFi4x9k9VmdB8pVoT7yd855OUXSsQSe0JoZuEk4Bt9GOjXPSNW05MLzCrFhLeTTbP
 gOqn2EsUCX9aJarwbJOq+6lYTYQ31TItgTKpG4+7zGzxEENUkCYelY+Bm3Vz1luMCTUvbejcMY7
 w8tVOmH57ZXWTFLZzLYfm9ACljBYZZkEjcqAsaBssIBqC9xfufHVNDuW5r7KlOaS3+MjFppTC0a
 nEDwvH1HHQ0yQu0SjvWmCSTQ8t2s3TOmEgZ83DTlKeTctffjj5y3Ytzv8Sx0XB6eswCnUueXX0Y
 IUhHr8iOKRVSl6IPw4qNYVcYkl1JxKxmqtsRWaC+7CpyKO7D8mTEPPX17agxM7hmuhH8Om2CI7b
 XpXTr0OVDBhsiU9uFPlUOC0bnCH1cmMXJp6Ar3sKySuqeEnYLyO6syb+h4yaO28ffZcqzCMMthV
 Tz2xcEZr5BnoEAWUnXQ==
X-Authority-Analysis: v=2.4 cv=N8G8hG9B c=1 sm=1 tr=0 ts=6af4396f cx=c_pps
 a=QIoiqM6LT8uG/2p1x/4KFw==:117 a=FKkrIqjQGGEA:10 a=zKsvO08KuasA:10
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=3KDSuW0U5VYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1TznLvf2HGhhZ3HWljPN:22 a=t0accCYvhhXVY_Nj_6gk:22
 a=n3I7ri1dMInypHW0aewA:9 a=QEXdDO2ut3YA:10 a=DRdS2jflCiEMTsFDSdXg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNyBTYWx0ZWRfX3JLp7J87+UlN
 pOMOmhERs3udQZIgVznLslvCeBR50lIkRno7rBpdzRozFKAQZP0Z+hAjXeX7E6zpKKE7MleSgOj
 x6iJsTSU/igeQixqinp2tFTn2Zytg7MNhqUH4bHViHDFV4ZmB5gq
X-Proofpoint-GUID: q8uXVCEPGm7rSa6b3YZ44JJsfZvDEoEm
X-Proofpoint-ORIG-GUID: q8uXVCEPGm7rSa6b3YZ44JJsfZvDEoEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110037

I had some issues with crashes when experimenting with TCP in Xenomai 3. My investigation shows that during the closing procedure of a TCP socket, the socket it is returned to the caller to handle the final FIN/ACK packets even though it is closing. This underflows the RTDM fd reference count and for kernels with debug/warn enabled it kills the RTnet stack. 

Without the debug option the underflow goes unnoticed but because the packet is still processed without holding a reference there is also a possible use-after-free here. 

This is the sequence that causes failure: 
-------------------------------------------------------------
1. Connection open    => refs = 1      
2. close() is called  => refs = 0
3. rt_tcp_close() sends FIN and waits for the 
   peer's reply (tcp.c:1410)
4. Peer's ACK arrives. Taking a reference fails
   (-EIDRM), but the socket is used anyway
   because it is closing (tcp.c:271)
5. The packet is processed (ip_input.c:95)
6. The reference that was never taken is
   released (ip_input.c:98) => refs = -1
   Debug kernels warn here (fd.c:312) and the
   RTnet stack dies
7. Peer's FIN arrives: steps 4-6 again => refs = -2
8. rt_tcp_close() returns and the socket is
   freed, possibly while another CPU is still
   in steps 5-6 => use-after-free
