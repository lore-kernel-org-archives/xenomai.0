Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF9187C
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 10:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqUEKJOCNWSsLlPHp2bjg6bXLcDwutUsKuVWWAOkmJnl5A9vkPkmV0eBJJwPjdS8fbDdghKpwu5RmhpM567fCBOUlYdmQO+mWT4KnyV6KFTr3zryndFECtnVQiRELvSPkz0YEMxLplatcfZ0s9WbZMJP/jP/n93icTG2Wt7tJBBcl63AQ0juBOAbvjzwzvexJ6wltawzUn2Ku1xPqFp0p8bJoxYvFbRlQT+imehCBGKWdWTO1gDJqzLBT3bMrEOoHr5HPv1GP8eFy7utjn3kTPE8qoxU1aauy5FvU8ipGGQuiTbQmQPN8oXiO3B9s0k1AxbChg0Y9ezMOvUbr2Rn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnmqmLWBmuhcdJ3FTLmFLdP+pdIUfcF5QqCnoivshcE=;
 b=n5a3jSVomNvYO2210zADeNFo1YNEQeZABmI4gLp32+TPmuXwpwp+Pk6sYFIhZldjhiFOu3sAsywCgCOGAl8FWs0InojDSVGwgx0dNsxpr6Feq8x47hx6XVTLD3BqtXSu6m5Fy6zUh0eMn9rZ9lLKeIPc+Xf8nlnuRashaNf6WEPasf7wYk0LHHu6XT93HsHMY9JBwhFqt4USKHXJoYbHdoix2TmVEZLTVu58YnvePnOSs5/q7m3TgRQhCK2Tkb7cPn+pLSExfV2kbxkEuEXsTBgKU2rvdOnex4KQFtZS4Z45zUjizw6ERyAMPx3LKZDaEN7v78FQkGE/cVzGkhs/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnmqmLWBmuhcdJ3FTLmFLdP+pdIUfcF5QqCnoivshcE=;
 b=YwQS1Ya6bIGL8TMeN+hr9lufPn//Yz9dK6jcqzv3gsd3mN1D4cWdGjaAOJP7avxCMyGUHECM0w6S4lDEO4l/SotkzOLjmqOmOPdMjKguJ9+Tl7PVz7k/Y+sIXh1kXZlMEH4M07+hG0FoLxrkDUn5dZhLVqv5/VZd8xLO+udud5FeZcb5VdhHsj/F1xpQXY0QQvsZFLXxPhzvSTdt4QPNjof6wqokkzAxpsb/41XSpxt/qMKHJVXw3cLQBN4lmQa22XZhbhd/Dc6IWiWbEibJaqq6hgUtHX4jYSQfs8UHnIL90H2f8ktK8DQiwSwdLIsm4y+vqTevn32LUYMP0qAgLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 10:38:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:38:27 +0000
Message-ID: <6ef7cc61-bdce-6f7e-57e1-8a272f468252@siemens.com>
Date: Mon, 15 May 2023 12:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 "Schaffner, Tobias" <tobias.schaffner@siemens.com>
References: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
 <VE1PR08MB4909999B96106DD25AE0D19D92769@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <7bb48d32-0c2f-18bc-8d66-cf969e6be74b@siemens.com>
 <VE1PR08MB4909DAD1B4F37E9F4D51B2E792789@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909DAD1B4F37E9F4D51B2E792789@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e50d1c-ae88-4010-8ed7-08db55308444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	btjP39KnDiJ/vDkx5KTK+cGfwajX44PK4WgMeCjwjdmY2PaFzGZNrTVqqQFcfLP+XbITetSIYd5WM3zcnmPLVYV18s/41zCm8yT+SypBDgybUXGL1U+Qrglc6I7lY17lVJ+DrUvfH5DCMsOEr3cF+ip2vFflt/mlgiUEUVaaxmWnHNn+vRee35KbFbvXDFxrOw+huh9fXGT8cMhjx4e7Sb1dHYNGDjQEhDEPAHxBFuCqh0MssprZh/CgYJmXbyE1eXEEcGTu8LVavneaoXTqCITrxWFWeV4AfOpIKN6NQo3wuSYXUgWAELnEwEyy8Ig1zAMWZyi/ipn5AeUTrN2+Kze+l+UZbOKEEdvIfLkRFDn9jI6lcIAY5oBWNoiVN/GV9Q/6rFEkESCoS+K6H7lS5RgGBeMQ4KwrKZvQ/cgMwREEMkdDiClpIJT6L9+fETI9WyLXnfDmAEl9zMRqHUEB1K4DZpkOWiUwsYy7fhrtfR3JfD31sDGpKwTc2c45H9bo27iWCeu3Loe2ABrMOA/Ozp0LAZC3Bj9j977AHjvQMNqOOWsnBxjmIjx0ATApE62+suKS2BJWuWEzFwsWFNONG5NJz+dlhcgp54oib6l4KJKF4BXkKAS8U73hFI4ny9AYHr1GhopXB4LyBOa+bXrByg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(36756003)(86362001)(110136005)(316002)(66946007)(6636002)(66476007)(66556008)(6486002)(478600001)(5660300002)(8676002)(41300700001)(2906002)(6666004)(8936002)(44832011)(38100700002)(31696002)(82960400001)(6512007)(2616005)(186003)(26005)(6506007)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN0OXNaQ3ozQUZTVExNMW5sY0JxYTJkZDdhN29DNHdBZlY3NHdGa1NJMHh6?=
 =?utf-8?B?eFRoVDdKbVpkUkt6aGlMTU8renVBMVYyd01xYXM0ckVjSlA2QzdLdVczOEpj?=
 =?utf-8?B?M0ZyUURaSTAxdE1EMDdDUHhTWEUxM0ZJSkg2UnVIZ0hTaU12Wml6aG1GV0Rk?=
 =?utf-8?B?czJaRldDbWxKcDFhTXRudk5yQXRidmdyS3JIVVRsV2ozUFBuYnRQU2ppWG5O?=
 =?utf-8?B?TjRxcWRYTUpnY0FKV2tNNEwwR0Y3TW1ucnkxVkcxc1EwZTc1SDRDNmNzSzB3?=
 =?utf-8?B?MHZrd3dnSU5vTktMOUZjcDhVck5DZzFRSkVGVFJlUnNUOGsrd0laRXpJU1NO?=
 =?utf-8?B?Z0wxeDBONUE5RURqYmQxU3ZJQVVlN2cyMXpJREhjMHA5b0dLWGIxNWFFL1d4?=
 =?utf-8?B?eWUzR0orL1RMY01mSCszZTVBcTFBSXUreFN2UkRpWWZvQ2MyNGYyeExNUTJk?=
 =?utf-8?B?Sy9IVncrWGJJTFZXVnNpOVN1RzlYcCtJK0UrcjhQbzBKc1lBdkd0VEFtNUJJ?=
 =?utf-8?B?QzQranFZYWhkVlI2U3FlTndWQmhKNjYxN2JQUkhicGYzUHpXNU15bWovMjRN?=
 =?utf-8?B?bC9Yd0VYbm82aXVpRTJlSlliNi9JKzNEeHA5RDh1c0Q4alFKdHdkNzJYQ3lZ?=
 =?utf-8?B?MTZHd29zMlNleHJQUGJyWWhLYWtIaFRYZkxQaXpCM0grd1ZzdExxd3dvVGFq?=
 =?utf-8?B?d1JKNXVQNGhiS1hYTi9zQVJmKy92cFRyZVFoUnF6bTRTNEFxWkpLemZsMDho?=
 =?utf-8?B?WmYwdDJTODI1dHU3RTdxa1JEcHNJb0luRXFxYitFSnRnMzhWNDNCaXpLSUpo?=
 =?utf-8?B?MUxVUW5ZbGhqa2xBN1Z2anlycWJWd3RLZmVBYTNKb0RmWjNFM2dRMXlFOHll?=
 =?utf-8?B?L1FBaHNKdjh2YzJETXdQbUhuWFNiM0JHRmVzdHdackkya016UERaWEljNEV4?=
 =?utf-8?B?RnFsSUlIbzBDTG9NdXFXWlNqc3ZPYkt2OEZvcEdzSFJOME9DcEU5UHVqdnhB?=
 =?utf-8?B?N2hRc0ZrYk5xVmc0ZGFCbUN6ZTlhYW0wQXErWUZOY3ZNaU1BUTVEcjRreVQ4?=
 =?utf-8?B?L0FzN2pHWkIzOWZiWVg1dWlqUWxnWTRabENDaHdaWVNZTUk5ajkwb0pNV3I5?=
 =?utf-8?B?NWxrb0lzNGxFWDdqQUs2b1BIQXA2SWljL1Z1Y01lMENzdGJWQXJrUnowN0Zs?=
 =?utf-8?B?Tk9aVEtFZWlGY3YrNnhESUFPKzZKdGpFZ3F6bFBrUmxraXR3UU5rRU1TeU90?=
 =?utf-8?B?NmNpN1dNT2RnYlZlNlg2UXVWSVBNK2dJUXlNOW5KOWNmTjVpSThYWXlEZ3hw?=
 =?utf-8?B?UGFldVFGQjBwcUdrcHpaT0RQZmIyWnh0TmhCQ1NMMWJqN0F1dzRIS3Y0UWZr?=
 =?utf-8?B?V0ZKdFdqWnlrSTJKemdnT3VkT1RscTRYdUxqZ29mazduRGdPd0pGZnQ1M2Rw?=
 =?utf-8?B?enpwQWd4b2Zxc21lSSszeW50N2FqdXNMQXJTUTN2K21ad3RTNnJWYS9kb3Fs?=
 =?utf-8?B?RVkzOW9zdktiMzEvUndYZkE1bCt3MldISEJpckh0RWs1OEVYMjBiRzBTbWRw?=
 =?utf-8?B?ZEMwdmptRThvRU5wME8vUmR5eUJPT1YwN21NRjV5Z01aeTQxSFpaZEhFamNG?=
 =?utf-8?B?RGRWZGZ4ZHBQOHkxMHh4cXFlQ3JJSXRpTzJBVkoyTWhlVEhYSVFhcU1SSm1l?=
 =?utf-8?B?bzBaanBLVFB5bTBXa1ZTNGsraVlYOXpGWFV2djBJem03UGdNMUxXWTVLcnlm?=
 =?utf-8?B?ZVNsTG9sVGw4c1kvWDNoNTd2VnhQMnpaK0ZaTkUwUHpaanFMeHZRLytjYVZo?=
 =?utf-8?B?Y2lPV1BqL3BKUlNzL25CdXQ1Zk4rK3d2Y292eEFzMENxMTQwUDZiZ1lrdzQv?=
 =?utf-8?B?V1BZSVA0UDVXb25GN1pIeDVUeE9LMHNhR1B0NnhQUk52UWQ3MFozUTlRcVRX?=
 =?utf-8?B?YTVxdFd2RmQ1eVNha2dlR1pDei92M0lpYmNERVVmczJTeW1aczRJQXhBMG8x?=
 =?utf-8?B?RFJtK0VaL2JjU0d2a09IZU1tclpFeHpRZG9PODRkYnlhUVBDS3UxNEpSTjZ5?=
 =?utf-8?B?MEFHVTMzbTEzaGhxd25TclJ0bE45U3NBUVh6aFlsZVhHNG0yY1hqV0NoWXVp?=
 =?utf-8?B?VEhMSDNSTC8vNWpnVjA2RGJmbXgxV1RLWVQ4Um1Pb3dRSG1OdUN1L2VlVVBu?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e50d1c-ae88-4010-8ed7-08db55308444
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:38:27.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AdXuVk4P8gfeWxxjYKCoaUkSf3dAG+Vi3TzPMrPt2ZuZ7flGRoau0m3BxZcHIV+l7qYPsz0hSTj73xVIg/EWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7165

On 15.05.23 08:50, Johannes Kirchmair wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 12. Mai 2023 19:39
>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@lists.linux.dev; Schaffner, Tobias <tobias.schaffner@siemens.com>
>> Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
>>
>> CAUTION: External E-Mail !
>>
>> On 09.05.23 15:17, Johannes Kirchmair wrote:
>>> Hello Jan and Tobias,
>>>
>>> I just dropped the patches on the mailing list.
>>> For the dovetail functions I took a rather naive approach, using most of the
>> frame setup code provided by Linux.
>>> I just tested it for 32bit and 64bit x86 Applications and it seems to work.
>>>
>>> I also added a tool rt_signal_hist that runs in a cycle and measures the time an
>> exception handling takes.
>>> It is afterwards put into an txt file that reassembles an histogram of the timings.
>>>
>>> Unfortunately as a 32bit application the rt_signal_hist tool does not run to
>> completion, printing the following:
>>> " Xenomai/cobalt: sleeping while holding mutex
>>> CPU time limit exceeded"
>>>
>>> Maybe the naive approach is not so reliable ;-/
>>> Hope I find the time the look into it.
>>>
>>
>> I looked into the x86 signalframe helpers before and found some traces
>> of locking that make them incompatible - if I rember correctly. After
>> that, I dropped the idea of just removing the "static".
> Do you remember where you saw the locking in the code, was it rather obvious or hidden?
> When I had a look I did not see locking in the functions I used, so I thought dropping the "static" would be fine.
> 
> Would you still try to use some of the functions Linux provides?
> 

I don't recall too many details, specficially not which kernel version I
looked at. Maybe part of my concerns was that I started from
setup_rt_frame (rseq_signal_deliver), rather than x64_setup_rt_frame & Co.

I was now digging into 6.3, and one area that is sensitive is the FPU
handling. We end up in fault_in_readable, and I'm not sure yet if that
is ok. The whole FPU save/restore needs a careful check, or more, if we
are not violating the assumptions of OOB.

But did you run your code with full lock debugging enabled already? Did
you stress faulting sigframe setups/restores? That would be needed as well.

>>
>>> Sorry for not putting more effort into this so fare.
>>>
>>> The next most important step in my opinion would be to define a clean interface
>> into dovetail for the signal frame setup and restoring.
>>> Actually that's the task I consider one of the harder and I am not so sure how to
>> approach this.
>>>
>>
>> Exactly, and we need to involve Philippe now soon. Let me medidate over
>> some interface options as well. Will pick up if you don't find the time
>> soon.
> At the moment, I am not event sure, what the next task would be to continue with this feature.
> As I am not sure how to define the interface for dovetail, I hesitate a little bit to change the code as it is right now.
> 
> What I could do is have a look why my hist-tool breaks in the 32bit user space case.
> 

Agree, this needs to be understood.

> I also could try to provide an idea for the interface, but I am not so sure if it is of good use, as my knowledge of the Kernels internal workings is still rather limited.

In general, requests from the co-kernel core to switch to a signal stack
(signal setup) or restore from it (sigreturn) sounds like a reasonable
abstraction to me for now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

