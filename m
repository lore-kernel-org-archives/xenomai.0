Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD02F2F
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 12:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Y957Cyz0vWPnLuT9dycqrDsVWahJLG5/Y/X0cgKlW0qTFGzsicXgzK2bwILX+lVF7n/APxNJ6OQTpK0w8OxMOWaD7DCwCD+Lg7Bm6CO8kvUhC6UMo5S3mJRYm0Uy8lBnLjQw66K3kt6Bnd4Vqz9KdI0br9xsQw7E9er0E0c3KIYsSeWzOQPPLVDRv3vlnFC5lj8n8n/Aa0aBVAOp03F8qQDOgZRVLsPWcqxYHMseDxaTTB6PM5llpcMfRJjHLxffdJ4FTdcQsPJo5Mygu65Ae8+/HBjjJBLn59hIiwxZlJnH+g7+sDfNVdTerPxbwecJfXNpHmZtieFDRVJJD8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE/uanmL2XG4qUojnwLB/z2MlF3ZDxtDcfTBk9O1H+k=;
 b=Hrxm8UHY2fKpyal98MYyysyHMQAPZ+t+i0xgQC2f//8lHZOXi8X1G++PGNU6wzZ2YQOiYWPvsbT4jMWqRXtA/hZtGg+/2xBUOnyN6BpaN6jsjFPMQxco+QMP2R2C1KYao7eVpGP7mhOrQTIcLbNi92vl/3fNojrmHi9NCtnfB/Efm/YKB8ujY95blDCpqNUyoe9LVMItouGAlGf55bohaWTz5qYM9creFydBD25i8hibmybzKlkLbkNC6OpoPuWgknTlTXWeOFme8lc8ZFhkRkaQrU7YXjkA8YOw+jEJiv1cIUBzy/6hNmqsyIGdHorWY3Mgi+2MRGCM8k/23Stk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE/uanmL2XG4qUojnwLB/z2MlF3ZDxtDcfTBk9O1H+k=;
 b=tAWRU7rctWE/+L44TjX0iJc7WMkZ+VVTdI37iTYGoCDw5w7img+OUx98JANTgdGTQe2rH7cyui0rUxQ0b2P3l2AAFbklmFTum2Gwei2vk8LtXlw2L6ZO94vwc3aw64ynWfT9yFMvBUdQWPZV2bOLI67QmiPwhUZd8hJz0HqDztXIy21KM/GBQtQn8gZDptQvbxK/MxVDWq+ZTQpi7qTV/n2rrwHQdTBr3ip5mTVVu5cizeOOx08axXAP/JhNq+VFOFEQmtigzbWghV7S59lisratyal9/6h+LqK8Yv5EiIRnOnhJ5+CDVV5ZU2XfSO3JUvlxYnlAmEJ90q9OD6gvnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:28:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:28:33 +0000
Message-ID: <7f60445b-3686-38db-92f4-3ae65746bc93@siemens.com>
Date: Tue, 13 Dec 2022 13:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/3] switchtest: test mode switches while in kernel
 mode
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
 <20221212121650.1294772-4-tobias.schaffner@siemens.com>
 <d99de5a7-3c00-8c61-374d-5c0366c794b4@siemens.com>
 <9d5a712df42f12ccb691454e64aa47cd6d6ab63d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9d5a712df42f12ccb691454e64aa47cd6d6ab63d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3604:EE_
X-MS-Office365-Filtering-Correlation-Id: 304ef9cd-4561-4b1e-56c1-08dadd058cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uYEbiNlXuQ+1srUorjqjQ6uap/0jhnIrAjwTn3w+JpsTlxy2QsIieCguYtnemypttDxGEawTj+Zp8lrA2EBvsyZKBFC1DlXQiL45Dy3GA5FhF+OSjRTA5QlV7+ew3hx7NhlBOj2jfKA7Or0Le10Xt0KVze5rL2qvz2mkphOdxXwncHrNYTl+F8M4H+aeEnYMtvv9tTrpGOIBo1qKB2J9z/kPcJcJC9mX6k0A7YST/FRqLl+91nuy5dYPN0uoQo/FhKGrClLOxpwxQ1PCzPDP0ilMaJj/cc/MB6e10YrOAyG5ik6gGS/EUBJTyUoCmmKer8c2mh/UEJYm5cLVngxwawaSwsGgITIdw076uMVnrDXeW8LS15Y6USIckzWzAODFPh1yd/TZeZeG20HC1OGa5IMt0HKwR6QGRyXX9DcahcsgJVB58JWgttmXUBP+ztuXRa93QgSBAfaDJS5da+jectaqP+zIWEzQUqLIaa3gdD2qKWa+vul1sEki6r8l31QWoN9XwY8+0Kt4peyANCqnjQgA8clf2RZxHbTRuVm1AoLHsdCE4DExN+Lba4z80lKnC7PvapOvSU450tFEsIUwljLqjH9y/vAEvVFPDZDvmCCU93FWb+OR/dqcoakjRwRbvIjYjsJajqjTFgiXTqecTJB+wHmZlaS1/JauQk6rWCh1sCsh/LmeTWmZg9cQVdZw5xudIjApFgQ3u/GVlTnRssh2RJ/kXGn8XEkrj+rinAm2RULDv13qbII9XF7642uJS4Dgz2KdX3Z0MjUyRN9NVIEqIWig5xpYGOkwNCc6Ewo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(2616005)(26005)(478600001)(6506007)(966005)(6512007)(186003)(53546011)(38100700002)(6486002)(316002)(83380400001)(5660300002)(66556008)(4001150100001)(8676002)(8936002)(110136005)(41300700001)(2906002)(44832011)(66476007)(66946007)(31686004)(82960400001)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXU2Z3I1TW5uTmdocnJWSVM4b2JZK21ZQS9KcSsrZWJmbDRGeGQ3L09GUVRx?=
 =?utf-8?B?ak1ndjFIWHBSR3NsQXZ5MU1FY29kM0M4MWRRaHNibS9Lb3lhcHl6YUxPcHVX?=
 =?utf-8?B?YTlzRnRTTjdia0dILy9BbFFqSWFpL1ZibGpqVXhSTm1CL0plWHdkTS9ST0ZE?=
 =?utf-8?B?eEhpZ2pMRWdBdzRqRkhKMHFDOUJNSUk3WW85RStYM3pjLzU3QTR6NHZEREVn?=
 =?utf-8?B?Z1huRUtVamNVRFd2ZUVwY0pTL3lRUFdYb3YyOEpNMTRoNm52ZHJ0eVpPemxO?=
 =?utf-8?B?dUNDVll2T0ZldXZzQ1ovTC95MmdTUEVobjczNERvV3grQzJKUVhNcy9Zb1Mw?=
 =?utf-8?B?Mnl5bXpESmJGdzZWeVNJaDJXS1JPR3pWdGFVdmRQaWFRRkpsRTg0dGUrRWZw?=
 =?utf-8?B?N25kMTBqZGZHbE5LUElRR2Foa0JVODl3RWtnQzd4MDYzZXhZSGl3SmVYRXNX?=
 =?utf-8?B?RXFHRUxCRC9hMklTeFJTZVd2SC9PVEtMZCtDTFI5SXd2dzF0Qk9hUkdhQldu?=
 =?utf-8?B?eEF5UW54UXRMek0xaUsyUTRUZzdzeEpWS0krSEhGSmVVaVhVWmhmUDlYRklU?=
 =?utf-8?B?YVB4RGdMalVMMHZyQ2FnNGgxbnA5Z2d1SnozVnVxcHRvb1FCK2FVTVJwZEVr?=
 =?utf-8?B?TjUwY3ZyelZXZ2ROL0ZITGRlanBEYjNHZytVVnpXWk9NYXlxc05xaytJWkw4?=
 =?utf-8?B?L3dMMzZDWGhZUEphNnJ4QkE1cVhKSUhidUwzV25yRHgyV3pDM1VONDBERXpY?=
 =?utf-8?B?UmVpbFVlY2ROUTlUT2pTclpQYU01VnpOM29QTlJSa0p0M29sU01LNk4wNjR3?=
 =?utf-8?B?NHpEN3hlSkFDYmJPeVYwUHVZSVZVaVlnUGlTa29KNkZmSE9kY1NGOUhYZk96?=
 =?utf-8?B?MXl3dEw0dG1saTdxSUN0YUR3OGJ0MkRnNlpZc0R3UUt1SEo3bi8yL3pzTlNq?=
 =?utf-8?B?aEpGTk45WkxCeStvN0JUbGVGV3JNblpaUCtFbGdEcVZmWXdhNlVTVkQrQS9F?=
 =?utf-8?B?RFRiWDB5dFJ6bm9FTU9sU2RkQkRoSmo4ek44cU9MTEtQdDF2eDh0ZXVkMm9D?=
 =?utf-8?B?R1E3ZnA5WHc3b2l4UUpYNVdqZUcyR0NSdFNtVUxWQU1GSkFsanVSR3phVWJv?=
 =?utf-8?B?eE5vR1hKdjYrVDIzZWlYQ1BuTk9DUmhOd1RJRGxtL1Zuem1HS2JqZm8zbHFD?=
 =?utf-8?B?ZWJSK3JoTHZMVHhvSmc1cHZaMExPYkJ2QVM1M1gyK2xqUEM2bm5adEM2Nkls?=
 =?utf-8?B?UGE0MWVhclBXVk5GTWZBbTJmZ25iaTZNS3pGcTZieGxXcU5oUnhSMXJhRWJK?=
 =?utf-8?B?c3lnTTVyaTVkQjg4WXRYVEVzVkpGaENCRkNRNkVkbVRFRC9KbmlGaGowSDRD?=
 =?utf-8?B?ZGlFQ25yMjcvdWxsL0MrTFBvaWdRQlMrQWYvVTg5eTd5dTNmRFZURWZMeVhj?=
 =?utf-8?B?b2lKZGw1ZmNhU1B4a1hISmFiRW1XM3kxZHd5TGFQS3grTmhNTUNzdWZLdldG?=
 =?utf-8?B?R0dKdHhJZjU5WU8zL254VjhUOWxxMnhpd0pTYnpjTnVQakZoWVBrcnlrdGdm?=
 =?utf-8?B?dC9rSVFLOXl3RHJ2UmtqL0duSTczOFFPVzBHc2w5UVBuamNoZjF4bTZIRFN0?=
 =?utf-8?B?SDh0NVJUTWJUOGVPWVRyV0U2UGthREU1V1hYaGJKKzBHQ3Vmb1A2THdJeGdO?=
 =?utf-8?B?NmRUeHQ1cC9mNmZNZjBUMnhraFV5VC9qcUgzVDZZMDhXOWpDT1RDcjVwekMv?=
 =?utf-8?B?enhYeEFFcTQrQ1FsUG5rRFpLTVV3dUF2T2habWxGUWppcThFRXpxRGMySlRV?=
 =?utf-8?B?eFhLUUdiL3NvUGxpUlU0S20wcEs3cGtYbExTV3R4cVVuemtFWHpOSXViVFVS?=
 =?utf-8?B?NTVabHdFVlJ2VWlQNHFoQnhJMkZPcHNHYkFsMVg2bWJyaVFVQ0p4V0l5ajEy?=
 =?utf-8?B?cGZhTlcvdWxiN2xpQytmTkdtTDJTTmdCMUFIcFp2V2NadWhjNVA1MlBlMGJQ?=
 =?utf-8?B?bHJ3SzFaT1VsSVEyQVRPZ0dGenFhZDZNYXdCWmtTWGtJeTdGZWhHVnFCTmVI?=
 =?utf-8?B?eHY3cUptYzV3NlFvU1ZWbk4rQUNVbWNVYTNVa1IxQ0tnOFdLd0NGTnlWZDRn?=
 =?utf-8?B?blZpNkk0YmlQRHdrMTI3clp6QVg1N0liSjVSa0lNcGhDNm1paG1HWDJDWXpr?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304ef9cd-4561-4b1e-56c1-08dadd058cab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:28:33.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms+DvD9f1rovQCNZDKerX5GmP+N+Cd07LZ+WfwX1D9OuPVale7YKuo9MYWvWTZPGwkkqjjmYDk69qNVkiHuvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3604

On 12.12.22 17:39, Florian Bezdeka wrote:
> On Mon, 2022-12-12 at 17:05 +0100, Jan Kiszka wrote:
>> On 12.12.22 13:16, T. Schaffner wrote:
>>> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>
>>> Make the rtuo thread switch between primary and secondary mode while in the
>>> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>  include/rtdm/uapi/testing.h         | 10 ++++++++++
>>>  kernel/drivers/testing/switchtest.c |  8 ++++++++
>>>  testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
>>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
>>> index f8207b8c7..c389cdc25 100644
>>> --- a/include/rtdm/uapi/testing.h
>>> +++ b/include/rtdm/uapi/testing.h
>>> @@ -24,6 +24,7 @@
>>>  #define _RTDM_UAPI_TESTING_H
>>>  
>>>  #include <linux/types.h>
>>> +#include <stdbool.h>
>>
>> Breaks latest kernel build, eg.
>>
>> https://source.denx.de/Xenomai/xenomai/-/jobs/541475
>>
>> Jan
> 
> This is due to a change in Linux 5.16 removing user-space
> headers from the kernel include path:
> https://git.kernel.org/linus/04e85bbf71c9072dcf0ad9a7150495d72461105c
> 
> Kernel code must use <linux/types.h> instead of <stdbool.h>. 
> 

Then we can simply drop that stdbool.h, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

