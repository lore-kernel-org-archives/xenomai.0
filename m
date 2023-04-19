Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0E3C34
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 12:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL4/C1OqzBal7DOqBDhK9C79niIhmVhM/+z96V9eKcPcFVGEm1DiZMqBPyVtJ2OV5JaAlg2UNyRwJ3LeTSyoKRFsiJlkdWyqridUs7WtuLWjQfe8RQjH7FORtk+dYEMZXDu8/rhdYcpZ2mMs6sf6WhiEZW/TrVHedztIs+YQkF8uJBiWhxxkEWTAwtGjR7LaUa8d7iJUAh5MVfXNy0cXTcLdk8GWKXoj2mP8+hX823CwGit42fDsBI7tLCZ97c0jV9jOVcZ3qfAP7w/XrH3D79NQOACnFL4Hk8vVPcXOHnxLxY0RcKpYfZB1djiCDjEGQteJ6kIIAODzOYPhp1Btvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5xpOaYYGyOBNgcQRt7bvfPK+YjczRBWA8bX/lk8orI=;
 b=KaT1njffznLtS4CjYysPcYK8xTc0y4GrtxLLo6zCO/7kD6l55FeocFoO/Ts5lWjp59NaTJn763dLqAC9Mw9c7HC+87fJT4c7f3UYjoJAZeqjf4sgjRp/Lu6qrZ8dMYBeTwu7AS8OcJk4PEa4QuokLf6g+sLPTkbcmrQv868Qoj+B17c5Mk5cV6Szi6CQM6ErBxSJZroK2jkSTuzuAbHzmUkakbmf4MqXi2dH67jUicIU+UZbkCxRxNNoRG4uMlsvyFQuK9yvyPLmdRrSUsEmYrMo+iLg/osF/oORabsdKsv6pjZcL4v0MvuI7FL3LzCcmR8sFQltrwTR/YtmreYKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5xpOaYYGyOBNgcQRt7bvfPK+YjczRBWA8bX/lk8orI=;
 b=ubFHdy1RFHuX+lO4CjGVyyJCPXgNdmKSX0oDpOMKiERw7KCfJilAK7YsSYhYs5SDOalHCCrUmWfEg6OguRNhItsSpzii0GMoKiBS38M9hqcJcYWwzTnywY5y/kEt9l51NMlrgv8VgcGrqVq0h172SVjhTfEfBEAmqPwhP3lKXpvloti5MZIR4+vWEtWSFJbmjeaI54W5DFxvyhZBAO2PBzawDDuoHqjt64LJ0FYfY/vW1cNKWYoGUMmXwKmGIS5R8K1SwTiCAvRPQWn/Lr9hcVvH0qd3lFOSU5yVpxXIzKtwCGjOawQrI0gQzrIFFccVM5tt8WtdWUDN3cZomWbLKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 12:42:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 12:42:49 +0000
Message-ID: <6f681477-40d7-dfd8-0813-2535c5cc3758@siemens.com>
Date: Wed, 19 Apr 2023 14:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Xenomai Community Call Minutes - Apr 19, 2023
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Richard Weinberger <richard@nod.at>,
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>
References: <MN2PR11MB42855D4E852BDC75CCC51471F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42856A94F6F6CC7E39D66478F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42856A94F6F6CC7E39D66478F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 520eb1e6-8175-4986-2c4b-08db40d3959c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0a9jZfAwiELp/SPsYMJwMjjU1SubKjBaui8svZIDe4yOrBYsZd9Ggnl1rLN8jerTtdI3i9OYDVxdfJ3lTy4y7Sg6MxjQwXO1TstedK3pCrl1sk8L6PVCg4ZENklHC+teBet4tx9V+Cru23G9VsKVFEvGAYMyO9x9ZWSPvz4e+FLhHr+TpvUTMuORd0MvSNIcxeXWZ+2oakqliogo0b7nzaf/O1IfIIKvM7v+JOYY/UeRkdHh1lmDXvB9hODvZW9OwX6eZ4bicYjSPnXuTGnM1Ju8JzKML/F1a2DQYfQwxQdYfxQT7B23nwhUghQnfADxcJuwbwEBRaBdcXOSJBkDNoJ7/NJPXlmgLkvYKdAGZicbJ3+WoFhsQTobIzuB5XT1bI3+t1uQJuBBJI0GmB/R+d+3wrvvIJ3TurRUqd41zMekZNdOeGCHMMQAbH1iH8LRA/be7RoWIVt+wsfbvDd/GGLPzfPoXINeGm7uXJCCkoZNWZU6dY7BcQzjwAbf23TaN9oNfDLCSW7IqJ5OQtCE2ijJD/KxYAmBbg364iNYzXR4511vEDEo34ho9FqHQb+hK2YdJazHISMAz76gQ26lVTNYrAnBF9Ik+NNqJjVgtBga1sdaoBspW1TVAODW6+iRpC5sXrenoGMjrX4Fq4ru3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(6512007)(26005)(6506007)(186003)(53546011)(478600001)(54906003)(110136005)(6666004)(36756003)(6486002)(5660300002)(8676002)(8936002)(4326008)(2906002)(44832011)(31696002)(82960400001)(86362001)(66556008)(38100700002)(316002)(41300700001)(107886003)(66476007)(66946007)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2J6UHFUZGhKb2dOYTVjMWM3RWEvZjlGOGlINFNtL0JabldhTXVSVyt4QUpX?=
 =?utf-8?B?K1Q5U2NhMVE2ajdqT0I3Q05TNXBYNUZKWWlTR0RlQ202Vk1yak5MWThaOUxp?=
 =?utf-8?B?Ny9MekVBWm4zaEM2ZE9jdU5WNTh6RjRKK3FjTTkwdFVuRDNMWHBNUlQ4UUU4?=
 =?utf-8?B?K0xYR2Vud3MrRTFyelRCT0s4c2h5ZDQyK25zS1FjUU82b0tEYTk2bDkyeXIy?=
 =?utf-8?B?UHpOSGVIUXV1SjFDUk5ES2FyZ05RZTFzcWFyQUhrcHRFWnNUVG00UVJyL040?=
 =?utf-8?B?ajVQNUR3bkZFTitLWEtyNWNKRGh6ekQzNVk2VnFPUjZ2cE1UZUhIUnVEb2t5?=
 =?utf-8?B?Vjl2TlZwMTl5eHV2UHNKSGR3Qm1FeVpoWElVay8wR0J2Y01pdGRqUnNTUFVB?=
 =?utf-8?B?ZE1CYjcrWDdwSFVGVWVwUEd5RHJEdG9NZ2hERDZHNmQ0aTFweFJrdWRvZnpY?=
 =?utf-8?B?dXVYTjRZVWZWRTBJODd4anBEeEpXZWxCMGc4Q051M1lJMENQRmUxaTU1VkdQ?=
 =?utf-8?B?V1grbGw4T0pUOTlrTVlEQUgxOXRkdEtObWdsVGUraTJYL2Y2Lytia2Qza2Nk?=
 =?utf-8?B?aG9LRjdlaUpuQUtuZm1KWk9LUVBrVjMyL05xTk1BL0Nhd1FSbzFwOHFXclhh?=
 =?utf-8?B?OGFLZ1hMaGxNTkg1R0d1dWlzZ09zdVFJTW1jdXVtUWducSsxNDc5UEMvbldW?=
 =?utf-8?B?Wk5KV2tLT0dYb0o4ZWJsUnR2SERLUVVLYjArcXhjdGpTb1NBWkNJRUFNV2FL?=
 =?utf-8?B?Tktjdm54K2VqUUV3ZFg1OS8wN29UYmRlT2dyVVJnbkQrZ1VXb0hKWWlaOU9R?=
 =?utf-8?B?VXJvNzhXSlZ6NCswaUx2YTM4ZC85VXpCbDNMdUNqVVRCZTU0SG1yVVRPTmEx?=
 =?utf-8?B?NlV0K2NPZGkxZnV4S3BHRW02RXgzcEQ5SGZjbER6Ui81QWdKTGtIeVZ0MmZH?=
 =?utf-8?B?ZUxiaU5ZM0R2WVFuZEYzbWdoZzBGZkd4YjMzczhtenJaSnFVcnRDdmU4Um5S?=
 =?utf-8?B?Ym5Bc0tHcUlqVFdOa3F2TTdCb2VqbjNsNTh0NVlMU3NPNTI4T3JvODNEY3B4?=
 =?utf-8?B?dy9YNTFJQTVLdjloeWFsajk1cjRnSTJBREk1VDhCTDlwVCtTQ3dYTU9welVz?=
 =?utf-8?B?WkdXSnBmS3pmVHNJbXh1ZGNnNWdjc0REa0o2b09UK1hmK01sU2FmSTVibkxF?=
 =?utf-8?B?ODIrZmFxcUp0OVNveVpRUDcySmdhSis1T0s0UlVqZXI5V2V6SVBRSk1aSUpm?=
 =?utf-8?B?N3NoQXlHbit6UUx0MTRmKzk3VnprUFViZzc1RW9qUHJONUhIRk56anl3OEtG?=
 =?utf-8?B?T1F3TXZDeWowMk91c3ZLMUpsUkhFdzlOd1NtbHN2Y0Jxb0ZLaURLR0VUS3Rj?=
 =?utf-8?B?Y0VEZE11Y0xIZEdINWtRSVBMNDBzUnZKK2VhSWl5dnlSOVZEdHBmbHFQcDc4?=
 =?utf-8?B?My9MYU54QnZMcGpCNmk3a2UvRUxib0hUR1BmZWxzcDg2VFR4WTlyK3lSaWdC?=
 =?utf-8?B?L1VTSEpjS1Ara1NEUnVBQW40dGJKMzhjOGpDdy8rekxRU29XWVl1THB1Ynp1?=
 =?utf-8?B?RE5EVWRFa1JXU3UzWm92WEZSZ1ZEYmZqenVoYWlNN21wWkFmcVdweDZPa3k3?=
 =?utf-8?B?Mm5MSGdUSElvZGI4UjAzc0gvQUJhQWxWczMxSUlrbHdtTjdrVWJaRWtWREky?=
 =?utf-8?B?YzZsYk42VXo2OWVVZXRnWHVzK3Bhck9rRzg1SFkvMHZuSEV5SkVyc09MMEJS?=
 =?utf-8?B?b3NIblYxNFF1SUFiZkxYWDB1bEdlazN6QW1GcHRPSjRsOHFpRUJUQjUxVUEr?=
 =?utf-8?B?NXZzZjNGYmhYRmJMODdVNTh2aVRlL3NnRU1FTzhlQVpzZmNLUStaS2tCU2RI?=
 =?utf-8?B?WW9VTytudERVMlVXeXhtdzRFQVhvK2M4andaaHp6dkljc29GZ3ZBNnBHMXRn?=
 =?utf-8?B?MGM5Z2FWbnhiNkM4YWRId0M2SHhPbW13L1lPaFpwbytNQjAyMmUrc2lsTjdS?=
 =?utf-8?B?eDI0OE1tTk1RNVlycXlpV04vMkM4TXUvRHo4c2VYVCtSRUR0M0RqUzgrV3pY?=
 =?utf-8?B?T0RoRHJGR3pCKzhsSGEyTHlmcDV6N29vbk02QzZWdDZOUkZvYXJDZzBaeE1K?=
 =?utf-8?Q?CyrLXblwSXfKSsrncXT1/egKu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520eb1e6-8175-4986-2c4b-08db40d3959c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:42:49.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTjuinIN2on3gwKX1savHcItd0wD88y5zDNqismzRfboAZa2zgCF8aXWsIHiAk3cc8/kXjfqqHYkTi0evIxRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8143

On 19.04.23 09:59, Chen, Hongzhan wrote:
> We have to cancel next meeting (May 3) because of Chinese Labor holiday. Sorry, I forgot to mention it in the meeting.
> 

No problem.

I might be blocked on the next-but-on (17th), will let you know once
that is clear.

Jan

> Regards
> 
> Hongzhan Chen
> 
>> -----Original Message-----
>> From: Chen, Hongzhan <hongzhan.chen@intel.com>
>> Sent: Wednesday, April 19, 2023 3:55 PM
>> To: xenomai@lists.linux.dev
>> Subject: Xenomai Community Call Minutes - Apr 19, 2023
>>
>> Attendees: Jan Kiszka, Rick Wang, Richard Weinberger, Bezdeka Florian,
>>                             David Oberhollenzer, Tobias Schaffner, Hao Li, Hongzhan
>> Chen
>>
>> Community update:
>> 	Kernel 6.3 build issue -- fixed
>> 	Alchemy, pSOS and VxWorks test -- integrated
>> 	System hang issue with virtual hypervisor on 6.1 -- fixed
>> 	Code merge wrong issue on ipipe branch -- ongoing
>>
>> Open discussion:
>> 	Big & small core usage way for Xenomai task
>> 	Signal exception handle and Signal base API and its testcase
>>
>> Regards
>>
>> Hongzhan Chen

-- 
Siemens AG, Technology
Competence Center Embedded Linux

