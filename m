Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF1DF6F
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCE8ENuB2CO1fpP9O7aEHW3h+TYp8NZxskG7RA1y1dA+rMCNhl+80KCBIS9/nOLS6++WhJN2F02IE32hvvwb4shaf8sHTSKcWGnYDElZOvGL6EUp4ABdO7DMaqehkOe1+5yUZ63FvZilcgdERm5poqT/reaBf5kLjgzYhoa4p0RB9WuuEwcpcaCb4YARLfDwt93b/8WqcD4u1vPwTVkIcGPb3LlUYWYt2EgOcPIMB+vqRQO3D6mDuh56fJUxJGU0qBRXhTAk6/od27KSDwpHNOmAKSAlr+I2P1IG+HFAsHXHlgAkADXwjYAQuWwqRUt8grF3gfFQZPAL1nxHZeC9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHJBHM/sDx+PJA8fFE4EIqoYmFBS3ZDtBLpWzaEtclo=;
 b=AY246iWmrV0RmbxfA4JYPiQFWxpZXkaBFdVoTWRd9/LQ1wRDgKMNOPzUcHqHnIWbyEk9Nm5jm0caUwfAHW69BU5QqjqM3oY0ebNSbgCaRymTzodj6tZUJHp3f1R7bLxBtV0iLMM6IURTEPR9BL+mgLe3Uv9LkU4ZD6vqTccml3AhiaMdAKtQA7bynKIgxkiuT+JH2zxJir+VSXKhWwItHEbCHfJ6LBCAadmNCHn8SAdQ1LNxvDaCD5b71+EK6oYLuHTd9tu3KatghDmyXcew2RN1mkqaOUHEIWNYCsAHMcY6HiILqywHGCQQ0T51hk98fOAIj1idrVBjvhmfcphijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHJBHM/sDx+PJA8fFE4EIqoYmFBS3ZDtBLpWzaEtclo=;
 b=eHTdh/KCcGoLih0D3WPR/ZvnpjY4ECvwL0xUhynxWu5LXUPD39inSxaER8P8yEHCrBhEgaQA/Jr2AgcHd+8R/W7RuVpOA6bVQJJ88x2I8rsVNLGODnvaPf2xdL0/vsUGoFcyw2S8s+Kr/5Jlw7tIz5KDFZJEn0eFaiZRo99P5RHhqgsyL0F5i5+GZOd0J2GSmsl/a3MZuOSFuz9rnALdnFg0D9fk61lnPbZiA2OrCXSw/0ZRcQ8O7P/BsHR9Z/35MF+qlZ6X9TI8/tZn58IowaDsE9c219M6s9TgmFsCX8xzNblg8v+ONiexmwFskR/ZilC1yW3t3i3Z1sXy/wkcNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5853.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 08:21:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 08:21:36 +0000
Message-ID: <a7e41059-9fc5-4a3a-bca8-5564adfac158@siemens.com>
Date: Wed, 4 Oct 2023 10:21:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Sep 20, 2023, UTC
 7:00 AM
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>,
 "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: c4872f7b-5b0d-4731-e4c3-08dbc4b2ecbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HviSGtksmVrARXJtde6DmQe2eOPeI2joB1jOc8H2a+Glho/QptddgU0+YztPvVtDoC9nJZ9ETjNzU+9cZxJzq2nV2JTc9eP1l4fLOLMetSabDaBJlT/A0nh2vmpyhQlnsNHdFU8NdLBamQRAOOI5rEj9QZ189RDOERlnwS4ye+7o/t+wcpRQtEgdTUwZ6LE+En7zByuHbn3j+zaAkhwp+bNe9LX4hJw5Q9wu/B43T/Ih7KdUgc9LSRxzUKTTgHMCYE/A5pvzHVezOHAaYjC6wZx637jNkn7dJtmYbr+qBRv79G8VWN9eTNK/jL2021duCO3M2id1bF9JeSOGJVUSbA/rbBffha21c0TRPdqlnm4HgJtgFOo3GhnPAFYOd6w8P6vu74omVz/y8bGEyVV6jjlXU0LvrgG4fmFxpt/49whP5+aBcEuLjDQfpt6rneERrpPJLNhik2WAjw2xl/PT+poIqklXgvpMThxpR5kGDeB4wahq6xt50UKZBTHvsOt6291AieenAYy3lymMcemDEwvwCVLPtK8/4cCblqGFJShbh/kqT6fY515+/TTkcWnFKQ2Dhd5iehtZwMz9lrQPbTYYqcPQKKotNtCOLQyDETsWfOgfTl9noGT6JfIn43JSzwfFHjHZEIVBhavp8HxT5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(110136005)(26005)(2906002)(31686004)(4326008)(44832011)(8676002)(66946007)(5660300002)(41300700001)(4744005)(66476007)(66556008)(8936002)(6486002)(478600001)(6666004)(6506007)(6512007)(53546011)(316002)(2616005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3NKNkdoY0U1Qi8yYm9oNWNBZGFrMHo1YXlMMEVZcVdFZk9wK0g1S3orRVRW?=
 =?utf-8?B?VWpJS1kvdTcrcFpaWkFQOFpZTTFJYXlYQmNkSERHSHJMZFdDS3FpZHI4YUQ5?=
 =?utf-8?B?b0syVTNwUkp6eFFyVUc3SFRHOFRqa2pvb3dVQlRPS3VQRXdrY0pwM09zTFI1?=
 =?utf-8?B?ZHhRcUp2VUZlTmFYUnloZVVsRjl3aHZCdG5DV25kdWw2d2tCdEliVjJQUzFR?=
 =?utf-8?B?NHY4bnB6ZUNjNmJpUW1SQmhFc0tuSENnWkJINHJWTVBjUGx4T1h2STZSbjJt?=
 =?utf-8?B?M0RsSEZsRVpZeFpidllrakc5eEJuNkN4MWl5RG9sQkZiVy9zbTJzTEtnOVNY?=
 =?utf-8?B?Z0gvOThNTVp2MTByaHhOcFFweFVMSU1zOUhqRWN0UEgxNVZwQ0tydDRVRkIz?=
 =?utf-8?B?V3FvTVhEZ3VEcVN4WXVuY3J4NmlKQVIxM0ExT1YyT0NnbGdtWVJiRUNYaXBq?=
 =?utf-8?B?V1hXZWhqUmdZSEsySk8rMWJocytTaVR0TWxQZ3laTjhncFh4NjFod0lBQ1F4?=
 =?utf-8?B?N3padEJTcWJLZHVVeFdTSTZHYi9pQlc1UWswNE1nZEI3Mm5QNm92ZU8rWFM4?=
 =?utf-8?B?RTBjc2xqV2ZwVWV1OFRpSUR0c0JlUTFvUVpOV3RFQzVTZm02Mzh5NEtYTFk2?=
 =?utf-8?B?Sk1kREYrTjJzZVdFclh3Y1RZblNRemVFSkl0enkxOHBZd2g4ck9aL1JlR0lZ?=
 =?utf-8?B?SnAzWm96OWFNUWo4YlYrMWNRYXE5a2VoQ0FlR3lsTFJ2MzZ6QXRTdmRoTlAw?=
 =?utf-8?B?cHBOT1JCaG5JRVpsck01VWVVY2NlQ1ZXWUZieThjYXp4eERMc3lrL2tOR1Qw?=
 =?utf-8?B?VGF3bXd5a0FoNTAwTWJEcW84aTNucVJVZVVjdHBrZnlPMjFYMkhuaitYSTZV?=
 =?utf-8?B?ZVhlRGowREZZUUhLcUJjWGt4a1pGbnRZVlgvMEpvY0tKUTlBRy90NHlIbmtK?=
 =?utf-8?B?c05kdVFXYjdKZG9tUjNKNEQyTCtDa3kzYVo3NGhhVVJVL0ExRy9nbmlQU0NL?=
 =?utf-8?B?N0xCNGlaWEJXNm1BMWpDOURycWUwWkoxQUhmbDBFMFI2NVd6NEZBK1AwbmdI?=
 =?utf-8?B?RGRwdFBUWVQ1VXVRN0xZMWlRKzU2Skk1S0Y5V09OUlJJM0QvK0tabzE5b2VC?=
 =?utf-8?B?Z3lNU1hHSVA5dU1zb3grZC9jang1bkZUT0NPMU1uU1BaN0l5aTlGYnRVUW9O?=
 =?utf-8?B?T2tWNG81dit2dmJiQVRFWEROQmRhVXVhTWFUNGFLK0FiZjJwUElPMWNFRGR6?=
 =?utf-8?B?MkF3UGkrdmlyeGo5eXRMZHBrWVpIYUY4ZXdzNnNLU2luU0dUV0poeGNHL1Ur?=
 =?utf-8?B?SU1pdC9EWEpUWG85aGdtT3c2eTYyTFhtdkF1U2NFM1pEL0hCSzBtTVo1UEN4?=
 =?utf-8?B?S0dUcGhiQm5iMHlHbTZhS2RsYnBHS1NHLzhmNDh5ZmtKRkhiZjI4U2RjTGpx?=
 =?utf-8?B?dXkrdkVUdDhkaVlxN2pTVWdZaTB4ejhZQkJBblB1TFlZRU4rd3FMT081TXJ6?=
 =?utf-8?B?dEVGN1BhUFlFWnFYc1JZOTIyM2hVT29pM1dUSmdia3VpT25YY3lzRHNQWE5o?=
 =?utf-8?B?SjVFSWhXT2h6TitEQXVIZmgxUFI3eXlIa21NbWJySGFsWFIzTlRpd1Q0VEdJ?=
 =?utf-8?B?UE5aeWNoYXJ2NHp1MkxNa290cWlRdFNQdFpBVEZkY2dmK09TRG1aZ1BYa01o?=
 =?utf-8?B?NXNjVmQ2N2xCdThUOXJjK3dBUUNTK3ZNaDNxOFZkTy8wMTFPV2pHcUUvVERL?=
 =?utf-8?B?bmxGdkhQKzB5Yk9ienU2ckRmYTVHRFI4NDZPVHJia0puUWN2UVRpeEU1VmhS?=
 =?utf-8?B?R2Z2SUFuZlFFNHdkTUxabU5Xc3R0dVRlVlhuWEl3VnAwMW5XVHJ5WEZyZEQv?=
 =?utf-8?B?dnpKVGt1ODdIRkx1Q1FkbEduNFpZTlJHRGJHLytQeE5Ud1ZneTVIVjZudXV2?=
 =?utf-8?B?elllb2QvTjRvT0tPRDlCM3RjWEZUUk40ZXdoODFQNzRDSURzN0Mwci9HbUx4?=
 =?utf-8?B?amQyaFBtbUpiN0hvdzc4di9jcFdtNkhPSk1oRzNNTDl5aE52S3AvMDVrbXN1?=
 =?utf-8?B?ZDN4aUtSZW04RWpTdDJPRE5POHdzYWEzcmoxWC9BblZvNWk3Y3F2MVNuNFIr?=
 =?utf-8?Q?y0J5kZHehqOlRLyPDOCseIziA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4872f7b-5b0d-4731-e4c3-08dbc4b2ecbe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 08:21:36.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TB2ecTdapHhNvFarzQ6l8haHyfcWI2EUHTDOmV8QE5abDcBi1lFAqnpjL7Qb1ZohCZLV1OSv8QbJvG0VHT35yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5853

On 04.10.23 08:53, Richard Weinberger wrote:
> On Wed, Sep 20, 2023 at 4:17 AM Chen, Hongzhan <hongzhan.chen@intel.com> wrote:
>>
>> We have the Xenomai community call today.
> 
> I'm lost. What is the current community call cycle? Shouldn't be one today?
> 

Sorry, it was canceled due to public holidays in China. Seems we forgot
to communicate this to the list as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

