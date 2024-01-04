Received: from se2e-iad1.servconfig.com (se2e-iad1.servconfig.com [173.231.248.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FB2C1AD
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtxi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtxi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rtxi.org header.i=@rtxi.org header.b="LGALv6VG"
Received: from ecbiz330.inmotionhosting.com ([69.174.52.25])
	by se2-iad1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.92)
	(envelope-from <ivan@rtxi.org>)
	id 1rLSYU-0005tK-LU
	for xenomai@lists.linux.dev; Thu, 04 Jan 2024 13:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rtxi.org;
	s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:
	From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1gE1yBLw+3uT7sVJ+RKM58rt9n7RiiYmehiOyRSszEQ=; b=LGALv6VGQh3MWVbcky+SFOk+k4
	NdWp15kAxkwfBDWKV+VXYaU8L0e7obRTcY4FH16aRfd4RG9FmFrj0x80MrxOoOyklLoA7+WEDDA4J
	G5AVeEiyHrzMqoSEO2odHP20STXOsKgMiXS35YzYJ59dh34lGnhjEXTwyY6DFtoaYj655bUKd4HsU
	xi6sYs3zHYASLIOpob86JTUSaSlhF4scnOweuFOsLnOR3eu0FpiTunj5J1RcXVM1or395dcZwovG8
	IXZI9f57DWm41/xxBX+2E0NS7K8xQATyugyRAh6UC/GXb4DNUp6dJxM4QR7pESdifrBdD8ncTPpKi
	Qitb2FEQ==;
Received: from [::1] (port=47690 helo=ecbiz330.inmotionhosting.com)
	by ecbiz330.inmotionhosting.com with esmtpa (Exim 4.96.2)
	(envelope-from <ivan@rtxi.org>)
	id 1rLSYU-006rbC-1F
	for xenomai@lists.linux.dev;
	Thu, 04 Jan 2024 13:34:58 -0500
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 04 Jan 2024 13:34:58 -0500
From: ivan@rtxi.org
To: xenomai@lists.linux.dev
Subject: Troubleshooting x86_64 evl bootup
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
X-Sender: ivan@rtxi.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: ecbiz330.inmotionhosting.com: authenticated_id: ivan@rtxi.org
X-Authenticated-Sender: ecbiz330.inmotionhosting.com: ivan@rtxi.org
X-SpamExperts-Domain: ecbiz330.inmotionhosting.com
X-SpamExperts-Username: 69.174.52.25
Authentication-Results: servconfig.com; auth=pass smtp.auth=69.174.52.25@ecbiz330.inmotionhosting.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+j3TVrBpJ5lk/W8zwQJ8crPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zM2Yn+ifXDUaVfcH2UdAod81AJ1TFUyPPWZD/fbWINKOfH
 zJ6mVE7ewsipSVIfs4bPi0IDeehX/cPQ4kBHJHutABHVTw1lV42ob3hDgXVUNRrZmhutlYgqreu/
 P9NI45012jOF85Kv6fCAxgcD8ltX/4AbSqvPcE4Mf22yV3UtxO3om1NOCXE1kCr91rpFr6RREhX1
 G5l4gTrHkGRbcdkkIyjbFUQY1CUernJTO7qkOddCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrU
 Vh8zaVyj66M1yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2ggTHzfqZI
 wwACW9bQ+KDdJhsM51Mye8eo6Y/hXEFbc9MIm4qZ5/UkJuZ+By/rOgnAAKmW7SISmwD3O07KW3Zh
 YDkW7+erWZ92q8bI/tBEya5tuBWXiK6eoWgQZnNLL6SbpUc7peFeo3eDQNYbhOKhzzgqmaDn5SlD
 Y9mmtv6e91aWBLor1oCWetcUjeG94V2X9RE7RRk84bvCOEz/JFkauu3R+df48B8L04LBNSk3CpUX
 2w3uvrp5n/wAQu59zaGd4eMdkbS2AbnmyVJ650k8g+EZ+xa5w99YhGFBh3nFUeexX4OQOI/UQ6jn
 FfMBgzwOZG1AF3tjVCOYSvrlAPJ6HvG+iTAXJjEOm1NgW9/nMFsrUSvDfpbfkx1WbfKbU8vq3ZpN
 xqNnBZNb4nRBWIVUzQB1KT12Lizbcb9tznR5BwZRXxKF5tPxTxfD0dMN+t5ZuBhi8RJN2CjoQMUr
 V7W3HTheMPxghFsjIwINNqkbXC9jT9hNB2s3st5Cg4aBbZWErw06R6bxmsiw7FImj0yCexflwisS
 BvVzBIEQ3WlqbwrIW7Iogayn8ZtRCzzW/RGgORbv56tZn3arxsj+0ETJrmRCocjQL9Td+ZGFmhHY
 C7qerIw4sqaimUdqGlIukNkaetx0sURKiwK/GWoRdDl1+vY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@se1-lax1.servconfig.com

Hello all!

I have been trying to upgrade a desktop that used to have Xenomai 3 + 
IPIPE to the new EVL system. Compilation is successful but the kernel 
hangs during boot with an rcu error message followed by a stack dump:

rcu: unless rcu_preempt kthread gets sufficient CPU time, OOM is now 
expected behavior.
...
Call Trace:
<TASK>
__schedule+0xd76/0x1950
? sched_clock+0x9/0x10
? sched_clock_local+0x17/0x90
? inband_irq_save+0xe/Ux30
schedule+0x69/0x110
schedule_timeout+0x19a/8x2f0
? del_timer_sync+0x50/0x50
rcu_gp_fqs_loop+0xf9/0x470
rcu_gp_kthread+0x15a/0x210
? rcu_gp_init+0x640/0x640
kthread+0x12a/0x150
? set_kthread_struct+0x50/0×50
ret_fron_fork+0x22/0x30
</TASK>

After some digging, the evl page references possible issue as "loosing 
the tick device" but don't know how to confirm whether that is the case 
here. This computer uses an AMD Phenom II X6 1035T processor and The 
kernel branch used from linux-evl repo is "v5.15.y-evl-rebase". Any 
suggestions on how to track down the issue?

Regards,
-Ivan F. Valerio
