Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE76ABC
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 07:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRXm7EDnzTldhBnSFnW1xoG8nehIdGZNWX82eh2QBLEfKQh9mA6dciUzoHA9Ncgn8HYJmLUZYqB8BJjhiNraDu7WV2t7UrWlUi4xZ4fIiFuBnZsUhG26fJoqBRrRjtqXg3dZppjx1Pyo2jW6YxJA0fMp5hiTe8Pp0PgqjdgHX0/3rN/SC4mgd++hsWR1RIBE5w8nhsiGcVS/rB7pbRq5zLtKfFWixMG16dpc+0QJf0f+ssf1DFkY/FDEksCmhj21nRogmEX0niHtOODiKX24eeZLUcvgOoryWA7dwzwwGVunlaV7vLjGs9dSnrLIp6juacdSNeQHjYdo6CAN8MCL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJI1ZFZ9WyTCHnGL4c/rSpmxn8GRGAjnbQ9DueCcohY=;
 b=HikRSUPwsN90BS9YcOBuRffarxPvLZFAo9MmBKlHOgA4MYHMxI7klZTg/j+phKQ/IhDm5nHYJFf+IFfbfFfg79xABv0pewt6cvURW7Zf8JAHiJ4SGmL6ZoLn60SfCEkvCGDQHoc8s80t+VtRNpPXOm2dCCwV86VOqXMbPFQD+3Pl6M32f9PIFRrvCiYg02a3D9kQGIfiRk7jx8yebIHGmFXVLbbbEF0nGjeOXNY0FdJ4FHIv6DKd6eR1gLnK4zj0nk/XCvesWxOqjf2wqSSBASArZ0gaYLv5qI4aAbg0Lp1px3SfEJ0hRE0qdtHlaYtCyCS/L3NYk9A0BHHyNmxhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJI1ZFZ9WyTCHnGL4c/rSpmxn8GRGAjnbQ9DueCcohY=;
 b=dvhqHPoh7xSp4QblDjkBeG/QdzftEZh1vqd+mYsIcAAMzXOdKkFuyI8DoUttEJUg9gCZHSH/aX9CqAv5hQ6Ll3W+BqqbSIS4qhJIJhZa3Hu8rh23H7PJMdVMfZZVGoUYM1BWD7wXdO2iEKvezGt9AVBNgH5bgsQL9uWE9uXX9QmppfMVUD6RuhB3iyM6MTfbz0KPCHBA4ZHxjxqIevaLD/OkocFXatDCkO1bLoKq+Evya+51Za/puiwJldTaj1bQW2ztG3VzQOg+qW/18WYfiu7YMogkQv7oBPxjSdPY2x8BhXU5SGl10VDTv+uObpZuyHYD5q4FcDnFckbGwAtiQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 07:12:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 07:12:10 +0000
Message-ID: <de7595fc-5ec0-408d-96fd-1e7bdd161a02@siemens.com>
Date: Fri, 1 Sep 2023 09:12:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Enable stable/v3.2.x branch to be buildable with
 6.1 kernels
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: e75072e1-a904-4584-4991-08dbaabac22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fv4fmi21rlXKFl5d8CMfotd1B2cCQfvZ/IccrA5CEjISK9KUXc1tAMm7AV20ophFYO6vZ+I04M7vhwWyApD3AlRmPjR1Rb97/3AML9wmO2hYohAGqWZ5Y2jF01xf8SYThNXYAxfOMti78SMv79JENGe8I/J20KTDoXDw8OIcyU6auY4BXDH81HnPljMAdGLSyOcDi/+6wCfcDud9OjgLMfb93thKCaRG4C7Os3/W9wFcN/RB3w5VBOpXRZhaEML53GeE22TkEEJBFyqrIATh6Rf9VPV0fhnfuqzm/QFkYDw4+KTwC01fNqn/AZVrTyofKaWSywNGlpsefGa8iw7l0UXWLOp/bmGFYj52gYHIMxWZXYPM+cg5lrNMEumwYkhAzkF9iFWnrFyOm3tn+7zRvT1b3nNfV9Zms/Z8sc+pAqKfJTswjW9eKyB7tCbSTlP945GwDKC+wT/CXvKNk8uzZsjBFkODajYQusIWuurbZlZFC3JqCPKFVHHlUJv2OdqsKRpbMkwevq7kCRRQtzkB5Btah7e3Jir4PTmJ2k5UFIgPbJXjLMWTtBxM/jZCFr4zTecC8FDFd2njVcgqQrEzICxtGBpTOo4UbCqrx/ECb7/gas7E6Qeoypa2vA4geqKxWRJqShqvfTgIHtB2jDgsnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(53546011)(478600001)(2616005)(26005)(4744005)(2906002)(44832011)(66476007)(66556008)(316002)(41300700001)(66946007)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ovaGx5cUZCMU9GcFR2RWxKUVF6bTh1S2pEN0RvZE9IMi9IT1kxaVlPN0Qz?=
 =?utf-8?B?RDE2TWFMcDUrMHFDSGUwaUR2cStYckpoYlRTWTh5cFFIOGZiSTNnZDZ5MHhP?=
 =?utf-8?B?RkNJaXcwRHE4V1NSTEVZZUE4N3VXM0pWN3FJRkJFRERxU1lPSmVBUlh5SWsw?=
 =?utf-8?B?dmtCSVBYUnhCUGlteEZRZ1dBSEZ6c1BwTk1lZ3BmNU9kK1psSjBGRzlxYUlw?=
 =?utf-8?B?TFpsLy95dVNFeVo3ZEhybzBCeFRUUmhRblI1NVZ4RlpuWUFXcUN4RzFld0U0?=
 =?utf-8?B?MllXbFN6T1lJOTJ3dTVXV09wQXo2YlJvek1XM00yVHVaOU04MUJmSTZPRmV1?=
 =?utf-8?B?Ly9KWER4TC85S09icFVNc1l3emdPUG9lY3dxcVZjQ3dpbm1YUW8yYkdxUDlJ?=
 =?utf-8?B?VDloU3RmM0pUSmpqZ3FxQnZ3K2JlYkRYc0dzYk5oTC9QNEwxbzVHNlFVWE1a?=
 =?utf-8?B?K2RaWDM3MFpuajQxR3FQOVpRdEZlWFlLQlBWK3AxeUYxS3pkdDVkangzYXFz?=
 =?utf-8?B?L3RLMHFMNS8ycGFHUjBmMXp2RXNRckdycHpSbzVCcEZEVVRzQk5BUVpmeG93?=
 =?utf-8?B?N21Pam1kc0JwTmlhVGxGQVk0cnMvSjliNE85WEtvYU90Vzg4Snd2WkoyVVZO?=
 =?utf-8?B?YkFvWmNZUHdtTjVlZDk5NDBIWWtTUldxQy80bFpCRXR5WWxWcmhteFpUT2Fw?=
 =?utf-8?B?YW5zYzUrTFgxVFV0Qi9TWmViTi9FQXhJYjJlM2lOVUgrMlNBQWxzNllwR3NX?=
 =?utf-8?B?TmFRNm92Q1pJMVZybUVtdk9RU1Z1a084NVJCZjVEM05pRGlNdFBaRlM4NGxI?=
 =?utf-8?B?eXNXeVVWajBmcWFTbExRcnJqN2dDaW1mSjcrV2FrYXJYYVJhSFU3ZWFHK0NV?=
 =?utf-8?B?eGN2cGIyWjM2WDBGNGQwVUYra3NGWXAva2dvZHlRWXViWG8vRDJZbGdzcUFu?=
 =?utf-8?B?WWR6VWdYMmZFLytEbUtEbDRNZExPbmZCRjRNY1R1cFh5Wk1VS1dWcWhhdFFF?=
 =?utf-8?B?bXY0bGw2bFhXWGhGZGF2MGRTY1ZFVGdTbk1uVDh5L0wvMTJ0anp6bFphZ0Rt?=
 =?utf-8?B?VmJMZHpzbmQyTE5XbXlkYVZtMW92YjVXV3JnNHdDOHdhT3grZDA1azFHNWtS?=
 =?utf-8?B?RGo2dkRleGZyTitFbXRCVFl1dDdiR3NncWRpbDdVQ0pSQXFWcC9RS2w0akpy?=
 =?utf-8?B?eDdhTXBBUTBVNVZRSHM5d29zVEFZVmVhb2JOT1V6a2Yzd053NnRCZk1ValNO?=
 =?utf-8?B?dFdsekNmR0VEdkcxcXNRZmZobFZMb21ES1R3aXc2azE2QlVsVzNwUU82Mncr?=
 =?utf-8?B?Y3prRUN0K1ZMdXkvWnZlcXhlSzR6d2tJZ21GZDhKTktzblBIeDV5TjVkNmVl?=
 =?utf-8?B?K2VjV3RYTVdGOFc2Mmx2UWVGNlRDME1qeHZHakZtS0puS3BxRXhyc3FkR21p?=
 =?utf-8?B?eTFiOGdvWWFvT3NDbHhHblA3Q0ZhSnZIbkZ4amRnaU90UUlQbC9rM1dzSm9i?=
 =?utf-8?B?YUJaZFRhMVZZQkkrV0dLM2pId1NTc28rYjhveUZiRXo1d1lHQ0RGWEFOVlRv?=
 =?utf-8?B?Nys3R3NIWW4rQnJWVHU5a2VkRHA2U3FQVTVVTjZxaGFrbFl1L3gzNFllMHZP?=
 =?utf-8?B?bTJwUEJzYWpidHQvamZFSGJWYXlRUWswT3ZBVUpEbmV3b0JzSjBFWkc1YlBQ?=
 =?utf-8?B?eUNGZ2dKVzVENXRMc3B3Z1ltQW9Za3F1aFhKMVhwUDRVbEU2VEU2ZGpPZmxT?=
 =?utf-8?B?VnNKSjd5WjJjVWFiK0hXNDRELzFpQ21EMktZQlZtY3IxRlorT0RmWkc1ZlFl?=
 =?utf-8?B?ak9KdXBtVUlyTVFxL0czMVMrK3pVcHhXMTZXdGxBZEVLa2xaWTVaemxyak1S?=
 =?utf-8?B?ZUN5akpwVEZFS1hJL1BKNVo2UWtqdUc0ODZySy9vMXVsaEs0MXp1QmsxdWpI?=
 =?utf-8?B?ZDlocXJ4WjlTb2YvWE4yclkwTTJYcDVrbnFmbzAxTUxZbCszOVhyOGtnNHJF?=
 =?utf-8?B?YTRKWGg3WmFvNFpXQ1o4cVJ3ek1aVEFuUTEydEdHOWxaa3UxbFFDeStiQmxO?=
 =?utf-8?B?bE56cS9zcUZhUTBNTEVjbXNDeVk3RUtvTElxL2ovN25ta1p3WVRNYUxRZ1ZI?=
 =?utf-8?B?OWhaK3BIRW9BdFdwVUV3QVRKamt3RXh2KzkzTjBZcnhmbWpPTitqKzZ2Z1I4?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75072e1-a904-4584-4991-08dbaabac22c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:12:10.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1bSAD+uUGY0ws79TuDghdcynE0fYLSDinJKDt9l+DH9Vujx4ZHUNB8BK1gnJT6PR8SSDR7WnH7+fptvXmrxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7724

On 31.08.23 22:37, Florian Bezdeka wrote:
> Hi all,
> 
> with this series applied the stable/3.2.x branch gets buildable with
> the 6.1 LTS series of Linux / dovetail.
> 
> Most of the patches were taken 1:1 from the master branch. The commit id
> on the master branch is mentioned in each patch / commit.
> 
> The last patch is a manual backport to support 4.19 kernels. The
> referenced commit in master did not have to care about such old kernels.
> We already stopped supporting them in master. Please review carefully!
> 

Yes, this needs careful checking and a second thought. In the one side,
some driver changes are more invasive than I normally take into stable.
On the other, most have lived in master now for quite a while.

If we take all this, the series should be reworked to avoid obvious
build breakages during potential bisections. That means folding the
fixups for kernels <5.10 into the patches that require them.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

