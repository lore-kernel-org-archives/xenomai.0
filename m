Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9301D5160
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358200; cv=fail; b=ZLMpOsWSqQNm+wVMnJrMDdVqe0cDfHa2KieBjHvOESNZe+OwDSN33pPC9Oyu77kb6Pttm1kryP2+N570r+tMxBMpIsI9odXZSp042foZca6X9CskmqnrmpoApeOhS1JSKhRTDV9X+1yUKNCkaA6O+rBzxDRsjK3Ad27vKbuzukU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358200; c=relaxed/simple;
	bh=3q9zhQCQ926AlH4AGJFWOsqGqpZDXkIp5riKAjK95ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9ebJqQXn0w+3YCSf64pofAquHbB2Ou3NPN2WlgXSQp0lOtWXSpfn0pCyv/csy+vchDs9FUwzx3NNRvA2hqFVn1FVEIMdsweOffPPkUZlGvJn7stJ6dQ63N/rpoupbkm72j1cMQ9TWzMO6z/hvDSK3LOWX7P+YcHv/E6fB8+c4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=p6+FbM50; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="p6+FbM50"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+ddGGm1YaCMD4aQWk1JSFIjJQ/vrbQpOTnUw3Z/lAAGjlY+RX/tEKlGcXL1pNybwTnCQE7WvK034yBypjVOoOrBqEfPHHC5/F2/tWNw9b5+W78q/3joG4totb/j9l6dIyt0KvPXCHfCnU+sfqMon03GlBwGDdRVrKrRUQ4vgKyZlMtWd3A/dnXfFb9BhFsHdip0JDA3UETOFJIHMWhLAwHJL7tCI1gWGK5pR/XGrKj1oKDtMBsR0sdpaeW9jb2EeAxpgX8q8xhD5F/vrMcOYY1yB0g8qqBwmliYYN8T0MUbwKWX3fZqWhfbq8gTVZZBvNc29sHWyp0ck1LQ20QK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ4jUiVmYOkcCTJQIaoDT0fDYpT+oqm8VXV/Qc/9yM8=;
 b=dl4jCm0sLBjhAtC26B/qixW6uEOnybydkcc22KclYxAScAdQvPwXMv2WqAreCaL4cdT8qi/Obk/53bM9M6QCeQz19yaB0NyRO1UIGYZwNc0B7265rrEdxxKeyBtjqswU5RXrUkTBjgzU9Oz0BZnjb7fqstRMCk/tSjWo2aacFryV+MaoYPldz62sRhTxSapImGHjtYjFTlYRF4ts91F6oTckhW5rGK3fH/9VDyDEpR7/J2pG3XNlFV7cgg3HrNxKc4+JO499bncBRc/m27H26rQm4eyuj8vKkitGkqxlHcROx36atGaReQd2VN2oU0gZrrEPiN2kHg0hfDNkNLhe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ4jUiVmYOkcCTJQIaoDT0fDYpT+oqm8VXV/Qc/9yM8=;
 b=p6+FbM50z0A4h1aePEux8mYK5Bu15mKXRHZekiEQKz/1Yly8OYRaojjjBAglTc2d7RkQYowFBmkJumJXWG9V36VPG4dacQ8rGR1dLjAb5Pt1s34hKCYXNjDct3d0FdqCucbtd6Yf1JBhP6pOOv5S4GITDiVHzWBe0D23YF8oyM4yfyGPJpvuJskZP+7VBW1sQ4kBrR8PwTXxyzfuEzi/SS+mm6pCOqfqKLNC/ZC5JpjqGu27qulrhFvpCHQCmU1fGNbvN+xi8n0lriop7uKO+jkRl0AZpgnHK467fDlZoQu3wOHSJ2SsnNMU4AxJAvH7Ejjnqt1f/qno2eKS3yUvLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 17:16:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 17:16:35 +0000
Message-ID: <dd6f0c05-ae5f-4e2c-a96e-d476168907fc@siemens.com>
Date: Mon, 6 Jul 2026 19:16:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v9 11/11] riscv: dovetail: add core support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
 <20260703152738.129122-12-tobias.schaffner@siemens.com>
 <60e6a386a564780148293e3b47692d636e91ba2f.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <60e6a386a564780148293e3b47692d636e91ba2f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af678a7-f096-4a27-4788-08dedb8254cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|56012099006|5023799004|4143699003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hgW5f9obpdRmsLbUKOw/feOswDi/8emIqNJreOLUdygdJrNSzknTga8wda++uMTb0ogdKdTsZxfJdV55iOrkQCZUT4m/1voewCsAJfkATVz2UdTe4ZrrvxOeE1I7dy490xmr0LuUDmFirUHMI08nwCPrfrSktqDNyDC2SefUEFYU8HkRxl6uwV8XQi7ei/LLfHBI3MpcTve8LsOo8UWbF/v6sULVi/c5GygAyVbViwsm2GKxXO00mFNLvLZs8RhacexNqwgkJxy+/qCwjOtZ02MgSv4rpBiMwHxXxNWQTW0dG0a16jJKF/C0rN0817k4tlfV3ov3TR5dCjBnUTlVfssHPhK4GlxjtnSaiAa0ns0O46C0WatwdYsW1C84cuJPfTTfrzGSPa4QRODbsh4Rs57ZCt3JZmTJCfACD4Nc2voLBw4XNmQWgma5WiZonwqFJpHQXuXLV+bGoAT5yjhKT3owmkNzFCax5IlnzM2DhkCmuC+FPVPRAQZ3eyqBdAldLsP1r7SlDUzhwZSpsVnxJotvhpB2U6oFyKrnbZ+/Zp+js55VHmTbzqap6IgugDzrFSGOecDmkW64N2CcXotIPgWSP5taYD2Ne2I+yGfaye7hx6SY5thDWeHAV6TbHQsAMkjQffwLrpWAlftTLiUIBi5SV87Citg4B8mBbZ76b4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(4143699003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWVEVHJQRy9zMFpmTXcrblpaR1hLVlRNdWl1N3piVVp6WTE4ME1zamFqQStz?=
 =?utf-8?B?M0dzRmIxYSsvZys3MWRTZnMyVnB5RHNqekpQeEU3ODJXQUQzMFVNeUtvS0xP?=
 =?utf-8?B?ZmcrK1RwcXBEamppYUoxUmNGMTVzc1N5Sjg3eEErdk9sM2JFM2svVTZJTkla?=
 =?utf-8?B?bXBybmk3V3ZoMVlERmErMGtyUEUyeThVWXA1Qk9OUm9TQTdPMFJtSFl4by85?=
 =?utf-8?B?ZHZIaWxIZjhtK3FuQmNJQVMwdWtkN2UveXBCU2JjL2gxV0cyTkJaVisydjho?=
 =?utf-8?B?Zjl6b3AxNnBnTGpZS1IrYjFXcHp2OUJ3REE2dEJqVWVSOGR5N2VDeXIwNE5R?=
 =?utf-8?B?eVFYM3lDVzREUS9EbFVkRGYwVU9wWjdkb1JrYU9ETkZGMXg1b0tXRzExKzhu?=
 =?utf-8?B?MnhrU1UrRW1kSzRQdXNGWUdhemxLSnhNNDhJRmxiTkpneUNDUzg5d2VYV1c1?=
 =?utf-8?B?NEFHRGZ6ZjNST3IydFY1VDRlMTUzOWNuTGNpNk05QUpZTmdzclowQ2tQOFRT?=
 =?utf-8?B?T2Y5dk1sbEVFQ3ZDM2FCUjhzZjZpbXJVelR2eHI4OGRtUkdHQysyaGxEVkFo?=
 =?utf-8?B?QXZKYk1sQjhjS3NzQmFBcGZiY3AzSm5PUWdHQ2ZYU3QyN0UvRmxpc1NhL1ly?=
 =?utf-8?B?WG1IeUoyZ202a3YzWVMrN2lZWE9FdUlwMzI2QVV6N2F2cFJtQjdHc3RJa1VS?=
 =?utf-8?B?SkhiTDBpdFMrRGxKd1U4ZVFJbUhZRGg0cDRaamhWbUc5Mnd5SzNOSHFTK2gr?=
 =?utf-8?B?R05NbnZPTlgxZGpncGxpSkpzRzZRMi9FTUdIL2V0SFI5SnFwSjhxaXlzWUQ2?=
 =?utf-8?B?am1qVDEvNFV4bEg2ZmVHdy9GODN6cC95bnhLNjJ5K1VCeTdNVU5XNVhZVGE2?=
 =?utf-8?B?a1luZlYrbHl1aU44L3dVKzRhVDYvckVYOGZGcmYwTTFNYzdSSTNrbmczNW9N?=
 =?utf-8?B?WFVZNTNaaGdxZEVzMVVzcTkyRS94OWcxYXYyZUVzbjM2L0Y4SlJZckxGWnVR?=
 =?utf-8?B?TnZJMlEvb2t5b3I2OWNJZ1RIaVdJUXJ1Y1dOalZXYkFuZ0FlbnB4VXNPeHlo?=
 =?utf-8?B?QjlPTUlOQVBJcVlnUS9RaCtSamZ0SGN0a25jdERyT2pYdEZkWVJVVi9CK2Vh?=
 =?utf-8?B?Q2psMWovN0ZweFpFa25wNDl4KzFZbGVzUzYyTHJpWHVsQTVncEFIZlBKNy96?=
 =?utf-8?B?YVlid2pYY04xOVVtbTVSTHpxTmxHV3RKcitXRWozUk5DeFVoY0p3SzBpYm9X?=
 =?utf-8?B?VW44VVZ6Uy9RTk11dndmYkFaVFpEZVpCbDBKWDZwaFdibDZTQUdQd3RRRzIw?=
 =?utf-8?B?WDZvQVVsQ2dxT1lHeGhKNWIwQVNNVy83WC9hQkNJQ0tEZzRRbHVvbWQvdjc4?=
 =?utf-8?B?aUMzSC9HRjZIZWZyTG5iK3JWdmtZUHZMQTRxb0NwWTMrOUxBVEgzVXd0Z2Vy?=
 =?utf-8?B?MndvSWc4TitUaEF6NGgyUmx5UHRhWmZxRHJIcDZEcnZ2U094K0pzMm5zNUFj?=
 =?utf-8?B?T0liVVlOV3V1dndFRm1vc0xCazdOWVQvVytUV0JNOEd5OHdqZ0FWUndHRmpn?=
 =?utf-8?B?WGx4UHhQcHZBc3NhczJuUm9HY05WaU9sOU1oNkFmbXo3YXVCVDRlZ2dDTUdK?=
 =?utf-8?B?K1ltOEVaQS9ENEtrZDhSUWpUUVVvZWx2R0NLVENtSDExQVR3ck9pOEJ0V0xE?=
 =?utf-8?B?cHNvTmdXQWc2c1ZLQ0swNE1mR3BNZVRiUTM1Vm45ditLeThiRkthWWk5K0x4?=
 =?utf-8?B?OU5paDFRSmdzWG5jYmFHV3d1K2hQMnZUanpGaDJHeDRwQm42WW1qcXJMV3Zm?=
 =?utf-8?B?bC9xVnNZQjdONmMrWlVBa0dhczZGOHJYQUF0aDRzMFlZSVZreE93U2RGenpR?=
 =?utf-8?B?MTUraDU3UlFwVDhEVEUxU2R1UTVET21xQVI4QzdONGVHK3RHUk56eERscGhF?=
 =?utf-8?B?cjN6TE96Y0NRSVYzWVZmeDRnbTZwN1NFdGtWU1pEVUVvT2dvNERXWDFaSHNy?=
 =?utf-8?B?WlExWlluamVVVEtDNVJQVDE1c3ZiSmxIcy9hZHFVWWRlK3RoanNWWWFTZE5j?=
 =?utf-8?B?bndORzVhdlBEYVg1UDJGQWNZNW05RnR0SEN0TVVPdzM1blMxeTlkSUd2VVNL?=
 =?utf-8?B?b3JYajVnZGZjSXNTelQ1b2x0ZUE5NGNyVDR0aENRNzFPQzJWRWJDS0lrNmw3?=
 =?utf-8?B?VFZ6d1hXZmZDU002aHRPRVhVbElhRjdMZjBLRnUvL0RMQzk5ckFySERuMWdI?=
 =?utf-8?B?MnF3SU5hTHhNYUVCSW5XUSt0bVF3QnBTenY1SkNFSDZRVFhxa1BVTUJpd21P?=
 =?utf-8?B?QkhWVmIwUi9wOUlMb3FHb1JwbWZtQ0t0ZUd2NFlIRWVqZ3VqTGFWd3dyRVhY?=
 =?utf-8?Q?30yofOXwtuGOcMXK/SVHugrMdVNuIdmjUMT9xR9dnrPt5?=
X-MS-Exchange-AntiSpam-MessageData-1: brRpbBCkhPFYzNl6NthZRVp6AcFThkGKzEA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af678a7-f096-4a27-4788-08dedb8254cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:16:35.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o33X6UpperXBkHqAjiB600pba9IzBpnBtQ0C72wI8toD1DB8HKnrE+0R++oT1fVZFRT54C46TmYvDuKTM+BYioLnn1GYLunjerXXL+IsYO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7497

On 7/6/26 17:06, Florian Bezdeka wrote:
> On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
>> @@ -359,6 +391,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>   
>>   		syscall = syscall_enter_from_user_mode(regs, syscall);
>>   
>> +		if(dovetailing()) {
> 
> checkpatch:
> 
> ERROR: space required before the open parenthesis '('
> #1426: FILE: arch/riscv/kernel/traps.c:394:
> +		if(dovetailing()) {
> 
> 
> Please double check checkpatch output for the complete series, there
> seems room for improvement.

Ah... That's the only checkpatch comlain. I will send a new version.

>> +			if (syscall == EXIT_SYSCALL_OOB) {
>> +				hard_local_irq_disable();
>> +				return;
>> +			}
>> +			if (syscall == EXIT_SYSCALL_TAIL)
>> +				goto done_inband;
>> +		}
>> +

