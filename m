Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43966FDF
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 10:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVP6QA/1sdks26tnlDa00BgwgU4wFhdCJPcrB4H9aKP6sM/zXyRZg6p6snWo6+545GCxOuSbUKBQbz89Mr96aWzTK6y+zYRN/5ZYTnV1HE4FY3ijB/f6pA4CRelCfKNtK99nYQGbLLBTmVD+HQWfYK4QOngRunr3K9QOsbL+JZOgHifiO2U74frux9fPgrmUnibMb6h7jDHZUkHaPMFjo383QDF9/0zt5hCEUN4DJb/foMoclutZT950ufdO8lDEJWKfA2oHF8MsswRZkM6de7zUvTOxBjHgB06uO2Q9AcXPZsljPaO0v6ZEu9OW7OKcNJ/UMvGDD3LpIACMbd+flA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV7Sb+Bxc0h67BEH50oCQVTWY88wGJrN8duykuxDwhw=;
 b=TNi5+SjrYsD4z2e3A9ZbP7fKU/QjhgHmWlOA4pXJMfpeYwRB2tsdNISfEFW6n/NkH1VMppe78KbqVAktIw6gvLx/09X1uorCXvo4M50NzfvzS6IIK1b0KQZxafkH8KbtJfvGkGv4A1qAuMRpRlf+v2hj5I26V6nfDf7AFDg1qUrHTMKyUp5yeGIvh6fYNahOVQsakjp9GbahBUcvslSJIASLbGFYch0Lg2QlbukXth90PTQHDZQSM+COqP0wbuvIj4Nba1qJtGhnTz90KWW50bkbSyZSLwUkDSD3/blClLeYFwqkAwhEXlDRvWNYwFrmklR9h3O1hRJTjkbtmRtTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV7Sb+Bxc0h67BEH50oCQVTWY88wGJrN8duykuxDwhw=;
 b=OhCLV1ib6jTXky9YUhT5THu3gtSDLX7x9IWFVPovyRJTu5U98W5mIv/UQTsoUNP2ypceGXtUuhviVDKFClFoedzEJJkqLdDf/d6ko8JwhB6i77jke4KLu3RfC+w3Pz8OkGl4URTk4LArbPGwIzwpKuvWSMWtlyqVmNxicanmgxqGndGKkeYfmS6zsZK4ndS42GW64A9OKH/iUJT6OLQ+oLkB2igukvAQTvUqFUTU39ltfpnBsoWPzxkgoQ//BBBiHhG17AQhpKVFec4rX5ewB42oYmDHMhw7OkIIFd0a0UxCElms73GjBaS2wgAO9T5L6HFau4/UO/IEwnrbGI6kjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:14:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:14:25 +0000
Message-ID: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
Date: Thu, 6 Jul 2023 12:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: v6.1.y-dovetail-rebase
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:610:b1::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: d88dc57d-c409-4510-00e1-08db7e09c6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0+qWtPuE1hYLYAkFhIiutOt8RbxTrpzohvhomL/mzfYx8ulw33NJW/5Vg4DlCb2wlYjplCqQAMArzzPCRVjh7JzEY8L/8wEk2XX7KgPZP/Fwfr/cFY9iGVW2piKJT0eV9Oc1tbKxZlP9FyPOssvy+201yL244IW5NavjgGn2Vf2/mX+AqUFfmy6GAs003Bo5Te8rZIC4McZ7ClsT12ITqcuzaSmPiiBf0Vv5JKlwFAY1ECprBTnuPccHYKbkZMYbMGA7rzqyKjx54/2Ioa8XZc//j0JAf/c1F7cNTY7i8zlwOthOWqiwMc+0vyn0P/hg4E8ni5+SGSPsVDN7ySY/C21raI5kCozu9jYYUbws1F8sjGyRgxRnf/bF13Y3tBM9812u7tEshIxwkY9ud1W21cJuRvmidhKCqyfeV40ZqzbF3OCusFmF7fnj7hz3Blx7Laj3ne+ZpqXlX8KiY0NiWlQAi4NBa0gFrxMfFKtg71c7wucHqsg3GkC+8/21U05K9U0+1RqmT+D0Pb2AY9Uj1Iz+BF6ylT/osliGLI2s7MFfRO5l5rA2fX4LUCqs2V/J8EJ+y1eJdHJtJnhNBqvvCqBwvrNLN1Xs9dQ/mzTckwN8so+PVWfuAh9s2BOQRs0mLnR/mX0hqyQRgMb3X4Uuiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(82960400001)(6666004)(6486002)(54906003)(66556008)(66476007)(6916009)(478600001)(41300700001)(8676002)(8936002)(66946007)(38100700002)(2616005)(316002)(4326008)(107886003)(186003)(83380400001)(6512007)(966005)(6506007)(26005)(86362001)(31696002)(44832011)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlWZ2h2UTNBVjM2NUkzbGNaelcvM2wwRHpGc1BrMEVUbXNCenNuK2hOdjg1?=
 =?utf-8?B?VzVqM2JwdFowSkd3RzBGRmE3a1cwZm12RytYeTg1WjNGUTJiV3NJQ0FjOFU0?=
 =?utf-8?B?OHZYZW5sT2UyTnhhRVRJd1B0cFhnMkdYWml5Q2cwdm9zRnRreW1GUm9TbXNk?=
 =?utf-8?B?K2lScy9lSVhTa2hqSWhPMkpZTEM4cXRVSnlUdzJRRDM3eU9Kc1lCakJDRUp3?=
 =?utf-8?B?K2NnR0loQVZFUGZZMkFyWDBlYzEyS3IxVENLTXFSTTNrbjNxOUtKdDFkMzJQ?=
 =?utf-8?B?Z1JoWEFSN01rTHVmT2xCczhHY0ZweWY0aW5xYkdET0lORnFIdEUrSDJYdkw0?=
 =?utf-8?B?Z21JblFKS29vNDl3OEF5aXRCYVhpbmhDeXBRZ0lYcm0zb0Y5am1nczBkalJy?=
 =?utf-8?B?V3B5cHNpMEpHNTNHOFo1MUtxSU5CK3M5dDgwUFFzQ09xREFXaVNVVEFyMjlh?=
 =?utf-8?B?MFFXQnc5ZGx3cjdaVDJBakwrZkVmbDVkQ2hxai9GS3VtckFnUDl0RHpsWXEy?=
 =?utf-8?B?YW5vanE5amZjeVJWOVVGcmxNVGRJMTR1TE5qUXM4TEZoSFRmVmtpRXllY0ZN?=
 =?utf-8?B?ZnZjdkdvOFowbGZ6VzJ2dUIra3VuR28waE5PZUl1Ulc1bEpSZWxDVVlzWDNO?=
 =?utf-8?B?aS81cEdyR1NZMllvN3JFYkdJR1dsQU0xL0lQMzZaeE81dzVrMnFRdm10dTlU?=
 =?utf-8?B?NkhpTmtRR1Y1N0htT3FQQVR3Wlg0VE1GbGl2bnpKVWZsVzloT0ZBQVRrNEI4?=
 =?utf-8?B?Ujl0Q3dlMHNFcEdyRHJmWnNzS3ZZZnQ4MHk0alUwRDZyclFoS1BnaW02Rkhk?=
 =?utf-8?B?bHIxa1lYTnZ2NWcvSDVDOTkrU3d1SXduQ00zWVg0bjlLUUgwa3R3Z3JRVVk1?=
 =?utf-8?B?VkNaRllPQU43cHc2SU00YnBzcEZCUVZmT2VPQjJ0eDQvNTB1amhOamtMcndQ?=
 =?utf-8?B?QzBEOTZMNGxmdjlMSGxuK2FSdTR5VHpGM2lUVTd3NTV2YVdRMnkwdlFHZytI?=
 =?utf-8?B?TU9KbS9DYXp5Y2d4WFR0dkRFVW5TUm9MMDY2eXVZQjlDdGJkTkhYZDgzNXdN?=
 =?utf-8?B?aHhENlh0aCtUcHFIcldWMmVCa2lIUSsvM1ovcDE1VUl2bnpIYXZWSGZaWXR0?=
 =?utf-8?B?VTROWkNmVUg1eXM5anJyUjRTWE5MdEJ1cU1UOFFTOTFkZk92MHAwYXdwUEtV?=
 =?utf-8?B?MUd2eXZQK1ZtQUFPQ2ViVlFsR2s2L1VFc2dQSFkyQzFRMnh6Y0hYbHVHckpU?=
 =?utf-8?B?QTkzOHhBNk1mRmd2ZDZieUNuUDZoOUh2WmhaU1dNZWJUTG8rVnpiY2c3Sm9V?=
 =?utf-8?B?dGhvd3dKNDkrYjV2UTMyYWt5QnNLUHc4VFdFbkpvMG5XQWFLS0NkaUdEdWlm?=
 =?utf-8?B?dUFsQWhDb1dFMC80RHBiK3J1RnRKaDVoTVdmUXJpMW9WbEZqcDhvYUJzbWVT?=
 =?utf-8?B?ODQ0TUZtZUNrZ0tuaXFlUW5ud0s1VVY2ODFRd21vcXdLM1FCNjJRQUFCdjdr?=
 =?utf-8?B?dlRDd3Q5UGhnckp6QUF2V3hoZTEwSjg1blNNcUxOQnMyTGM2QnlLS0cxNFk0?=
 =?utf-8?B?OURyWFkzaXp4THJheXh2VmlWWXB0MnBBS0dndFY4NTRZZXRWb0J4dDl2VklU?=
 =?utf-8?B?aml4OEhnbkFDQ05VKzZsQTNsejBGTm9VdEtmVFk4Sm4vTlI1NFY3dlZjUkxI?=
 =?utf-8?B?MlJnMGFqa1BzQzhvcXk1NGU2eEloK3BraDZ1dllrb0szVVBHNURLVnhtT1gw?=
 =?utf-8?B?RWdRZzc2cklXL29IYUxJZDhVdzBPWmVQb1hIMDdyZGxkMDAwdVgraXE1NGZM?=
 =?utf-8?B?LzkxQS81aUo4SThycUtNWTdPUEFBdWh3VlRPRmsvcjFRcjluRGJTQm13SWI0?=
 =?utf-8?B?M01IMk9SUmxiYkhYMkVJM0d4cTc2cWpvcnBrdTBXRWcvU1I2bUp3d2xQWWZw?=
 =?utf-8?B?QUk5aitTc1E1ZFpTQlNvcmFjMjN6UHhRY2xTSkNiaVA5Zk5CaEZyZWJFNTlo?=
 =?utf-8?B?TjRxVjd1Q05idlhWbEVwQnhOZEtHcS9QeUxwT2VTZTlLOHYzQXJkUC9BYUh6?=
 =?utf-8?B?ZEJUaTM2UHd1TVk0WllLVUJNWmJLRVlaSVRyNmZJTVFHUEJnbWFHZ2ZMbHJL?=
 =?utf-8?B?dWVsKzFOQTNpZ0hqcnYreUZsaHBoeUtEQmJpdDUzYmRhK2hpREhTeFBhNzFN?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88dc57d-c409-4510-00e1-08db7e09c6be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:14:25.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X80VJkqXmgbOfcFayMaNm6mrVrpxoA7dzHcfFvbS8yQS0ZaOwr95L9S58oxfLu2H0GUH8eUyhTkAQlhLRYYO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4106

Hi Philippe,

quick feedback on latest rebasing:

https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed

This was likely accidentally folded, right?

Furthermore, I will factor this change out into a separate commit in 
merging v6.1.y-dovetail, for better traceability:

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ce8bdd804bc7..c843bf352999 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-		return;
+		goto out;
 
 	/*
 	 * If we need to retry the mmap_lock has already been released,

To my understanding, this was a dovetail fix that applied to previous 
versions as well. Besides StackRot, another reason to update 6.1 soon.

A tag on the new branch is still missing. I suspect you are still 
testing? CI picked up the head already as well:

https://source.denx.de/Xenomai/xenomai-images/-/jobs/650229

Jan
