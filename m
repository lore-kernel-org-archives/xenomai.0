Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA022109
	for <xenomai@lists.linux.dev>; Sat, 22 Oct 2022 06:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB5RcwKUuKX/oophyZuQBC74VOTe6jF3b6N/Xko4coK0MdNXTyIpX2xAc5BChf1GXcMGpFQwlETPV+o0I6SJ7Jl42llIj+wRnIYd7VDVmbHiqI/3odRLJaydxCdCNKWZGxCdZnGfCAUVWdIHtB9GP+uxA5I9vNGu6Csi0OTctWMlV4YH8/qg1y6sf5Ib1yS8haGe/0SApf/3BY/3kjUa6R2ArQDueKCP8mY8yf09sOEeLIcIef/d09dmG6JK9O0pLti+MvkM7N005oGgiB9m1TYIeWQGJ+D5opvzslclkOHQx45/5g3nTHGC8ol04lJf9dEB0n/w2XNmtjjkw3zThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmxq20V7InVYEhJxEqhb+Vx36I57kduXI6Dx9xLS9iI=;
 b=URbchU9lD7jVD1WEz1AKBMDzmWP6teA83oZyCi7arbVAXm4cJv0ySz+LlS+VxYZ3B8H84bWuoY+xHj/bJPtffC6lZoQNklmk64OnVYG9rjGM0a/hxa4RzGxJ3zQ4ZS56Ch6RONsdkHV3jcFyinCwhYUFoVk9QJuQRpiNfd9sK40SNKRoi1YpMSOHD2cL76Jn9Ovi0hkDkzy8UyuI1uS61bXxmTGH0TXulmP+Zz/HS+p6U5blegGDAjKx2+BBkI3xoCL7f264VkOX/SKuhIqvphSSjBoJ2pb+rkOvIbyJJ0QIKguKXQnG5lkCHQsWHdo5y7r0uMHeKx4RSCtXGoCJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmxq20V7InVYEhJxEqhb+Vx36I57kduXI6Dx9xLS9iI=;
 b=EWBN+W4g+gD71JJvVsNgvqhVIedwOrr8v400CNQT4dEDmJhS+1M52iV87DGbP4O78JLlHEL+1t351Ke098KOPgjrMoKCc3q36pfmwgYZgYu/yn/E5o+kXmrQJlEZZkx3QQMBZ0n6ifbeMcHQasa/yQaLGlnwKn9hFr2QsLqA9ALkgOnFi6Y/Ch+HSlS1m8IbN63FQFdFUsPbggnegcPWOvIeyM/1xeWkJxRGQ4s+zmtvlAOYpuc0UwtUzJ67FQ7zSls0WTBN9yGlp4BT5JHYLvB3eO9LcxuFtGgpsP7B+M413VB2vcl806uCLREInTzyoq6+7/Dufq9ddijbu0jm+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 06:21:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Sat, 22 Oct 2022
 06:21:34 +0000
Message-ID: <ffff3180-f9ec-9e9c-64bb-c2361fa94fae@siemens.com>
Date: Sat, 22 Oct 2022 08:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Microsoft 365 security: You have messages in quarantine
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
References: <5411f7c6-0202-4b69-bce9-84b32a3275d8@DB5EUR01BG101.eop-EUR01.prod.protection.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5411f7c6-0202-4b69-bce9-84b32a3275d8@DB5EUR01BG101.eop-EUR01.prod.protection.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ea2b57-d759-446c-21ea-08dab3f5aad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jsoZCUNO1D2lpEakkoG8uu+AB2CV/vMeuKlTkOa2PiPGWvqh+QzgrSpSmuU4cGmStKI8emmVaWyhppJuD0V3Nzwz9aDksi+ZUiHueSVPtBcXh8kvWo+gA9Cc/qxuml4+lJs117H6Xv/7MM13nSmjIyhGCOY+Y37PhA0Fyiy+t4nv+ch/B4msbfkBlXdPYcHJR0k8e4Q2GFX3n4NKgxQQ0yY8nWD4eWuv3KQ6KvAKfL1B6pmRZcM/MpFjpmm/r1GnfuveARLIgCH0XzbkVQ2pPpVAruIkRkjlhotOhvhLMDhcC/EjLbveMbfh+XI8hRKCvRJ4RbIDVpqcf98PMINKVymtFB1311VScYFtxk0y3yRptGUUcUhYG/MiM7/aFc0kwPIzqVE4xEPheF2FE6tHRjdwR/Xa/A8Y2cF2oyRgQGtAc1r+EXNjsecoCKualqROPKKC2QaIO5+oj2G4mmpae9Ik1XAkZscNlsnyxNselFHDQZrdtaXsCly5iSy3My5OW2PyE1Bcn5K9QMHAjix+fHiIonJjbYzoFUv1msm69jYNjojVgP0e99MI/UFGVblbgRYTb8oZsi5czh4d5dD8Ibhn/OYlxB/YMSqQrq7dsT0TH4jn7BvS1+aZhies73ELGBxL61O+yRi6yPKEMB/X0RMJg8GVdQoLl5Cd83wqzUij/MzZ49VxpX7YoCg5nThheEyAYQhspFwTONocjmWxIX84gmrZwR7XcRVjOJgg3xdSOr/YlqLc4VDcOOC1zf2GkqPFV7YBehncuHPGtYuoM9fAfHEpFiJkcEd0kzCajT+eDiBJqtlAYY2T6SqC13l8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(47530400004)(451199015)(478600001)(66574015)(66556008)(83380400001)(86362001)(31696002)(82960400001)(38100700002)(41300700001)(6486002)(8676002)(5660300002)(4744005)(8936002)(316002)(6916009)(66946007)(44832011)(26005)(6512007)(6506007)(45080400002)(53546011)(186003)(2616005)(15650500001)(2906002)(6666004)(66476007)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2kzRlRYUVNFQ1kxcXRsVUJOT3R1QkFhM1RvYmsvZjl5UzZkS2FGVDV4VnVM?=
 =?utf-8?B?Y1ZTNHUyUjlsSWVIQ0toSkpqelVDQ3dHUVkxRlNHbmJORmZ3aUkyL1R5dGFB?=
 =?utf-8?B?SEtPdFdaeDkrQmV5Y0NqTENRMUgzaTJIYVE3VFVrQzZQSHkyU3RQNkxtd2pI?=
 =?utf-8?B?YW9xNXJOaEJjdHFQYUZsV0hETGU3MEdKL3VSd0NCZ0hCeFlUY1R1VEFLSkFq?=
 =?utf-8?B?NXB4YmJpbU5KamNodERUbWNSclUwT3RZNW9FV2ZaT3FIWUFvb3Z4aEQ0R05F?=
 =?utf-8?B?TDJINlJ2bTVQY2lKelEwdUNSUGphTlhiVEx3M1dFZzJZcUl6dkVmQ2NOY2hI?=
 =?utf-8?B?WEMrM21sQldPbDMzN1Bnd3RhNnBRNHNvcUxHTDdoT1poYmRqdkNGU0dEcHdl?=
 =?utf-8?B?M2htcTVISEpZY3lxaVlrYnljK2FLZHdHaHZSZXo4WjR1Qm1IRkNaVkVCSkVG?=
 =?utf-8?B?VHhBZVZRcy93Yjk4YUQyZXFyb09xOU5hZ1VFVDZScm9WbTk5WnQ5NGZIbUpD?=
 =?utf-8?B?WHBKQ0wwVWYwOEJNU1NqNkNUdVUyR1krVE84Z3FNQmREeVNiS05JYkk1UW94?=
 =?utf-8?B?TGZzWWI3R1BjczY0STVJellLMUJNSlZIS2tjMFdPa3dlNlBUUHlQUVVIekRz?=
 =?utf-8?B?cTNUM1kvcVhYd0VobjhtSzkzcnNLRVRJaTJUZjhpM1N5V1FOa3MzTzJwVDQw?=
 =?utf-8?B?OU5nZmxEK3dQNDJoNjUrWjVub1p5UVh1VjMzQmhKenI0alo3RE5xNE1nTGlx?=
 =?utf-8?B?TWJKTGxRTWRLalo3b20xdXhsUkQzdFBGaEZ1aW9QcmhZdnphVThKM2xUUU42?=
 =?utf-8?B?ejUxOXhEM0RIRHhkUmNWTFY5QllocGlmRzVRQkpFbWZKN3RRbDZacmVoWlZK?=
 =?utf-8?B?RzRtZ1IzNDNUSU9iMzdmbGIxQy9MNmIvaEszdnVyRFRneFZxMFlZR3pqS3NX?=
 =?utf-8?B?eHJIcDdtL3RCLy90eVZyQWhqMVlBUFRFQlNUdkRXYVFFWnNMVzVXa3lRNVRx?=
 =?utf-8?B?NExpWkxqRzZGT3RQaVpSYlVzczlzeVBxbndlOW45YVlHL05zNE9iZ280ZUt6?=
 =?utf-8?B?OEd6ejJvakRCc29GQ2dmOFNwRHcyVHJPS0hoNC9MYU5GT2NhNXBaWWw3OXZu?=
 =?utf-8?B?Ty9Mb2NaVmpLc0xWNHVKaEtzeXRFbXV2Ynk2ak9TbzRYNEZpMEw4RklzRldD?=
 =?utf-8?B?UkxnYmFYV2ZNcmZpTzA5anhwek1IdjY0bFpMWHU0ZWMyVERaNUhnbmhOeVJs?=
 =?utf-8?B?RVhCTVA2VGtvVzMvSll6aXdnRm9udURnRlZlaEVhOXphRGpRSEJQYy9yY2F0?=
 =?utf-8?B?V2NRT0RlbnVZUGJTY1lWdjNlNzMycGEzRjFwK1p5U0c4K1UzaUZOa1FreVNK?=
 =?utf-8?B?eG5ZVE1MSHgzTnJnbU5yUmNvd1hiN3VQYzhsKzJiUmpQeTZNS3hhMDR3R3Zh?=
 =?utf-8?B?NnlHbk1LWmdraTY4aC9oNU5xRE9PNVlvT096aWpicUtvcGZoUEZTV0lCSDRG?=
 =?utf-8?B?TkpPMFBsQm9RQWdENFlKbkZwVlkzNFVlcFZKaVY2cnJicTRlTDNtS3dGYmht?=
 =?utf-8?B?QzVDYS9WZ1hjelRTSzZOaFBMWDBwREk0SVdqNkZtZXZiaUJ2ZEw5QmFTWU0y?=
 =?utf-8?B?UVp0aWtGVXBCcWZ6VTZwK0tiSzE5engxcXZNYzNMcG5VUWt6c0NSQ3NtNzF6?=
 =?utf-8?B?aFVOcXgrQ0tleGU3dnZRSnB5SEc3QmRlQ2h3SURSajhaQ0R4aFlpeEVWSWJm?=
 =?utf-8?B?SStaMDFRb0U5aURHUC93bVVzTDJMcXJLaXBZYzRyY3VjT0IvVDhJL3FkRXJT?=
 =?utf-8?B?ek1IQ1ltZjl3MEdvbURzd3pnTUNCSmlRSEpUSDlpelNQOUNxLzBjYjhSZm5S?=
 =?utf-8?B?V0hRR0h0ai9JZ0MzZis0T0UvQzVSRGR6Z2dGK2xBM2YyWXl6RlRqbXU3eUJu?=
 =?utf-8?B?VUpJODdTSTFVcW1IMzFXUkNHT2ZadFRoSXFyZFBzVGxIOXU0aEtCSVEyZzQr?=
 =?utf-8?B?a3VZQ3lMdFhwTUZVeThwUjJvTTR1MHRkN0dZQmZ1dmJFTHVaM3J6YmZEcGxr?=
 =?utf-8?B?WGZjVUNXbkdONktFck95ZFlWUnViQ25ja0Y2dzUrRkRQL2VMZm0xNE1EeGlI?=
 =?utf-8?B?OWNaTnJUajZxOGVQT3JpRC90emVjclRSWjQ0MEEyQjBYaUtoRHdqUXowTGF4?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ea2b57-d759-446c-21ea-08dab3f5aad8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 06:21:34.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPkEF4sOAW9YEEdO0tGSMhzZFtJ9g2YgdRvXc1tSG3/Gi8CubPHOvCSD29msz6kk4Ac1XP3m2QgcOIjg5OiKVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7897

On 22.10.22 08:06, Notification from Siemens IT wrote:
> Microsoft <http://www.siemens.com/>
> 
> Review These Messages
> 
> *1 messages* are being held for you to review as of *10/22/2022 12:00:00
> AM (UTC)*.
> Review them within *30 days of the received date* by going to the
> Quarantine page <https://security.microsoft.com/quarantine> in the
> Security Center.
> 
> Prevented malware messages
> Sender: 	jan.kiszka@siemens.com 	  	 
> Subject: 	Fwd: Wolfgang Denk 	  	 
> Date: 	10/21/2022 4:34:22 PM 	  	 

[...]

That is something Wolfgang probably would have laughed about: /me trying
to forward a message in a Microsoft-infected infrastructure, failing
miserably this way. "Tell your IT it is there to help you doing your
work, not to prevent it", he once said.

Jan

