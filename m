Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD517CB
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 05:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcR57qJuE/qfHw5KU7mCsjEHDZ6WnI3TcckiGZ2et1WYbfGy/jw2E2jOSD4IKzTLOOpADfe+Lb6sBADH/WTdlwGN8IqRF75SXMuWzl+cyPkK4RN9C3cc4QkOe8m7eNNbXSWZOKWPMZDRUU7sBETgTuGVKIaObH5mHQZgfbang2KG5YsO2loKUuKKiB+xKBMMCWJUWI+u210QRgGszFY4jU/ry2nPJCJgE1jVJnrT5eAFDPOIXqvBKYGs092m1/aiEp/hOz7eEHzaiid85JRBXncih53AinBtB85uceN1krH6i9KepKb+OVKqbrSeSI0ruhrOjopPExkDxyMC39qWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdoW+BmJCiH/TmfVhvIO0RAEr/MryinL82jj57Sb7KM=;
 b=mpSaUy7XChImjuek8iYHlKpnWWRDfP7SaEo4CWRFmGAMewLhG+cHpteF0bFPXQsLlixOqCsZ9JzH9v07fGd8b3Jx2aTCutbJISR/OzalE1B5RFGynp23Sxn0RSsI2/zgMyCPOzyrtz7m4hdkR34BX8+lkEf3el/RMFyRyZxL7I3FiqvsJIog9aV8fMLLI82pUq+AfT07DTtaYC34jMy2ZjH6WrXTQ/MmtX7KORc+gGQMIy8HhcpJQO8sWXvEws/SX+KdD1RNtdi+K/wWQyYujYkKEhNRMjdL1ETju/Z4lRseSYgEXGvncM/GgqXuAArf0IoaINsJJMDSkB07TfZq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdoW+BmJCiH/TmfVhvIO0RAEr/MryinL82jj57Sb7KM=;
 b=WTFTyAvX4/T5QncQnd5cxU+xlmkl5nqblpOC5sK3CBacTvPCN5/PKd4pQeDtgsk5n21qys+kyXrRgTALj65DkTWjTac9nOJqfzy5uEK7HnG2FhvlZfloC/Rwe5rGvfXEpIbUx2jqqtA7T3tfq8H0qsgAoT7KsSkjUqt+BAgHndAmqQDOyAZRx/xiRcpsTSjN4OgB5m07Kzc7GSz8cPLGWbZnwujUlBBd4au66ZiE36ope5I+LN3ggCKvqtIpRMRWsChW2YnCce86t928ASAK2Mwz4F9cbHT90YlvO2vV0uhufpVdSt24VRn30//RAsXwAYmaywIfjeL05dlT5k343Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7673.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 05:30:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 05:30:27 +0000
Message-ID: <42c1ea5f-e648-8a00-6a5d-151c8d1550ff@siemens.com>
Date: Wed, 14 Dec 2022 06:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Reminder: Xenomai community call on Wednesday, Dec 14, 2022, UTC
 7:00 AM
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB4285BDEEACED1195EAC700D3F2E09@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285BDEEACED1195EAC700D3F2E09@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d19bdc9-ec61-4ef4-cee6-08dadd944da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mCx7BOEMi6EFe+s5J7nD4GKkYwIj5HceCefY0hrL++E53nI2ulg2wxIfxNHHqSjkBRH9Tf/hF7OKFZvXhaybAOmGiUhqdJ4/nCH6qH7FfmGS41xCmHF8mwEuDMWArcE8mZnp6+OLDlRBfTbgsO7Xctn7qkLOlnJjieG50kBPimo0jhG1CfXTBGWxdKUzGAq/+LvTQdA/LTCgwqryX/QTvChMUf70hyO5zwLARU6Jazyxf6u/o23msSL+3KkswpGXptLzH5DQSJ1pxTZ6Z1364yl0ielheDsRBfnbKhNkTCuQXPFXy6hNqXI0wY0xsh/+uaiRmUn8jxQNq5eZzR374zSXVBtp0ZWpRdLNXUDUoH5c2zmr/p94N0sSP7qR+glk6K4YKDGuGxte0nanibjzY8jkJxaEG96VmGkr6at1nuY9TX+CpbI8UCpw5UvGWzjgRooOw88tFHVna6gfFYGpNNsjXM8SGdrz+apwGtnj5jasE8z5MCsgJaymkA+voHh/MPez3kll7rE/qs/1cxSVV9EyZ6V3jvOXYHbkpmIg+UTb0U4buRN1dWfjQZsBnDQrHnmLiv6qCpeCMUQJdv3YDL56j60aGIgoVP2Mg32WZftUNXWPar+WqivpykAZeY+hForPvhhtfxfFHzC80pHadUP8dGn9pm4wwvxq2Wm+sm9iL/DZMPisdHWIqamL37AXRGzGe6NSpPtmlDzcG92mixacgju2PgiE+O0VdDL+P7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(66946007)(83380400001)(41300700001)(316002)(66476007)(2906002)(8676002)(31696002)(86362001)(36756003)(82960400001)(8936002)(4744005)(38100700002)(5660300002)(31686004)(6666004)(66556008)(6486002)(53546011)(478600001)(110136005)(2616005)(6506007)(186003)(44832011)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFdMWjJCZktpL3FvN3hOL2c4STFGYUR1eHErTnFUOXp2ZEJlNUpCWS82S1o5?=
 =?utf-8?B?aWphS0NTOFh2cmRLREtqUFFaSTBydlNxeCtQWmNPNTBPRjNCUkpSTmpQZkgy?=
 =?utf-8?B?dElTL09UZFprSlUrd2NySE16LzVXQjVrQlE4aUlmb1FTaUFhMU5RMUh3cVNF?=
 =?utf-8?B?c2JSOXBiYWNxc09PMnFSYjR3bzd0RWJnQWtOTzVLM25uRXEya3JVOWd6UVBC?=
 =?utf-8?B?dVlpY05jZGRHd05DdmlDS2hLMml4ZVZTZHJ4dGxJSGpvaTdlbVRCdmJtR0Iw?=
 =?utf-8?B?cnB5TytDcVRPUnZLdUFxM3pXTVFZOG5lcnBEeVlzNjZUSklhZmh0RTR0Tkwv?=
 =?utf-8?B?RnN5c3FEUFVKaEdvU21TMnhQUDJHYWdBL0diM3BaUHlOWnRIWXdhMXZrczJ6?=
 =?utf-8?B?SktSVnU1QWZSWjBqVU1Ka1liK3lMTHpmNTdSSXE5QlRKdFNQaHhmUkxLc0hU?=
 =?utf-8?B?UVNrcHphdG5wOU1UM3ZPQ1JqMzBmSzJDbDE4Q0phVm45R3dUZ1hxY3dHT3I1?=
 =?utf-8?B?cDNiMUlEenpqMllqZDBYczZPTks2Y0N4NTI1Q1RQenBvVGptSTFhQ0k0NkVz?=
 =?utf-8?B?bGNMMVYzSXBjRHlLeE1KUTg1ekZvMEhYdjh6TXZOS1FnODIzT0s2Q2dDdWhZ?=
 =?utf-8?B?QnpCNlZINGpOZmswMFRMUXpxaUFsMkk4ZnRQRTlJQThwdDc3azdieGljVU9S?=
 =?utf-8?B?eHpTMXBOQnlGMnFoWmhFOTdraHZKR2RGY0ROTmdyc0hsTElkRFRCcm00amZO?=
 =?utf-8?B?QUswVU11L1o4Q2w3cDdrcExDUWVBSVpkdEwrUG1lTndJTjk3YldORytrUU5q?=
 =?utf-8?B?a1ZzYm5tZng0Y2E5QkRieG84ZXBiSlp6YVNINjJyclpPNWVNemNCcnJJN1Jt?=
 =?utf-8?B?VmxkeUVTaFQ4WHVSYi80SFFVeW9qUWdOUkZVTmZxS2tleTRWT25xU0w1T2dX?=
 =?utf-8?B?L3FZcTVPU2UrY29iWjYveStvdEs0NUd1aVpiQVppRlZ2MkpIc05NNGNESDI3?=
 =?utf-8?B?dzgzcDdwY3krYkxqOHJzemhxaXdtak1IajVTUy9xMzhxWDdWSjBTQkNQWDhk?=
 =?utf-8?B?b1FPTFFTZjNEKzRaOXdieUZRTlY2TWszTWRkSndxV1lLeThvZ2xVcDZDaVRh?=
 =?utf-8?B?TEI0RVhrdjlIdDczREhoNDRNVzBhY1lwMm4yWERsNis0a2w4dDRPQmFydUVt?=
 =?utf-8?B?Z05sazZuNThqNVFXelIxbGtCalJFMjA3ay96Ry9RajRyY2Q0NCt2SlovM0Y5?=
 =?utf-8?B?czFKSU1tazEyb2l2NVh0cXZiSVNNQUZYVDdJcVFPbllJUm5DdE10N0IzcFNo?=
 =?utf-8?B?S1N5MS91M3c1NDZ3WE54VS8vR3BrNEZMK0pWRFZpVVViZGdVOEhKTnpkUzZO?=
 =?utf-8?B?K1ZMa0gwWjhtWU0vbHpFOG01MzJGOXRsVVVEam5OK0x1VmdRRXIwMnZlRTZP?=
 =?utf-8?B?UUNzQm1KeWJSdlZvS2dqYU1QTkk3SmlKRjVrQkltRUtXZE5YUG1LWkhRd2dH?=
 =?utf-8?B?eVpQdlVVR3Q0VDQ1Yzk2eFYwVmpRb1pPYktiY3lUWTFLU3JSb0pJZkorU3l5?=
 =?utf-8?B?Z0xmZkFITlQwbXIyL3crVEdhQkhzSlc0ZllqbklqSTE1ZldlaFhGekthcHpQ?=
 =?utf-8?B?MVk1UDdyL2draXJDWTRCemEvN3N1SnczQWJ0a0laUWVGVnpZa0MxVkI1MU13?=
 =?utf-8?B?Y0JXRVc4Qk1PWUt2WkJ4Nk5YZFQzekVacVE1NkZxMHl6cUphUUt3elA5UTk2?=
 =?utf-8?B?ajBxYkdMVHRCbTNROSt3K0QwZWtnWFRwOGEzdE1Ya214OXFuYUtyelhOV29k?=
 =?utf-8?B?S25kZEx0SndGNjFsMFlPM1h0N3BobG94RUJUdDN6RFA0QXV6bFl6RFc4RFVw?=
 =?utf-8?B?TnpGSHRPUDIzY2V3NmhFUVFZN3hjRUI3YkpQM2toWFhMUDQzelQxQWNnRGRh?=
 =?utf-8?B?UHNSbUM2ajdUc00rM3QxVEFSUGdkTTFySVNOOW1tN2xTNlZkYVhkNXFORzVO?=
 =?utf-8?B?YlRsK2dMTzhXZmlDNUJJRlpTZkoxVkRZcFkrWExXRHFaSFFxN3lWcngxMk1K?=
 =?utf-8?B?RHZ5QTRlZXRoTGJLU0k5STUra3orQnpiNXVwMU5VcnBVdUhLblhqaTYvSHo3?=
 =?utf-8?B?bXhySjdENm1nWWVtS216anBkNFlEbmZSQ3l1SFBFZzZJNDZ2T1ZaV0FXaUtK?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d19bdc9-ec61-4ef4-cee6-08dadd944da7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 05:30:27.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bVJGXBfxu8gfj1n3CDEw44EofL90amB0+Muffq44Pa1o+dfYiwwGosllqYqLQ32iatOd5ZwMhCpwRY4B85aqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7673

On 14.12.22 03:31, Chen, Hongzhan wrote:
> We have the Xenomai community call today.
> 
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Dec 14, 2022, UTC 7:00 AM
> Paris, France CEST 8:00 AM
> China CST 3:00 PM
> 

Sorry, forgot to inform you that I won't be available today. Also in two
weeks (holiday season).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

