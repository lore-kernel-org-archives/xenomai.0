Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9A6A022
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245095; cv=fail; b=t8qxOAb9tEWe/la/dqRHCnWkpJ4VY6x5CJaqM0aCdzXr8TYLreLAqqeZpybQlcQeIr7JHsMSu7FRAkNJyM/ySTbN5I8R+K1ky9wl3r7Ij/zceWx4l4f/uYXiWUVJia33rILpn1sRl6g9o6qzuA/uRpYH2Nb+tVs9pf1WJMkMzKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245095; c=relaxed/simple;
	bh=eYF/Y8k3NQrS+IxVYhuO0zagKaNLzCJWjOcNoaepm+s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5AdSHnStjqJdDvj3bDR1Po5eVNY5/4jTiPv78ak4+2Mz2IcEgdlkUwYg+uXhGMUZ7y+q8O5HTaOhrExFzfp+DNhV5Y+nBZ1PueN/8M+NxRJhSfxjQVtxMY6sUgbOhRiLhuiSNrlX9S/PrMO6x7po23DLdk1MUlLHrCqabeWCEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gsNlT+lf; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gsNlT+lf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXD5iGKoHM1EbfifF6uZw5iH5PLCKDpPoqw3nZKypLJq40a0crovy0c+qver0Ivlor7R2gNZfWHlReJNNE8ugeItfAXAtwSGXBWJExXFYvChIf3O5FjAGFxG8WzGGdAFftjCgAlYASNfR+EAnXwgqAVlb3OG9djmwYvaeyD6YD3Lu+02XOxmyrKyuBqAwIAwaiSa/fpDBPLdDpPrgnz8in0hW0CJZDQVuioobtyh+/9hnk3vdwm2SofpgTjhzhrtQ5rp7l3UgdHg5yk3VT8fF+UC/0/bNu6CixhAmLCRdYemz1rpcL7tfTHJ5t4QpVbj2SnIvMDr0MHNTseAsO2Y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm0GrXypk2ArfasZngvpV/RrBB9y6BCGjyD4J3yOka4=;
 b=AVjEIgCNcmx03oqExOFIL0SZZGz6L389cpqFCaUHAUTdpYVqb2CRUEvREIqdhxKUXxpIkfGw8Y6JBnvgU7+TiYJLp+ruqqqMf+34xt1IfcCJOXoG/OXY8LXiG2AX+xUJBYy1zL2247RE0ZPrpaVgyMPIXk60N3vtclf6Nx0bSNf/z6ospXt51ZVlncR4/vQrxUCwBY3K5GigcO+Rd3mCFqO2xSU464LlWxsqQ1rmqmmBB2ILei9HmJD8JxmmnUWmJWko0r/C/obtL0bpbddyVtPCDM0tlfj4gPBEc5ZLbpnIV0Bpyj2MMV19aD0l82/DSMocoJ669+SF+agZjYxBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm0GrXypk2ArfasZngvpV/RrBB9y6BCGjyD4J3yOka4=;
 b=gsNlT+lf5tzOTAQfcQfbYERPoJdiS7uvlasegzqL5Sn1+hwDIWp3LYsv0kzuRHsrrauGobJYWuFTV41vVtR/XiOPr0xAa+EGUHJK12Gx9JgHYt0rRFSUTuo+XGqqdrOpH/60pxLym60tRSoDHhw6d7wwrEW8hZHCgvfKmiDdpQ0kAJxHPsn/QALD1scMkxpBpv6y1Zt/CoXAXz6GjTtcGdbQG9u6tQwxT4jurcyCqOaz/NVSZzXl80ZtU6OraTX6n46+WbgaTPWXYhSFwOLil18LHzjy7dHdWO6YfNCaw36r3TpDTdE0d169hb7mjQVXWdjNwZdIOjDkEnFA6PpBGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 17 Jul
 2024 19:38:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 19:38:08 +0000
Message-ID: <f4c2a08d-9f80-43fa-9dff-d7d6f1d81bfa@siemens.com>
Date: Wed, 17 Jul 2024 21:38:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: add x86-64-efi target to long term
 test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240717193152.510216-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240717193152.510216-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b863d05-5db9-4e03-3344-08dca697fc7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFU4L2V3ZFNyTFhoSXR1L052cDNNU2E0NXY1OGNhaVlEWkNXTnIxaWU1eXJ5?=
 =?utf-8?B?NklNbkdRMnVUWGFtUDFXNEtpZ1d4RnJTbnBETytyNGd5UEQzRG11WjZiamFz?=
 =?utf-8?B?Sjg5RndLbU80cm5jVjVCeEtYZlVzNCtycEVsbUs4bmNpQjVQQWRNUUJwTC9w?=
 =?utf-8?B?cXJKZUpoM1luRk9uM1RUendJM2NsdjlNTnZ0WVY1U29sdE0yUTNMZitSUko4?=
 =?utf-8?B?dmtCb1FvcTlNM2NoZ0xNam5YUitLYUl5cXZCcXAzeGE1aFdvc3ZiRmJ2RUdQ?=
 =?utf-8?B?OW5WQWxCcWNBVHRJY3djb2o5N1dFRFdnTnZuMjVxbGhrS2VWNk8xQUdaMUd1?=
 =?utf-8?B?elkxaE9KK2ZXbkdLNmpLUFoyN0FIbmNXRW1KbW8xOWdrbXNqdnkyWUE1WkVY?=
 =?utf-8?B?cVpNOTEwWDBMdlo0Um92TVhwSHV0Sms4TkVUYWN3VzUzQVphSTRvMlpsUmFj?=
 =?utf-8?B?SzFQOC9TdTlVZnVPNXJNZ0JOemxOUXVoQzVUaU1WZVA3eUwzZEgxT2tjbm9p?=
 =?utf-8?B?RmdZdG9vRGczN3VacFBTZ3VoUjNOb0ZSQkNsSW1GMFA2dHJzN29xV3NBMmtv?=
 =?utf-8?B?MnVscmxXU3RmQW04SG9YSUd0amwvSHl3Q0ZVeWhBdVZsZmNGS21yM1JpNmhv?=
 =?utf-8?B?L2lNVVFkZWc0dlZ4d1hZTGwxOVdaaUFmUDQ4M3hoUk5yRGVTSTQwaTZsYmRZ?=
 =?utf-8?B?ZzRSekxFR0pqbFR1Qy80SUxRRUo0OFBJYStHUU03ZGNiWVZzVzByZXdjdlN2?=
 =?utf-8?B?c2ZXRk5EWGJGVWprR0N0TEVyb1JvZ0JUY3QwV3pkSTZHTFhoeTh4N0NTNDdK?=
 =?utf-8?B?MVowSHo1TU1yU0l1R3hPenBYYUZBTGFsaUpuTXZXaS9XQzJKVmJUTmlhRTVK?=
 =?utf-8?B?cGRROUo3QmMzLzBjdStBOVVpSnREM0R3UVpCMHZQV0grRnljQkl3aGlVVGtO?=
 =?utf-8?B?aUJiYWJrWVVINC95Y3AxeEo2RWkrSW9qY1hUaXpuOGdzS3ViN3YyUHg4azZK?=
 =?utf-8?B?TlVkSzdRSDhSOFI0RG1aZXVVUHVhYVdOcHJYRUI4eElrd1NzMnpWUlFUWklt?=
 =?utf-8?B?RUZGcTB0MlpCRjZHTFBWWWF0L1hvbm9DS1VZYm1KSG84eGFFam1rZFdGWVlS?=
 =?utf-8?B?dXNOdFlnZG9HL3ZLRjhPY3NYdzhmb1Aya2F3eTNmLytWUVJFdVRBRHh0dXF6?=
 =?utf-8?B?eE1BbG92VVJwUHdVZDF4UE1PcU4yZm42eXB3SVYvNmYxNVYzbHNwYnA4WTRG?=
 =?utf-8?B?SFIvbG5zcml1QnlCaGNnb2tPS3lLaTN2Y3ZpUERJaFAxOWsvY2U2b0VzTWZI?=
 =?utf-8?B?YWVkcHh5V0NmQlU2WU9yZ3ZzYmh0ZTIzZ1E3VVBjak0rclc4dGExdHBGSUow?=
 =?utf-8?B?NTNtMk5EVFphSXlpblVjeHpvZW9WWWdRYzZZV1JKeWZzU2doam8wUDVZU2lY?=
 =?utf-8?B?NzU1R3BLSWkxUVh0R28wc1JpaGZESGVCNzN2ZFpkSGt6UmMvcWNGaU1hK3Q2?=
 =?utf-8?B?NksvbW1zYkFJNzArdGMxSzlrcjNBejZHenhJckg2dVR0UzBYU0RPRWFlUnRq?=
 =?utf-8?B?QTBJSTJhUXo4THFqcFdlbGlYcSsvdlZKOVNSbU5SZ04yZjFvclQ2SXRSUjVC?=
 =?utf-8?B?bzVuY2JoOUlsdHIxMVl1NXI1MzFycEp3SCtqVTl3VHdZQjVJL3V0bmE3c3ky?=
 =?utf-8?B?WHZPNkFhNGpZNDU0T3VJZzN1RGdhdW80UmcySDBsOGxBVmFRUUxuTlU5UlQ4?=
 =?utf-8?Q?XnRXT4t/w7Ne68uZ1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFNHSFdwUmJrQ0lSUDlrbFN6QWJNY2lqTWFsTzlyUHp0QW5RN3NsVUJEQlhW?=
 =?utf-8?B?OWhPMDRmMk1hZEk5Y0NDcmw5NFRycjdEc1ovSnBxWkgxZWFsWkI2Mnl6MGt2?=
 =?utf-8?B?RVRFTCtsREdkdE1HVnVvNFBZREFzN0RyVmlDaFVPMk8zeVlkQ1c4aWtJVGhv?=
 =?utf-8?B?K0RSbGZuc1RGUlM0L2xheG8rWCtNejgxODM2WGlneXB0UUFvdUx0NUMrMXE2?=
 =?utf-8?B?SmptSUk5RHNRcVpadEZOZ2M4Y2MzMjR2dm5rZkpRSXAyT25nUXVJTkFuT2pS?=
 =?utf-8?B?SkNXVUtqdHlrcmdHTy9OczVVL0gvengrTFJIeTlvMGROVjlReDl5YndlNkx5?=
 =?utf-8?B?TE9MMUEyc3A2clY0d3JMaFNtY0RUbFBGc3BMd1A5WUl2MGxuOXFBYldaTGZF?=
 =?utf-8?B?ZEp0MjVXVS9WM2R2WVFHUmJCdFFGdGttbmhMZ29tMjcyOWQycXdzejlVMkEv?=
 =?utf-8?B?VElYcDVicnFqdWRlNHNEUGZOSUlvKzNqSzJjMWdjbmhsa0ttSnM4RzBpSFVB?=
 =?utf-8?B?cHNNOFRqUmNUbVdYS3g3cHhyMkpkL3JwdTd0NUJaM2tPbEtzVGRNWmdqYmdC?=
 =?utf-8?B?Q085MXlzYXE2YnhwR3lINGswbEhVNmNmbmpSRGF0ZjFYYUE0VGVkSTNyYWVZ?=
 =?utf-8?B?TElaQ21YUmZaUW1wQTNTc1FaVnFnTmtlMitaOTJ0b3RqSlMzWUZCeEJ3dFFs?=
 =?utf-8?B?NEg3bzBzZC9pdVRNMUxZZkdsM2dsbFE4ejNVKzhHaFJ2NFBiVUtwUWszNS9K?=
 =?utf-8?B?NnFOVUJmbkZYTG9jbGsrS0Q5dHoxK3BOTEozYm1rUVM3cXBnd3BXRWVEaHRQ?=
 =?utf-8?B?c3BURXlmQjFIVFptRjlQUmFpeUZHY0YycHhWNU1iT1JDNkM3SG5WemMxcEE0?=
 =?utf-8?B?QnZFZXJOaC9XSGtSZDNIWU80MlJ0OHdZUGd6cFNlei9PTklYaStkWnVPZ0Iy?=
 =?utf-8?B?Vm1CeXVNUTVKWjlmd2cxaHYyWmlIbjdES2JkOEFpaXVRZXBMbFBZSzM4emhz?=
 =?utf-8?B?d1VkME8xbXpxTk9PWWpTRzR0ejlvdXRTZGVpWGl6eWF3Vm5TUGtQU3dXbzlM?=
 =?utf-8?B?QThabFk2UkJ1eWYxS0JDVU9MRHpCSnBoQ2JhYUxiSW01Rkc3cks0WWMybm1B?=
 =?utf-8?B?SXNmSHRiK3AxVndteEpGZjZsVUtpQlJVQ3VMRlBQTy9YRy9BY01RcVk1dzhq?=
 =?utf-8?B?NHJWM3ppNmkyYStFK2xmeVJKTnZwU2VRNENxUEw3RXVJRjFwWG4wdnIyTVEz?=
 =?utf-8?B?WGxsN1h3Y2FCVUNMTkdSN0hMYWdWQ1ZEOEJ0dUxuWXJhaVkxSG4vbTdrOGVz?=
 =?utf-8?B?ZFVYRHV1dG0rdkdGL2xncU1Lb1BQNTF1djdsNzhxTHRyY1NtRkRuNVdQSUQx?=
 =?utf-8?B?Q0hTK1M0clJseEJpcE9VWDZ2OUJudGlzOEt0cHYzMHRzeGJ6M0x1aFRLWTlF?=
 =?utf-8?B?WjQrMm9JQ25GT2tESFpZSHQxQmdYbFRWdkN0cEZTbkxQcnBTSk5uTEpsRkV4?=
 =?utf-8?B?REwyL0xxczlJS09kc3FLcnlMVlRjTExSZFlobGduUml1eDlqYkRaWStHRlBi?=
 =?utf-8?B?RUFFSkFTcFNLVUJId29kRzlZRFUxYjYzcFVFZHBzRDc1cXhjVUdwR2JHVFJq?=
 =?utf-8?B?ek5Gd1hHckM3Y3k4OUgyUE5yVnQ3OWF3VTlqaUVEeDhiamVYcTdQcDhsdGk4?=
 =?utf-8?B?cCt5YjJza01hWFhvR3VMREkyZ0YyRzNYRy83OHV6cmUwRkgxTFM3alM4aDMw?=
 =?utf-8?B?UTdiK3dmWmRxWTFoRk83Mm5yMVdZdVpvSTRzcThGOXF1QVlKbWVJSVNTL3Vv?=
 =?utf-8?B?WDdzTUtTY3M0NGpnTWJhUU96SE5ueUlodWNpWTVhNFR4bndjd1VJa1orSG85?=
 =?utf-8?B?ZGNoa1lXSlVXMDFBZmdYNEd4cEVENmI4cW9yeU4vR3dJNld3cEx2NG9EaG5v?=
 =?utf-8?B?RlRISVNoMXJTTHdPSFdHZmtIemNpZXp0OHBWK3lKcWUwdVhXemVIckR5a2tt?=
 =?utf-8?B?WGVyVWhTdVVZQVdKVXZsRmFOQzVxVXZ0UjdscEJWL0RoeWpLNXRCZ09lQy8y?=
 =?utf-8?B?YzFwTnR5b0ZrWG12Ly94Zmp6VVpmRzE0akxnRGhKUGhNbUtrazZDREl2cm5L?=
 =?utf-8?Q?Bx2PJBtaC5O1pDhPi7q+ef/oY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b863d05-5db9-4e03-3344-08dca697fc7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:38:08.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9GNe1YHG+Qx0+/H544tnYK+kym6Ku481R4t1e71Pvf18HhuUHhBB/qmEGE1ATcQU8gPNoFg4L9IqnE2YkntSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834

On 17.07.24 21:31, Tobias Schaffner wrote:
> Enable the x86-64-efi target in the long term tests. Set the maximum
> latency threshold to 100us.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/kernel_6_6.yml          | 13 -------------
>  ci/kernel_6_6_physical.yml | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
> index e9efe20..59e9704 100644
> --- a/ci/kernel_6_6.yml
> +++ b/ci/kernel_6_6.yml
> @@ -50,16 +50,3 @@ lava-test-6.6:qemu-arm64:
>    extends: .lava-test:qemu-arm64
>    variables:
>      KERNEL_VERSION: "6.6"
> -
> -build-6.6:x86-64-efi:
> -  extends: .build:x86-64-efi
> -  variables:
> -    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
> -    KERNEL_VERSION: "6.6"
> -    CACHE_KERNEL: dovetail
> -
> -lava-test-6.6:x86-64-efi:
> -  needs: [ "build-6.6:x86-64-efi" ]
> -  extends: .lava-test:x86-64-efi
> -  variables:
> -    KERNEL_VERSION: "6.6"
> diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
> index e57eea0..2693907 100644
> --- a/ci/kernel_6_6_physical.yml
> +++ b/ci/kernel_6_6_physical.yml
> @@ -36,3 +36,17 @@ lava-test-6.6:beagle-bone-black:
>    variables:
>      KERNEL_VERSION: "6.6"
>      TEST_MAXIMUM_LATENCY: 150
> +
> +build-6.6:x86-64-efi:
> +  extends: .build:x86-64-efi
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
> +    KERNEL_VERSION: "6.6"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-6.6:x86-64-efi:
> +  needs: [ "build-6.6:x86-64-efi" ]
> +  extends: .lava-test:x86-64-efi
> +  variables:
> +    KERNEL_VERSION: "6.6"
> +    TEST_MAXIMUM_LATENCY: 100

Thanks, directly applied.

There is now also a weekly schedule for this run:
https://source.denx.de/Xenomai/xenomai-images/-/pipeline_schedules. Once
the current pipeline runs passed, I will also manually trigger it for
the first time.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

