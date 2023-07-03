Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66C10780
	for <xenomai@lists.linux.dev>; Mon,  3 Jul 2023 17:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RStMsnYAV9YAipZcSMM5vtzw9KYF4sADskSfGZQmW9a0uerzfunWg1hrd45/7LZWjK8uiTVigZ/FTcBzh/AiVJnS3v91yjK63zjKyIhJfHehj2SNDj28osAKgJM6ZiapvteKJAbvh2J3XJjSF2dC0UxazywGdOWOInbuTkV88HpzjRo+EoTLpyfxjQarUX2DBs70FsxJZtuUmTG47LzlerqBksWXjgAV53OdSJMk61b1uYFRFOOZV422BqbABvJOlh/XUoXgY4fHKZDKkRoOwIonjKdxWKDmkxe21kciHjsDstH2Y/cyILnLtR/UbxyT8wGct2pVXB/LGM9TPZpLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYqlYZ/Qe7Bws+6fHuq4f2MqNTIJMBrkRXHMMRN5tzw=;
 b=C1bnKGMIfztOUbzAQb0SSsNY+29cYMYSSSa+fiq93GlFuxOM1WxDmOJyG/UJmELvgS3p8rOV/h7mKrgMxY9YibHDS2QQmg4w6Qk3PKTZUeO7A0/5CK8bgTddXGynsBFpeExbaFiURAb4EVllGNLedl27V9LP5L4Vc5sQg4wdzOpyMSV+Mo3BHm5Q9t4WncBCcgnNmtlpUWTtcWNrAxs1pMRnL2HB9rDJ/qm8RZpDKaDYJ30ohtkv5ISWFj26mU0HosFM0Dz1yEKbHfP9G6M9N+3jgkCMpkruorBMbcR/t4ER1+Y1uEVuuyArDNubOV/MLFQnd2HeWFtweZIgzxSojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqlYZ/Qe7Bws+6fHuq4f2MqNTIJMBrkRXHMMRN5tzw=;
 b=ckNXXgoT2OdibsilrlWKSdvHu/OLHNYigiw6OLA7DXXycdGrNVM3l7LM7IRRK5yZhympkivIrMXVgI+4qMzsQP4TnDVf4hjStM6CsUyZFCkVV00KMi+RziHOE+CD2kJQ/LwIuAqDBmTCI0lW+tOoZ0UcePV0Xee+OTfDJDntRnQWABQr3Re6zML4gAsWhWjcz4QQ+MgAcLQUuU9MmUuOakimAT/L10ulJZoIchJNWXdTrPrPgc3HO92/GsKuTUmdsfzJMLvAtdL+DiCdRjMV6SqFmI5ZlF2cL/FMT7gwa89SdchIDVt9ECuL6Lgj4RQqr1yptOhalfR41mgmRww71w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:46:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 17:46:43 +0000
Message-ID: <73df2266-e106-3114-148c-e8e089b6ddc5@siemens.com>
Date: Mon, 3 Jul 2023 19:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: ? page fault in xnthread_switch_fpu
Content-Language: en-US
To: JerryJun <jerryjun123@163.com>, xenomai@lists.linux.dev
References: <6ebaec16.1fae.1890aef455f.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6ebaec16.1fae.1890aef455f.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3329c58f-8f8f-460b-733d-08db7bed7694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OL0zFQYS6lWM/uPVecsgJyz+wSMEqrQvmQO2wm1NmbGzZVkNeJbLQdOgH6mi6BiEVxA8QmF2egPm/esyQWB1F9Cbj3WI/RSJqXW502/FOK95bZq7jyPvl4UyUzkz+PY0/Osm20W0Mk9RpABuy360eWUA/UDd9j9a2Q2Ri6seIJPz3cmnODGKKhJNz4MbzdS9yr6I7zBGbaPflomzymqU/nzuW9KuytOmqneapm9gOGMVQNZswSbldPzLLyCM6Uc9c+Weh1dOIeil1U5VQIlF2nYma1UsnDkmxGkJgzXq5ClzQ2gqJr55FQKesY0qIvfLQD8d6qBrKh2Xv03797/EJrREk3SvwpPbu42z6RUqZdLb5o6aKiGCf9hxKnCMbLj8xMFha2Ygyyo51nXeSaBIKU1xtCX7ay7fCtiN2l5MeYm6h8f8MNKfKOFVzXxEsu9ILIz9qfDBfy34TlT4Ra/A0D/CCj5BXqPf2ueyA/VPcuiPh2pvcXLxyzZCDGeMIQZ+Hz5ssJr+yZC+g9HZkRoQI+7lrYoI8wsRXcaWM/nUekKo+uifS2Z1RFtPdzeITpdIfLHdGAtGYImui+yYPWYuDlVQXwZRUoOweb6q3rH+XXLxXXP/ZA59dMyjIi+W4agFXPFJllt521df5Mtj3CbSkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(4744005)(2906002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(36756003)(86362001)(31696002)(6512007)(6486002)(478600001)(83380400001)(186003)(26005)(53546011)(31686004)(2616005)(66556008)(66476007)(82960400001)(6506007)(66946007)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN4YUNlTWFhM2d4M2RXZFFaVFBaaWhhUmV1ckswT2NacFdIdUZXYmNEck5a?=
 =?utf-8?B?bUQzR3libUlrU1RpLzRCZENVU250SC9PREtsRWtvV25NTUxEaXo5UTJvb2sr?=
 =?utf-8?B?ckcxZGhVOHJYQXhZNEd4d00zT1B1N3N5VkNpQm1xK1hySENQa011ck5FcGs2?=
 =?utf-8?B?UTdPRmozWmdjSUlGZkQ3b1A4M0hXaGhjenlxcHZCVXdEYjlPV2YzT3VNZU1V?=
 =?utf-8?B?TWN5dUFnVFY0UDJsOThkY2lqSlVIYkxPR0lQYXFGU2VGeUFNOGxaRkpEeStl?=
 =?utf-8?B?blZLNkFJLzl1UE9Jck9Zbkg0TkZNMzI0dHVuOW1YQnBQM2t0TlNWd043Wkpj?=
 =?utf-8?B?ejNiVU5kQzY5VVd5QjROaGxlcThZbGpiVXlKWFZSMmt3eFk0bFh5Y2VXaDdF?=
 =?utf-8?B?aFFTM0FPVTVsanJrc0x5SDJ2elVETHk3YW5VNWxzS0dpV2VyVXlxQmpRNzVm?=
 =?utf-8?B?SHdPbktlbmpyalpMKzlpT2Q0U3QzWDd0SzUzeGZocUEwdDRkb25MY1Y2MzMx?=
 =?utf-8?B?QWwycUgzMUozREhhMzlQcEJndUtSaU1CZi9ESmtLdXd5aTBzQ1FDNjhzaDZa?=
 =?utf-8?B?QWJRTnJvZkVwUXVTV280TFI0N0NtYU5rMTdNd3dOSXVJZGVxSVIxcFVtWHp5?=
 =?utf-8?B?UEtieFhTa3hEUmRqWVN5MlZsODZGS21PQnp1cUc4bjlNU044MkRoVW1FclBP?=
 =?utf-8?B?ek12UFF0M0lkQUZIYlFWOVFXRk01SWlEZ005dXJSZy9qd2Vlc2xaOEQ4MkFW?=
 =?utf-8?B?K3JHOGhZSHVodmJTeU5uMXJ2b3IvU3pIWldlSXFpNENJOXlNUlNTbnd4RE92?=
 =?utf-8?B?QmVKcEFxY1NKa2tzUU5oTFhYYWNJVzZjQ3lYQU5kQW5JYzBIMXBueXp3ZHlq?=
 =?utf-8?B?U1I0bHVaeFhvYlVERkNITEk3c01tTVpkbk9wdWhBWTdEamFmS0N3aUlFSUky?=
 =?utf-8?B?dFo1TkFjQnpscUpQS0ZidVlsdFhuVUtObEQzZWsvczVUOFFGV0hjU3NqajRD?=
 =?utf-8?B?eWlzWkZ6SUFSTVRYSlQ4d21TUkhzbkcvV0NPa1JpL1dvTHhXVExmYUhwQUJL?=
 =?utf-8?B?MEpuVURRRDlYZFVOc24rODRlVWgwbGMzWjRZY1NDSGNvQ1FqeW1VRC9jYk1Z?=
 =?utf-8?B?a29oWGFRU2JQeEZXQ1lpMVhLRWRxNmdKckdKUUcxMm5HM2xPOE1QMHg3Ujly?=
 =?utf-8?B?ZXUzMmFKSk1KRnptaDdOOUlRNHE2Z0syeG81cDkvRmRPSEFSR0FDZC9MYlJ5?=
 =?utf-8?B?b1U2dUd3dTdCQzZ2Skdlem1aUVRxV1FTd2J1dGFpcGJLR0p0em1meHI3WkdC?=
 =?utf-8?B?dkhDZVR2YWlrK1Rid3J2eFltcHl2MkRNQXhSbkJ2TkxZM01UYUs0WVhQS1hO?=
 =?utf-8?B?K2FlTFVPcEhzQUQ4enRCUDJBdlB1TTl1bTIrY05jY3JqVFJtazQrRDJBTEd3?=
 =?utf-8?B?SEU5VWNVb3NjTmdVSnZrVVZyaDRSS3NRaS92OEQzOUpXNGYzK25pUVd4dEJx?=
 =?utf-8?B?blBHbnUzMHc4NlNhaVZiZGVFeWZIb1VxbWdEUlo3WjRNWTlaRE1pb05KZnVF?=
 =?utf-8?B?dXFldFBuaGFFUzF5aDRVREt4dVlUTXh3Z1g5bWN2cjhEQ0E0S1FEVmx6OVhI?=
 =?utf-8?B?ZDBSSk9vVk5mUzV0cDdIY0wvWHBsbGFLNENFdGtNc01WV3YzbjFHREgvTVFQ?=
 =?utf-8?B?bFlVeWZsc2tQNUdrNTROZ1k3Sml0dS9oRHdBeThJYTJ6bDNoMVEvSWg4VEtV?=
 =?utf-8?B?V25kK3JCMER5aWZTVGRnU2I5aWdYQktIUGltaFBuckg1SzFYVTV4blFQTE1l?=
 =?utf-8?B?amxNU3RxOFBkSWpHcEtkeFRQNEhQSUZrcFY0VXBOOUxMSGkzZE1WWmlHQ2Qw?=
 =?utf-8?B?MFFvVjRuR2R6Tk5XWjVESVdCbEk5ZjdGdkVnSEp6N2pUdGpNRDkzak5pWGJS?=
 =?utf-8?B?V3FCNW9tRVc0Q3FtRmpJbmt0VWxHMThuK0NZYmlPam0vazdYYnFDbUNyZ0Vx?=
 =?utf-8?B?UlFzMzBBN0x2Z0I4NkJmQkJhUW1tQkh1dDFnbU9Ra01xSFhwLysycHkvMm1K?=
 =?utf-8?B?dGRaSVdsWGN6UmZObWFraG1OQjFCSEZMRFcxTUlUeHZoQnIySU84a2FqUUZK?=
 =?utf-8?B?VDFyR3pTdWQ5WHE3REt3VnRUYm5GanUrRFdXYmxDVmJ1WWhQR3c2ZVN6c0Fw?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3329c58f-8f8f-460b-733d-08db7bed7694
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:46:43.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNlMP6U4GwoaAask1bxxQpbBz3hcf2w10ljDj3BQDSKJ69XLOpHqEUtxnZgqEUat6ySUrbwwUX+MA4YcxWz8CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3665

On 30.06.23 08:13, JerryJun wrote:
> Hi, xenomai:
> 
> testing on the linux-4.19.89-ipipe-9-xenomai-3.1 (kernel：linux-4.19.89,
> patch：ipipe-core-4.19.89-x86-9.patch, xenomai：xenomai 3.1), we get
> into trouble which the kernel oops more than once ，not frequently, as
> follows. 

You know that you are running not the latest versions, even of those
stable branches? Those are 3.1.4 and ipipe-core-4.19.279-cip95-x86-26.
Already tried to update, specifically the kernel?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

