Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C120F7
	for <xenomai@lists.linux.dev>; Tue,  4 Oct 2022 07:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1+6lQR6w2k+NWziuPxyp+iQfWrfNEaZ5aVhabcRsNNgdzFC0dIfi2a5/5c4bRY1RCZwrxlYim4meqgGBu5NU0uUjKr9KMxFPL4x7iXkZLQzlhDBkWEL1478Rncbzp3cvb27vXCInmg67Puz3OauHE/hCTL1kOwnTUdLnLHI7kqBQzbEj2O8R9OwLGHKRz1ztZnPPnvoPHDOh+0cA0rhHF74cCewd/MPn7mi+WFp8LswLMA4rW/1/s06YQIVIEZfRU26hz0Qylc9U79cmx55VFXbQ7ryNFL0O3BXkWXdoBYl0aq/OyiuI/N0mD1RBsBdn9kwauDbKYvypU8o0zvl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWbvFvihnlaXML7RMlOOzaWJ0RQ9sSbzbSy6YNhi0eU=;
 b=n2TOjfFmZ0RrFxHBxomUb+ymI37jAWJ6+JVcghKejHfV9HWbFuHb/2VRPgKJ7HiT47lN8Z7kTwtsNbIbSHWndcNR3esbZ3p4Jk+pBE9VLV8VS/+SBhh3B61q5Q5KFb39fKlzJGzUOBk9eVtbIuTinE/dZmOVXSuCnieqU5+U/gOyhwGzsgd9qmCombjUt5oP3G/oLd8gph8wB6yKLSbiLYIOCnRjW0XoZxHi3JQISYpKzExzjVUmTb0a2Vu5gCc+PLc7//lf/BlkRceiDfWty1djkLIIX8OaOxqSmygCVhBaRvPnZC4UrYHeS4DkHDzcP0PK/fDdhjaNVJThDYukqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWbvFvihnlaXML7RMlOOzaWJ0RQ9sSbzbSy6YNhi0eU=;
 b=KD3l3eLLNZkf0hxGLdS/oReftjygQRRjtZ5ajyO/XVbLF0B0hO27JQgUkT8vC/q8BYCrAdMelMTYEc6jeTxG+UPqpAgrf/6h6xmQlZzvw0z60R5vV1N/XNePi6wmgSp/N8IqHNvaAtlR0KOzOEppG5HqRrUuUGrkRQ+8aQ9g/SeERBCnHvG9R5O/xu7UiwhmxS+9NKk1K+jbB18K2UAQoDYp8lxTqRPIjrHVFgc5+78jCCEPUkgekBVXFdOdKfZxjA0iCoIAGWrgyWHMj7Bmr4jAwSwh2TtPyR9jAWWOWDlmasrVqYjjFpd+Fb6v9dAML7c0RKkqQIlWW1nyQGwGCg==
Received: from AS4P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::9)
 by DU0PR10MB6677.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 07:46:48 +0000
Received: from VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:5d6:cafe::5f) by AS4P195CA0021.outlook.office365.com
 (2603:10a6:20b:5d6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Tue, 4 Oct 2022 07:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT072.mail.protection.outlook.com (10.152.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 07:46:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 09:46:46 +0200
Received: from [167.87.50.151] (167.87.50.151) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 09:46:46 +0200
Message-ID: <9a209271-dcd2-b19d-8421-283d734ae259@siemens.com>
Date: Tue, 4 Oct 2022 09:46:45 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the
 rtcan driver
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
 <20220920122503.115682-3-florian.bezdeka@siemens.com>
 <3ed01ad123d1ad28298d9ae4fca06046b24e3805.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3ed01ad123d1ad28298d9ae4fca06046b24e3805.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.50.151]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.290500-8.000000
X-TMASE-MatchedRID: EhMq+2gclHs5QaOxwNGfvo9bHfxDWoibKx2x0HdtdQGqh5pv1eDPzwD4
	keG7QhHmGcBq4eMuIsxR3ZVJbCL+bO9CQ8wc8LEOLyVaVKT0PhGrQDiWkCjx2SoiRKlBVkYIMoS
	2PLq1B74xA2L6JKHf6tnoquRwHY3BU7OH0oftJy3EiWaNVXpRKmJIEq3r88+zXmFVlObh0PxBfk
	JWKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCDzvSj1BF/M7VnRXm1iHN1bEQdG7H66TyH4gK
	q42LRYkb7kjcm5x3Uj1fZnPvCMIfTkhpwc/fOBgfYTvO9y45DV+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.290500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: E580D86BE653F07F8A1FF2D59FCCF792540C0951E44DF6CC74BCDCF44A981DF62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT072:EE_|DU0PR10MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ba8dd2-f584-412e-d04a-08daa5dc9797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KFGIKjmMc7z5x1qTWQQkW2tFyaJqrDay9eEvVjYIVJt8+udppOdyTL5iI/1Rg52OtLXNKMsUvwDP/Rs1vkh7mJaBF71yqGgDkqlFnco4f6iLKcMGJMS6530gk9qRAq77B2ICsFcAnUE2FhCqaupTYls4/uMNrgQaijW8ToEJ/ou9pOE8S+BpFKIxcPDzwT4AzgcaSEInu+6xjVFDHglkGSMksdkfr5lpNpVJDoMz5NOG4sUD6bLs2lf+nXH9zQNjALTnjnDnNJRW0nFbVyGyBntof7V2wcQcS/249Quy+6VyvvIbbu5Ya6V3GiBYoz63JSkrmVzWF4ZjvmXa0Y22HTeGXTpoKDCAZmnqEyDe6iIjm32QGqnI/t7Hwgcim3ZrY1eHQiUyJmfEdiTJ2sKjNVlY6JDC15FrpIJiSUpjnEcP2PlKeSdZScNpMHxCE2l/H8/oqxULT5NjSpePhfZqwCn35kjTa8XgVHPMDuUxKRMY+rRW2HY/w+/Mqxg8Mhiq6ySBuahhtF0VkYJJZNDB3ovvKX3oQIpoBuC1GI0EdDI/EdC+eTgPvRswcavYzX3t/e+nkGzrkgmrO5ppPuOpRB6ognfb6kekmwbwR60IbE6ayZo8ty6/B0hgq/lMrwyzdqCm4gKUCr2W9RO9CeZouvHHfdDIHNuQLaVZJ6qz1rGvk/NnyKX2KSL/s8vRYpylmvMqJiHFIEHPdYSEfKvPZKY1wJyM6ZChfPx02T7IY12mibsa/DBRR/j9WwOVaKb8Z89EiavidZ7yB2ZjHHGQht3D9UVsC3uqtnHBm6C1VMl0XeGjLJU/7gCWZHR5Qo3pK5YOlZCGo0AIdEpBiCCqn3QV6DVURvyKsUD+ULceU7U=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(336012)(41300700001)(5660300002)(40460700003)(36756003)(44832011)(8936002)(8676002)(40480700001)(81166007)(82960400001)(70206006)(70586007)(82740400003)(2906002)(86362001)(31696002)(356005)(36860700001)(26005)(186003)(110136005)(316002)(6706004)(83380400001)(16576012)(2616005)(16526019)(47076005)(956004)(82310400005)(478600001)(53546011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:46:48.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ba8dd2-f584-412e-d04a-08daa5dc9797
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6677

On 01.10.22 00:48, Bezdeka, Florian (T CED SES-DE) wrote:
> On Tue, 2022-09-20 at 14:25 +0200, Florian Bezdeka wrote:
>> Once Xenomai was running as compat application (=32bit applicaiton over
>> 64bit kernel) the can smokey test failed. This patch fixes the test by
>> implementing the necessary compat bits.
>>
>> Affected ioctls:
>>   - _RTIOC_BIND
>>   - _RTIOC_SETSOCKOPT
>>
>> Affected syscalls:
>>   - recvmsg
>>   - sendmsg
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  kernel/drivers/can/rtcan_raw.c | 42 ++++++++++++++--------------------
>>  1 file changed, 17 insertions(+), 25 deletions(-)
>>
> 
> <snip>
> 
> 
>> @@ -922,10 +917,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>>      if (rtdm_fd_is_user(fd)) {
>>
>>       /* Copy IO vector from userspace */
>> -     if (!rtdm_rw_user_ok(fd, msg->msg_iov,
>> -                          sizeof(struct iovec)) ||
>> -         rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
>> -                             sizeof(struct iovec))) {
>> +     if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false)) {
>                                                  ^^
> To get the rw check the last parameter should have been true here.
> Noticed while going through all that again to make sure the API is
> correct.
> 
> Jan, this is already part of next, do you want me to send v3 or could
> you directly fix that up?
> 

Is that control relevant at all? Aren't we always writing something back?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

