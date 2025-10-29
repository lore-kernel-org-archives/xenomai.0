Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDB310645
	for <xenomai@lists.linux.dev>; Wed, 29 Oct 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722383; cv=fail; b=I5AV+FJXDXK5I0QG1VoQSr+RaZCODkb2NCBIKykZ6WtU1k7pLZ17neZG+87EOYMi+R4EadVrVVxMk80uM9moFycZrXD04ovPZh8qyXB+B7B+9alsbHyeq9qzgwkRBXT4y/1khW4h2kmv7IkBdsR7eLwxdm3Oon6wSi/MQiAZzno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722383; c=relaxed/simple;
	bh=Ix4ZB+Vpy3/kvQgGgWr+DiDOpiN9EZ434Zzkg5AtYVQ=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=dvrC1ovhqKfb+Fvy7NL2UBdTVe5QxI2Ri9/w6CrkTbEsw89voogaSrZyvfFeMBqo7Qw+whqPM8exO01G2RsXCBZKlBGfOy5piZKkyK7urVe2QqnYLAzSGNFB1jYIwfDRrnn9hUqf2+Dvacpgy9a86QOxm5YINcgTiVfqdoRwOkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KY5i/Xfr; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KY5i/Xfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Km8O2a8ibWZqBy8hUrvlJuEoqQwMwZrv1NRtJq4A+61QgixVWFb2AXROlou8moyh3HYFFOgLw3vbNXrmMBCUvN9vukld6YITDuCKV0RjWx7KjYdMO2/JKmlc/0aPAJSq4PIytJnEcJFYLgimtCd9oZz5nzcxj5qiq3BSi7R0ICwjl6tz2YN9/zeIWRrcK2bLnmkcCzjTzjnsFPz1WZCkLzQNwSc0oYXglIs8rXW7ITqVWJiDwhqybFNHcttpQuGqXTn6nD+fS/5fueKQ+Q3CbkjJd8ChW/XZKuLd6KtWnwdil6wZJTiTyuUsFt1V6jwrHfBly9SxzQHyPGhdI7fvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBYVrNiBx0YuteEOCTC73tH2ql4arPgQMQ88Wmxgbh8=;
 b=bB1QjUjzQmSFZ2EBT9HKI+XeYHqEXDE3/Egt9Ze5NKuY/9EZnfr5YEfM/XZEkPWBDrg8Kj1UGqsa6+4PCQ2rSV15bEQkferZNYjw4k9SQs+w1ntfW9YIoucODzneiZCn78wJgrvh5ZlrN8cVQAhAQbLpN9DrYkpbJfx9R5MIwQd/DTsEL+AMz5D8OwcPUK5TcaIRYqsUJ3+FQCnd5HukcOXupSnU9z/bjXyDXsWvaW5FpHLdvkggD/ubFFGJXigJ0Qf1pajjjLXzZvQm6CpUuFBK7u8+08/Y1cBWV8JUny2Rx7EwQHpVUKoFRD78D3VFLATX1iefrsQ6v3YCd9sl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBYVrNiBx0YuteEOCTC73tH2ql4arPgQMQ88Wmxgbh8=;
 b=KY5i/Xfrs/xuOOzLkERMQIjD6W0V3VuHD7zqqb3K0dmUHsvfzXp4rSxJlqY2/xHWItvpcQqryEaCIWBh23rv7JWzNckurUqBaOeHM/35DqXxcCHHa9HCmB6SobtxFeD4Nf0LxkrvGkJUX0zJkcblCO3oeDG1lhRz01svdpPMHpdsUU2yLBCf1kky1oawH/hCQ21b8YwPjaqZJQA+0NEJLKpBk3bzHXPD1VytczEO1EkMjlC4Im46KpNCdpYRTuIw7LrQp4Noz79o8HcTCKzsmUTIBGVn6WZoFpnwfAaKy/CSPffolO5QGjoPIdZ5KJ/dfeYLJ/Rpih5aeKdYOoEMlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:152::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:19:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:19:39 +0000
Message-ID: <f397b94e-3e07-47a0-902f-730451c85253@siemens.com>
Date: Wed, 29 Oct 2025 08:19:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, October 29, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3634:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6b1156-edac-4eec-fc7a-08de16bb859e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2tjV2xBOTlrbUdYK29jT2daNktCbHhwSy9xVHF6RWdWSVpDaHhYbmRBSkh0?=
 =?utf-8?B?UFlrUTB3YjVoQU85UFhJc2ppN2NHWXltN3NYVXlhaW1KdUpJZUdNcHRyV09J?=
 =?utf-8?B?d3dPVG01NzY1aVR6NjlLU0U0UERoVnhyWW0rN3FqT0VvUGhuOEk3OGlmMHpm?=
 =?utf-8?B?UXpPNzNUTTBYUzlONXFLeXZNdmNENytnNHQ3UGZyaHltRGQ0cWxKTEsvTjZj?=
 =?utf-8?B?RG9XbWxKTDlOYXFrYi9LKzRKQUZ4VGpRT0ZLdVlsa2NtUzNqRmN2Q2FxSGdQ?=
 =?utf-8?B?SXdRRFQzb0FEbkxQQ3BWTk1yUHdTVmdRSVpFMFV1SkJ5RExpZk1FUjlTanVZ?=
 =?utf-8?B?UUc0ZFIzc1dlcDBHTWw1TUNRUkZlQjhKQlE0dVgrSVV5VGxuUmhJT1hCa0l0?=
 =?utf-8?B?Qm51bE03SitpeUFsQjNZWHJmMWg3emJRYXdDbDZqVHVyVjN0QkRCd0w2b3Zj?=
 =?utf-8?B?ZGxyc0xuZFE4R3lMamZScG9DdE5uR1duVW1NWCtjN0E4NWV2NHlTNU1vblRC?=
 =?utf-8?B?Q2hsRFpPRU5hMlk0N2JWMWxENHVuV3plaWhHeHBTZ2hkVDk2aENNTUtLWEts?=
 =?utf-8?B?R3B4MEJWenFLbE9BUmJmT3ZsRXVSbGJaM0FwUURsT0E2VDRhZ24waStQQXJu?=
 =?utf-8?B?RFJ6RjJCUTVUemg4aUtlWmdpYkN4aVVHMTk2ZXNmTWZ6aGJHOWp4NTJMSUxO?=
 =?utf-8?B?UkF4VlgycmVRUUU3M2pobG5pQ3hHV0kzZC9MR3RtM3dOUEl0emI0dmwwbHJK?=
 =?utf-8?B?cUpVRWZGWnZYNURDNE9lMDMvNFpiRTJqL2RaeUZoSVdaUTdxVDRXZWFuZU1Z?=
 =?utf-8?B?WThwaTc0VzR1SXFrUDZKeGFTT3drMUxlR0VoZ0pqYWxwdGVWbCsxL3hQVUls?=
 =?utf-8?B?SG9JWkxCL1BBeVZKMXY3OUE1eGoxaVVGYzdKVXJ1SmgwWkozWVNOTjdENDJS?=
 =?utf-8?B?RnNyZzBrbzkyVEdpSHBmVlc5cUFzWm40ZHE4QThOdnF5SEUwUWNrNUt4c2pN?=
 =?utf-8?B?cTBXbWRnaFlncDlsMkMxZjVLeDdVN0lQdnVrVG1PS3QvZW00VVdLWXlQcUl4?=
 =?utf-8?B?cEZicVlyNE5qSmlrd2ljSGlWaC9EMmd6dEhIMk5qL2F3Ykk1d2VqRVNjZ1Az?=
 =?utf-8?B?SnJJdUs5TzBNWEpKMEFRTkl6Zm00amZkSm1tNlhyVjI0V2RKZjNtNWJ3R0Rp?=
 =?utf-8?B?Njl2WVhzZlhVdTFVWEM4Z29rQm9lb1JIS21UMmZMYXdqeXZnRXltUmp1RllO?=
 =?utf-8?B?WnJqaklNZDNMWmM2MFBuK1Q4cUVLWDl4QlNpNTRjaVBpbzRkSWlncTU2RzM5?=
 =?utf-8?B?OXREbW5mUEhjdEIza2w3RXZxZnA0K01MZmZPcFE4d2d2NUVVQkZzdUhSeVBt?=
 =?utf-8?B?TFA2Y0drUmZyMzBKeFdBWFdPVFlZa0V0T0xsWnZQak9ZY3RZY3d4TUNrc1dU?=
 =?utf-8?B?ZVQ5VlRiUnY5bnNMbFhwL21mZWRiaENHZ1dETStUNy83T0JkR0dCblNnaWoz?=
 =?utf-8?B?dTc2ZC83RC81amFrNG1nMzlsSUNUR09SQjcvNnI2dmJINUcySmVET0ZZT21R?=
 =?utf-8?B?NEc4RTZJUkdFa0pLYWpEVFpxQ3VhZmFnQUZUOXo3amhYajRFVTFwWkJmdm5Q?=
 =?utf-8?B?aU9EdDdRTXhjZ01yRmN1ZS9XOVBPc2pTM3VlSUdQVzlBeU5DOFhLaC8xQjRj?=
 =?utf-8?B?b3VpcWhFL0l5R2hvSDNWNzI5ZkFNSjhWTExRSFd3WnJDVk10MzFSRXdMK29F?=
 =?utf-8?B?c1FMZGcwbmRSc2ZMem8vNFJDWXpHaHl2STlyNFF2ZVpvb1J6d2FlSlFSejhr?=
 =?utf-8?B?ZVhiMkQwbEZFQUlRMUxua0ZNSUNLeUFEbzlhYXJqUTdjUmF2OUZBSzRqdE1F?=
 =?utf-8?B?eHdnbFp3c2pNeUQxdW5yYzl1dWlkNEVyUVRaMmFuREx6RWR2NmhSbERlYisz?=
 =?utf-8?Q?8+AJDBWX8Pgu5uCoHM70telrwPZAoSSA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtyU2lRMDlHSWFXRDY0TXUyQklFNHBmQ2dpMHdFa05oREp6VTdZQ25LcktU?=
 =?utf-8?B?UUpxOXByZEllbDZDYXdHemVRR3BHVnh6ZXpyWlgvYnE1bEdCY0FJMDZrdXhz?=
 =?utf-8?B?bzUyMEJUZWJZQTNBOEQ0QTUzUCtyWGFNcXNEME8wQ1RndXZKK0I3TXFRMDdG?=
 =?utf-8?B?UzI0TDFsZzNSTnVFc01WcmluT0xKRXhFSkwvWEVmRGNxdHJZUnNzNUhyK0o3?=
 =?utf-8?B?U2FMZnd3aG43K1RQdXdkZlZkL1JldmYvV3NER3pmV0tnSHJYank4bzgxaHdH?=
 =?utf-8?B?ZzlFWmpXaktZYThOcXUwb3YycEU3bXNHTXd4MTZQUW44eHN5VjlXY00yMk5n?=
 =?utf-8?B?b2hoUDZrUDh6enF3M2lIb1NrdllEdjgvVTJ4QWd6cXZsczZ6Z3RGeG1EOVFn?=
 =?utf-8?B?ZzBXUzdJemM0cUNlUkE5ZGR6M1JtQ3ArU3FadUQzTWZtRlNKMGNXVGQzaVBQ?=
 =?utf-8?B?QlYraTUyMGV4NHg2UkxSSW9tdmw5anF0UHptRlFSUks1UC9tK2JCWGVtazI3?=
 =?utf-8?B?UXlCZmhTYk1SYW42ZHk2N2NXK00yQmtNdVBVaitZdWg0UHZPc1FwSXhzS2xX?=
 =?utf-8?B?SlkxWG84OGQvMmFwVDdZU0JiYTBFdlYwTkNLVkdVNEJsOVVvTi9zbzBWWTU0?=
 =?utf-8?B?eUc4NkRBVXk0M0tKaThVZEZkWUhKNzBySlJZSlkvWTFRU1F0RkxZalVQOGpn?=
 =?utf-8?B?Qk9NVjd5VXU5UkVUT1RZTm56WEk2dEp3OENmbndvM1Q2YU9Kb2J0VXJncTBx?=
 =?utf-8?B?dSszMC85SXpwMUYzT3kzUUZCazZHWENENEFpNHpuMDRrdVcwMzIzcUlOT1hh?=
 =?utf-8?B?RUJJTTA1amJUQzBMdUpsQlYvc3pIK1VDUG1DV1JTcitSenh2Ymx1QU1xUVhw?=
 =?utf-8?B?QXVPMGFjV1RSNUExODBGbk1NYjJIRzJmREhJcndEN3ZMNEhuYXBNUUwrT3VT?=
 =?utf-8?B?K1N4bCs0ZGx0K0RZSTRiMUVJZDUxTWZkZE16ODhJajYzM2NJQ1VaRzdKek1Z?=
 =?utf-8?B?aWViMmpCemVrVnpWTDdGNUIxV3lRS0ErMGJnODY4akR6ejFvb1RHY3NxRDZq?=
 =?utf-8?B?RnJhU05jMVAyMThIMytEOTRBMWlhSGZGRDhXUURhYjF4VTNzdkNOQXlac3FR?=
 =?utf-8?B?OXR0eXNuR3czRnZrYjJrM2tkWWJibEl5QVFPaTVCVXVoMHBEbFY1U00yYXdQ?=
 =?utf-8?B?VHlnSDNxS0VlQlRCSjdZc09jZ2l6d0lGbEVyZFFmc3lNWUdTYlRCRC9LNVFV?=
 =?utf-8?B?TTQ4N1oyYUh3b25yZGdXT3g3c1MrUlhKN0FKOGx1c1gyREhjNVdxSFRpZHlp?=
 =?utf-8?B?Z1FZOW5NK3pGRlFQekVDTFdTZE4rZmQxT0t4MnlkYzZmeHZrbUtPUk5LMEMr?=
 =?utf-8?B?eGVWMTRaWnZsTG5ydURYd25XLzBENUhqSDFNS0U5ejE1TWZscU9hQmZWSURw?=
 =?utf-8?B?WXlyaTg4YTdMamFYY3V6bHZOSFdzV2JVUXc1VHhEN3BGSUZnTEk2bXB3WHk0?=
 =?utf-8?B?SWN5aWVMdGwxUmtUQUJTYStQUmFwc0RsLzhuQzJqUVEvV3JydlppK3ZxVWFr?=
 =?utf-8?B?bTZ4WEdZb2RrWE1KSkFEL0htRGFnanBtQjhDVEtQSk9BbllQT2pGYWdIUEtC?=
 =?utf-8?B?ZkhnODJIbzQ1eEJ6U0ZGcTN5Y1RjN09JZVFJR1QxOFBybW42WVVYbDdTelM0?=
 =?utf-8?B?Si90TEp3U0pEbGJMaTZLSEk5ZjJPOXdpUzcyVnpqSXo5WEZzSEJNSGZ1blZt?=
 =?utf-8?B?T2FKYjNoT3VLRkJRMmNBeWU2MlN2WG1Cem9vSlNDNXZtbnVRNXIxWnhReXhZ?=
 =?utf-8?B?ODR0NDQrdkpvcmFOMy9CZnlpUnNhclAxNmdSS2pDaXBHVjduNFhQT25kazBj?=
 =?utf-8?B?ckJVa1l6WWlkSGRnRW5weWNBRjdRcTlSczJJOHVCaUNOK3hWRzFmc2lVUVhl?=
 =?utf-8?B?Vmh4RStjNWdKU0hWNXNwazhkMjdiSWRkTy9lSStoSHE2ZVQ2czlXVk1VbitO?=
 =?utf-8?B?clRtQjhjZFZQbmkzdWp2c3NPK1F1Ry9LUjBmUjRiNEpiUHNJdHBmS1hOZ2U2?=
 =?utf-8?B?bEJoRGRHMVpyT2gyMGtGWnJqN1hTTlY2Vmoxbi80VExUOWZnWnh0c1RJdllx?=
 =?utf-8?B?c2krbmlMaTd4UUtSeEZQZk1PZlp1TXJDNzNUclZnRHNYbXBDdTlvWE5mTTY2?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6b1156-edac-4eec-fc7a-08de16bb859e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:19:39.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl1uWwZXo0Pnx3a4pG4UxGGYXLovMNYADj5LvDN7DOl+IfzRdJXKaH8KJPBhvNOsHdgwnzNa4fF+SiS0rtHxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3634

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, October 15, 2025, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

PS: Sorry for the late notice - and I almost missed the DST change...

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
