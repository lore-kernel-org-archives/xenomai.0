Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428531537D7
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467994; cv=fail; b=UO/ceJCFMmU9WUCrjcHDM78239BXvjSI1sXelYvk72ia2DNScSH2GPKwSmAAqWpfLvI1u6UnUH2vvv56lt4VAlJ+XsXLW3Pxh1Tv0ysQodDrVCQiOhh7PDREmFjgNi3XXA3MCXAYCAZWCrWTDRXEhkByci7W8XhtnXYH3SYgdA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467994; c=relaxed/simple;
	bh=H5+C6i891AuP5LYb1LszX6blUJYV9+4hNoDebaAp9sQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWpxwKOKslc6kbkuZ+TqfA/NdwVc9AsyI3rs36SxF/VrDnZeq8JcRRFPLxd4KQ5FHIJ66SDLBLMNZkOvrUoQkfVkr1QCCoengOAs+h+vbKvF1W4QOiP72AXfgOpZkeouWQI+y453TYWt5BRzhhp0DCitIxuiiajoGov0+bHvTeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BKQOOnTs; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BKQOOnTs"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 7E5DB100008;
	Wed,  9 Oct 2024 09:59:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20616.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::616])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A4530941558;
	Wed,  9 Oct 2024 09:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylOF4ltCdF4/ez9q39Y3V+S4AsxPje+pAcKYCXcfr4gDyipC+txqDewbeFMMgbgeEpmgjpdefJbnPk6oR4TkeYep2x+GMbm9OrtGERfbD1/ctFv2yC0lCS07Ikmzp4NiCjUaUeuW7j0AK/dcwedY8Q9evqSWaQA/WE6SrwOYNpUFcSD7G7s2E9LcaGRBt15UQDM/KY+8zSIVCO/4XyrUYbQQnam3IGoWUoJLTIdvOTPsHoYTlIR5xZLTy7enJVMbkKYW1KIZ/pTqEJ5papIujcJpZrTxkYiz/utY0w1WWi5Lg5ccNBMzvQlwuWuu3ytWlS/pZw9HW/CCA/rk7JV+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L14se7Gvoa3YXexjqKbp6lFtzavzOSdTz7sO6tcXdjg=;
 b=Wk+YTBRvmeG6RB0lSDNmreaoY+1xjWocJ4NFUfoYdBPj+wQLTdDtCmWzjwixAZEo+EMap3Mfouuq+D8MFWf2bTn7HUNDUlPmrp7A0ZrCKloNhUR/VOVSozgoRD43gLI22Tfoi0w49U8YkE8KehaNKegR9xGjx0Qyqtsx+byqYYfc/lQF5CecI0C230CAwbfiTlwHplGFPESXb255FRgwZWgsariCuiNIqGzNvOHMgPwNir/pJN1fF98sP2kli0cs3U/qyMxf47h0Pg4AZjHeVoJE+oKYTvYuIZdZOJpgWdNdTX6EiWdo2iWKfVGVUSWr7wcT7SaGs3ICqkT/3pPalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L14se7Gvoa3YXexjqKbp6lFtzavzOSdTz7sO6tcXdjg=;
 b=BKQOOnTsw0TzWQU8PcyMGrUh/c6YDgxfeF61RNBA8a/aPdVMOZyc+8xs9bdlQJ0w+Nr+rQlbli3e/1Dfwq2n4Nq7efbDBHBPxBPvJqRDDYZtPi+6OIytWMGdBMHY7q5QhxBnlVx2wJRZZUojhAyaHV+GjPumb9gxAWgYmHXZN2d+Gasr8uiL30vuidCForVxj9l294OYnPeKAF/4LNTjhfQU7sgn6nV6FyEUQp1iUs+BQV2WstFXYDnuYWQ4WGx0w0u7VVQOdWYPEA2efsk/Wp0jMBma9SV9dyUVNoqjy7XLS8hg5Gxt8bFEIbE1iP7Fi4QhYuCu6QsrJDnaWagk9A==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15; Wed, 9 Oct
 2024 09:59:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 09:59:44 +0000
Message-ID: <815623d2-2222-4eb7-8c64-2f5f9aaf48fb@siemens.com>
Date: Wed, 9 Oct 2024 11:59:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: POSIX API for EVL
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
 <87set6lajm.fsf@xenomai.org>
 <CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd07ec5-ea54-41cf-22ef-08dce84919fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWRYNElpaDZZN0djSnVJV1J4eEx4cDFaOHhGSEVBZmNtK21jcnFweURJNWRT?=
 =?utf-8?B?clFDZlR1TitrbzZ5cFgyREhZNnRrT21OZHM5Sy9yS05Kek16UWNyUGNObkh5?=
 =?utf-8?B?eEV5VHNYSXNrSHlsRE1uQ2VmZEozVXhMTmNRSENtQXhiWTUwZFJYUTVLRE5L?=
 =?utf-8?B?Rnh0WnNkQjc5NGpCYWVGTVBSK2ZHcXVOTG5DRXZCcXRFNUdMSjl2UGhUYnBM?=
 =?utf-8?B?bjc2SDYrcVlTd25FMmNSWU1RZFJTbjFFdjNlVFdUbHMwdzUyaG9nVUV1czg0?=
 =?utf-8?B?NzlkeXhoWitZUmswUTVjUEZIaDltb05PT1d4aWZPZHA1MXhMbkp3QW13WjU4?=
 =?utf-8?B?MnMwSm5WancvVDA5dElJaXZjY1Z5NlNzTEp2WS9nMmVnSmxPSXg4ZzZkeFZQ?=
 =?utf-8?B?bW9BM3YyQjFyZEx0TzU1NGRTUDJ2cG9XYk1ZdTE2TVdJTHoxTFNHRjY3a0lQ?=
 =?utf-8?B?YUlaaTgrUU1lakxPL2tYVzc5TjN5Zit2b1VaVW1ESUZQcmNtZnBtV21vcGhv?=
 =?utf-8?B?RmpTcm5GUmd2T1FHN3hVRGlSbzNadkhFZ0hDK1gzT09jUCtFUHhIZkptdGF5?=
 =?utf-8?B?dWJYWlo0N3kvcFVCZnRpQXhCZWFTYVhvbXpKbTVWaGM3dlN2OHlFNVkxWVBq?=
 =?utf-8?B?M0dUZVJRS3Q3YzdCUnJpVHI2S0FhSHR5bnRaUGtyTlVFNG1sNWpUMVlSWFhR?=
 =?utf-8?B?N3ozNGdTTWhPL3c3dFpOWEtSKzJrRkRsTHZudVM5OVJuUjJSRm1VWHczL0RL?=
 =?utf-8?B?SXQ3bkY0aW9vKzdpZ2ZqSXFIRzF1ZjEveXFhM01sbHZXN0V2dzF5aXVGZjBG?=
 =?utf-8?B?V2xZV0NsOEJOT0F1R1FJSDhKZ0ZrWXl3dURkNDJ1N1dvS3BRc1laMEJSMitv?=
 =?utf-8?B?Z3hrV292RnoxdkVMS2YyUGk5eEU2UUZvaUxUcWRpSENyQmxGSTRzeFJEbnlB?=
 =?utf-8?B?ZFpVK1dJSWpZcCtCM1FGazZibGRZY1RwTXo2dXV1SndQS2VLUm5NUVdqMWRI?=
 =?utf-8?B?MEs0YlFwZ0NZT3Qvdko5VTlXeThLR2lnUWlFQ21CWUxHbStlWjNRRDhpb2d4?=
 =?utf-8?B?K2hLWFJJZGJPMFkzUlBHS0ZoQldVRklMSlhYRUJpek90VktsN2xsazFUZXUw?=
 =?utf-8?B?UFRxMjZ3V2YySkNnY3dqZDR5U0d1WkZwank1UjgvekNUVHV3RzlDT1NjODh6?=
 =?utf-8?B?VU4vWHN2cVNLTGJuWGgwVkRBajFZR2M3WDMyMDkwNHpwV1hLQ0d4VlpPNGlC?=
 =?utf-8?B?VkhNREcwV3N6NE11dkRoSXFuQmxpV2tDUU5HK3RUeHg0cVMvL1BkRU1yeVk0?=
 =?utf-8?B?NUsyTHhPZ2tnM2Q3UDVSTlhiK0Z1Sk9HS2tvRUxnWnF4dDVmNkJvcURYeGtU?=
 =?utf-8?B?Z2c1YllkbmJlRDVJcEIwd0IweTE3amtqWWt2OWZsVkNndzF1VzZjK09reXNr?=
 =?utf-8?B?VzRqY2V2Q1owS3Q4MTRSUHMrOU81VDRFRk1DVEpxQ1FBbWY1ZTN5TS9Ca1lj?=
 =?utf-8?B?aUFYU2tSUHlBdG4vNnVvRFkzNEVBNEh6d1duYTZXUmpmZUo4MUlQSDd4WTgr?=
 =?utf-8?B?d25QSi9hRVJNblJiQWJjTVQwYzBnMWF4L3hDOE1zRldrcnIwekh6UWpYbmI4?=
 =?utf-8?B?V3A4bC95SWt2YXp3OFR3WVZBWTJFRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01kZk1SU21uTWlhUUdTUnBPejJqUzZaRDRDQ1AxRVlpVVM0T3pOYnpvV21V?=
 =?utf-8?B?N0NwUFBWY1RmY2hNSjlxWFlKQTF0V0I2andVS3hBSEhqWTVZeEZTRTRhdWVh?=
 =?utf-8?B?NzdjMld4VitMNnJNK2NWUUVNSmFwTTN6NVVuOFBEZklkRVZPMEdrU3M0blJ2?=
 =?utf-8?B?UEFHRW1xYVdBRHhRWFRjRVZWblFQNkFTdDBNcHBWcUFpVnJmSmpUTWRlQTI3?=
 =?utf-8?B?QTM1bWRIS0JMSzFYVlFjT2kyOFEzTG5Fb0thcWIxeGJWaGNuWElDTzhDNXhr?=
 =?utf-8?B?VkRBajNRR0dURk00WXFQWHBHSW5ETVNrdmxWZjFLYlFyVFMzZkgwQ0Z6LzZT?=
 =?utf-8?B?UXVJWG5zOFRqZFdxSU5tMjRzQldRaDY1UWQ2cEVhd3VMa3pEUDFnblVIc3Jj?=
 =?utf-8?B?enZ0OVRjY3kzOUlwSVZSd3Nzc1JVMEFOaXV0dHJpQ0R0bVVjNVZjZXMrRGhI?=
 =?utf-8?B?L0lGOWROVGJIaDR5SDczanQ4N1J3UXNES00xVHFOQzZBZ2VhOEtCQ3J2NnBj?=
 =?utf-8?B?WFI2bXZybnFoNnJNdVlMNnRoY1NnbFBrc2JuV1hXTVdqdU9jcm5TN3NhSlo4?=
 =?utf-8?B?RWRjMDFueElWQU53Ym8vV2xMZGpHaG9LVEFPSUhPWGF6VVhXQ2xBaHJHeDdj?=
 =?utf-8?B?S0p2Y250Q1NDRGpQTHhPcklMQVQrUURkbS9oOWJBeXZqVTdSV0RtWFkxQnBB?=
 =?utf-8?B?RkFZa3IwTXpzclhvRUpNSVZtazM4Z2RoRE01enNrRm1TelNIMnNnOHFEUUM1?=
 =?utf-8?B?Yk5VZjI0WUc0STdhekxCNjFuU1VieWYxRG5uOWd3UW9maEVlejNNbWtIME9u?=
 =?utf-8?B?aFdZRzVqWXl0enZyY24xZHJ6ZWZUaXRjUkxwV0kySHdMcnZ1VG9UR3lIVFBZ?=
 =?utf-8?B?VnFZVGpxTGdBMWZZOVlFVVd5Z09jTk14Y2JKc0xhUmpuLys3OUhGNGpCUnB2?=
 =?utf-8?B?b28wUzdWR2c2ZUJZSUU4Zjd4cVEvZDEzRjE3Uzlab3FIMmlxV2pWaU1rNE5M?=
 =?utf-8?B?Q0x6b2t3OEpXd3Q2bnlvODBPTC9GQnhGYVhvRTduU3dMelROaDFtMnZ1Zmp1?=
 =?utf-8?B?QnQ2TkZrRnBrRmVvVXF4WGVIV0MxMi9qMGZUYzRBaVgyait4OEh2anNZQU1J?=
 =?utf-8?B?N0Zvam5jRjBKd0p6dWtFVFF6YzBzZTdDbDBrb3dyYnF4dDRQMmtOT3duWXMw?=
 =?utf-8?B?NU9HNWk5MHRjTDRrbE5HbWpyY25ESmZHaG56bFp1QWd6UUMvdHZLN296VCtn?=
 =?utf-8?B?ZDNaS0MwMDk5RG84WGFaWEZWeFE1K3ArTldvYlBkSzhRUHljd3BFOFFYOHF6?=
 =?utf-8?B?MWs1Q3hkVnFTNlg3cTVUYXF0bmdMREgrWFA1YUoxNEx5b3QzSnFHcEZhK2cv?=
 =?utf-8?B?bFNxQmg4NTQ3VlJjaUFBcXY4UjVtZHJwbTdxaU90andMOEEvL0pHNVI3NW1I?=
 =?utf-8?B?TStUTWJEc2ZCRGZRQUYwUFRxRElLY3VNM2xHT2FYRG1ZUFNJSitkb0Vmd2dv?=
 =?utf-8?B?M2Y4aWhFS2FHY01seTZmYjRFM05XeitjSytLVE11ZFRXZlpJL2YzVFdrelVN?=
 =?utf-8?B?cUhIT1o5eXVWYks4bW9QRFd1Sys0RkFoRDNDSFpzU2JkdllrYy9mRFE1SEFo?=
 =?utf-8?B?ZUloTU54SWd0eHNZQ25lT3ZoYlpNSGdVQ1NvNXdkSkZueWF1emxCalNVZTRM?=
 =?utf-8?B?MDhESnBCTWJhN3MzZjd1U0ZzaE5HeHc4WnRBTXpOSVQ1c0RWQ3IzNENTN3RV?=
 =?utf-8?B?Z1QvenUvN2tzdndMODZBdVJBaEl2ejBpTFE5b1ZoeUNCMjJWcUFhRUwwNzZk?=
 =?utf-8?B?WldqOUdVeCtrdnZncE5iakZHcWFoYTM0YmxWOTQxTGRUVWIrTGdZRjZCTW5n?=
 =?utf-8?B?UTUwTTcxNjV3c3RYL2Fnb1ZmUEZZY0ZDVU45ZGVCSzVEOFNsZlpSRGZBQUNu?=
 =?utf-8?B?NzhKdUd2U1VaRUFEZENJNVduR0tTSmI1eFBEL2F0VXhoOEpGdm1FTDdkMUh5?=
 =?utf-8?B?eFZ1REM2R2pXK3NYcmhia1FoZVNBbDFzVTY2V3V2K013OG5QWjA1dmZvZnFP?=
 =?utf-8?B?OGRnSUZBRjY1MFR1YlJXZ0llcXlFZmtkOEVDS1ZCQmMxeitFSXdZQ0x1aStu?=
 =?utf-8?Q?IoICkgxd4aawfI27wErnJiqAs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd07ec5-ea54-41cf-22ef-08dce84919fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:59:44.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMLsLO29X3XJL0xTaEr2hirp7pDvyvwTFP3WjiWjoPA8/87ibfOYydmQ/UUGXo69VrEu0JlueKWTEmxsZRKdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5868
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=BKQOOnTs;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2613::616) smtp.mailfrom=jan.kiszka@siemens.com

On 09.10.24 09:53, Pierre FICHEUX wrote:
> Hi Philippe,
> 
> Yes, I do remember.
> 
> https://source.denx.de/Xenomai/xenomai/-/wikis/Common_Xenomai_Platform
> 
> The lack of interest is a bit strange as the industry is mostly based on POSIX.
> 

I would say the challenge of moving forward is right now that users
already on Xenomai 3 are happy enough to stay so far, plus some have the
blocker of missing POSIX with EVL. So, there is now an upfront invest
needed to enable POSIX over EVL in order to evaluate if the own
application works even better there. This is at least the case for our
internal users.

But my plan remains to enhance portability from Xenomai 3 to 4 so that
more comparisons are possible, and we may eventually even consolidate
over a single code base again.

Jan

> regards
> 
> 
> Le mar. 8 oct. 2024 à 20:22, Philippe Gerum <rpm@xenomai.org> a écrit :
>>
>> Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
>>
>>> Hi all,
>>>
>>> I've read some discussions (may 2024) about the lack of POSIX skin in
>>> EVL.  Supporting several skins just like for Xenomai 3 is not
>>> really useful but POSIX is an industrial standard and so for people
>>> willing to use Xenomai instead of PREEMPT_RT.
>>>
>>> In the EVL documentation
>>> (https://evlproject.org/core/user-api/thread/) I can read :
>>>
>>> The main kernel’s thread is the basic execution unit in EVL.
>>> The most common kind of EVL threads is a regular POSIX thread started
>>> by pthread_create(3) which has attached itself to the EVL core by a
>>> call to evl_attach_self().
>>>
>>> Don't you think a kind of POSIX "wrapper" could be useful or is that a
>>> silly question ? Did I miss anything ?
>>>
>>> I'm about to start a study for a big industrial company and the lack
>>> of POSIX support is a real issue.
>>>
>>
>> Years ago, there has been a proposal for a Common Xenomai Platform
>> effort (aka CXP). Its purpose was to establish bridges between the
>> xenomai3 and xenomai4 systems, user space (e.g. POSIX interface for evl)
>> and kernel space (e.g. RTDM emulation over the evl kernel API)
>> included. AFAIR, this proposal did not get any traction, no user
>> feedback showing interest on this list, so it had to be ditched as a
>> consequence. The only way to revive this effort is contributing detailed
>> ideas, a plan and some code.
>>
>> --
>> Philippe.
> 
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center
