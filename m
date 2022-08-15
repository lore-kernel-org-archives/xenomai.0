Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A81C04
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 13:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7O/gtT+xpSZpGV3arZjehWbpL4Yu3X1VZSxnLT1fcTaUykgbXZbqSTv/RH47HzIsQN1c10Cptj4DxKHR1pLhciOf5lSA9Yzewzcpu4yGkvNU7IpHNNVHGdaa8CDXVp3sukDj2QhCSiVO+Mq0lKjpiNwsDmMApYoXY039i/MPD7qAEdyXa0DNx4QRKK9EpvKdQtlLY24ZFkR7gQkmVVdoenshkJDUPjLKZxmwXqpJal2dZqEDemSsxnyyLgViLtm0Evtn1AYPSR5grQfu5ZuSFPPo3VPyIYkrMupB0L8zGTDQmE/oDZrL8PDDdD/sTZ6+Ppp3Fqmxr3EEXTSBREfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJE359cbuIVM+03r2dAioIODzfhOgQKw8SVLbqBqBc8=;
 b=V4kXQvHXzUtHxHGmmBWZk2WxAu5D4eXSd/3qCHBNB1ClbCF75XKheNnNTUVARlxlDFiGxwFikeTNMBKE9QtugXiTIxCgRBctgUvprZV4t733z/OogMwa5iZ3y4DZmN8Bs8kDtq8cZFpI0nbHoNVw8tICIlgmiE7z3C9+pN0yVCojbMDrejgO6uEb/UF8sjnxpM4tzoXEXJExR2+/j7AyJm5XDWFHqBeBvCaqw54+gHoIDbiw1nYcBSbTqN3cAjtkZdgZ0qwbV3DjxH9i3GGX4VQciReIZaYDmnzSQV/+IxvB3jW/TLZlj6uFB+odB1cvCyP9neU4NNoRdHPlpW1ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJE359cbuIVM+03r2dAioIODzfhOgQKw8SVLbqBqBc8=;
 b=rKE5wXHro0n8VxFCvDQMf/m98A2/s8rfWAPrayauBqZEgnk4jtWUw7PhLw9E6LzsyCT9YG+hZtSFfHzN07lgsH5nbZlqF0rHctCUfUJXy5CZdT2LpFxGrRnhYOqziIBopo58kgknSIPSVfngDV9KCohaSPdwjHQN+3JUUwZeMjG7Ky24yicgcfZI84t8g93uD3moPdIQzyKl5ic4EDKjYGbhVRkpU4ZbJVD05RJFnWJeAnfcSiBbc/Z2QLvVsX0U2OisLkOOUr+GwlqSKHIMI4CFom7Du8STE67PWX9Lpy4GOcSBxP3TccpWxCJVzK1AXINKs+Gu7ZdGxqxj2GIQSg==
Received: from GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::26) by
 DB6PR10MB1848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.22; Mon, 15 Aug 2022 13:54:43 +0000
Received: from HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::fa) by GV3P280CA0033.outlook.office365.com
 (2603:10a6:150:9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Mon, 15 Aug 2022 13:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT089.mail.protection.outlook.com (10.152.1.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 13:54:43 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 15 Aug 2022 15:54:42 +0200
Received: from [167.87.14.55] (167.87.14.55) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 15 Aug
 2022 15:54:41 +0200
Message-ID: <25363307-a86c-8c42-363d-2538a0f97c6d@siemens.com>
Date: Mon, 15 Aug 2022 16:54:40 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Content-Language: en-US
To: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
References: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
 <72810e59-33db-821a-64c1-8e2c41bdacd4@siemens.com>
 <AM7P122MB022912FC857E9E50CE2B1063F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB022912FC857E9E50CE2B1063F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.14.55]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.397700-8.000000
X-TMASE-MatchedRID: SQgWp5F7Q9rPhQMrvkSA3r6YI58LYP7EXKlUkWaHqwvx5KZMlKYS/Vml
	OOES95HRFLMZ4A6MnAuWuae/q4aocaPeRHREe7wWF448p0FfPUA6eoylHdUTnX4neC0h7SADV44
	7DNvw38ZaSqvd2CpZuJUN1Bz58xm8/Hvd7e+JR82pgf1jMun5exww26fdLk2gHWRJEfGP5nkCn5
	QffvZFld/wHr/wk3HvfpbJvOkvAXg3JAgrfU42EytS3PG+1A2HW/a1GqmWl585UYVNPDbxh7Cou
	BF2/ACKS8QrgUwl2iqJ7cxjte/SmEY7rq7vfUPSj0IvV7jlqDi0o4XZVQw9jvSG/+sPtZVkqUdp
	DBnLMO3QVIVGngZv8TnoZ1nFQX1W4EGZzTsi5gI4Rn2SotNEZ6kkq/yNcHP6F+qQpCWTUjn348e
	2CE/wYoLLX3ZHA1yaXPhPm3zGFF2D4c60NJyz2F/V4FFkYid2le+q6k7Q/cwvzLls7HTfGX0tCK
	dnhB58vqq8s2MNhPCy5/tFZu9S3Ku6xVHLhqfx33fj+sMArfMaMUyeC0staEkVAPr0TXS8
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.397700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: D8C8B1EE6A4EE40628CBEA787E1A56229DB8FC923F48A24598BE94DF48C735062000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f68c5a-ba7d-4f92-0ec8-08da7ec5b4b0
X-MS-TrafficTypeDiagnostic: DB6PR10MB1848:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0lYeW90amE0YjltSVlFK0lTWXJjeFh0UkRyVjg0ZXUxTXQ5S0t2akMwNXly?=
 =?utf-8?B?c0Ivbm5XcVBWNjQzc3lKUk53UmtsbE5PSkNiSDFwSkc0MHBlb2FOMi9qdUZu?=
 =?utf-8?B?UEFZdTMvNWFuRzBqSUxmd2ZybUxBTVlVNHV0VTkzeFJlZGJnanJsN3ZYUUF6?=
 =?utf-8?B?Q01iajBVSldtZEd2MmNtRk5YUm5IQkpQd2plTDB1ZVdDa3N6R1RWT2ZrSS90?=
 =?utf-8?B?RlE4T2FjbEoweGdTRVBrclo5SlViMi95aE8zTzdLRjBLYUE5eUFOTW9HZDVo?=
 =?utf-8?B?aG54ZmxIaUV3b2JleWhPcUhIRnEvUjk0Zi9yTUFmTFNrM2ZIMHdsV3gvOE02?=
 =?utf-8?B?OTJnNWtXLy9PTEt5dmprNUtjdkpNYmVSc1BDYzl6WmJlL3Z4NnMyY1l1aUVP?=
 =?utf-8?B?dXZ0ZEV6VTF1UnR1NWZ0L25lUVFWQzNsTk1SY3FZcnErREU2OVJkNmJNQWUx?=
 =?utf-8?B?ZFRWS25ZdlBjZ1U5Uzl5NDN1TTNBVzhSeVYxeGdYZGtmdXFOMEtDS3lOc0l6?=
 =?utf-8?B?M0ZiVEV1U3VsVlFRN1E0ekd4Mk9SZitjUWRZMGdiR0tkUHdNUnp2Z2Q5OFRi?=
 =?utf-8?B?MmJTSTREVlRPeGJPZXY4RnJsa1FqV1lFbzhsekY3bGx4dVZWZCtOcitaaVB5?=
 =?utf-8?B?Q09vN2RJVUk4QThWWjdNQ25IQWEwTHBZUU45eVpEZnIrQWhKY2t6UHZEd01W?=
 =?utf-8?B?WGFnZUV1RlZYcWl3R0cyWWFyREN5M2htWnNvQUE0aFZqVDVRS2RvR1V2S1FS?=
 =?utf-8?B?a1FBelJNNkV6K3IzL1J6U0gvallFS1VtM1Y2WnhrTmZpV1BTaWFsZWp2aVps?=
 =?utf-8?B?SlZCTjRzSWdOTk9mVTNjSXlHdDRrZ3Znbnd5LzA5ZnZpRGQyMXV1bnovaHZP?=
 =?utf-8?B?NGE0NEVid0h3ckJjYS9jMm9rTGpvb0dsa2ZPUDFMMWhNUGtCcHRGWk1tSUdB?=
 =?utf-8?B?T1l3TGVKU2tCVXhHWjhPL3BRNXdCOFJYN1JhT1ZwRXR2QUpvY3dKdXMzVm1T?=
 =?utf-8?B?bEZGSmZNazBTTDJZSnVQS2o0N053cEJuRitoeWI2QzUraEUvZStTNFQ2Kyt5?=
 =?utf-8?B?WStWNmxVbEgvb0VUM3h6UGdxTnd5SGkzY0JRWXRFcmZmUWZjQVN5SVdvV1NR?=
 =?utf-8?B?YlNRN1gxVjRJbXVYVERIMlVTMTNJVVltcWY4bVcyajdEMnJzSlpZNjFFU0kr?=
 =?utf-8?B?NXlhKzg0Zm1weDg4VS9TNlBhcHdra2o4QXc2OThmckMzbVd2amx6aXA5WFlr?=
 =?utf-8?B?eWhLU3h2R1FjV0VtblQzYVhXeWd4RmtQSGRNMFZkK0VBTFdqUT09?=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(81166007)(16526019)(41300700001)(86362001)(53546011)(26005)(956004)(186003)(40480700001)(40460700003)(36860700001)(83380400001)(47076005)(2616005)(31696002)(16576012)(82740400003)(34070700002)(82310400005)(6706004)(70206006)(316002)(110136005)(31686004)(356005)(44832011)(8936002)(36756003)(8676002)(336012)(478600001)(82960400001)(2906002)(70586007)(5660300002)(87944003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 13:54:43.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f68c5a-ba7d-4f92-0ec8-08da7ec5b4b0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1848

On 15.08.22 15:31, Grau, Gunter wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Montag, 15. August 2022 13:56
>> To: Grau, Gunter <gunter.grau@philips.com>; xenomai@lists.linux.dev
>> Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
>>
>> Caution: This e-mail originated from outside of Philips, be careful for
>> phishing.
>>
>>
>> On 15.08.22 13:27, Gunter Grau wrote:
>>> From: Gunter Grau <gunter.grau@philips.com>
>>>
>>> There is the possibility that a new level triggered interrupt is
>>> already waiting when __ipipe_end_level_irq() is called.
>>> In this case at the moment when the irq is unmasked it may already
>>> fire and call __ipipe_ack_level_irq() before the masked state is
>>> cleared in the irq description. If this happens mask_irq() called by
>>> __ipipe_ack_level_irq() will not mask the interrupt and the system my
>>> stall.
>>> To prevent this, the masked state will now be cleared before unmasking
>>> the interrupt. A following direct interrupt handler call will then
>>> correctly mask the hardware interrupt as needed.
>>>
>>> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
>>> ---
>>>  kernel/irq/chip.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c index
>>> 6a883a4cee87..25d0942b592a 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -1048,8 +1048,8 @@ void __ipipe_ack_level_irq(struct irq_desc
>>> *desc)
>>>
>>>  void __ipipe_end_level_irq(struct irq_desc *desc)  {
>>> -     desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>       irq_state_clr_masked(desc);
>>> +     desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>  }
>>>
>>>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>>
>> OK, but if we need this ordering here, why didn't we need it before for
>> unmask_irq()? There, it was sufficient so far to disable local irqs around
>> unmask + clr.
>>
>> Jan
> 
> Interesting, I thought the disabling of the local irqs is exact the reason why it works in contrast to __ipipe_end_level_irq() without disabling.
> So did I miss something? Should I add a local disable here, too?

That's not yet what I suggest. I just first of all try to understand the
boundary conditions for the issue here and if those may apply elsewhere.

If I look at the caller of ipipe_end_irq in Xenomai, none should have
hard irqs on when invoking this. And that means, when local irq
disabling is not sufficient, unmasq_irq may have the same issue you are
trying to fix here by reordering.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
