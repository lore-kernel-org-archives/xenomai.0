Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225B24209
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tt+X+CMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIVrbjlQesQUQIMLYZKb5ewNbiYonUo03DrwkZmAlTBmlB9L+ObHbQFN07zxdaKuSVGQeePG7FjqrnR9glacwAT4Bm4tNVWIB1gg+YcDkOwasuho9TtNeQWNBrZd2CK5lRq4iVTTy0y4Ekz3kzaEcp/jT61Uf009/v74d9OE6mKuWPuYwubyXa+scLvkLZVIzyDYEE0RjEToY392Pwy45VFEAf0UhY5a/ufDxR6iZBKMCDpfDBVHiQTO0bKzTF2wk649Od0qnvoz3dOq4JTXNP/kj0zPXv19ulAIxe9xCvwHbAnqpjcnn6GN/ZbIgSM+gkRqHaoYQFyG9IpW6ydbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSriCAbWiQveYYh3t9X7LYbH9tly8Oyj8uf8IernB08=;
 b=YYYqUa7qXwP9fPuAlw4wD8R0z3bPofNzroNrRQxN4mqZZA6HDfdee8fZPzchvvt77cLIHe4PHhe9e1pmMCyb9T9ZD7G2ZzDCsgtfzsf27Se/TJGBbc3lEzl5srSnpHsF1F4xsGkP1O93vzAyWqMXLQjplvUb2xd03oHL0lanTreFBwA5kNSjRKY5HmCpescmaY2k5AR6kcGlhi3hUrYvdaUFskhlDURY/PZcSACnS7dKt2m8vJLS4lwcItxAUH/5ZYVx4OTIuDal2om0GL8ZntbCpzezLDRayPUsYG8zjYiRBcLxenpett1R0C9iAxK/kyU70wJbPImIlgN0mDJ5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSriCAbWiQveYYh3t9X7LYbH9tly8Oyj8uf8IernB08=;
 b=Tt+X+CMtgAXmBV7WBegTb3p5mQgMqEiMe0qteIKEkCbvXgRCVU96f3cIAe7/RJmQXR5HbAOR0+ZeEeUfPImqx1RvrM8CJoxQ95YP3JMb0EuEAOO7NDKDx/gviQZeWGQgEnVfDOL3Pp7gHAijvHw1PngSYgd8WNogXHuTiQ0iKAmBsExG6QoSxolUN5gI/2NqUoDybvU1YO8UPEVKK5ilgDQ14BPL+okkakY4Kxpq2N94VD4lfJX6YPQWLYIZMwh9Ro7Jqwc4BOVCyt3ZqTK3uw2klWLpzz3umkrwbTto4bJ8uTvyaYi19i2C3T0tEP20y5On03aauAG/X4tUkJ0H1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 16:14:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:14:36 +0000
Message-ID: <91bd48b1-4ac2-4e5c-849e-d579ea5939bc@siemens.com>
Date: Thu, 4 Jan 2024 17:14:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 0/7] Add evl support to xenomai-images
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5468744c-9b5e-4f08-0cc4-08dc0d403ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WNjg/KuwUjxP4ZHHBM8v+tP/Xke0ypV48ml0d4TRBcBVHjg+myBCnU63shMRSlvaeN2IbMurch3hCGgwJr5d01BmaqAFDuANtPYvF4OphS3/awh5RodZwlXNtlX9UXe6FMf7PoHhz1YsRsYf4WyclHOxw3R/uF0F4vcdkvRrncVOH0ZMxS6FIjiRUxh/jNEDVKkbKoS4YFl1BJm3/4pStCbqc7BH8imqWAQDcng3GRltyAc3OLjYQmCj8qiSuZy19ZOrdXA6WA1R7iXLG9XVORyA8ypw5PCH7st0r/Jkk8slDbj4NjBfecmHlAR+WRrCjYc1GG8xxz5q2ZLJduoNzsimrzIyBOM/1vsmQZz/INeOTupwGF0GI9uEajsaPWs3kEDO30R5u4BU0WGuoS27BwPJ8Lgh4UzWChgf2CMOTbRPsR2d2dzpVKKjZMVMlczdBtVomDyXtODGUILYBVio9/wzVdOHv+nDfpoa9FixZzcBQRTz+C9ZoUxSXs1ubWRclEUW9I6+r0XS7yQSnMLCtxlSqpBMilgWJc804P4xh1ZVgTWiNdLyXGJslf+/YNi6C658dqzw1GzNML0fnXyCa5j1MYnGZlP9FYASR11jQDmw7cxw0OAdYR+bZShMvi9cHNYy5wwiUEnugjVT2upxiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(53546011)(26005)(6666004)(6486002)(478600001)(6512007)(6506007)(5660300002)(2616005)(83380400001)(2906002)(4744005)(41300700001)(66476007)(316002)(66556008)(66946007)(8936002)(8676002)(44832011)(38100700002)(36756003)(86362001)(82960400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1VwNmhTWU1zS05WYnJVd0hvUXB5UkxpWGlKbXI2ajNWcE02ZzVzSkRRYTBK?=
 =?utf-8?B?cm9waUwvMGJlSldORkFEcVV6NkdDaEYyOFcxMnZTWFprTHliYUdqZUlXTytm?=
 =?utf-8?B?eWt5SXFYZVRacFhqZDFiQUFTQlFXR0g1Z1g0VGFLNVluYUdnMXNTVmZPeUtq?=
 =?utf-8?B?Nm9iaVF6TVBFZk5KMldBNk1PdTN6RjVHWTdxa1h6T2JkMHFmTWJ3akpQcmVi?=
 =?utf-8?B?LzlNSlZhdmUrQ1RYSS9DcHYxYm5ER25LR0ZGVGxzR0pPaC9lMFlwNEJPSUs2?=
 =?utf-8?B?c1RZWjJseEVWYW53ZUVPNCtqV3hEc0tOamJ5VmNPbXZGTDJranJaZzd1TGFV?=
 =?utf-8?B?YjdzWGZ6Y1NrcG5ldWJ6MnhwTDdSdE84MklvOFlHRGIweCtMMWE4RjFqUzd3?=
 =?utf-8?B?TSsrdFlJaTI3ODduV2ZPZW1vWXZoNlNIcEdJb0JoYjQ2QUk0UGJ3SmIxblYz?=
 =?utf-8?B?UUYwa1V5aFQxQ01OSFc3VmFYMHhsYzZEbmlWeEgydlprVlVJc1RyeHpFQ2U3?=
 =?utf-8?B?YVZQUEFGekZ6UWYrczAwRlZ1ZklBclM0ajQ5ZE1iYTZZUE41VkY4Y3Q5eXJt?=
 =?utf-8?B?a3Bna3d6VFNLWXJtUUExMFBMd256WnRFRG54bVVGeDhEQ3JBZlBORGE4ZlVk?=
 =?utf-8?B?M0J6ODl2VFdrU3loNDExczVOdzl3bkNwTjNCeVRFdmNkbHdJSUpOMUN6Q2VX?=
 =?utf-8?B?SEZMMDVQV09Ya3BUcU5wWGF0bFJpdTVaTjY2WWdUSmJGeDhLdXpxREhldWFQ?=
 =?utf-8?B?RmxNMVk4UFNScHRBT1NIYk9oR1krQ3ptaWxodWFzYnlUNlRGcG5RbU9hRC9u?=
 =?utf-8?B?R2w5dDZFUzNzTS9sNnJYNTM2VUF1b3F1ZHNycFRNTXFMSGcxekhKOTZyUWtJ?=
 =?utf-8?B?U2JBRVNNY0ZjTVhpdFpUcy80c0dGYUJ3R0IxdTR1WXZZNDNyUHBQN3VMYVpS?=
 =?utf-8?B?ME1DdEE5bXJqT3lTSWVVcmIwMUcvL3lpK0tadDNRajdiNm5UUHllODJhVFRw?=
 =?utf-8?B?RUw4a1JWc2k0L3hEcE5ybGFEZzU4WUkrWkFMOEFXS1NKRVAxcGc5M2I1dDRL?=
 =?utf-8?B?aHBDZTlGZjN3WjhiMzJZYkNGWThiV3ZXRFVWaFJuZ3kyNVVtbEFRM3N3M21D?=
 =?utf-8?B?aFZlMzZGQVdkOW02U29DTzQ0WDB5ZUFtcUtGc1h1Q1Q5UmJxOWhmL2V3T2xu?=
 =?utf-8?B?RDZ0dnpCOTliWlhja1FMTDF2QWVxazhDRXFEVUtLdmpzZ0JxdFI1bDJkMGlh?=
 =?utf-8?B?ZWdNTnUwM3lnYUxaMGNneUQ2dXRxbXNOaXVUZmNncThyUkYzOFZKeEJmeXpu?=
 =?utf-8?B?QW96YmxsM0FhVjczZkJDejErWmVhcS9BejFPYURpRlJ6ZnhBMjFKMHVRNXAz?=
 =?utf-8?B?N3l3UDNiWldtMjNDY0dMcHh5Vm8zZmFGbU5RUzBQNlN5OFF2RlJmM2p5Q1lr?=
 =?utf-8?B?aGFSMk9TWWhGUE4vNjZjK0o5TVBjWWcyRjFRL1RtWUpBdVpsd0RoUGRVc0N4?=
 =?utf-8?B?dllZTFhvR2pieHlPNkRIdGZ2cm9DblVFcnRLWmJNZ3ZMeURDS3JYa3FQekhI?=
 =?utf-8?B?NXdqcjVZTWE3QlVJMk9xTU9YanhCeFFoM1FjaGIyUlJsSzNzaDMrUVV3UFoz?=
 =?utf-8?B?TXVZYWROVEtOM2NOTlNoSW13OWR3QU8xRWo1Vm15ZFRkWXN0VW1MNVpCS3E3?=
 =?utf-8?B?OGRMeUJ0MkZWUlZ0aTB4V0RDc0kzSHNwWmlXMFZPS1oyZXp2R1NXcmNwVnpS?=
 =?utf-8?B?dFNGLzM0SW1zdllQN3J2TGtkQ3c4WEoxSmZoU0lTcWtwWEJWSDVHdy9scFlF?=
 =?utf-8?B?bTZJd0dXNDZSRVN2WGRxR2VvSFE3dDhZa3BCcVRyVlFrMTM1cjlvK25ETzF2?=
 =?utf-8?B?bFZER0RmV0QyYjd5OE9xMUFudzVJUDdIRVhvME03Q0lSSVFJbGN5cHpHSEtk?=
 =?utf-8?B?RGN4VUx4SFd0MjhIVFEveDdxajlPR2N0RVgxV2VVTGlRb2hIMlFzTHZXdGg2?=
 =?utf-8?B?K1ZEd1BhbnF1QzcvZHNKZXUyR2FEMTcwZ3V5cEdoVVIydkkxazhFbk53Vjk2?=
 =?utf-8?B?UXd4aFY3SWU3eFNCbmhPQzFKdjZvMm11K2tvcGw0d002aFAwd3pkZGd0R2Yw?=
 =?utf-8?B?SUg4WkMrZWVFU1h2QkY3SnlMeWtrM240cUd0emN6Vjl4WElaZVd2Ri92MWgv?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5468744c-9b5e-4f08-0cc4-08dc0d403ee9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:14:36.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5m1gML29IRM8nzhYQKqOaorJjxy5EnTGYBcalwkRjXRYU2t64txrOF+J+nFubp0xwzy2kOkrRPdPNNse5/Gtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7761

On 21.12.23 17:37, Clara Kowalsky wrote:
> Hi all,
> 
> this is the second version of the series for adding xenomai-4/evl build support to xenomai-images.
> Thank you Jan for your comments so far.
> 

This looks quite good already!

We need an Isar update to pull the sbuild patch for x86. For non-x86,
ie. cross, we need some tuning of the Debian rules in fact (headers are
in /usr/$(DEB_HOST_GNU_TYPE)/include). That's best done in the
debianization, not in libevl. A first arm64 version just passed local
testing in qemu.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

