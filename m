Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982265;
	b=Z/nEKtRMhuSUI1g8qlxFrX+okrFPW7kQ5yi5oECbWq7C41uLkBpikuhXoVTcKwfjTZIW
	 ikJ8MPbUmZaNq158qXAVybZa57Kc8xbYNluhOSMi2n8fp7ArLv9zHwz7wNspBN0w71dSm
	 17dLbXXBLX8PoEqahj42Wf5l+1mJEZTw6n6dz1EiwVAKLm1gkFZiGbzqi9e1P5Q0KQWXK
	 FpPhzdLK+bdQnnf655uOIsKuYRVR5BO/SMdZ6HiweGqkzTRAzE40J5Y9bpyEVBbXQgJtS
	 DmhR8E6JYC1evp7ZbUJV9/TxaKA13IN5PO7kKljCeHsR1G3R5LgWzMFTaD9qxidDILg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HSkge6+hlZtxWb01aFsp7cbPnA/6AoQOWvq2PoqSCXU=;
	b=dW+fhSr/hLW0QXEnDko/Dx048zmvFjnOY6RGQz2bvABPQB5wRW5/uwFRH9H0AZI5i7cC
	 cwt/RDfKMrt3NtMtXKiDrybV5p6DaXSEQ6Gi7A8xS11AWjvG7AFuHlTmN/L6WFOaxP1lm
	 iAvZkQ9G8rZ4+sF+JqGA4+IvOHY8HP+bkFdQZbWfX450OP76SDXj5jiA2PZJagNd1ydbV
	 jex201CS/8BbDlVPk+tOr9LVPViYvQA12MK9FzqqmT9E470H+kulJi8tvyk4KuwFkUtVr
	 GdV+YMw0AKgayaY4ZzrO9OA9X0kzQm/6lPsRm4DzEdGb/zLKYSIDJV+qS4VFwoGvG/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="NFfMNB2/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.0
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01698606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NFfMNB2/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/L6Y7tx9CDrLDrmfLN856FGDsiW99/ZKpWdtnvZE7J2SWBBP7FV8vDyscK1c5HYUCdaUtJWn96wYDUWofsxm6/qyvmIOnnGDQJspJ0YJauHjzS1L+zd2l3vIgkUrg37onw1MC2IIcBNm3+AnEMBZWNsuPSsJUp88w+szArkTY2TP4wfEa7fzUq/cR9R17FyiRbjEoxWSy3Q5jCrGTlKlt7qh+jgeDi2eTU9OCzIYIvX8qy43q1scgafYD72r/MRy1xWlVoHEyEtBJNmupT5vgo3bp7wVqYBT81/nzCUu7CMxhXQyLs1QGDfN59jPTWpsYJtp1CRzp+x4B+Gkk9kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSkge6+hlZtxWb01aFsp7cbPnA/6AoQOWvq2PoqSCXU=;
 b=AWgHKYCuPckS+1Qg/EtZ4gFmaJzGYuUCoRWEnv96J5a+t1Z03Y+KW9qf7PWPuc+iLk9/JS3ua5XjrO3PvxvTeQFytjKUWEskrRqRyJMDRKvAHk/bByzq3rtOS9s77hmS2YFDDkWb3sruvpstx7FxskwOjbRPI4fgT8I3rosbCeFS6QTJO6zLjqcWjsXt2iFDPU+AnAblnGLTyHhCzRtbFuReD68fYx1MVUcakSBrLYyVHEAjQyzZjv0KJxcGg6kc5cTXlOUQFbfBVltwms/t0rVMvN/KLpc3NjCZRjHyI59nBweCogyflg9B/f3c1IVaMPgV25g4IlW+ZYFjJFBSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSkge6+hlZtxWb01aFsp7cbPnA/6AoQOWvq2PoqSCXU=;
 b=NFfMNB2/L4JmssnVgP352AKpfcQLWbHmT/8S4PHttDnYMBgMOerOf1xnHtS/uHBxWI7phlnfwTkBtjItqRjX4T/xcgOT6vk16zV5NTJRjvANUN/mFDS/xbDD3D8IeOmGyTZuOrlXkew4lmkAyVIQLpwAVRUqXjOrxtbEHCyNEVQU9+hZ3I76Vxv4z/jKilqwINM4vIEk/vFazgFIBXMLvl/IWomSlMek6oxG9uxiMiUD65tEPn90fNgX3hrtpUXpWOH3lvc2duU45B759rHZLOdgpmUVfxTnXxSbu8b++C9ctToD6a9rpUphzIVG5g561Rx9a90mv//cB8fRqjf8CQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM7PR10MB3841.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 06:11:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 06:11:01 +0000
Message-ID: <c843f43e-07b7-4421-8623-2beef851afef@siemens.com>
Date: Wed, 18 Nov 2026 07:11:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 3/5] riscv: dovetail: do not nest the unknown
 trap handler in software checks
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
 <20261117123925.597027-4-tobias.schaffner@siemens.com>
 <6fca88474f2e6ae11638f75e85aee0b211690fc2.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6fca88474f2e6ae11638f75e85aee0b211690fc2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM7PR10MB3841:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9bd286-ba84-434e-fd22-08df453ab84d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|260925021311599003|260925021911599003|260925022911599003|22082099003|18002099003|261009223027099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5X1cu/bH+4ZG+c4sGkmq/bQWRFE5cBGUyJvC7AQAK7lBT5EXKyzpC1c2OcFqowiXApEBTu+AeneNixtjD6RK7NBu8zQWFGSwFGeEGnEs3/s1XhfsUXBCk9XTiI4zF2l9RKECcBzFB+QG4Ljq6/RqJEJt0d8898dpnSE8YsgRbw/Npa/0mItXcBfSApPl7HdCbQ3i+V8qtw9++NUoH3c3MHrGUbcB6fRkPSIkbnF4hBFWrSIQZaT23Q9NZhP/nsBdZ5uN0aLUYCcElC9afACuBj26dEtYSrzyIjb0DVQ+FzgjK+7/iVrLvC/8mTz+oh39dfVIQOrL+6UXyGj+TsUuZxAm7C68wSBdalwYdZ38lPpYQCpJ7od99MCaT1kqDPaNlDoltu0dPrLLY5JXkpJ6gI5SUjzdKiAccbDSrVvkC1iFnQpv0UGzz9sa6jh68X67+hmwijJRkx1X7Fz738gmPhzvaeEIOxBHGXyZ/dsMJKYhElLBgFosK9xnBQFyIH8AAcw2Zsiauukkh5mw7RCgR6iFAm4g7f/cd5k2869Nkrn2PdSXH5r8camJx6miE7AjGivj6Lh19n91eACzfBBIavicCOtpcrZEfVxgVxwl2SbQB8MQezU/LnzxBNXT3biF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(22082099003)(18002099003)(261009223027099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFBTaFErVVp4MW1JOE0yY01ZZkpUYnErbTAzSklPK1dBYUxqb2JtMXc4djdH?=
 =?utf-8?B?dzRVdUMvNXNJMmN6L0w2SlR6cEgzOUp3YisrM3pWVmllK2IxYUhNakpVWWFy?=
 =?utf-8?B?T3c5d25aNjFDUTZXV2pEdHRYVjFwejRTb1JIeUY1elEvSXZzdnpGdG51djBW?=
 =?utf-8?B?RkVMTkZESXRNdFN2NlgwNDBjSDE2VDZxTmtUc3FhdVkrbEJzTWlzWURIMmlI?=
 =?utf-8?B?Uk9CTzJiRCsxeURkZU5qS01DcmZrZkJSTk9OVTFhMTVjQTJqeGhhRXBZZ2VJ?=
 =?utf-8?B?TEk0UXhzclNYaWxLeVFFYytsMmwxejBRQ1pOdEJId1ExYXJJS25aV3gyem1p?=
 =?utf-8?B?NWVvTmdicFE4Z04wMzJIUmdudDB0OFJhV0Y2ZWZRdERka3hYbHJqN01hMFhs?=
 =?utf-8?B?MldIOFh0UnNnY1kwK3VpVkE2MVFCNXkzZGxielU5REJuQlFDQ1lqRDl6RlQ4?=
 =?utf-8?B?b2o3TDlPc0doT2JZUHRVQUljeCtFNGFBL2ZPMkhEaUl5YlVJQkY4cDJ5VEVs?=
 =?utf-8?B?ZGVVSmgyM05JMkJNL3JhY0JrOVZnZ1NWTzFjZzFnTmpGaE9paktpOUFYTDhH?=
 =?utf-8?B?WHpKbHNqYno4emdmb2p5cHBHb1Npc1gwZllrMGt1UzFQazd5dWRWeUtvTXZU?=
 =?utf-8?B?ZGdBVHFnRmt2bWh3NGQvd3ROSk9xWEdseWZUK0MweFlLelJZVGowd29PTnlC?=
 =?utf-8?B?b0wwaVZnTXYzNUZROW84d0JpUngwUTU4NU5XaW9VRXdRcFlrVVFoMVdzWnRz?=
 =?utf-8?B?T0hsUkx4UzNDWnRIRTVVZ0xMZm5DUmtVc1YrWDFvWnVLNHgzL1VKSm5aMDBu?=
 =?utf-8?B?VjZPM000V1RFR2JWQjArUkp4R2VFQ3gwbXo5b2FRbFJNbStSZGp0RGRMVEZJ?=
 =?utf-8?B?YUJuWEZ4K1hBYWpndlAzNHV5UjVkT053TDlxNExqUjVKWEdQMloyVjNCbXJU?=
 =?utf-8?B?ZTlWZDZPNkpTc3piZUg0cmY3RnEydkNReDJkV1FkN2IyTkhUQU0rOS80UHg0?=
 =?utf-8?B?cHB5NlhZODd6cWZSTk44cmp3Y08xRW1kWHc0NTVJdzlIdkhOVExDM0VuRi9K?=
 =?utf-8?B?ODFTbDQxTzJ6QlZlclgzZWpBcm4yaUJCb0dmWk9EYlhXUytQT3ZYd0lqdWxE?=
 =?utf-8?B?Q3MzNkMrSTEyV2NoS3dsNXYwRFBDZEQ3bXVzTmdyU0VGd0VEb1BYVWJySnBm?=
 =?utf-8?B?VE04Y05MTDVITXlpMUNJVGxRK3lkaHV0eWZVTVM3aVlwaUdXWGxuaktPRWdY?=
 =?utf-8?B?MWJoMGFabWtpRDJFMEx4c1paVDdZSkdQY0RWU1VHME52b25SSk5vZ2tEZU4z?=
 =?utf-8?B?MlhJK1JCZkM3SjdCY2o5b1poZjUxTXJaQStYd1V0NnpYVFROL2xFNmVYc010?=
 =?utf-8?B?N29adTliaTVDd1gwSFU1SXJzRmRqQy9IWGhYL2NWQmFYY0N2VFNtV2grN1Nw?=
 =?utf-8?B?cFJMNzl6OC93OUpHWlJza2pWNGNROXE3VlZ1cEtONVY3SGQ0cDEyNmZqK0x6?=
 =?utf-8?B?VnNZTHNrUDZ6YitSVXdLdFZnb1NoVng2VzB1OHlnYnZTd0hFWXBUTm54L09N?=
 =?utf-8?B?OWNhc3Nobyt1VUNGdjFSMUQ4N254aXIzTUs4VTF5RHdZVXlxSnlGQmxvRlpS?=
 =?utf-8?B?ZVQzNGFtS1NNdExtNlcyRTBEZnRISkw3T1E4N1kzSm4zcnZwdC9Wd2VocU43?=
 =?utf-8?B?T0taMHNSdmltdFJwWjd3d3lGVG9va1V3SEZ1SGpGSG8wcHEySE9GbytwZUly?=
 =?utf-8?B?Z3ZlVDBzMFdXUE1Dek5CeisrWTdJZTljSk9icTFLN0hKSUhEZUNDeHRBMjJ0?=
 =?utf-8?B?OHcrTUFhbkdKSCtjTHE3eU8xOCtFUktpNHZ3SEpYMkJieGxiTm1EYmE1QkVJ?=
 =?utf-8?B?RTFjcEJnNjRqMEZhY3J5VVVuUzJKQzcxOC9DK21IMkZ6Y0J3MU1LL1R0SnE5?=
 =?utf-8?B?NEoxTzhsVE1GUnI0TCt1M3U3emN6ZDFhOG5vZTc2YnNyU2U5aFEvdHlnV3No?=
 =?utf-8?B?MmJnVzF5elo1WGlvV0ZPSEVMY3Y2QVhWL2N6VTMxa2tMSXFuVzdiSjJTdXdw?=
 =?utf-8?B?SGUzaWpFbVlUbTBieEYvYWJJNkxEN0JOMmcyQllNQmYxYUFEeHhMOUZ4eTZm?=
 =?utf-8?B?Ly9MNlE3cDFYblFqVi9FcFFocXRvakFOTDdLb2F5Y0xVNzByeFVSQU9PaXNR?=
 =?utf-8?B?b0pqS3ZPRVVFYitRczhZbU16TXErVno1Y1R6ZzBWL2prUFJ3UnRNRDZhaXU1?=
 =?utf-8?B?S24xamxMdUpWMVlYakVtbzFTdnEvekFzaXRPcmxydDZqdkw1MG8yaGhRQVpi?=
 =?utf-8?B?b2V0VHpBQ0NHa25vUHhMNzhTUG5QT1JSM2F2N0orc0d5OXJKZWN3QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9bd286-ba84-434e-fd22-08df453ab84d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:11:01.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB3lvnwd9IXaAkh5ydjmYvKoKFdJIjR0tjHKTETmr42hSE82v8Rg4MnJs593iXu4vLU4qo+1DspHGS7DRrf4GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3841

On 17.11.26 21:38, Florian Bezdeka wrote:
> On Tue, 2026-11-17 at 13:39 +0100, Tobias Schaffner wrote:
>> do_trap_software_check() hands a user mode trap which is no CFI
>> violation to the whole do_trap_unknown() handler, which enters from
>> user mode and notifies the companion core again on the same frame.
>> The nested mark_trap_exit() unwinds the trap before the outer handler
>> is done.
> 
> If I get this right it's about nesting of those traps, or
> trap_entry/exit() calls.
> 
> That problem should be solved by the series posted by Jan.

Exactly, no need to address that at arch-level:
https://lore.kernel.org/xenomai/d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com/

Jan

> 
> But: We shouldn't inform the co-kernel twice for the same problem. I
> guess we don't once the nesting is probably solved. Isn't it?
> 
>>
>> Call do_trap_error() as do_trap_unknown() would.
>>
>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  arch/riscv/kernel/traps.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index a8e37ec27cc2..dddb30711440 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -473,7 +473,8 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>  		if (mark_trap_entry(regs)) {
>>  			/* not a cfi violation, then merge into flow of unknown trap handler */
>>  			if (!handle_user_cfi_violation(regs))
>> -				do_trap_unknown(regs);
>> +				do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
>> +					      "Oops - unknown exception");
>>  
>>  			mark_trap_exit(regs);
>>  		}
>> -- 
>> 2.53.0

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
