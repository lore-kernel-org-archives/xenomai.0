Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FB374FC
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 17:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/wDyV6PgnSsOcmlAcaTyBdAnMDe2lO3lPjvzZJ0ixd5ypZkXBkjpmj62vS5cJKyP54Y7OKPr1hiwReg+dmTz/+kS2915UxFRh3XWK0Hai3YHR/LLOvyqBZKJ3jc43wflw0frBaf+hJR/HvzkaWf2m4DP9RUL2nXiEYvtw6Ds5ZztKMZKr0P9uznC0Ku0f4hb/08WivjfHwWMcdyTEExMaMnDpFqoAYWsQkRSS4QP3J/FBsrJk49oflrpjnLMEkLBe5GOEIMHG77OCO+Bgn/Yzku/2rGcyb1426/INgCeFixhVviJoZZl9Xp/jdeY3FyCKDF2haUi8OE8CvSrRnPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W71D7Co4c3ehIlaQR4SVm7Om2DVjPntepX0lfsq3nAo=;
 b=KSRsVSc3MGcThHW9+7eVQ9gGb9Vi6l4mBuXy9v3LDlvSe9AFS20dP5DYkAYFaH2Dq6m8NVgp59T5REdcwbUTIJbYZ16G6571f+biiLXpiVsXnjsl3lqUYyCguOzD8H1ALZQXCwOxsrXqel39Z5oyqbnbCp2AkOpalOGM1m3OkiuU1MKvvYcdPpUmM9fedy6TwNEE686hPBssotVMzivYzaSznm7i78eMRcrr3dIFhhhwMQ/JjL6jwHKQi8ApklIhZ9DPFX3vYvX5cc3S3ZxjVOq9XuKR2L5NGtYauHungDG17hf5NzoYgld4szxHPA7eQTxNrSRxKzXrhg9TYfW1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W71D7Co4c3ehIlaQR4SVm7Om2DVjPntepX0lfsq3nAo=;
 b=hLrwaQ0FigL05oaftJKlDZNgSxugbTNCN/HZnYkNvGGIlE8/XeJyoyGNnmvkDf/83QU4vAx+ipcqLNgI++XfdIIoiid+tYEPCZ5aDwD6COMnhtTWUAKlPL4mFYSfz1ydPIYzswT2xmgfyEhxsYtpj9bAkI3GHKYP2YkHBq3fFwlq9NllMowg/W+up2408RmCVj4+OLgzYzsW6BRGBNCMFmpCTYkgwoczWyRO1kbPZrupAgcNR5clQz+GBoDVXML37D/kqWshSc7OxyWlLOKArmnJ0INpZ8JwBr5oEM3OYAwFqdIUk2YApUbC3AkymNFmNW6aqpxhHBSEAEXiBuMQXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:31:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 17:31:17 +0000
Message-ID: <e9b6cd8c-2def-4c9b-87f4-6eca34883181@siemens.com>
Date: Thu, 28 Sep 2023 19:31:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
 <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
In-Reply-To: <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: d0452b16-05ce-458c-96d1-08dbc048b916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0gcvhJP2ONMCjZcI9MHQJeJpKXY4KBnrL02W/kVXaz4EhHFtUxG7Pni8//h4pSpa8skYF4xt3PGLXzDJWz6w15pLz3su365fH2vkiXJ1mbtCiuKuyAt+k5p0OQxjxNM92ObVpNmAyLmNUQReR3zUbU/2FinPo48Vfr69KVz4UfKDbwUYzCB5rRztZYTsesjXyezkwM+EeAmbdvrn0nBSZ5n5F9ZW869Jy+S8EoKjW8vcoMJzmCqAkkFwrMFAI02fVPj38DmAb5TWTFHaumme0eZ8WBLO6/Is7ttimCN4Qgg4K37me4Bioo4zyhKYwRs8BOz7Wv80hOYYGhj5ZPnG9RduG8GGqS791kVHtymWq8lSC09G1fOFphHfRDTt4Ar30t7RRErhuxOOiK+6zamN0NWZAof34T+uEOfmj9/LFbZ/9opb+nkKE36AGR7qFSn+K+tq+7M4tEUw9dMkVz+vXEkhSwxdTcmAiuUSSgFTVDfB9XXiI68KZJQDA/eRA19GLhS0cXuCEcA5LGwCzJPuYq/CORlpm38iEcOHUaa6NLSc3DYhsPy+WOuD9twDTiHFymrZvqGI33QfXABYVEpgtU9UMbdjYvZkj5cYhKsaO3VRM+w+SmnGlXhRoM0GNkq8Mcw7aW9v2rGwxi+9/E4p8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(82960400001)(2906002)(83380400001)(38100700002)(6512007)(66476007)(53546011)(66946007)(6486002)(5660300002)(66556008)(41300700001)(6506007)(478600001)(8936002)(26005)(316002)(8676002)(44832011)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9qTldLR3FMOGdaNnBTMDRzVXBJY1JyUVhrS3RNY2Vrc05uczFjVUJpYks5?=
 =?utf-8?B?RWtVUWZrN0dJTmthMi81YTJidmY2RFFiM3ZoNXZCWGF5NEN0WkQxdDNHZzgy?=
 =?utf-8?B?c0RBdE1UQlcwbnFQZnRhdFNWdWxvYjRPL0dPOFpOeXF5TVNVQyt0c0Y1SVhO?=
 =?utf-8?B?WnhMb1hoREI2bURYZEtGYWc3N0RxUXpkZTdubmJUQjR3ZVozd0FWa3JTeWIv?=
 =?utf-8?B?NHFSaUtPa2JEeUh6cjJDQk51OHFRMnA3ZVJHWXQrRTdHYnJBcGdGejBSR1JT?=
 =?utf-8?B?elFzYzIwV0xMSEdrWDNqZVZ6RU9YdXp2S2paNDFrQzZMREpnV29XWXQ0eCt5?=
 =?utf-8?B?dlZIcWF2U0JWUGNGUmY3SVBFNlhLY0hvYWU2VGF0b0Y4SzlHZXpwYnJoOENs?=
 =?utf-8?B?dEE3aHRFMFZjMk9Nb05xWW41WmtDNDArMitDR3FHZTZYMzVHUjVIKzJzYWRK?=
 =?utf-8?B?K2RINmlIRCszR2RNZlE4eldlY3NoN1EwTk0xVVpaeWkyTFFrbm9tbmVSR2dX?=
 =?utf-8?B?UlVFV0tVVzVxYVE1TEhnU2tBNzV5Rmh2ZlZvc21aUmpOOVVMdXFjRXdsV2Nn?=
 =?utf-8?B?SzllWlVKRWs4Wld0UmxxdDZ2R1RDMDJITS8wZ2JRbVpLd09oUCtJR093MGxG?=
 =?utf-8?B?TDJCT053ZjBkOEJuMDgvLzg0NHhrbWdVdXZjUXNHUDJ0ZG5OOG1BbHRHbUxO?=
 =?utf-8?B?UnJQTnR1ZW5XMlhINUtBcExQSnIrOVdKTkwwWW8xSnBtWm5DTmhwdk04UXBN?=
 =?utf-8?B?YnNvWkZCanVKUEhHOXpWYTFOSGwwc3Z2RnprTjFmeWh6Ylpsb1N0L0hxaG51?=
 =?utf-8?B?b000N2QzSVFJMTNYVWhaMEJVMFNmdWtpNGNDRzZtZ21OWTI0bE02L1VOTVdE?=
 =?utf-8?B?TGNEZko0SUVvK3ROdzc3Sld6NVFGOVZRU2p4ZUpuOGdVUnFHYlRTSUVqVnBV?=
 =?utf-8?B?NTRwWDJnVUJTT0ZlWG5UMHJpUG43eDMrSWVpQW42UHFhTW9JZkRYdTJIQlhS?=
 =?utf-8?B?dnY2WGhpL2g1ajV0R2lNKzZJV1FvYTFjQkp6cUV2WEZVVk4xMUcxQjZBdVRH?=
 =?utf-8?B?RURla013a1ppK3BhaWRXNlFGN2FWWlUrSjFkckJvV0p5OVVvczhEbjJxSFVN?=
 =?utf-8?B?ME95L3ZxNXZTQStKR2o4S1VqRVZSYUNrUXZJSE10VkU2VHFheTR3eDBNaDlM?=
 =?utf-8?B?cEpTbXVlTTJZa0g4YzIrSE9TVWlPL0JFRDdYR0dDN1ZVTDlCUVcramEwUFlv?=
 =?utf-8?B?N1BxSlhPQ0p1NkxYUXk2bmMzbmVkejZhVlRlWjROV3l1YjlRRFB1OTdJZmpM?=
 =?utf-8?B?TXl4N3cvVDNzTGEwUXEwZlVtWlFRMXhlYXdZWlM0allzZjQxWVlqUTRYQWkx?=
 =?utf-8?B?Qks1b0JmNVRybzVxZEpzMmN2Tm1mdndNUkt4U1ZvYkRCMGdjRnM4UzJ2SENz?=
 =?utf-8?B?ZjAyTk5VN2trV0pFRm1KSmUxMldSODM1T1NMMFRJWEMycjNGcVNSSit0NW1Y?=
 =?utf-8?B?dFFyaXdDWkhhcy9NV3liMk9ZRXNnVHlOR252eHJJU0ozU1BtOWpzbjVCQWgw?=
 =?utf-8?B?TER4dCtEUlV5SEdhb1NQZEZ1TEo1YkNOeWFPQlRvaXpLTUlQWHFxZkxLMEty?=
 =?utf-8?B?QUUrYy9kenUxR205TDQ4dHpxSVgvS201VmdMS3I5M0dpbE0wZEFya0xVeXFO?=
 =?utf-8?B?MlRxWFRRcElRMTMvanFPbVRPblUyR1N3b28weXM0VE9JYWJSalhmWjg2S3Qv?=
 =?utf-8?B?NXVkL2lFdllYd21rRXN3SDUxTkRiRTJXMHVyd24vZURrVlJwQUlDa0lMVml2?=
 =?utf-8?B?Sy9HS2ViUitTc05GUjlpSkJuY1B3bnRnZS9LMTB6Tk9Zb0QwZUt4Smt3aXhS?=
 =?utf-8?B?dmxpTUZYektIRlcvRVNxM1BJQnNWTlBRZW8xaHBlOS9ySkhJR3pSRFJjTW5p?=
 =?utf-8?B?YWd5TEpwRWdTMURzS2F5VWsyUWUwTEZMZVJURHdiVlpXOXB3UzNmZmIvcVVV?=
 =?utf-8?B?ZjREMFZQeGFuNUl2aVhCMzhyMllxcGI0MFN4T1dFcjhKZU9oWHJsdGp6a1kz?=
 =?utf-8?B?ZThUQlEySFRLN055VU1mTUs1L3JIL04zd2Y4T2lMMlIzUUpRQlJXQXdwcWpE?=
 =?utf-8?B?cjZjWU8zZGhmakhSci96Z0dGM1h3eEFMMytSdmFxWXhQbUNxYjRXbzFLSWg3?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0452b16-05ce-458c-96d1-08dbc048b916
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:31:17.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtmW3WS799kZnbhSl3H8zy4tfs7drcgoOcb0PCorqtWaO7x5yv7NQ9iAx30tUUMMp79DsuLbYiAtTRsedeSJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7990

On 28.09.23 18:25, Jan Kiszka wrote:
> On 27.09.23 15:50, Florian Bezdeka wrote:
>> Hi all,
>>     
>> this is the final y2038 related patch series. With this series applied
>> y2038 support will be enabled by default for all affected
>> builds/architectures.
>>
>> There is a kill switch (--disable-y2038) available in case unexpected
>> problems come up after merge but that is not expected. The y2038 queue
>> was regularly tested over the last two years now.
>>     
>> Short summary:
>>   - Implement y2038 safe ioctls around SO_RCVTIMEO and SO_SNDTIMEO
>>   - Enable additional function wrapping
>>   - Fix some smokey tests (reading of reference clocks)
>>
>> Fingers crossed, seems the y2038 issue is solved now.
>>
> 
> Thanks, this is sure a major step forward!
> 
> How confident are your that all these now possible combinations are
> still tested? Our CI will run with y2038 enabled, right? How is the
> disabled case tested, at least build-wise? Or the case "unsupported by OS"?
> 

I already applied this to next to let the tests run.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

