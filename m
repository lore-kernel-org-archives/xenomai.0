Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2215B2
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 12:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZWT8luOsI4/lkmHOaJFR0+D2DUGDsasDLpAvedFI4gKTd8k2EScs8W2WvvcIAaAdmE1ZBlaKJMsR35zC0zxBduvk64rm3oY64m3kH0RgeLWyPFGqOX8Fh0Z0lg6xAhl7cI/Xl+oo1rCrNgFLuFUw7hueJcZgjwF0xJW90mXi1gA2KbZUuLDovOvKjxDM0M5SVcBCf/kH1q+OEULSadCfpKex9pb6iDWdjz/WeDLq64eicHj/c/l5LCAiV6HBtkT+vjXI+FvV90YxAJ2eAKqeYCVi4IVIDkZQSSCJkZs8orsAS30ubQOBOER8S8xFKGOieepSxySEnCj6A/FDOvAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLyNpY/FGjx93V4sxliFVd+Lg19CI2ZVTXDd/4pVBzo=;
 b=VEcY5uPYfDv4CqzUo9wR88jKjB1n8w4lJqptKLdmAgYfF22lIPqoDh+cxTKpZgPREcAlSocQHaHWiL0MIE5b3H/NfrPlU1yCjMFMwWeun/N+mNUIEjOXcZQGG+aW9i/krOTpxrMMI5d1g+W/EHxdnM3jg/buFYZhUhSih3ss1+s68RBpT02vTCayR5DTWmPtxQbpJLjC8KiOO6DZ2kA20n40mHQHioE3B2GNgb22kW/AzE+L7icNoGqr9MO4xVE5ejVOxHre8rIdUvdgy1H1Mp+qc2XV2vgabwCSOVyopKBZURFMYnLClSxdGKWSghyicKq3hXOJPNdlLWsyAn4ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLyNpY/FGjx93V4sxliFVd+Lg19CI2ZVTXDd/4pVBzo=;
 b=b2QVSdtz7+aFUJxtzOIcpGKa2GhMYSK2MaU/VyqY6qq8yDOWnJieJXOmcp5SGchEusVgMfk9iezQOLf2khcGOrO//gqayn26WEn5nXdHO4M/ouCCG+DioQoTxGwlqSXFXXT0QuAhbXBiSAv6i4ggu2I99ae9+LHGdmfP3NX73gVKDQDEC9Lf44+wduDbwlfIjknBdA2T6AVgFY+9Ht9c0lwZ8jQWaNf3bXp3EnHBpb57D/J2NOYeGqplgBAQEKj6bFOZDyY1/Y/gShSPsn/HbywPimhf9s2tBnJeDpl/bpbRQ7sKWmlOz95pFhQum2lWqQxBqYsGniDI0dmlW5DFuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:38:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:38:40 +0000
Message-ID: <866ba105-0c09-a70b-7398-f84b8fa9b37c@siemens.com>
Date: Tue, 13 Dec 2022 13:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/3] switchtest: test mode switches while in kernel
 mode
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
 <20221212121650.1294772-4-tobias.schaffner@siemens.com>
 <d99de5a7-3c00-8c61-374d-5c0366c794b4@siemens.com>
 <9d5a712df42f12ccb691454e64aa47cd6d6ab63d.camel@siemens.com>
 <7f60445b-3686-38db-92f4-3ae65746bc93@siemens.com>
In-Reply-To: <7f60445b-3686-38db-92f4-3ae65746bc93@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:610:60::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: e3493e1e-a8e1-4bfe-dec9-08dadd06f686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fGBIaQ7Bf/TsRmXeUL3ZEnhyu1nTg8SBE2K70Gbi2FwIpnpd8xhqAHIPwvb+BYNNAFcFx/hlKAdaE+oo2S1BinfGWRIbxkSs2MkLD1F/cuYErQRHGqMzM2Lu00J86xviBDd/GbgbKWzG/N5zLftwnZu9CwmUh0Clh40VoIX722W8BVCuSfckiRR3Zm4BIGni84OuHl49ut2QBxFLXzBT24hxtNT+PJ5XzgoT/HAXuCLBXQ1RECsdp2JTRjTfV364hlfe0GJN92dtVS0v5L7iaxu3YiJBbz3RDZ+AvwRCUhZIY1bej0/Sr+Nvm62tVc03zy5US0e7sX/kxDYV/ZkH8bcWJCbseAXbvOM2Up3Yt32dzzoD3jD6iJvS2Ry0/kOAr33CR8Taor2q2W85CMxphm+vMWZT/xmKBfrtYwT/uOqkLiSVi2938NopYIk5CnJ1mbfu5J4qCrfecS6AYdM1CahV/2TK19Hs7Gl6x2an5tXE46W70D/+W43I+Tx5z83yb2w+EUJDCQf8ABGGFWK4a+i0cMpJ6TYIEuuWYY//JeRnfV3Zg9Bsd7aVbp/fzHwmGxjmir5s2a85DXBEZC7XOEO8Rv823GuoKp1vOSe5cLvEek9eJuQp0mrpPewShp3DWpYBosXmsl4FgbW1hhQIXLAG5xXD5EKJTG1s6eTuT95P8VcF2BbHDtqVqKIOVO5WPerVhlskDJd44MqapwP9fHNVrWRsUZ9MlcNEJlAjb4XkAdSr+7tqAUTnEZWQaFh7Sk+UNdAN0mzDQPYwYxLJSmsLg0m6fgeHwoNwDhpk2xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(5660300002)(110136005)(316002)(66476007)(66556008)(8676002)(26005)(6512007)(86362001)(8936002)(53546011)(66946007)(6666004)(6506007)(2616005)(186003)(83380400001)(41300700001)(478600001)(6486002)(31696002)(36756003)(966005)(2906002)(82960400001)(4001150100001)(38100700002)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBPeTloZi9XQk1nY1dlTzNHK2kzbkdjSHV6cTliaDl3VmNsS0dXTmhOdWJD?=
 =?utf-8?B?VXZIS093blNLNlZ3SVZTME10ZjV4NTFPeDlva2NNd0pRaGo0VWphREdGdk9i?=
 =?utf-8?B?ZnR3VTRUSWVLQVhDdTFBaXVKd3haMnNzSDNodXFKRjVOWmRrOHRBYWZ4UGpL?=
 =?utf-8?B?WUpvbldHUVZWZnpSb0tpNVFxQStFRE5PT1BJZmRLUDNUT3cwUExESWE2b0dN?=
 =?utf-8?B?SVpMM1pvcERqYWR4dTBQekY2cGYweWVrRG14Rmh4SEVoNWVnQTk4Ymp2TUdh?=
 =?utf-8?B?T1J0N05LdHR4WjF6K21Bc3dBaE81YVlzUEE4SWdHVDJmeWJSRnRUK0t0Yis5?=
 =?utf-8?B?Y1BJTGVheXVDejJZTjhCNWFtaFNsL3hUNE8rc1hPOG1TTi9WQytCcWFJUlhw?=
 =?utf-8?B?M096SHJGcVBQOURuNFUxQ2U2elpmYmJnTDFIcytxMnpvL1h2S0xqN0hENG8r?=
 =?utf-8?B?bmhqWUpIMnNHVE94eFZkU3l5aTZhQkIzSXNYOUxWV0NFYThOMUtqRlBPYjA0?=
 =?utf-8?B?Mk9rU0FTa1VCZElzT1NzcFpxZ0Q1MXFkcTlnL2lJclRsTXJUeTJOSGVobG5K?=
 =?utf-8?B?QmZoVTBhOWRTMDhRditzS2NFR2NJbFVTN2VJNHVTd3IzaW5PTmt0cC9EVENG?=
 =?utf-8?B?cTFPOXRFZXg2aG5hekZqYjdtclJqT05SU1lhbGJ1MXpFTFZwRnFJOW9tWVJV?=
 =?utf-8?B?cjZQbzdLeXRPTm5qa3g2ekgyNE85ejZFV3B6dVNFWUJTOGFXdEtSdFNCL1Nt?=
 =?utf-8?B?MEY2bFE4VnN1RmJpb0N2ckNBUlRNRytpUklweXdiQTZiTjdsblg4NGw4Znd5?=
 =?utf-8?B?anlDcVhyREt0VUNUNmU1eWFvbUIzdzJud05JbmQxRTZraDh2YnB2eWxWdTE0?=
 =?utf-8?B?bTlrdjQ1QXVSNzU1eW8zUy8wZ0JDZlZhTlJiWEc3MndpNGtkd3EwY24vNEhH?=
 =?utf-8?B?cjIrdDlDb1dzNEs4TGEwVHNTY0UxVE1PbkZPc1orRWNDUlNEYktYQkVWR3hv?=
 =?utf-8?B?bDBLL21COUhFZHFoNzR6Q0RDa0wzWkt3a3BkUjhyT3BtM0V5eTFOcUV3ZElS?=
 =?utf-8?B?d0NhenVTRE1jSkZTTlpEd2R2OFdhaTVrc25CdkFnS2MvbFh3RlBPN1dVRVJM?=
 =?utf-8?B?a04wWktzNG5DcE4va1BUMktiVUNmbzVBV2ROc2VDbktDV1VUT3ZZTG5NUUZG?=
 =?utf-8?B?WW5EUWF6bnc4Vy9rWFBaY1hJLzg4Q0NIR2dub1VsTWY3SWhkOGIwN2psdzNG?=
 =?utf-8?B?NDZWWWtCZUVCc1d6V04zTmtiQVROQ01HSjZRbmd2dWFQTnJWZFM4eDhWeWxT?=
 =?utf-8?B?RVB0UTk0ZmtsZzB3MjBDU0Y3aXdpNURtYU9DOHF6L01LaFFhWm1IaHQreUR1?=
 =?utf-8?B?SmFoUTVOR0c0S0UzcTR6YnJEVmdVT043UExWOUdIU0JBMmZUczJJQTlBOGQw?=
 =?utf-8?B?Q0luUnZBREJsOGpsUUxtNXNYQ3NCTTBYTU45cUpPa2dxeFJKRWFlRld3SXdq?=
 =?utf-8?B?bFVNNWZOQS9DN1NLM1BVbzJMUU5YV3plZmZPeTVjTEhwbG00NlQxL3Fpc2xY?=
 =?utf-8?B?R0cwSmdLNmt0UDl4cE5RL0lCNTJ4R3Q4MVdySXR1WnJZVVRoU2Y1M28xV2ty?=
 =?utf-8?B?dGtydEZiZnIyUjBTQmgwaitXbkpLVU43b2NXek5CSzNua0FSaUNVU0VtRGJV?=
 =?utf-8?B?RjFlSG8yeHRxSUxOejhpMSt2Ym1qczhIMXRaeEZ3MVV2bkcwZXB6aEJDZzgv?=
 =?utf-8?B?YVh3L0J5MW5Mdi82WXVUcm5DRkt2WFNoVXZRKzBmcFhNelJ0MXBWeFR1eG5k?=
 =?utf-8?B?ZmZFTGN2NEhEcnR5ZG11Z0pqckZaczRJOGZjVUwvY1hjUGpMU1g0UzBDU01v?=
 =?utf-8?B?RFMvT2NyQzBKZzR6aVl0Wm5heTFGOXJlL0U2V3lQTXQ1REx2RlZIejk3OUVT?=
 =?utf-8?B?cG5mK1lRNGtDZDhtb2pNcENMOVAvcFk1SW10Q2tGLzJOUlljODdEVUN0RFhW?=
 =?utf-8?B?Y3Fkc0l1M2c0eng2WUkrcllydUFIOG51a1QwVEp0SDQ1dmhMdTRHZjdjY0dr?=
 =?utf-8?B?eTlBb0dMdnVvTnZ1VzJIZXhlZC9ydVJnNlgvZFlId2N2ektaTjVPeUx5WURx?=
 =?utf-8?B?NFpXUHNQdXpmbXRkRFVNZ1MwcUVBVHdQeElaOEE4eW9BVWNZYmZhYTJiRExM?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3493e1e-a8e1-4bfe-dec9-08dadd06f686
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:38:40.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EVJOmTu6Yh7biUVQZXttz+StgxOEZ2IrMNO5cDC7wkdFMsey9SH+FgBsNp9Lk1TqJCjgWJACe025FmqH6em0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6571

On 13.12.22 13:28, Jan Kiszka wrote:
> On 12.12.22 17:39, Florian Bezdeka wrote:
>> On Mon, 2022-12-12 at 17:05 +0100, Jan Kiszka wrote:
>>> On 12.12.22 13:16, T. Schaffner wrote:
>>>> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>
>>>> Make the rtuo thread switch between primary and secondary mode while in the
>>>> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>  include/rtdm/uapi/testing.h         | 10 ++++++++++
>>>>  kernel/drivers/testing/switchtest.c |  8 ++++++++
>>>>  testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
>>>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
>>>> index f8207b8c7..c389cdc25 100644
>>>> --- a/include/rtdm/uapi/testing.h
>>>> +++ b/include/rtdm/uapi/testing.h
>>>> @@ -24,6 +24,7 @@
>>>>  #define _RTDM_UAPI_TESTING_H
>>>>  
>>>>  #include <linux/types.h>
>>>> +#include <stdbool.h>
>>>
>>> Breaks latest kernel build, eg.
>>>
>>> https://source.denx.de/Xenomai/xenomai/-/jobs/541475
>>>
>>> Jan
>>
>> This is due to a change in Linux 5.16 removing user-space
>> headers from the kernel include path:
>> https://git.kernel.org/linus/04e85bbf71c9072dcf0ad9a7150495d72461105c
>>
>> Kernel code must use <linux/types.h> instead of <stdbool.h>. 
>>
> 
> Then we can simply drop that stdbool.h, right?
> 

Actually, the better way forward is the avoid types in the uapi structs
that do not have explicit sizes. I'll drop this for now and wait for a
v4 of it.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

