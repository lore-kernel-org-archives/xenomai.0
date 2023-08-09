Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC211C98
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:53:58 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [217.70.178.230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E3612C3763
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:41:58 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 91FBB240004
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:41:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::616])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 84E657803D0
	for <xenomai@xenomai.org>; Wed,  9 Aug 2023 11:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/CMvisrOMu6DkZfaeqY1Lp0SWgGZ7mGGYC7ilLvdR3ezp0YRzo1LHBsJqDjNQMx6rVbhGbMPmco6xG4b+oatSR0DiWggy4zqO/WJRDH1z8OoilUfgZ/7wLIdjTC+q4kJOz7F05C6lHuOmnYGQpz0ejLO2TEJThH3nmgUAg03bgXYUpRH+eq+Asatz5tM7K74SXljCgg55/qoiV0+PawU1WAKTqGXXZ+sbqx1eF9JXLTInPwSmF6cZLx4PbZ9zBPY5zYUm5puFm3FzEtpHrNsgdi/MehVNty7uxxbGJRdodPf0dg9+QjSsLk1jZVnWyz3X/WwcxXNp6n4JQBu5UgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6vx2JCXbjgLkmPKOe8oe2v/qllpLrBtJa5NBhRdYlc=;
 b=mKj8Fgc/Yiv3DezZM9/eiH7hjD7UDL3b4UuyjR+6+ar6W0eYOIBlSwAUJUJpNgckQ3irRS9Fyjn0QXnyLf4X9mV10VCScjAfsry0lFDANr6H7usxKBz9iBL50VS9/PEDDedQ3QytD7VmCgz7avvTnwVs9NA7+7k1rdSW0hzfm6oboeZeA60W3HKMkThSoyCVNZVk6dlQ/jwOu5dWoGVlUvgY0c/ynvrCnXCOj/3pdR72W91S9kvNTO5NFrz0pXrlFzjPBqmgdyEljySKzWH3VmZLPVtsRKW8w/+ZxzatTuC/ogrGauZzDyEZGkF8wUbs0Q4kyk4oiF7bb3GGQsXPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6vx2JCXbjgLkmPKOe8oe2v/qllpLrBtJa5NBhRdYlc=;
 b=fH6fYgR6R01MOJtErHhESe+mzsEyBGFAAwAse5JPlpipu1g+fdu4Y+BL12USguQXW66+9T+IIzchzuQoYn1+QeT0Z48AqNrNelPUprGNP7/Uag6kJEmOmpZKgh0/1nuhHaShOBrz5bmug7EezDEPWQ1IxsIeusnXR/uIb6lPOJcpAFhEwPRS0sCVkDxBliqOV39Av+N3KH7tFM5fVj9ozZ39xXBHVfiMO+6/bIgo+zs7tf8DVvIvLjc1zLu6SOIbFtEaVrrZlAQxK9XKyVNw18zncLOu/Hhd+BNkt9fRVeraI0+YsWYud8enHfUl1aDOvMrdI7y7TZ7CLsZ3XLbAwQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 11:41:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:41:49 +0000
Message-ID: <aabcaa96-f667-49d4-91b5-ff6be0754f34@siemens.com>
Date: Wed, 9 Aug 2023 13:41:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: XENO_ARCH_FPU
Content-Language: en-US
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org
References: <1bfb1-64d35980-3-66457a80@79680774>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1bfb1-64d35980-3-66457a80@79680774>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: b7850b20-c3cf-407d-c434-08db98cd9de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GQs8utKU0QL3MrN31FF7c1dkXm5CE6L3wEtiddMuidPgQ0w2/fPywGt09E1gA+hL+kZaV394UmfFuPGLFvMUanWKW67vMhWbArmtgufVLmVuiSPBFi574Nu+ZXo4PDjbUOvQoGsjm46XyR+LZ/y91rGnzpamCg2m/c60Naq7V0VwlnSZYpd3xKgyer/dG2KEq3905pThTRDSbHy4I9cEGp9UklnhNsqvXBvyqo7VNKuP7nExJMaWuT66xxR7/3NtaquNBhUYZ2TjHCnEafZz+UB/ruMwReyY3m6qRDQgYFzA5AIdxGbpql9lJtIW8/d1vq9LvgTcOETnA6hqLVDkBc2Z18gkDdEKqX6DHLE/m+0/opSqE+7sR9oAqlXDzXCWXx+NaHUZHbLl5d4fTT4S26W2ksS+vxcHEullAw4PbtHz8sOwoaAbLykghfhmDNQfpyir0ujoLHj91eafMvRVriztQcReQtfeL+fuC7XCeJ2xaITUkCAIRqjzvp820lmNG50ePCPC3GQ2W23UOeuopsO7FLYQcMawUVbO3pv88wieD493J5DkvByXBVFunVcyY2rtNXUhbsEAPOtnXcGgVE7IIeZsxRjAvFpuak6lI62Qrw7jj3VgqCoVRsHMtdHlLBYPFYMBLA79itj+8wz/fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799006)(451199021)(186006)(2616005)(6512007)(36756003)(4326008)(316002)(82960400001)(6916009)(6506007)(478600001)(86362001)(66476007)(66946007)(6666004)(38100700002)(66556008)(6486002)(53546011)(31696002)(26005)(7116003)(66574015)(8676002)(8936002)(4744005)(41300700001)(2906002)(83380400001)(5660300002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBvMHVqcnZNRHRiWHB3YjA0ZWY2Q2xLNkhiWW9jWHRQN1B6QTQ3ektHVWs5?=
 =?utf-8?B?bFk0WjIvK2QweTlUTmlTUFJGd2lYUUovRnRhQ0VOQnl6TkgyaWFVYmhpOWVx?=
 =?utf-8?B?TFhOUXEzTkJZQkdwMEpQaTRxVjFHY3hPSVVBYlNINjFMdVV1YU9ZUzc5VGg0?=
 =?utf-8?B?eklJdGFBK2RrdDhXbEp1YzhPamJKUS9rb3pPQWNiaG4xUDFDYmpsKzRWUStI?=
 =?utf-8?B?Zjd5MlZud2J4UzQ3ZzhTRHB1eU9Rd01NVjhlUEFkRVh1SkNXNjZKV1RYQVBS?=
 =?utf-8?B?M0Mzdkw3eEVhaXV6bjd3SzBSekw0TFYwMUVCeWdhMEtsQXB2WmlUaXNoS01I?=
 =?utf-8?B?aXZneFVxWHQwcjZrL3ZNcnJkb3MwQ1Y1a1c2RjJwdVN2KzYxci9Md3REOWlO?=
 =?utf-8?B?bWQrV3FFbkI4WUxPRWNHOFBINVFiVXhUaXRJZjBpNjhONzRIZTNEZ05vK3By?=
 =?utf-8?B?Wm4xb1hVVTBUSFhrb28zSUVvWWJleE9JaW9VSEhuTzEreEZQM0VWSWU2K0Yr?=
 =?utf-8?B?aHJwSW9RK2lxaVNUL3IwOGNJbTBhR3VhTE1YR2FPcGM0eVZPaGhhNmlweVZp?=
 =?utf-8?B?M29sTHZpZHVXNHY0K2ExWVJ3VFIwd1dMcWMwWDY1L3d4d1BKamcrQ0hONW9j?=
 =?utf-8?B?SXA5NTg1Z2haUzlVZDdNRHFjd1FkMWtXSUxXckxXTXQ2VjlTbkxXR2VQQllE?=
 =?utf-8?B?ZmZvejhzWlR2b1FtUEt3aGxOam9KZjVNYTFCdlZNUEllREpzVEJOcjZaY1RR?=
 =?utf-8?B?ME5sMzhJYkw4eEZtK29UdUtwYzRlVEtVbHNZbUVtSzNZbHJLUkZYSjUzWjdS?=
 =?utf-8?B?cWEzU1k1dTBIWTR2Nkx2WUEwV1Z4UElaUXl6cVFOTWlwRzBmYkhkY0o0b2ow?=
 =?utf-8?B?eXJ5QnVjZnhNRGxuNkgzelVvcnRpQjJXQk43VncxMDRjT05RQzB5ZVdWZ25S?=
 =?utf-8?B?ZjN2VktPNm5RNEUweVlaeFZWZC85VmcrSTAvSUtqc3ZWYjlISVJBUjA3REk5?=
 =?utf-8?B?WXRjc3ZtMlBpZUVENVZZalpTbjB1MitJUGZzMUYxRlhUZFJDU21BN1A5b202?=
 =?utf-8?B?SHlDMzhGTjNsUDZ6R0d6bCs2aW8zaFFVc0NCOStWVmNCOTJHWFRjNXphR2lR?=
 =?utf-8?B?akJ5MkxySXZDb2k5RjlPWHkwVUFQdWhyUUpjemZ4eUV0MEVzdTdhaUc0cVlX?=
 =?utf-8?B?UW5KUDQ3U0IxYUQ0eGdYdnY2RjI1UHptcHZ3RWJaeFBSa0Y3azd0bXpBalJO?=
 =?utf-8?B?TUNxREhaUkR6dGl3THp0Z2ZWcTlmQXl3T21yVmhJWnd4L3dvZTNXWmJOR3lu?=
 =?utf-8?B?czNYSkVBWUl3RDZxRk56NUZuVmc0Um5MY09KTFRhbDU2ZVhIR2dYdFFFWlVE?=
 =?utf-8?B?dUJWY1R0NzExR1ZCRnZIN2x5K1g4L1dNdUxKSFBidzV4YXUyVmxXb2FTL1M0?=
 =?utf-8?B?Q2tqRjgwbnU4VkJsMmRjUUFSVHhwcTliVGw3VUYweHVKbmRHVFI0Zk45UjVz?=
 =?utf-8?B?d0FRTzg1c3VFUTQ1aGhPM1hLSnJZdnUrOVhHd1pUWXgwalBJK0JOU3JlcCtx?=
 =?utf-8?B?SGQvMHZyeXR2Y1NxVTRZdUxaVmJUalFrcW53cldxYmJWTWJONTlPYzZCQjMy?=
 =?utf-8?B?UVVDK1c4RzUzc0tIYW1wcDB6MTQyNUNubnJ0ZzBEbnJGNU95UjlyU2RPcFV2?=
 =?utf-8?B?UUlOekg3cW1qazRsVEVSSk1RdHJYQjFIM1Jibk1EckQ1cllRc3k2ajVrV3cy?=
 =?utf-8?B?eXd3Y2RhenhDaVZSeVpyTHVKcUxzZWNmazFUOWlNdE9QcnEyLzFvV1RSanp1?=
 =?utf-8?B?VmduRkdUYTFNaXJRSDVDVjA0Tld4azA0bkRuWXlHYmtnUGtnSGVtVWUxUUtS?=
 =?utf-8?B?UzJjUUNRbjh1MmNJRUJST1F2eXhDMXdRd3I4dTd3SkhXdG9yUDB2MFNYM2t1?=
 =?utf-8?B?ZVJVQXVucXo1NDYrL1BSTTlTM2dUcUU3aEYzaWpmZHp5RC9GbHVBb0JZR212?=
 =?utf-8?B?Q2JyWVpwRjNsU3FGQWZGMkdwcXNEeDEvNDRSbUdIZ2xaTm05RmNPbUJ0ZFVJ?=
 =?utf-8?B?cUpQRVdxdVB0MHhiNDhRSmxCRnVKaEhnYUFwL3FlQWJPcGR6WFFpc3NNQmZO?=
 =?utf-8?B?a1JUUkdRNkYxM09sZE1VaHhZd2FFdGNNUnROR1MxQkdubGpPK2dtVG0yTHpn?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7850b20-c3cf-407d-c434-08db98cd9de6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:41:48.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFO4l0/8EhoNd9Vn8zpIbvSyXzszhnuQgQNy6YhDs0HhWQzrfDWQa+dWbTnswrGTppcOlVzq+w/SvkUhH+Claw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6936
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=fH6fYgR6;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0e::616 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 09.08.23 11:17, François Legal wrote:
> Le Mercredi, Août 09, 2023 09:38 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 26.07.23 15:39, François Legal wrote:
>>> Hello,
>>>
>>> upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have a build failure on kernel/cobalt/ipipe/sched.c :
>>> kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration of function 'switch_fpu'; did you mean 'switch_to'? [-Werror=implicit-function-declaration]
>>>
>>
>> What is the kernel version you are building against? It's kind of a FAQ
>> by now, but 3.2.x is only supported up to 5.15. Newer kernels need
>> current master / future 3.3.
>>
> 
> I'm usign 5.4

ipipe-core-5.4.231-arm-6?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

