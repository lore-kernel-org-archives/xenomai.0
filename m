Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB2FF679
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577813; cv=fail; b=WtSlgo0GBc6BRfux31a5NA7FE//5O8X4QnaPsV7oXhEz41ZlY4FrgEtCkn1n3Su48pUZa52yw+m1Q8WFpTeEg7cHWhkAaNa6sVpBwGKr8GmkChGJk4Cep2p8WcPln1HfSZS/U3TB+05rVjRmwV3yPCUBceYISnVk/uj6oCWSkLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577813; c=relaxed/simple;
	bh=Sv8TAEeplFzEeho5E7dM7POoYX7hpQuM/agXaENzA0I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZ70B99k2kDTELxvxRB7jPZo//7pmPm57cbUsN01X3/v0YKKIn8VMJJnVgIsRJOZ+SNAwrTwRfuHy5VTy5d1TRnb2pXf4slskObb1sIq9IbZQqZH7jYHegCpAOdPvrdL1Vjn4zLoJJIcxwN6Z8NoB72I3Zu6/Mb7GNX2BEMtTeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PKn72bcP; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PKn72bcP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhX99WhM7KqpTpjAu7IPYJ1EqBvDuMtiMrixpksXaDTiIMPriV5XNPBljKlOygctMtEYfRdbsBvleVJhpSBe56Mx4g8Tc2Iq2cfPGz5CQbVI3MJBp2AT+zEhZ/F9LiKaCath/TuZs+I+Ei6LU2llNH8vnhXWCk+wpFRr3x1kFqvKNlcuY6q3rKsv2Lq2YYXXUBZuVOC6Kw+bJIBxjUlIvBAavcN4UnS9aq35A+9q+dNHvTZdjpUS6utiyWJuq20mEE1pP88CL+lIPF4y/9uW3eN/r8A0iRjN40yLIiMGm2TpeooSnsyPA01RJUf/rON3FeGjMH+G4FTKMTshMCQ8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGOR+VJATWj7mKeOKOUobXHKG/0W+qJKF6xN4tmMlJE=;
 b=SEc3SSjcbUsS2GGm/UHk5rM18VBudj4jE4U2XMY3FJvsEiMYOGbtqpQt4M2vT3el2pQ6zIdWaEGji2U6/IohQgmfsOg1LLkPelMWKACe3ZUz+JggR9pbU0TsZ2DUN0+iIGOuVw3c2B1hoIdRRZ4IiAiJBnj46vrZGR1ZshViXm3uFdg+TCcGKAhi1lvm48m5sCDYgHGIh2Y64aS9qoC+L/8aPjg/kMFTA7b7ir9xsWY1k0MLWv+RtBAUrXnNQHqcOO2XdeWcF+V1hbdxUOsMUdkQNvfX3JXKsHY79p7b8a+7UgML/1jS0STHLiZLgkWuV8JE6bbams300Km0olllzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGOR+VJATWj7mKeOKOUobXHKG/0W+qJKF6xN4tmMlJE=;
 b=PKn72bcPhQWn4XuDi+KDEQSeeZ4hJX7ol1E8g6Z9BB1KikDcz4Ic7Dzr8+xi+VBge1LMKliRjB43wksGsXUrjKBY+4Um1ouLSjAp2asqmw821q+1wK+b5SVc+0DxGoVfoil7o9RmqDJpWxA3LQqleGfhxPbCnA02Gllvk+v1aUX+oYbE2vlO8atmYhUKcQkFzzqYW81H9QKWvS/iVRegYu76QodTMnRFKn0tHZwid//1qYev2XpW5x2DtXVXi5ofw25Ue2jDmNaT/FSvWaGd7GiACbCcJAmpFNTP13sCh0HYn80mscnXk+9pKbIK6RlSt0ma3LSGqLzqVKYZyaUPbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:504::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 15:10:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:10:08 +0000
Message-ID: <e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
Date: Mon, 27 Oct 2025 16:10:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
 <b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 9926b291-438d-4489-fdb0-08de156aea8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDRieStUQWxBZEMyNXpvbW00VW9iZFZQWjBqWjFrK2FNRmxocjBLK1M4cGJH?=
 =?utf-8?B?a1IyK0tGWC94enRaVXR3WlJIMm5uTGlvZkRvNkEyZVVBK3VwZmVGVm9EVmhm?=
 =?utf-8?B?dGYremo4MlBTNXY3a1RNYXFnc1kvbFl5TGQwWGNmcVd2U1N5Y2wzV01OUCtq?=
 =?utf-8?B?aXBmMlA0NEwxVXVvWW5kM2VGbGYvNlhWRTVQdHE1NVRWS2M3QnpPdVhJcCsx?=
 =?utf-8?B?bjlBd1dMSWZQb2VVZEV2Qko3akNINWFERXNnUkpqaXQzbW5aV1IxOU1pQW1O?=
 =?utf-8?B?Q1VlUXVVSXlkblU2NE5zdUxHMmJhVk8ydlRsL1lhZFRJT3Y4YXNNTXF4bVRG?=
 =?utf-8?B?eXNnTDlvV2pXUDVMdXptUmZ3YlArUDg4eW5acWpRYzh4VEhQemN6RmhCK3Ev?=
 =?utf-8?B?c2JJNmYzVlVNRDluWXdraDdSVE82R2E5ektLV1RzU0w2eEN3RjFvQ0VSTzdQ?=
 =?utf-8?B?WHZNTkx1S0hNMm8xbTBPOURKeUhBOG9oRVhjcm55TTNCN3p0OEU4azg4N0lr?=
 =?utf-8?B?UWdpVmhLUzdiYlU5ZitTSWJVSUFJOEtRRi9CM284NlhkUldybGh0T2h5MmlD?=
 =?utf-8?B?dHFMUXMzOGEwSUEyVWJ6S012Z0R1Y1dCREFWNzRNRnZMLzZPR2lIVEhyTXZS?=
 =?utf-8?B?dDFWUkY1cHZ1RkIrZDY1Q0daNTRGUXpvSm9jcFEyQzlad1NHR3RvNEhETzR6?=
 =?utf-8?B?enpoK2xabHNJSUFLclZqMXJPVzMveExuUTNsSFk3cEZzUHpJTHRKeUQ0QW1H?=
 =?utf-8?B?UHJ3d2VYTGoxNGcrbndFdUV3a1l6SlVjazdTUEVmdThsakl6V1BQTVRoMDlD?=
 =?utf-8?B?QkpqSUl6TFIvSTBxSGxDclpEQ21GT1hOUlZ1TEcyWThqbUpvYVNLYVYrcUcw?=
 =?utf-8?B?YlNucHU3cTQybyt5cmJBdSs5OUM2aU9uYStEUE1UU2x5bmM1cXFaVkRzUnRV?=
 =?utf-8?B?NzFxN01mYTRiUzZiNktqSnNmMTlDUHAzcUx2NDlJYnhpUHBVYWlmc3dPOG95?=
 =?utf-8?B?VWtkN3BhRWpLazU2M0t5R3ROMThneU5NalRTeGhTSkUwZkdtakM2cGI2TjZz?=
 =?utf-8?B?YVE4WDhWZXNGa0k5RU1ZVGJZK280WG1SMmt0OTJic1BXd001RUEyY3lYb01W?=
 =?utf-8?B?YllTY3ZQY2RBcDN4ejVlYy9xRVJKMkUvYkJ1WUk0c3pMcndJNkFrWk4xK2Zk?=
 =?utf-8?B?SFB0UkQ1NFlnNFBaeENnc2J3Y3BlcEhCOStmSGF5NUVSR0l4aWVxdVBiL2tF?=
 =?utf-8?B?L3lCZnN6SmdxeUthNVVhY2JNZ1Z4Nlp6cnF6TkF1Tmd5REk1K3A5b3h4ZkZP?=
 =?utf-8?B?MWs2SDU4L09QaXhETGZheFJzUUF6NlZrVHhqbzBNSnI0YlFWTWg0ZTAzZ1Zl?=
 =?utf-8?B?V05GN0o0bzBJUGhEWWFUM1drblNXR054WXQ2T0ZISW96TnRHc1NWZmxSeDBu?=
 =?utf-8?B?TTNwc3pVU1FtanNVZ0tueXl2bi9DOVNTQkRzTXA2TkJOUEhSMGNKNWlVYTB4?=
 =?utf-8?B?Qmg0NWM5UXdqREtWUEZSb0QwS0lFc3NENXFmSjdFWlBrV1ZDaCtEUkx0QnM4?=
 =?utf-8?B?dFhlUmZWL1MrWUZIQUhIOWVDREp3VFhvcFFhL1FDRXREUEZYWkNjTFB1NDl5?=
 =?utf-8?B?UzNpNWV5VWxyQTA4MWlRRVp3UW9iYzF1dW83aUd5Nm9EdkU5WUNMeUxRU0Mx?=
 =?utf-8?B?YTZxZGwzeWJUVk9zeC92dmxTUkNacjlYenpFc3IzWC8vTTY3azlNWkU1TDBJ?=
 =?utf-8?B?Z1RMNlplQU5WSVQ4dFloVGswck1ZbXFLTFBmMzlZbTlxRWNPRXY5THFwQng1?=
 =?utf-8?B?djRqKzJrUkxhN1ZKTEZoQ0JMOUhkQjJ6c3JZTGtpQUhudUFYOE96cng4ejVk?=
 =?utf-8?B?Vnh1bTc3Vit6MlJhUWZ1b0t3UlhUNk4vM0NqcEFlanZraHJ1ZDF1TWlJK3Bu?=
 =?utf-8?Q?LoA7UMMqEqJqSBAYOuzaHmqCiVD80Tvr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDVqS1J4UlpPYlA3WmV4OWVBUkFOUGtRa2lSeXdQazM1c0VwM2tneVlERTRO?=
 =?utf-8?B?Q3ZDVGdsREVYUThpVzF4NXRiUlNtckNsa21jaWYwZytDMHVNRjZ1dVpyT0VY?=
 =?utf-8?B?RzdOdzVaSTNCbFZyeXZLMzlZdG1ZMklwdVBCOXJNeXJNeU9HSWZncWIwb1BF?=
 =?utf-8?B?L3ZGZnZDRnhaYStlSUtOM05FM0xzYjM2OVdFV243Zk5iU2ptKzlybWFSZndz?=
 =?utf-8?B?STJmazZEOUlFVlp1TEpVdGxlN29xT1lQZy93T21uQnc1OWU5R2k5UUJPWUpp?=
 =?utf-8?B?VExURDgzZDB2cWFMWlY0OGxxanA5KzFlZXJvdVhISkY2a29QSzdqVTkyOVhi?=
 =?utf-8?B?dElxSjJ2bVI2U2tWNVEzem9VZE5GTHZSUnYrWXdWRHFrbktHamNiR2cvVTN5?=
 =?utf-8?B?RGZETTR1WkRVZVBJa1hnQVFLVGg5N21wdnluUXRCdDhBbVE0M3pSa2RTckNu?=
 =?utf-8?B?b0JQd3lEV0o1SWNaeS9VRmRXTXRoT284NCs5cnNKUlRrRktSaHhoRys4MEFD?=
 =?utf-8?B?TWVuV3AyQlVhcVhuWlUzNU9rRW1Da2JVSHhlZjVmR0x5VFBRYmdCWkpYZUpN?=
 =?utf-8?B?TjNUNlhmWWNPd0tvS2o5UlVuWmJ6R2ZJVzJqZENPdTZoOEFPQ3NpWXByeXhq?=
 =?utf-8?B?S282aVV3a2NXZ0x3cndXODdyNlJXLytLaldJODdQUXdyUXdzaGZ2elFDU2Ny?=
 =?utf-8?B?c2hVeWJ5cFpPSGFlM1hjd3ZlSklHRmgvdGhYR3ljYWVRR3V5bnp2UUNrT2sz?=
 =?utf-8?B?SHpLT0NZaERRUElVaXBwQzFLT21iNVl6NTRSK1dDUmk4MEYwbFIvOWdsbmp3?=
 =?utf-8?B?VU5QdktBai94YjNJd1h3bGp1ZW9mUTdiUXhwME1MQlhaS0Q0dzZEaG9PLzQ0?=
 =?utf-8?B?VkpLUDYvYnUvSnRJVENrdzZPSmNJVkNickFQeE5nOCtZaURmMC9ZTElNUkNh?=
 =?utf-8?B?dGJxdTg0SnlxQmtxM09EZS93aGdFeURhSlkyZXVMU1p2Zm1VN0NXMmVrdnkw?=
 =?utf-8?B?YXNrQUxHNzJKOC9xU3VYdGlta1g2M0VXZWs3YzZTU0NWNmUxQ3djRzhOR1hN?=
 =?utf-8?B?UGx6YUVteU5vVWZTRW1RSHNXeG82akEybXltUWdpUTYzczlYRmVBT29mNG1U?=
 =?utf-8?B?MlpFaHhkZDVBQ1k5ZVQ5T1VuMmpBWXl0ZnFLeDZOckhtbzVRYWhmc1luQkVT?=
 =?utf-8?B?R1FnOUdMNlF5YTN1bmxBY1VjcVlybnRlaWo5YWZGS3FTeWNRemVpRVQ0NEZU?=
 =?utf-8?B?UHlybGhkUnlvMTVqNTFUU2pXWm1uOG5pb0xTVER2emNKOE8rRXZnZHRMTHEy?=
 =?utf-8?B?MCtDMCswR21aVmZhTVI3K050UEtuaVR5aGhxVmxtVm1DWWcrV01ReUluYmh6?=
 =?utf-8?B?QVNmOUtQSTVXd2krcDNvSGowcUdHa0svRUExVWJqMTlYNDhVVmhkb0d0a3cz?=
 =?utf-8?B?dHBxakRmZ2Y2eEZmcW0wclFTTWZVTk1BbHVkZ0hibldZbkwvamNpSUdlVk0w?=
 =?utf-8?B?UjIxOUNkKzlRUElwaHllWkxCZVZDZ3ZoMnZlT0UxV2JIdG1qOStqQlk0b3oz?=
 =?utf-8?B?cEpvN003YmF6Sk1UUVdrdmUwazIvUlp1bUlnQXc0V0xVcnhtNCtweFlPWGFU?=
 =?utf-8?B?SUJFOXJsV1ZiRW94Y25xWU11VzlaVVduOFYrcll1akZVbUlBVUc0Mlp4NEYx?=
 =?utf-8?B?bkNSYjZoVWYvaHF1NEN2U3h3NlRaZmRvQ292djBLRXhlR3NEUVlKWTk3aXFS?=
 =?utf-8?B?YlZlTjhKVkdOTUhnYWVkSUxFQ1VjSEd6YklkZEJqMFUrRTJYNGlNaS9LNzFl?=
 =?utf-8?B?L3RRUTloTm5FVnpPZE1zYTBQU2VBWmdVeVVOTW1FUUNEQk1YZ1BaQXJQblZi?=
 =?utf-8?B?TWs1TEVhT1BGOUc2NXFIZm4zMi9ua0ZsSHZETWMwVUJWN2Ztdy9RWUZ3di9B?=
 =?utf-8?B?NUhNb21rZmFWUFY2WWtoeWhUREo0T0IvcTZqRldQWkc3cmtKN1dES1hXcUdO?=
 =?utf-8?B?Q1RUcXpoT0Fjc05Ga0VpdHVFZnNQQTZvejlvT2VudEFjbitMalo2a29rdW1k?=
 =?utf-8?B?UFlNVjUvN0xQQzdvYm9PcEV2S0M3YjhnSjBrQjgyVUlNL2IyYkhsaVg5dVVN?=
 =?utf-8?B?bGxKT1ZGSTJqZTN5MS83T09TTXQ4bXVXcEp6RFEyWmFKQU91d3lzanpWNzBk?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9926b291-438d-4489-fdb0-08de156aea8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:10:08.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o34CMkxKWr40Z+p3nhr2fG363E0nVxZqkfwNy4pOChlMPWdti10KTk273rqqdIPZ/Y0v9R6teqy1UQSAliNN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6329

On 19.09.25 08:40, Florian Bezdeka wrote:
> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
>> ---
>>
>> Changes for 6.1 will look different.
>>
>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 1f5fcac32b2d2..21f8785948ca3 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>  				  unsigned long cmd, void *v)
>>  {
>> -	unsigned long flags;
>> -
>>  	switch (cmd) {
>>  	case CPU_PM_ENTER:
>> -		flags = hard_cond_local_irq_save();
>>  		fpsimd_save_and_flush_cpu_state();
>> -		hard_cond_local_irq_restore(flags);
>>  		break;
>>  	case CPU_PM_EXIT:
>>  		break;
>> -- 
>> 2.51.0

Philippe, this cleanup is still pending, applying as-is to
v6.17.y-dovetail-rebase now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
