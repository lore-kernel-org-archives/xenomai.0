Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EF1C9ECA
	for <xenomai@lists.linux.dev>; Fri,  6 Sep 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621113; cv=fail; b=RSu2hOLvAcSDq5M83pkSHdSpk4GsySUaUN1KYI6xLp2oiqHaxjbyiLzqu//CE6pll9m/pZFMa7kH+tz1NC91MpGQisQeUPBZqfggewjhBwVHWaYYNrEWyyPUA95IYGh0YGSkV5xHbhDmKfdHFlh+VmlT6cea8t8mHV3Yf0LQ/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621113; c=relaxed/simple;
	bh=SzW7DuNRBMpqArlZGAjBUDHQ9YDblSjbffgkUAtBOt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jTU8jc79f/+4PKsHMQsP0932DJvSM6MNLesYjy0/QkElSiC5P1A+IcOL0or2IiNDf7tL2F47uCQPbOM0AWyGVcnhbbGIgjTmK2WEkU9Yks62rqzwuqYw8wWTApCCJBS52th9ymjzNpJz2qZJ7ZxmsW6ICjMuqyUaTOA/5lG7iSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qNCAVY4a; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qNCAVY4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2hNs02JA5rlL+Yf9Ut8QUOqDvNcRu2baJsbFupDuNzhawt9S4zRIJV+d9egz4jpJJhNvZwzQNMShquc4E2QbnEdc6a/O6DhjI6i3sqt3UTYw2NfqmWgMWu1V3GA3XuewJZgldnRGUOzqmS5PAK1ec3W9S8xPpJfiJQbemPG29DbTKDSqn3BmHg7Vy9PUJwSKDC2LZiXsEnQH5N4Ocw1o/U/ZwS41HH93kmwS5FJIOBt/JcE6BOaKPqEobJ8ApPbxnzRD5WALDMjWKr0nl0inXfE/7YJ7voxKeMZyMCTGK/+5YC4Zht/ruNVyqr+WOs/cX+0ZsNo+3VNj6tEKlug+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvJGyvF/ydNWv3AdFXiLW4OmdgQSe281DoXHutbW99U=;
 b=YOGEUWhlBAa1zqqerKmki5f8SKzTAXlKGph85rPzWYzDUq3tX6GC6RoVgr248Ol95ZAcURKjCvDh63E8IAakmrDiH6RoUO5Wvi5uytsKSdFqBapqd/jyOlFF+XliyVcpDCPBZ4PCHnLBmC4y65Pi9sEClE05tzD+nk5eVuORHim8W49Hkx1Sl/wNefq1F97T39SzTtVx/MzrpGhoLTGGyYsZPyWNpBkd/1MqAQWXpfQL4FfK3qGT9pwwxO0UCEc4tNEv3e7RIBhnMETnn5MB66RhC4qeEvryhH5IGsbCAyOrWJD8Ozr1zCwc31hdoHqoiRR0isPNGxyWDlS38xU91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvJGyvF/ydNWv3AdFXiLW4OmdgQSe281DoXHutbW99U=;
 b=qNCAVY4ahSlTQrpWmvYTB9Tett0zlbPNt7gpMbQB4/U1ykteOLZy2OiiW36tD48vlfmB6eF1HnJWNaeEwA2d1dCdrJ87DJcdTdyzJU+OtReERKWoWjFn/TzQ2wF560fsC68doxLmo1C83yJZnn74p5lmjtJIaGaiQ1XdzqyEJ8eGGn4RIO+rM+ZPn3eEk0kin8EHsPPRzHUToG51GyxFwzJYDo5Oz+O2jOERWYUu2kOcY1mqwaERi89eFPo7Lps0Y59JQPo39d4mpbqobvR6UyVt5wIEnfORiJs2lFNZWc/dkYWxvAWoCEPXhzXQwXyTluMsiaBKHbppolmYLqPdgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 11:11:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:11:41 +0000
Message-ID: <4f026ecd-d732-4f9b-9cb1-a8437f983493@siemens.com>
Date: Fri, 6 Sep 2024 13:11:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 5.15] x86: dovetail: Allow multiple HV guest
 extensions to be enabled
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Ionut Nechita <ionut.nechita@intel.com>
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
 <20240823091858.3355791-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240823091858.3355791-4-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3841:EE_
X-MS-Office365-Filtering-Correlation-Id: 46874026-56ab-4623-3f1f-08dcce64af4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEltRVF0UHRFSjVpa2dFc25nRDNhdENOYWFMNlgySlR0dlVBd3pRNVRWUGFi?=
 =?utf-8?B?RnFHWFgrTkdleExVbVFRN0FQUCtldVp5WVBmNUExMmsxQlFrd0ZURnNKQmlx?=
 =?utf-8?B?ZWU4bXh3SE81OGd6bUFPczd1cEt3Tkh4c1laU3dqakNYenZZdi9HSE1WWHdy?=
 =?utf-8?B?aTRWTHBVU2hSTWIvVXVmcGtjZjROK0ZhTHFMTGhwNVF3akJaNkVOUnRzWnpQ?=
 =?utf-8?B?RzV5M2xFWSthQi9NNnRLM28wSzVhdUQ3dmZwWm92RU1VZXJ4akk1MS9iNHFU?=
 =?utf-8?B?SDBBeHBMZFgrb09FdUxMRDgvZ2JpWWk1WkVOWU93S0pvRnhpZXlxc0lrVlRH?=
 =?utf-8?B?OVM4NjIxYTdXUUFJZG5IMkI5Uzd0YmFQYmxXNmVybmRsTk9yK29rM0N3UEFx?=
 =?utf-8?B?UGk1VG5ieWs0QzZCbEZaU244a0hycG81NWJsLzZXaHFiTnlmMFlhNlY4Z2hT?=
 =?utf-8?B?blBpaGRES2dVV3BlN2YzdXcweVY0citBdk1XZklIYUZPQk52U0ZzVkhncG1T?=
 =?utf-8?B?RXJXY0tMVm9sOVJaVUl3c0Rua0M1TzZ6VGJVK0g0ak9zaVlrV3hIeVU3cHNw?=
 =?utf-8?B?d3I5YnFuaHNuWkorSVZXVE5MSzREY0l3a3o1M3VCdTM0Y1EyQ29STUdXakVu?=
 =?utf-8?B?c3dCbjBrbHM1T0tFM0hhSEltemVabURFNEpZb2xmTmIyOGl5K25OeVFrZHlU?=
 =?utf-8?B?TDNSSDRqMHNLM0RWd1N4Rmpld3hVMmtCZmptU1JzZksvdlZLVUs3V3dDSzBQ?=
 =?utf-8?B?eUVoSVpWNEhkaU1DWlEybXkzT0hKQlB6RHdrbXpZSFVFaXFESjFFM1NaUlRX?=
 =?utf-8?B?cmRRY2RDa2lHdExEYlpDNGlQeDdXQW9yN3VzVjlsYW9OeDhtWUNWWkZCcnA1?=
 =?utf-8?B?SElPTDhpYmIxMlZRMm11akpuZ3dBdWxwdFhNaU9PT1VacHd0U0IyRE9aZmhH?=
 =?utf-8?B?YkVKM0I2d0pwTFNwMFNEMGZLdktnUHA4RVNPSE1VTERWUTJFSEdMY09GT0U2?=
 =?utf-8?B?K1JLUUtCS3ZDci9GRGpVcHdxRW9tNVFqMW5oOUI5Vmk2eEpIbmdSUmh3MEdF?=
 =?utf-8?B?amxOT2czZzFFL25BdjZFK25DSUYrdmVTSDU2eVhxQzJkSGRScHFnTk9wQU0r?=
 =?utf-8?B?NDZSMHNZRGJKeEMwcTF0VUZ1RkZ1NEVndE1LTGU5Z1lqM0JIV29XaGIzNDgr?=
 =?utf-8?B?WWdtQlloQStYVWxPbU9BUjlUdDcyZ09tbzJwWENxZ3BLcjcvOG8wWk9QdVdx?=
 =?utf-8?B?MzViNW9KY3B4NW1qTlMxSHlhalNiY3JwSjBraEJCcldsRitUNnBDT0xBVVlz?=
 =?utf-8?B?aE16MzFQMHYyRlAvYXB2R2pOaEV1YmthRCtuSU91WC9xQ1lGZEhuZWNWMDlQ?=
 =?utf-8?B?ek9YVGs2M0YrN2drRHVNYjFraWpYaWZ3clhDYk9HT2p4VzhjblRPVFd3YUow?=
 =?utf-8?B?NnlicnlqVVA0bU5HQjBtMjViWFAvR0VXTm81cFVaNEh1a2M2V1dDczFVZW1y?=
 =?utf-8?B?aVEyaXc0LzlhSE1KcDlDQ2xMZ1RGOTVCZVIwTFJJaTZwS25JbCtoOVltKy9H?=
 =?utf-8?B?Sit0aC9zd1UyRWgxRklMMjA1QUVmQXJRMzlsT1NpR3RBNFRMWThnbk85NmJ0?=
 =?utf-8?B?TE5pOFc1TXNSZTROV3JCK1M5UFJsNDRGNlJzVnpOcktLM0tyUWc0VTJReGhJ?=
 =?utf-8?B?dGlobDNDcGRkcWNBMStLMGM5SHNTQ0VubTF1OWpzcGpSM3d1a0Fhb1VpdDVr?=
 =?utf-8?B?WUxDcGwvWE9yTFI2MGUwMXFaZFJJUzVaRm43eTVGQVZPY3NhZUlldXNkMjZW?=
 =?utf-8?B?OHc3ZXp3U0hRaXVnMEdqdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FhY2hUdWQwSTd4QTJORmp4K3hIcnF6NWRqc25xeVd2TCswVlcweEtrUVhj?=
 =?utf-8?B?SjVyeFpYYWJEQVpQV1FmeWpkTVByRE5QbjBnMkNnQmtnb3FCcE1RMzRsc3lM?=
 =?utf-8?B?UnNzTjJLdFJYNXpZY1daandHbnllVi96QWZQYjNPQUFOQkRYaUl2OFc1N3NQ?=
 =?utf-8?B?VUtYd05DdWE5MCtNOUpWTjVrejJDdnc5U1dKM0RHRlFUQXovUmhhOHF0UHIy?=
 =?utf-8?B?bVM0UncwRHJPcHVEWTFPbzl1NU9nNzBQUGZsN0gyTkJ2NTRIMUJHN1ZNeEdv?=
 =?utf-8?B?SmZkdElSd2RYenlWazYrK0c2eW9RL3VNbU40K3dpMHJ3aElYKzRsdDcraWhi?=
 =?utf-8?B?U2NoOEpGVjFaK0hPb0QvQVR5UE8zMFA3NFl0dFBxd1FpT1VaSzNzR0NGOXFI?=
 =?utf-8?B?eUI0eTRkWWQ5UW9xN09tYXpseVNJS0VFTS9RZ2ZGTkI0VWdDdjhNblFiRjdH?=
 =?utf-8?B?QXVlWE1OZlVhTUFGVnptSzRHdTlZSDdaTmVxZG8xaGc2TkVqaVZ3M3k4Rjkr?=
 =?utf-8?B?UHpZK2duSFR1eWhaOElUUEdWRlUrYm9MRnNwTnpjOFlPWGRCTEFJaVJoNTls?=
 =?utf-8?B?eUFTSTdYYXhHS3hPcFpZQlBJUTBFOFY0aXArTXRlUW5rYTdnY09PYmJnSVl3?=
 =?utf-8?B?REJsWjNYaTArVityWnZNNkRpVVRYeUJrT1hnRjVYN2twdjlZcGlVUmFnZlUw?=
 =?utf-8?B?QXNDWW5XNHljbEtLYzVPaHpTUmI4a214VGgzSytyaWpMZlpkcHp3U1BCYmlF?=
 =?utf-8?B?ZFB4d3A3TE1hZ3ZkRC9Ga05MeWNJQU5CK2s4K0p1TGNkR2JlM29ObDdoajNp?=
 =?utf-8?B?WVdMeG10WVl3dGh4d24rRU9Bb0xjRU5rbmx3NVVRYnpXMnpwUFBEaTJzejdH?=
 =?utf-8?B?VEx1RlRmcEVUUk9PT1JsS09mck1xVDhxN1ZWY1hXY01QenpiOWg3a2pqZG8w?=
 =?utf-8?B?ZldRZnFYcFN1M2c0UkxyNGV1VjNGWXpWU3dWRzY4Ni9rZWlGYnU5R25hZHZE?=
 =?utf-8?B?M0FReGJvZGoxUGtoM0pOVHFKTGRrZzQxUHYyaTZRMktXYW1mWTlQeXhHMU85?=
 =?utf-8?B?SjQ4ZmY2aWtHQ003UTJTRStSakFvMG0vZmFidUsvR1dKSDVmNStZMlFUVHpn?=
 =?utf-8?B?cmM5cXR3LzRvVmdLRktCTUp4N1VBRFhCRHh0R3ZoSnJrdUFIQ2Vvc0ZCM3Fq?=
 =?utf-8?B?WHlvZHZ1SXRZTzlKSmEwcGlVYUNOMEJ5V1VPMDJweDJCTXhneUZHbjlsMDR6?=
 =?utf-8?B?VWhnUVJsZzBzZWVxbHk0NjJLaktjVkUwNkVzYno4eVltQTlJOGVlQnlUMUlN?=
 =?utf-8?B?djBjdWJSS2plT1ZHMVdpQWdqY3FWcXFmbXFHWnd1Z0FMQ0Ewdm9hU3RiZmxk?=
 =?utf-8?B?a1h4OUx5eWt0aEorZUdsZGl1VnVXelYxRlBMclZ3cFRoK1BSVUp6UVY3a2dZ?=
 =?utf-8?B?Rm96Ukg3cWQwNTdhaHJ3eVRveHlwU0ZFS3RISnZRTVYrMVVFMjY1QjVxbDNy?=
 =?utf-8?B?WlF4aE1zQ2ZtT2pkV250aFdkejhqT00vR1RnQXlyK0IzRG1XYjNQc3lLdktM?=
 =?utf-8?B?aGVpdmpzQW52bmxBU1Y4SmxZOHhRYXdlN2lJa1FyMGw5eU8wb0k0bkpOQUZm?=
 =?utf-8?B?c2s4ZFBuQnpMUmZvY3dNdkVzRm9xWTJMWVJhMm43Z1QzMTRLMHdZTmJTK2xW?=
 =?utf-8?B?cHg3MUZGRWJsaldwdHVzT2xEZEN3UG44RnFtZHZqQjI3blNIcCtxUUx4QWxo?=
 =?utf-8?B?S1h0OUhxRzlKS214N2xMYzkyQ2R1ZGdXdlh5cVJ4R2Z0dGxNVGloZEQ3WkJQ?=
 =?utf-8?B?clVKcDBaVWRDekU1bXBOMGUxdjNZd2IzOGJ6YlphZjgrZjRHU2pjZDcrcE4z?=
 =?utf-8?B?NDBUMUxJUzFCODBlSG1keFMzaVcxM1VHWjA0V00vYWtGdGhKSEVZNVZtbW1p?=
 =?utf-8?B?SXI1d1Z0azYzcVhnMktZbmkwZG5BK3VvMlNkVXh5TXgwYkVwdlJ5andZbmpu?=
 =?utf-8?B?OHVQdVVqUzVoNGQyT1FLRk50elQ5bUM2bzhGV2VsV2YrTVdvNUIwb3BrL2ND?=
 =?utf-8?B?eTFQNEZtSEU5NFNibTBkTzRwVVdhUFc3N2pVY2EwT0xESjBmNlRjcTFXS0tS?=
 =?utf-8?Q?q9dEUg6ILOSs401+/03fhIS0c?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46874026-56ab-4623-3f1f-08dcce64af4d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:11:41.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNfLWftHJgDNYMCoQjGpMgQU9yaoNNjcIQyz1ngqisrRJbZefi1wJiBjBmp3aROoT2NDgOxOSoC7F9tnA9R2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3841

On 23.08.24 11:18, Florian Bezdeka wrote:
> do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
> CONFIG_KVM_GUEST is active at the same time. If both were enabled we
> run into a compile issue:
> 
> arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>    160 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
> arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>    154 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
> 
> As only one hypervisor (HV) can be active at the same time, but support
> for more than one can be compiled in, we have to migrate from a build
> time decision to a runtime based one.
> 
> We introduce sysvec_install() macro - like modern kernels already do -
> and call a dovetail specific pipelined_sysvec_install() before
> registering the IDT gate.
> 
> All HYPERVISOR_CALLBACK_VECTOR related callsites of alloc_intr_gate()
> have been migrated to sysvec_install(). sysvec_install() is able to
> distinguish between the low level entry point (asm_ variant) and the
> higher entry point (__ variant).
> 
> The trampoline function (pipeline_hv_callback()) is needed to statisfy
> type checks done by run_sysvec_on_irqstack_cond().
> 
> Reported-by: Ionut Nechita <ionut.nechita@intel.com>
> Closes: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/include/asm/idtentry.h  | 15 +++++++++++++++
>  arch/x86/kernel/cpu/acrn.c       |  2 +-
>  arch/x86/kernel/cpu/mshyperv.c   |  2 +-
>  arch/x86/kernel/irq_pipeline.c   | 18 ++++++++----------
>  arch/x86/kernel/kvm.c            |  2 +-
>  drivers/xen/events/events_base.c |  2 +-
>  6 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 1f277e852c4a..5d1140bb5acc 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -218,6 +218,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
>  	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
>  
> +extern void (*pipeline_hv_callback_fn)(struct pt_regs *regs);
> +static inline void pipeline_install_sysvec(int vector, const void *function)
> +{
> +	if (vector == HYPERVISOR_CALLBACK_VECTOR)
> +		pipeline_hv_callback_fn = function;
> +}
> +
>  #else  /* !CONFIG_IRQ_PIPELINE */
>  
>  #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
> @@ -257,6 +264,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  									\
>  static noinline void __##func(struct pt_regs *regs, u32 vector)
>  
> +static inline void pipeline_install_sysvec(vector, function) {}
> +
>  #endif	/* !CONFIG_IRQ_PIPELINE */
>  
>  /**
> @@ -474,6 +483,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
>  #endif
>  
> +#define sysvec_install(vector, function)                       \
> +	{                                                      \
> +		pipeline_install_sysvec(vector, __##function); \
> +		alloc_intr_gate(vector, asm_##function);       \
> +	}
> +
>  #else /* !__ASSEMBLY__ */
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 0c9d6953f89a..3b02a4fbec97 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -27,7 +27,7 @@ static u32 __init acrn_detect(void)
>  static void __init acrn_init_platform(void)
>  {
>  	/* Setup the IDT for ACRN hypervisor callback */
> -	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
> +	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
>  }
>  
>  static bool acrn_x2apic_available(void)
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 53ded40f3a48..01242d5c204a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -406,7 +406,7 @@ static void __init ms_hyperv_init_platform(void)
>  	x86_platform.apic_post_init = hyperv_init;
>  	hyperv_setup_mmu_ops();
>  	/* Setup the IDT for hypervisor callback */
> -	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
> +	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
>  
>  	/* Setup the IDT for reenlightenment notifications */
>  	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
> index 1332f328a45b..921898cbc7b3 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -14,6 +14,8 @@
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  
> +void (*pipeline_hv_callback_fn)(struct pt_regs *regs) = NULL;
> +
>  static struct irq_domain *sipic_domain;
>  
>  static void sipic_irq_noop(struct irq_data *data) { }
> @@ -76,6 +78,11 @@ static void pipeline_exit_rcu(irqentry_state_t state)
>  		rcu_irq_exit();
>  }
>  
> +static void pipeline_hv_callback(struct pt_regs *regs)
> +{
> +	pipeline_hv_callback_fn(regs);
> +}
> +
>  static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
> @@ -150,18 +157,9 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>  					regs);
>  		break;
>  #endif
> -#ifdef CONFIG_ACRN_GUEST
>  	case HYPERVISOR_CALLBACK_VECTOR:
> -		run_sysvec_on_irqstack_cond(__sysvec_acrn_hv_callback,
> -					regs);
> +		run_sysvec_on_irqstack_cond(pipeline_hv_callback, regs);
>  		break;
> -#endif
> -#ifdef CONFIG_KVM_GUEST
> -	case HYPERVISOR_CALLBACK_VECTOR:
> -		run_sysvec_on_irqstack_cond(__sysvec_kvm_asyncpf_interrupt,
> -					    regs);
> -		break;
> -#endif
>  	case LOCAL_TIMER_VECTOR:
>  		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
>  					regs);
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 9beb81d32d98..107190bd2309 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -751,7 +751,7 @@ static void __init kvm_guest_init(void)
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
>  		static_branch_enable(&kvm_async_pf_enabled);
> -		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interrupt);
> +		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
>  	}
>  
>  #ifdef CONFIG_SMP
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 04ff194fecf4..7d0c56f6bf90 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -2213,7 +2213,7 @@ static __init void xen_alloc_callback_vector(void)
>  		return;
>  
>  	pr_info("Xen HVM callback vector for event delivery is enabled\n");
> -	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
> +	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
>  }
>  #else
>  void xen_setup_callback_vector(void) {}

Thanks, merged to 5.10 and 5.15 branches.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

