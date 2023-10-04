Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C96101F0
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2fvQbDMzBlqHJ18TAMgsNlAfM9Dei+8ljo/Mq8qP5fUp7WB+RSieSxu9wmHJ6sTCXDH7t5om1Icfq3YKt3wmjB1/JR6oydjkxgb5w3bEUQfqdl4WpjQN/UQlqQMLEEbHhYPlWepeZ+bqL2z5BVngTHcMvme3l7xGJR8ExxA0u5NLHqSPqZfRjbtInUGcWftw9pk3k/KM7/RF8wbolgRz0Z/KY7nhFnZpXds2Baj+lGQTlRGVEQb/dZauGt8/v4en6YrP7KviKY8oJ5MKsJLXUQOrrNw3wZE6DET7XxbNTbKYBuA9W6v5jKI5xFXBQ9H5ZEXj6yWPTRPG2lUBrRN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRlvr9ybGymsTdpulBWp2H2yeOwnocSuUOuhK+6wbCY=;
 b=DZon1xNQJGnsj5P7Ymdpjqd4s4Q8wsoTV1hekQ3CRKo8IiVLaRznEi+gLnVpCqSWKA6YEZtisMuFmSPBotB1TuGk7gEH1JM665dnI4NAcsqkxALdS9qe4YQSqTyTbybJMoCLfEMpGyQiZ833zkIIjaqUzVyJgLjY7uobxlmsp/UUt+q7mewpgWdqPdTPRUfXp3q3UBFRUpSpS4h0mfkVZfyuGvmpcTlLyVr6d6yUyQExokkdHC8KO5pTO7ws/o6ivJouDwBgd8BUKdQMNTodvLQtRcJ7hGFVJWlbu9WL/pq9haqhZzPkYAjHCT/C6fnj0W6ZRAd2IKcN5hu2FNUQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRlvr9ybGymsTdpulBWp2H2yeOwnocSuUOuhK+6wbCY=;
 b=Ljw51GEzkQh3Ly6vS54vTiSDVLHwguE8Mou2axWS02vdZnw5VjqvZs49W0LVsGFo4n7nNUP7GijbpcbK9uTWELxhftscKZcwmIa21Kg0ieNU5mXV+OnqJFdkYw6kpmyiFZ1NBsEXP9M57l/SKmO3QG3WLyrhsbpAtIO6Keky1LzTzehaK9eBWQcudyVdaXrFDWUovpMZnGYBn42Rb/eySs3Cl8nZgXBpeB+ag2IY7oTkqVdzkGGCI+3cJ7L+6Mg+qj3df/QBXdQMxy7c4GU4sSnPPBV4nBgOupDcLgV1PU/2qwWgJFifG0S6wGjOyv5YLv0o8BWjgaHetECC4lF0Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 08:24:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 08:24:04 +0000
Message-ID: <c3132113-ffd8-4783-975f-4c601d4d0181@siemens.com>
Date: Wed, 4 Oct 2023 10:24:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Call for Participation] Xenomai Community Meet-Up in Wuxi
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>
References: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
In-Reply-To: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 71359439-a1df-47b4-49e7-08dbc4b3457c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	70W+Ikxon/Q/0+or3AjrZi8x3PwwbHGN7hIwDydqjHeAfh5G5+xEVyitXQ37oDT5RY298cSp+QFcYfYMMBtOE4ZEhXnCa77Fu3aAbH2/7Lsn4icGI/Z0AaEOv6Au500BjVyzozUsO8HBOIThOJmiPrhVCmPaFVzrpMg4qNejFem3a4iAvyZJqil4wwVu1tPZAG8GXweX5OkwNoBueOMhJtj3btl637K7lTkIfgTnJqZacGrIDi6FRU9N1lSt1Hdw+Y1jj/RCY9j0g4XrAOT51Go6PjUwSOZ2rlwFsxUROOBkfi0JHoUxmRuagdICgNBEvBoCfjCLogc+TnfZOWrFitJiTIvQkfp11h25OIn3gPObu5tsEDdb03XS+Xj7L3fmwxbtQ5rUvfd5gwJ0TkG691BAtxtT3PmYJ3lFxPGbICcaP5JXQe6ez6valYMW5fe47xopUUV2FeDclzxaiM6UO6JhN0cdRls1ROKbVNiYvfkU552pZyvS2+1uGmYIr2biQNnKP1IEmaaQjV4JiwgmgCrEK37qKxkyMUjTqAv7rOq8FL8jIJBVcWSYm5ijL0Vnx7Ry/UbLnzWsRtY5KEcs3/u/JhFHcHAW3XXbTHmzZ04i6eZv2tFB/XSZYi/lFrMN00U/PU7ZoNt9i44ielmwgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2616005)(31686004)(6512007)(6486002)(6506007)(478600001)(53546011)(82960400001)(38100700002)(31696002)(86362001)(66946007)(2906002)(316002)(6916009)(66574015)(83380400001)(26005)(36756003)(8676002)(66556008)(66476007)(4326008)(54906003)(44832011)(8936002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWF2dDJmMzNUTDRma3hYV1VkeG9NS2g5WXlSY1oxTkNrYzNsMHh3M3VMVzVO?=
 =?utf-8?B?VDBKc1lRS2k0MTRQQ20xWXZmWHpnc01tVEp6QU0vUWFZNENKQk9KWWs1OU15?=
 =?utf-8?B?WWpGYzZ5eHRrMmtpZCs1cENXTVRBOXhZUm1PaS95K3ord3NjVHZIZ3dwNnhJ?=
 =?utf-8?B?VGZaOEF5ZWluUHZnd1BXZS83NHVuMUt0b3JpRUxKcDNsMDhvVTAzYW9DZ1ZN?=
 =?utf-8?B?M2RzbjJJWUg2R0xLb0dIMHdETUF2V09FZ3RBbGJmc0ZCbW9PYm51UWNBN1Vp?=
 =?utf-8?B?YkdBdnphSVRic2ZBRjVyU1BUbnpaK2t2OVJqaXFtSWpSWk1yQVQzdDRObzVP?=
 =?utf-8?B?UEVGWTRsbHpNUGlPRVM3SjBxbTlScDVibm9PNmhtMTFVOEhIUFVBdVpkRnpC?=
 =?utf-8?B?VjhOWlE0ZFY5b0ZnTXNaWEZ3S2g0WDhtUTZnMW9vUDZ4MW5XYmpEdDlRUDVP?=
 =?utf-8?B?YWlKbGZBMUxpOVltSHNrQi9qcmgyT2ZPQmFlZVZwUndTbkpqbng5Z2NCL0RS?=
 =?utf-8?B?c1hhaHZ1QVh0eVh5alJPR1dvMHFwZ0lWSWR1Z043TCszczhRYWVtQjNFSGht?=
 =?utf-8?B?a293ZFRvQytyLzZoT2piUzcwb3dKQzBKT0xzcnc3UVI0anRJZS94Q282K0V5?=
 =?utf-8?B?ZCtPNVVubUJLL2Jnak0waGdQc2NCK2xOdDdHY1R3cHhZbTZZNDVzTVhhZUhC?=
 =?utf-8?B?Q0x3UTNKait4aWJJczk0RHViMjRDZGViL29ONVozSzh4Vnc0d2RQeG5PUHh4?=
 =?utf-8?B?SWRHTmM2YTVoWkVrMXNVaStodDBLeFpzOWtIWngzWVliOEtPZlROTm1SRW9R?=
 =?utf-8?B?N2crT1ovUDliMXRjR3h4ZmJOTjN5VEw5eGVFR29yTVlYU2dRamRkeHBKSllB?=
 =?utf-8?B?S0Q2L2lkaFArSGxDSVMreHgzSEwzcDA0SGUzWkV4T3BQZXdyaFUrc1FwajVQ?=
 =?utf-8?B?VDlRa1Z2QlpQalZudmZPRFlQVERENU0yMllWMEk2SlZ6U0V6M0ZKY2JxMUpt?=
 =?utf-8?B?cGJJRHY3VWx4Tk5hM2pSVmRzOUhzQnhvYVoyN0dMZkU3L2xFOXlkTTc2ZWhh?=
 =?utf-8?B?L3d1UDl3RGxONXlvRFlDRTQyOU9uSURqQkNjcU0xVVBNTGNWUEM3T2EvS2pP?=
 =?utf-8?B?cGpkVzJqdFBiNkdpTlV4RDZTaFUyVHJFdldvRzFDM29lZWNnb2JLL2gySUdG?=
 =?utf-8?B?R2VFMURma0tnMzk5bG5rUUoybEovOFJWNjF3OWh4OHpjWnM0RW5uRU9iWW1P?=
 =?utf-8?B?Yjgzc3ZZamhaTmVoa2J0aVRjNGxDRm5OdnRMNDMzai83M0Jlcm9XL3d3Witz?=
 =?utf-8?B?QitwOVNCbmxWeW1jKzNoQWt4blZSRjIyTlVxNWxkSUhwVFNTeWEwNW5idkpT?=
 =?utf-8?B?TXlqZEZIVGVSZUxpTXJjU2hzTFA5QStsa2pROS9SRExFZmNKUUpzU3VGU0My?=
 =?utf-8?B?QWM4Umx0SEhMK2NSSWFrS25EU3RCRVRGc3FTV2FOMnBkQVdFSWRhVkF4OGl0?=
 =?utf-8?B?YkdMQUx1T0E2ZnhUM29LZGVRNFJqNU8vaFB4cXhYNEwrZEdZVWkxU1EyUkM3?=
 =?utf-8?B?UTZIaXd4NDhlU1dBQ2doZVUyNjlZVXR6NVpMSUpqVkpheVMrN2cwYkY1NVhw?=
 =?utf-8?B?V25Uczh0bzJpTGhwNVU2YXBNZ2dXRzFubWdWV1hyZEQyVkZ1UFpCQ1VFTHov?=
 =?utf-8?B?V25BS1Q4RTRnYXR3dHIvTXNrd3dzUDNLMlNVdXNONTNhdWtHTysyajV2TjV3?=
 =?utf-8?B?enVQaURGTzAwaUd0alFMS2pPVkI5SFI3WUNkN2ZTZVp4T3M4S3lmYXMrSC9n?=
 =?utf-8?B?eHNEVTcyQWpTRGhJUDlqZmo2UnpoV2N0aHlienVpYXAvNUREbk90dEJlSUVz?=
 =?utf-8?B?dERkQVQ3WFQ2bDZCZThIMWZrSXZhOFB3L3M1UXFFdG5OelZEVHNvVTgxTmhv?=
 =?utf-8?B?bU5NNHVPS3NUM3FzMFdxeEZoM0lQbUNnNUxhdjNRZThRUFNnMThYcXBiWW5N?=
 =?utf-8?B?YXhzaWFlVDhGQU1yQWRtbENEbnVaWksyZHRuQXpMb3FiYUprQmU2Uk5IODlr?=
 =?utf-8?B?NnZhQmZyTkZjQi9meE1lSG9IVnVxNW13bFhFQnYvR0U3dVFUdVNwWmlmblUr?=
 =?utf-8?B?TmVRaS96RjlCakh2Q3FjVnJZaHNnSXhyM1J2SEZYMXgyWUlFTGlXOGE0QndC?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71359439-a1df-47b4-49e7-08dbc4b3457c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 08:24:04.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l50UsHS9JPJ8eP3rZz5+wHgTbHo/uf6X17pt5Nny7cQI+OMnpgYOrDF+LXHPZwey1rwB/ShBMYrOigJk+DyZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5746

On 12.09.23 18:55, Jan Kiszka wrote:
> The Xenomai community is planning to hold an in-person meet-up with
> presentations and live discussions on November 30th in Wuxi, China.
> Attendance will be free for everyone, just a registration will be needed
> because we have limited capacity. More details will follow.
> 
> Xenomai社区正计划举行一次面对面的聚会演讲和现场讨论，
> 计划于11月30日在中国无锡举行。每个人只需注册即可免费参加。
> 由于能力所限，更多细节将随后公布。
> 
> Sessions will be live-translated and also recorded to share them
> afterwards. One session will be given by the Xenomai maintainer on
> the latest news and plans of the project. We will furthermore have a 
> slot with Q&A and open discussions. Beyond that, we are looking for 
> talks from the community, in Chinese or English:
> 
> - How are you using Xenomai?
> - Are you working on ports or extensions of it?
> - Do you have best practices to share?
> - What do you expect from Xenomai in the future?
> 
> 会议将进行现场翻译和录音，以便之后分享。
> 其中一项日程将由Xenomai维护者提供项目的最新消息和计划。
> 之后还会提供问答和公开讨论环节。
> 除此之外，我们也在寻找来自社区的演讲，内容中英均可:
> 
> - 你是如何使用Xenomai的?
> - 你们在做移植或者扩展吗?
> - 有最佳实践可以分享吗?
> - 你对Xenomai未来有什么期待?
> 
> Please send your proposals consisting of a title and short abstract to
> jan.kiszka@siemens.com and hongzhan.chen@intel.com.
> 
> 请将您的提案，包括标题和简短摘要发送到
> jan.kiszka@siemens.com和hongzhan.chen@intel.com。
> 
> Important dates:
> 
> - CFP closes:            Sunday, October 8, 2023
> - CFP notifications:     Wednesday, October 11, 2023
> - Schedule announcement: Friday, October 13, 2023
> - Event:                 Thursday, November 30, 2023
> 
> 重要日期:
> 
> - 提案征集截止：2023年10月8日星期日
> - 提案结果通知：2023年10月11日星期三
> - 日程公告:    2023年10月13日星期五
> - 活动:        2023年11月30日，星期四
> 
> Looking forward to seeing you at the meet-up!
> 期待与您相见！
> 
> Jan, Hongzhan, Rick
> 

A gentle reminder to all who haven't submitted something yet.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

