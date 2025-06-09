Received: from proofpointagent2.wolfram.com (proofpoint-proxy.wolfram.com [140.177.7.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DB148850
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.177.7.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470061; cv=none; b=F6M69rsaU011gBrosrXR+YzqikXaivl5PYaeaMaoSR/LY7A5+pJvWf1KFHodMGRZAaApkPt5CKbQvonBSRdxU/eip8IqRbmOzwqPX8u48H3YeIef/++RWUanvW5LGGdB/O2dYZSa3u83G0HysInCSlpks8YAXN6gERWfUVifzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470061; c=relaxed/simple;
	bh=EAuzH/J3TmeDXnX+Vc61xBlI5HzKSzGz7AQ+j+OndOA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=OwvVTauUnalYgFzNvwJbDBgQKJ2my30rkWMsGoAXmzgJvFTwoYOwiSmyEes5LCPqB/31syzIXqQOqz/vpkQ07aW2Z72YDg8X+kyUN8MoO3MtuDxM0ocXEQu/CNfjXRuBhbm/AnhfRYNUi7Nbopr5vq+8C6wCvM9uoOPEaB6VKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com; spf=pass smtp.mailfrom=wolfram.com; dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=k12T1ZEO; dkim=pass (1024-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=cSk2qjbL; dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=WJzUao0H; arc=none smtp.client-ip=140.177.7.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfram.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="k12T1ZEO";
	dkim=pass (1024-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="cSk2qjbL";
	dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="WJzUao0H"
Received: from pps.filterd (proofpointagent2.wolfram.com [127.0.0.1])
	by proofpointagent2.wolfram.com (8.18.1.2/8.18.1.2) with ESMTP id 559B4Uh1030382
	for <xenomai@lists.linux.dev>; Mon, 9 Jun 2025 06:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
 h=content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=proofpoint;
 bh=0qoljM95innT4qnhr0QDDOuQbm60vBScGGnaBWRrSvI=;
 b=k12T1ZEOXqDr3zJNgZFLalHObPuRw9Ax11oclLoaePaay2K61CsprfnAx7MGJiuV40tt
 xlelOixolY3ONN7QYCvUyXCQAUhJ7n1lMKs6puhSW9VCfs6gGtMdGtLePvGqiE5shOFA
 ZEtSWT0hKDXxiZk6683F7VDkygul0H1Ye6+v94dnabEIAZa72ZXQgYAEpGhoBEFTF6K3
 nNe4cz5S0po0va0jXiz1xFgqKXKFKvonb4n+nNbgZXAtlLKQJtEasylZaW1VLdtDyMdD
 xo09CBiIj0+BNq4B07jNnzIzBTJb5fK1McEVKCc0vxlEC917IHayDpLrEuSkCt1YMB8/ UA== 
Received: from relay-ext.wolfram.com (relay-ext.wolfram.com [140.177.10.52])
	by proofpointagent2.wolfram.com (PPS) with ESMTPS id 474hf1r83m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Mon, 09 Jun 2025 06:27:31 -0500
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 33F30606D
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 06:27:40 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 33F30606D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1749468460; bh=EAuzH/J3TmeDXnX+Vc61xBlI5HzKSzGz7AQ+j+OndOA=;
	h=Date:From:To:From;
	b=cSk2qjbLw6jTFoLXY6Li+Y9tC8lg3GgCWC161ozyCzFeTHnStiACVuKBBlkRUVH7B
	 +S/9NofH76WdTkNAh+dJNN9Z1rEB+CJBQKdEA6EgKyT1Cyt3JLeOYklYD4xDDEXsCS
	 5C2HpPHFa9RSBxO1SLFZw1JAqyW9q+gmcT0TZ+bY=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 2CD1830004E
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 06:27:40 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 29165100007
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 06:27:40 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 105981006B1
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 06:27:40 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 105981006B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1749468460;
	bh=0qoljM95innT4qnhr0QDDOuQbm60vBScGGnaBWRrSvI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=WJzUao0HKIoWQXpfwK+Mey0ogkuzR1pLGbx8ixDGw5D1uaALzYwZr8prjibfw2BAn
	 hh/d1jpTCauaqIXHuSJ3TKL5vJDnnQg5PrEsr4KF96WQUlK0mWfyG8eCEX+mGKywEV
	 TzMbCSrBM19T7VVOMYKFJHgurxnRbaCekjNoYs+Fc6mj4/4gULBxkASfRFL0zwMn2Q
	 SKOhvP+EFjERROU4TLOmLUKzSlcrYZ4L82t2eFMBIPFgt3E4fuR/9iBjqLrbhMUeZ4
	 +sf7CH+CE0Py0iBIWxuNCsLk8MoXg5aQT//dGBdJArHqcx0YN8VvYnBeHzjm9vAKTQ
	 jfwR5Z98bWqkg==
Received: from wrimail03.wolfram.com ([127.0.0.1])
 by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ZBBUC5uK7Ls1 for <xenomai@lists.linux.dev>;
 Mon,  9 Jun 2025 06:27:40 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 00007100007
	for <xenomai@lists.linux.dev>; Mon,  9 Jun 2025 06:27:39 -0500 (CDT)
Date: Mon, 9 Jun 2025 06:27:39 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1461577086.484867.1749468459969.JavaMail.zimbra@wolfram.com>
Subject: Controlling cpu for interrupts
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4653 (ZimbraWebClient - GC136 (Linux)/9.0.0_GA_4653)
Thread-Index: g86pqJgTpbrf6FA+NsgcyAWZ4o6syg==
Thread-Topic: Controlling cpu for interrupts
X-Proofpoint-ORIG-GUID: 4SmeaTIfLJctxDOUc9kRTK46x9JCiObh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4NCBTYWx0ZWRfX1XFdkydD6iT7 iW2XUOPogyYl6z9vY4MT8wDLA/sDZ0gnylf83h8Jb2m2uChRB/Z7Ft/VHJez2JTVm0BeF4YyLGt bfF69c/hvXSg46WS41ZC2vu0YqS0cBLShquF2bYEvYGIVdXiUdtS2XPNjGgFyQePSKTE+yIP42K
 zyN49ce1sqCg7E4XBli6ZwwWms3+THVvw92HqKW4A0tSxoguX9ZkMhHhGsw5Fud6HH783jqGrSU Z/buJ11KBHYQyxIB60A0zUdVIrxyPRTOH6YOKdu6BWSfGRC3XlpJI37JDqui24Kt6F22Yg5NDbU ssyT6ZAUDHaalOLmwVwRcdrX2nzj0YBanDCcOZFHo7Lyf4K2qSsuBJt5VeJsMQTKCSwsMzR+/13 3RUbJUMX
X-Proofpoint-GUID: 4SmeaTIfLJctxDOUc9kRTK46x9JCiObh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=478 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090084

Hi=20

I have a setup with
- Xenomai 3.1=20
- Linux 4.14 ish
- RT Net e1000e + igb
- Peak PCAN

When I look closely on the rt-threads I can see that the IRQ from the CAN s=
eems to be coming in on certain cores, but now always the same.=20

Here is an example of my ../xenomai/irq file:

  IRQ         CPU0        CPU1        CPU2        CPU3
   18:           0           0           0   130419960         pcan pcan pc=
an pcan pcan pcan
   19:    88638780           0           0           0         pcan pcan pc=
an pcan
  127:        3215           0           0           0         rteth0-TxRx-=
0

Thus, for this case it seems like IRQ19 is handled by CPU0 while IRQ18 is h=
andled on CPU3

What is the heuristics, if any, used for decing this ?

Thanks
Per =C3=96berg=20
