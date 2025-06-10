Received: from proofpointagent2.wolfram.com (proofpoint-proxy.wolfram.com [140.177.7.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3723C4E7
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.177.7.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571216; cv=none; b=kGMJuK85c+YrdtmMCdC8lOzXo9BtVXp4om/S2e6ADF4rZ0Ds9TRSLXX0rva7A2nj0YaxY0XGbIL0JGGskbJD0lxBKkkBCiAp3dLiVq58rDmnP6vqMnBjmRUYelYq7NctmriNZIaR83+4ub176r+7J0oTdFDTWFZ/+2shUXeOPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571216; c=relaxed/simple;
	bh=SL8Me/ftz2rR+g8nW8XPo9ZILkxWMacVtBvMjVj9S8I=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZLDnWzNNegUu+61k4ZVJNNHMIFnQWKlkeq+n4lDFEVMdzNekzPvzWl9QmjBcl0Vhy47+cdK7QW80q6k3NhXLq+i2fnS2qby+4t2m9sUyTmm11OyG5tlgArzsqZBYd5n3YaIZKjiAVaU4/j77UrdshU7brz0gvgfTKFNdDGSpxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com; spf=pass smtp.mailfrom=wolfram.com; dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=S0OrvpEX; dkim=pass (1024-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=00LlAbUE; dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b=hr5Tf5dw; arc=none smtp.client-ip=140.177.7.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfram.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="S0OrvpEX";
	dkim=pass (1024-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="00LlAbUE";
	dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="hr5Tf5dw"
Received: from pps.filterd (proofpointagent2.wolfram.com [127.0.0.1])
	by proofpointagent2.wolfram.com (8.18.1.2/8.18.1.2) with ESMTP id 55AFigle013533
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 10:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=proofpoint;
 bh=Y1XyvmxpZulBqMaPRYY/yZoskMuG0nKJC0oL2GS9BS8=;
 b=S0OrvpEXuuqQXQLISH3xTcoHQFYhsdZ6GvYkbF9RLPzD3mQVWjiKlH0g+7iS9GpHb6YC
 fcD/GUVZAG/+P45ptvLEHBtbcwMP1pw0As/dyHBLIHQ9V0Yt4ljpRpkY9xxiVB0P2069
 UrLD40LhQV3WjVw01wA0qr0jdN+Y1BchwR6PKnlJxk++iKQk9aLL9zM6cqdgd7OIBfuu
 QiKn7eVj5q3sOOTkybEEg2YRA3vWpM9enSib10x5Lvy7dbaMsuJJizKyLqN5RoJD2TQl
 3O8pD/KhnXmvoceFRyZ0/qIBNtupDRCfQmzJJeXVe8TbyD6nOPrrF+x8Zrv/tevoGP6H mQ== 
Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.10.52] (may be forged))
	by proofpointagent2.wolfram.com (PPS) with ESMTPS id 474hf1ren4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 10:59:56 -0500
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 828D4606E
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 828D4606E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1749571205; bh=SL8Me/ftz2rR+g8nW8XPo9ZILkxWMacVtBvMjVj9S8I=;
	h=Date:From:To:In-Reply-To:References:From;
	b=00LlAbUE3xqXwQR8AXperTmVwFkybP75LqCoo5wPIitrvgRHDJQyeqm/MAOaWAkEb
	 HD+2m3VDWGpX8EOfHHx3FiA0HL15Duiz7w+AyjkNvbOsaTOILJ2vy+UvWT5xIgjJ3W
	 zIvJCd7bDvB53ixd225BxGKWDUCBGjYITKZBPWo0=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 7ED0230004E
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 7BB871006A4
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 657891006A5
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 657891006A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1749571205;
	bh=Y1XyvmxpZulBqMaPRYY/yZoskMuG0nKJC0oL2GS9BS8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hr5Tf5dw5ATfcVbcXwm6EZ192Bv2K+Pz7CTUv5iMb58rxvXZN+5gEDpttJPg5AzQd
	 0mirbAPfMURhqUNk2XK9yic3AqaOwO65OByZtnc7+hmddLU2fRNDA7eL7x3Stt2xqi
	 QLWJoL7BESzp4xlIkTc+PNizUR0Hmp2Xm2YmOI7zdTa3QNaPbbKaL2taFtGzbMAiVY
	 BqhvhATL0A7qaeq9ZIlEXetggmMybOhjQoYkEAtr2NfHDOzqhZTnGfLXTyHlX2+7El
	 p5m1z+ha82zvOts4ROFkMffdG9t+9bJdkAdn5BOabdPwjml4UnLmaARNwj4Jy1G/0x
	 ezFAEOnlHGGiw==
Received: from wrimail03.wolfram.com ([127.0.0.1])
 by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id eSR5AnX0IZ9T for <xenomai@lists.linux.dev>;
 Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 56AD91006A4
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
Date: Tue, 10 Jun 2025 11:00:05 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <681487015.1166416.1749571205337.JavaMail.zimbra@wolfram.com>
In-Reply-To: <0f7091b9-5c6f-4c44-8919-8e8c7e21913e@siemens.com>
References: <1461577086.484867.1749468459969.JavaMail.zimbra@wolfram.com> <0f7091b9-5c6f-4c44-8919-8e8c7e21913e@siemens.com>
Subject: Re: Controlling cpu for interrupts
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4653 (ZimbraWebClient - GC137 (Linux)/9.0.0_GA_4653)
Thread-Topic: Controlling cpu for interrupts
Thread-Index: MY/sLFiMyVBgz78LdNw+RLX1d44HEQ==
X-Proofpoint-ORIG-GUID: 9IbkSBV5JO7OL1QZkqVXeSX1gn3n5i70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNSBTYWx0ZWRfX77If9gbDGNrv G7Z6F//p5R9xrFg2bLFMenlfUog4qfmjKHDSeN5RG9IbRaWjRJifi2Ytufeao5ZTlc1rByfOMUA KbdKlyr5rUzgCUMhl4Lbk1TX6hhf6F6H2e7GxVBy6/Xc3USHLyxXub7PunE1Ml0vMplshxAGtlx
 nC6QWWpR5oHEIueK59LJbPmy0/Nc5P+mA893Yyhq/NMRNZ0UqtgTOwhkI45dpUcHTEbh1m+9qm4 zRUKq+oWvE0CDPPkqI6OwN+up07qZezIMTJvvEDbgWXPeYGYSNseiJvouPPQlj7dbAh+JyaDb49 vBvnU3/fAcrqj+S96NMUhWMluSaL/lJHgxoWhSb2ThDWfjtuV2hFdeF5/LaU8ApexbhGC49MUR/ 5SvCl9G9
X-Proofpoint-GUID: 9IbkSBV5JO7OL1QZkqVXeSX1gn3n5i70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=715 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100125


----- Den 10 jun 2025, p=C3=A5 kl 16:09, Jan Kiszka jan.kiszka@siemens.com =
skrev:

>> Hi
>> I have a setup with
>> - Xenomai 3.1
>> - Linux 4.14 ish
> Ouch - dead horse (kernel) warning!

Thanks, yes, I know. I am currently debugging an older setup.


>> - RT Net e1000e + igb
>> - Peak PCAN
> Standard Linux driver for CAN, right? This is at least my interpretation
> based on the irq names below.

No, actually not. I should have said. It's the Peak PCAN xenomai driver

>> When I look closely on the rt-threads I can see that the IRQ from the CA=
N seems
>> to be coming in on certain cores, but now always the same.
>>
>> Here is an example of my ../xenomai/irq file:
>>
>>   IRQ         CPU0        CPU1        CPU2        CPU3
>>    18:           0           0           0   130419960         pcan pcan=
 pcan pcan
>>    pcan pcan
>>    19:    88638780           0           0           0         pcan pcan=
 pcan pcan
>>   127:        3215           0           0           0         rteth0-Tx=
Rx-0

>> Thus, for this case it seems like IRQ19 is handled by CPU0 while IRQ18 i=
s
>> handled on CPU3
>>
>> What is the heuristics, if any, used for decing this ?
>>
> /proc/irq/*/smp_affinity apply here, at least for standard IRQs. If the
> mask is containing more than one core, it's up to the IRQ controllers
> and CPUs who will take an event first.

Thanks, what would be the corresponding place to look for the RTDM stuff ?=
=20

> Jan

Thanks
Per =C3=96berg

> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
