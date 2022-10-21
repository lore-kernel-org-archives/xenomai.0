Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236073D6E
	for <xenomai@lists.linux.dev>; Fri, 21 Oct 2022 17:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKbXrxC04EslL2wMezjIXnyXABAsKfEz8JFHPsNEJEGUPfdsyyHk1WiqQU8qm8eAUg70b32avsgWwc38WJ4pN+B81E1iCdgyaeoFemyNocZhJ2sTWUiu+7dKLnViV2ke1O2w/IY/RHFPHc+0VYyU8oSzKr9qd9LmegT9XK77Qsq29lKJNdcfBNVaGEm4oKuLbyWwikafb0UNP7v5MCg24eR/EyYviVm0t7haiCsn32qWHsAlzewCIdDTuPSKc9IxXjd9hB5+1GsWCI7uVUV9z8SnJGuRvqRhx0ukC7alcFh7zWPnVplt6dINeNhWP2JP3tlxyDonrGRD/Kwo42NSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69xqI9osVQmfaoqm4dBVkBxh6g2Bip5zRHLCEXHlRJI=;
 b=L3tlfuJwJhW4rtI0UkDHl9neEmYLCBZfEMpYxM+XhogS4ikI0FR8ooWXs4DGsaE3Wk7jqimHeDdJW4V0kwv54Yi8Nl7jr6uP0pM1CKZHGXeT7OMdYNyXxU7Y54Qe9T958UCGEDGczHbbmN4XQ2cET5BGDV/6RJigA8o7Wc6TT8TeFdzaiZunZirB/29EkmslliITpsHLEmZuHfDj1LEG46uZch9lWmU8R8MRT6f454su/+YeQ8JWg8e0jn2eSMAQ8CrWBfH0/t1R7wudIBTYAn6gooc0LJtWiKOaM25u3GmRnAoW9onMSA7qaJJsuOPoS2zVKHHnb/uwYuJb7N7m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69xqI9osVQmfaoqm4dBVkBxh6g2Bip5zRHLCEXHlRJI=;
 b=p6V3UAV7CIAy7LceDd5DkqqBjWh8ZP/g7tZ6+EZ+U6KgEC1npn2V9tCUHGKj0VgD1nLO09UQSu5t7eU0oPjWLtDRfjg6N6wH7GsAUsVjfKKfrVRNMYrJuuYOjTlQk6hl5cNYu7jmdidj9mPKmeKtoFSjIJCFQsCBPX5ekpWn1yJ648Ps3F3LhfbaxRNkFumG8SDQn3ZCv+h4Fz4/k8A7zv7rWdp6awEYm9JA6OxYUdmLuuCWSXboO1xwNCcAdc9uNxKIRyP/LTWSHh6yFwL3kaRNnW257/TNybwI9/rpmwGNvmEBUZoag19JHm1Qjy8veBKZpjomFyVjzhOLh7ipDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 17:00:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 17:00:31 +0000
Message-ID: <eca5db9d-5e39-672a-e190-1c8ee6dcd813@siemens.com>
Date: Fri, 21 Oct 2022 19:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Wolfgang Denk
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
References: <3fd650da-2c9a-689d-0771-2bd9285bd207@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3fd650da-2c9a-689d-0771-2bd9285bd207@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dbf489-79a4-4b2a-4a9a-08dab385c350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	igIlo+ufvgh/oParZK0alFsTDcyRESme/46VDOGXXQa2vkdmTAjLKNp8X64k3WYZbZDXdE3odn2Zojl3D4Y6AlhZvM9gDmUjpZJRooy2N/XJUJSuMphDWG4QZxG+zS82bwNYR7eh0+G1V9/Scyms53EEll/zKs7iAL2gE8KPI/EFCDwd1NG1A+/ePZu7vZ/eWsUohJ6OHUt/CZXwFJ0G5tortjB+6pWTqneCaR6uP0caW7EHGBEL6e+Pss7vNZ1H81pahbIg2wpEylRyQRto03ONgwE49f5YyJOhNQo78XG0lA7IExkRNWfzVgHoQClOcUiwBrsQMSMcoats5sKUV5JOUnzuS+QPeHvIxER4/hTMpH0II5M1GHVdfLk/Asxg2WCy7xuOWqxmhl+otDNrkJt3PaKNyidaNtwIoYkAhDrBEiHNhFTY/KJxjV7iOUcWdRGbx8ygxLy+P41TUVbqlCC6gpecGemXrXhfKwb2wIXBwe/HpoqDPJVrmV+xgvYWhMA819NdRgLxoPCfC7yf2aYSqcqvRnPHhYkaQK0px+rbq40K3pW5XHitfijYpsZ+caLHOR6QGv2wv5ovaBHYtPbsfSAs8UyXA4uTFhJiA/22h6Qj7MtDm9cnsLhmdodhQpX7KJth/t1B/35VlekwuG2OAdjdhjqCOX6d0XAD+4Ows6nXgnRdKbCTkHAzcduLXz7pDmAFpM8xefj6OvnQ05j97tjyE70C5jWowzNc5+eI0s/C89RiPPKto8nAnKAUPV9CnyUD2Rqc0N8sLp2O5GtRpLwXHCLcV0DfDxprjao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(31686004)(66899015)(36756003)(86362001)(66476007)(66556008)(38100700002)(31696002)(41300700001)(53546011)(66946007)(5660300002)(83380400001)(3480700007)(2616005)(6506007)(55236004)(186003)(478600001)(2906002)(7116003)(316002)(82960400001)(6916009)(8676002)(44832011)(8936002)(6486002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tng3OFBpRGlUUGpoZDVMa09wblVtbFo2R0lERjBsSUVITWF5alNnV0tYTUJo?=
 =?utf-8?B?a1RTQkxjdTVhWm5NUTZjZTVPNmtyWUpQOXY2bWMzUTF4Sll2dW81MHhXVWxh?=
 =?utf-8?B?eUwwWlhqYnhyaGJ4NmFDUjliVlZhSXRiNy9nRjBjZTFFa1h2NXZheFRCUlNM?=
 =?utf-8?B?QWRkSm04bWFlQWx1bFRabmRubFR4VFpMUXlnSzdGMC9nZnRNYjFKWUR5MTFS?=
 =?utf-8?B?MnN0S0VvcjVIRXo1bWRrZ3E2L2Qvc3FuMjJxLzdpYlNNdHI1RWtHSEJWNVNo?=
 =?utf-8?B?TXFvM3B4ZjhUS3lIOGJJeHVDMjFJQi90SjlTTWdldHdZa3ZKcW1USm9heU9F?=
 =?utf-8?B?TFYxTUFWNFI4c25zWnh2ZE0rZzBBaFdzNmJhUWE0QUZrcDY3eDRSREcwUzFI?=
 =?utf-8?B?UDlsbXpjNTc2VEUrbTVJQzBpNDRJWVg0dDQzTWZQRzdIR3hzNVFqU05Zbk96?=
 =?utf-8?B?ck9XVCsyNU0zb09IZ1dlTWdFcWdHWktMYzZqU0RBUWhKV0t5VjNuR0JBSWJh?=
 =?utf-8?B?YWpySjdSSE5DLzJXTWtNeGc4U1V5ZHQvZ3JJbFBkTys1N2JGbFhkbVJiQkxH?=
 =?utf-8?B?ZzlQWjYxTEtIYnNIdDA3eUVodDM2VHo1NFFTOUdPczA2YlBEUWZNVUxEbUQz?=
 =?utf-8?B?YjBHYUpreDlJYUJoMkVLakd6T1ZOWFdJMFlxNm9oVU9vVGcxZmV0dGdES3Nk?=
 =?utf-8?B?UXBmWkZwRjNhaEd1ZEZFb2NJZzJURG1kSXJhUFlUbnQxQjNYVDRSR2phMnVU?=
 =?utf-8?B?Tnl5VUQ3SkIxdmZLbHZMM3Y4R1FQUmtxdEhLc3lZL3dPUmQraU8rclBVcGxu?=
 =?utf-8?B?UUc4QmFza3JKNzZLWXl1SHIyM3hBdG5ZWmZVOUE0d2hhYm5URGVKMWxGS1BI?=
 =?utf-8?B?bkIxcWh6c2JOQnVmQnM2TVI1ZDFVU0tQd2U5aFhxR2ErWVdONkZlaUR4a015?=
 =?utf-8?B?MTNaWU9rcWtmd1JHNkVMOGtVc1RLS2E2Z1RmUzRlTjg4V1RGWC84bElxMzNB?=
 =?utf-8?B?ck9QV3lBb1dFT1NONHJFWEE4U3RpVXZhd3VVZHBHUkVJOXlRTHcweHBUQ2Yx?=
 =?utf-8?B?aEdoZnVud1ZmVHdLYkhjZ0ZFTFNFYzFaWmp0Y2hobVlIeXcxbkZ0N2FJZ2M4?=
 =?utf-8?B?ZkROV1Z5dmY0b3JGS2FXTS82dFVnQURKNmJvd084cTliQ2h2T3h3REhmQ2U4?=
 =?utf-8?B?SzVIZXoxWWMzTEtVOWZEZDV3Z2t2OExqQ1ZLcWV4Z2JldG8rZkYvdm5OTzJl?=
 =?utf-8?B?d3dKM2Nmdmd5L0JyL2YyNWJNdXY0WUpMZWljOWxrUy8wV0Jra01oRGxrc1pH?=
 =?utf-8?B?TDBNS1pXTTdZZ1pJRndpVUI0TkhDdTh2cFQxWEZnWW1sVndMY28xYU1jTDk2?=
 =?utf-8?B?VkRQVFhicnBsWmVITDhGdDRLUGU5MXMyTWFON2Zzd0QzTUYrdUE5QjZJVmd1?=
 =?utf-8?B?QXNPNU02ZFV1b1NCeDBOS2kzRU83aEIvdnI0ZVNyZ3kwcG5FTzFueGJLOC8v?=
 =?utf-8?B?b1hvYWp1SUJPUjhnZTFscXlvRndRQ2JGRytjT2QzekVFOXRQZXdMYWp1dG5G?=
 =?utf-8?B?UDBOa3FOczBRaUU4Rnd1dmRKZGN6cXFwOHVkRDk5R3ZEa1N5UGdKY05vcEI3?=
 =?utf-8?B?SVV5b01XZyt3V3lqUmFld3Y1b1p4R3QxYzZVejVWb0VUanJLYlNLc3NDdlB0?=
 =?utf-8?B?bE16eDRNRHlhcUlFUTJUb081SUZucm9IQzNjTENtL2NpMksyRkl6dy96bGNz?=
 =?utf-8?B?VzZJeFpkTUdtR0xRQmlZbXhJN0t3Vk1jempUNVpoQTJyTjh4K2pqMFV1cHcy?=
 =?utf-8?B?QnZKV0xjSW5EUy9HSG94anZiSnd3SlpQMDJ6Z1BxZjRyK2NwYlpPL0VKOU9C?=
 =?utf-8?B?amM2RkRGcUk5ZlhET2pXZVBJTVlra0ZSYUlMMzlINUo5STdMVG5Dd2ZpeXJj?=
 =?utf-8?B?aXdSUkkrdzhVV3dWN3BVNy9KZ05oV1R0dDJBSkoxdkVzaFl3VUl2OGhmWHlv?=
 =?utf-8?B?TDgydGY5TXFlZzNjZ1Q1d05jY2xOckJCdkFBMTVsa2R0RTRQN1E4V0YwWGdu?=
 =?utf-8?B?M1VRQ3NPdDV2MWFRRFI0MFhJYVZoSytUWDg5WWQyeWJTUHgySWFRdFEvdFdX?=
 =?utf-8?B?MDZBV2I4THRxNmxIODYxUVY3c2dQTHlFZFR1TTAvTVBHZ21DMW4ycjZuMElD?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dbf489-79a4-4b2a-4a9a-08dab385c350
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:00:31.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVTVqwMW5VDz7sshKaIpmZiIaPoL/p1fxpuhLpIQGsE3twpu5t7fjixF07x6YxXFF5OFEQpO7oEtH3NYMgYh8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7768

Dear community,

these very sad news arrived just now.

On 21.10.22 17:11, Stefano Babic wrote:
> Dear U-Boot community,
> 
> it is my very sad duty to inform you that Wolfgang Denk, the father of
> U-Boot, passed away last week. We have lost a great developer and a very
> good friend.
> 
> I met Wolfgang the first time quite 25 years ago, when we worked for the
> same company. I was hired as consultant for a (at the time very
> frequently used) RTOS. I had no time to introduce me, because Wolfgang
> interrupted me with : "Just install Linux !". Well, of course I did. It
> was the first good suggestion he gave me. Many others followed.
> 
> Wolfgang was a pioneer and strong supporter of Open Source, in the time
> when Linux for Embedded System started its first steps. In many
> occasions he had strong discussions with customers to explain the
> advantages of Open Source, and he rejected business contracts if
> customer was going against his principles. We will miss him.
> 
> Rest in peace, my friend
> 
> Stefano Babic
> 

Also in the name of the Xenomai project, we have to thank Wolfgang a lot
for his steady support in various ways, not "just" in form of our code
infrastructure. His strong community orientation secured many
professional contributions to the Xenomai project over all those years.

I met him the first time in person about 16 years ago, when he invited
me to Gröbenzell for having a chat on the potentials of Xenomai and
RTnet in industry. I admired him for having a business around something
that was still a hobby for me. And later, I enjoyed finding his
upstream-first contract conditions in offers to my employer - while I
still had to explain this concept internally. He was really ahead.

Thank you for all the Open Source, dear Wolfgang!

Jan

