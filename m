Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BA3955F7
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790942; cv=fail; b=pCyp3vYS8z6u6O+jgHGhNI49qFAZrleYvTxQ/O3O48wt+sEUkgvGx1q4h0NIr4cfw/PijMXM3c4cisC1vF+tJ9/8up2JgHdUt2cQTzKsD+4ntiSl+gzpo+TUQ3lwXTFWUnjYq6cL4Od7wGoUSdSTn0wketAONzH26sZw2Xr/od0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790942; c=relaxed/simple;
	bh=30RBRo8cyWK0yZ6Ar9xpDOTclBpd2WrBumM1Vtf9uPs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GeQELumLasT3OfbY0Il1YijnQbWFrmCgCs1ccyMXMXxmU/TcfgVMzRQeqAJXrPZtLHWd0XYJWUaX9nflD7e3brhMIQE7L4gEvY45NiDksdJgAXvptxxfa1FdVkounfKSf0Yj9NJnXU/s8vZ3fATYv+DsERyexWx0jeP1myRq9BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dWDINbpM; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dWDINbpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3HA1BKOY6mvzi8r4qTF4/GgTjPSyJlQDFKqQXLRF5mUyCDFWquOf68V/57gAMY4wY7eeOyvqwObIKY0bExmXICPai7A9cPe/9TFyZLp2TSGcfiP54QG9CGuZMFABShGUGEHkJXItKJAAThVOQ50kWhEnZVyfaciamVCdcNotIRFzxkUGVTY3HK2f9omtVvqCs3qVZ7qHsEFFq3fjTHWqk4B0lOCGtNDoQp0qlseTnOWKaV4k36fUn+1V8wVAO6iCij3ruX4POwq32+FPzFOE6QOih/9NPNFF1AdbyMIDnKO1Z0BQHyio9dvhweGKvCrqevQMaT2PHpXUHRgXGWfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ5yRdFEUnR/lAsZe3SjYsLpjUPuhEEb8FhykUEMX0s=;
 b=B6Sbila3PmgcBphgezr6SHIS0HpCLuzcP531uR46AbfmC51k7itPK60Z6R3oU+q+T92lDakGjB+3cheNqkQSG+hmn5NL2BsVMrNkgg5oJPQ4+bq4k675HT5DpiT0OZeb4pTE2xOyVtebtKg8vkueP5ygWJc3iqS1Pvx4zDlQigjp4GzYUhYf2W/u22aPSCmv82zVSTgqn3xRIilVJ80fFc4ePnY2rccF+P+FY81Poo2tbx4OQN0y1VPIKB6heortpo44YQfKenLuYvK40o/mOFZ10Edt3HugUXhp1jAuNoEMylLgD6oqlU3VUximcAGUjrYy7dubKLjKgCRM6V0VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ5yRdFEUnR/lAsZe3SjYsLpjUPuhEEb8FhykUEMX0s=;
 b=dWDINbpMTiPLlnDiJnxmq+MCeyJxr2qz6OEmDPL29Kicd9emwtTiHwxaPTAztUZSRccL43tzYgD2fLNE2ZB7PpaqABz1umgjqFj81vuiuPUKOE7tzOB0JjFWw5kXJGQ6iG5bBGijr6qllC15CL2muV2GGeS9sgxEsr8CP/DJQ8VnIaaGMKIOgDCB9vGb2bOK/Sf+U49fcV09XSCoqWS8GmG9tdFXr41XU9yUxzY5ZrJfvkXZVlCpTFymfpXkBCgSgkh51ij2SidbvGayUyLA1a8eXvRgAIPLs1EXnyG/ttx0KjgdF0MAsxhW7EHOnsWOviAhYBTzw17goxJJpWLldw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB8038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:22:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:22:14 +0000
Message-ID: <308d85c3-7e7f-40f1-8755-5a99b25d0015@siemens.com>
Date: Mon, 7 Sep 2026 16:22:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: Fix a2x warning for PDF builds
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <20260903083447.2220024-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260903083447.2220024-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e95327-aad1-4073-a5b5-08df0ceb69d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|3023799007|10067099003|18002099003|11063799006|5023799004|4143699003|56012099006|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PpsSOuoi7akjhzLsUtBiT5sDogj+SFvN5ayGFRQ1cXzWKmDgpi4E3+3NCSuJnq9rB3MRH+WLoYR1XI5XcOG1ZDTLKFaSB+3nU8YlhjcDlhhhHhRFf1lISwjSlOpW6n1qcIjVm9qCDQGzsuKsYroGQuIHZCKF/nTUaAZ/SxNgts/4T2zKk65rw7vngXuCDgIupV52ToXTPp5uPX0jaZ1q4Y6A8wEGhZJr1x2huUzONk9EH9EJBBlKkBEigCKAdwiIViB6rVx0eP+YJLnMBpakR/1Enznzou1Ac0KWGfH1wVOwI/gXMZFLBj8QR+/qSIDu9QM706SKXpGSUZekxy1fT2wJ7m5+MWDsSdCW/krhA0z1oJ+pBPDr/jJYlCgJV4AkIgLASS4mYNTVNiaT/wE182bRwQNAA1/bfGRSsMEppV67B8zWvl2hU6OzkVEllbEeoiDo73QkvRsw7iazsIFlllhoy9ASPAMHJySEspkN+85GknG/48HCnsnBKE4X4iYZE9jv/zJO0sFQB1q+RDTUsGVJqKCN45VVJp/9pobjD76Glal+BLakbF3GvTZhCvWt5/SAAY9TUolFoKowM5F0ijd1aEmMVdFs8Bank9HQLEoQHny7kxxDlAtgee+fbyWV3aSF9SPUaN6kxWihfo2MqGLMjqpnp0uNQi8ER/RInqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXA4d2xYMVIxMDF5N3NyMTZYSEZndXZQRGRMYlFldUNGRkk1YmpEbDFLRHNL?=
 =?utf-8?B?bTlhaFdzblhVeldiVkhpRjdybFNSTGsrTWlEV29wRWtyKzE3MGJ2NDdYc3di?=
 =?utf-8?B?VnZGZHVwNkVOSExEMm5YV1NuUm9FQTZ0YUxDcnVnNElhYlVHSGc0eXc4dU1a?=
 =?utf-8?B?RXF4WDJlZkptY0FoSndWNUtCL2QxeHUzdkY0azROOHhjYmdhUFBiYWZOamFG?=
 =?utf-8?B?c3ZGdGgyeFpLL0hyampEWVd2OUpMS1VrWXN0R0RQRWxvZU5lVUdmSjRHNXlh?=
 =?utf-8?B?Ni84clEwN3B3S2xCR3FPdlk4WXZhN1d2K3A2aVFZRzRzZHRMMGJjR1RrK1B4?=
 =?utf-8?B?amRRUG9yR05Nd1ExZkpaMW1xZFZONk9DaTZHSlpRZHZKbktCVi9QOWZ1alpr?=
 =?utf-8?B?TUdqMmtKbndJdWpZZ0ZneW1IVG83NjZBcXB2T1U2R29tSk85ZjJDWHk3S1Jq?=
 =?utf-8?B?VlduSDhOdXZVNHA2NndHU1ZhQVVrRnZiUEUreUxPaDhsaHFuZWxkdW9sYUNx?=
 =?utf-8?B?MHprU202ZzVLVjdTLzlzVzc2emJhb0J6RmJCWnhyRFNseHBBNmFUN051c2Ur?=
 =?utf-8?B?aUNQd25DQWxIcUk4NlVFWWZ2TWxKMUtKa2IxdHowcEl4cnhKTzFLWE40WDM1?=
 =?utf-8?B?V1IzSFoxbWYyVUo4VExMcnkzZy81ZVQ1T2pRV3oyanJubEZLdXIvNU45bzVF?=
 =?utf-8?B?aGJHODhQdDF1R0FKeWFpT3BnbHVRa24wb1REV2o3WGZ5UTVhVjJmMmNYa2pt?=
 =?utf-8?B?QVp2ZXdiNklkT25XajZVRUdoa2lod3Nxd1J4Q3hOQVpPcVVkUTVjRjF6cm1W?=
 =?utf-8?B?bHBvZjJXRU80Q2dhblZGSUNZTTZGdnhycXlnTVhZUmFvR0piaWVtTzRydGVN?=
 =?utf-8?B?VVMwUGhXcmhPTmxyMURMMDFJUk9IUDR6L1lKOVVZL0M5U21tVzZSTmVLZjA1?=
 =?utf-8?B?MmJuZ1hkaFZVc1cydlJsZ1VNOEY2VUprT05aVEVuYnVCQlhKclZZQVRYa2hV?=
 =?utf-8?B?blJOcXFHQUZuM2pvUFJacXlOOUs2MjNmdmZsVXRjSzFTZklFY05DaFFRY2lx?=
 =?utf-8?B?RHhLZnhDUmFrUzJzWUwrZVFuRkVIUng3MkdYV3gxZnlHRE9Cam1vZUxYTGRw?=
 =?utf-8?B?VzRoekVJZ0xzS2VEOW5wUUx4ZzkzTDdFbE9mZWtoYzNhK3NlYURJNUtacGN6?=
 =?utf-8?B?OEprYWNPc2I2UE03T1VtZExBczJQZzFSanBLbEVWck13MXNqZ3I3bC9oMHRv?=
 =?utf-8?B?eXVOQWtpRzl6bi9JZDNsYkkzTTA0UUdKbUx3WTBwTjV6b1g5bWNodnA2SUlF?=
 =?utf-8?B?YUoxcngvWmp2U3hiYkthUk1STGs3aGZTVjVLdGVpVGZGMWU3cnZ6MktuRjh6?=
 =?utf-8?B?cHdtOHVlTGdGUlMrOVVnZWhoTUJoY3diTlJxcnFaTHRybjNFSFBrWlcrcTBo?=
 =?utf-8?B?d1JSRS85LzdKb2IrWnI1WWFBUSt6MWNIS3gwS21MMFQ0cDlrTmxqRlc1bGN3?=
 =?utf-8?B?OVhLd2ZPRmgzdHA2UStaZHpXemJTVTBKeXUzNkNOVVV1MFNNMnlGMWpLc2gy?=
 =?utf-8?B?WDZtN1NZM2pGcU5XalJIYTZsN1pxTGZKRFJpSmJmSDJuL2JoUU55STF5blhz?=
 =?utf-8?B?RXJ1ZmRJZ1pVOFlTNEVrWjBGakV5M3F1ZVZDTUR5R1o2N0huK1orbFBrY24w?=
 =?utf-8?B?YXIza00vOHpzeWoxNUdhNlFlUUd6RFBnQVZDL1E0V1B5dlE3L2hneDR3WVY0?=
 =?utf-8?B?ZXVOSVRKL1VIemc5OWpkVmJFenNJZWJrQWIzazhsVUJQcFI1N1A1OWJFMDQ0?=
 =?utf-8?B?NmZHbTVFREZVcVN4eGkyUUMvN3V1TWIwZzYybnZBWllIYkxvdFlsWFQ2aVJP?=
 =?utf-8?B?anZmd1JPTnM3clVPb3p0ZHFMWEtaNDlqSjhUK3lFYkxQRTJqc0F2S0dkbGcz?=
 =?utf-8?B?eUtiUWZwZG95WmpxNFd5bkxKTXZHVFI0Q2g5SWk2cTNJYnZlaEt0UDM3cEdt?=
 =?utf-8?B?Q29zeGszeUxPdndEd3lISC9MeER3UDVlMWtHZ2w4Z3lCZkp5MGJmc2FER09q?=
 =?utf-8?B?bE8wTmQ5M2dwczBNckl3Z1dSOGNMTk5XL3BDWlZuMHFPNHgxdWY0dithaEd3?=
 =?utf-8?B?WXMxZE1tK0ZlT29rY3hoeGM3U3JmbVVTSEgzV1FUUFNFVHdzdlFlUkhMelFj?=
 =?utf-8?B?MGkvQW04UGlYb0w2QlZVV3kzS3hXcTl4VGRtd3V3amNXTFVENmh6dElaK2xW?=
 =?utf-8?B?eldXNEJHSG0zQ0liNStiREdaS2tuM3gzYXR5ZEMrNkdYajhLcFhKa1o2L2Fz?=
 =?utf-8?B?RlgvMStvbGRUS2UrN2Y2VDNJVHpDZFRUdS9RQXpZbENWbGNQTEw0L2JuVzR6?=
 =?utf-8?Q?UEyiudGbZusXPpzs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e95327-aad1-4073-a5b5-08df0ceb69d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:22:14.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eif1n3YIYzQxARsHjFxTpw9IraJzcVC1yAcMCe1qAQQby6n4eXefJwDbsR17iCVYzJjaETdIy65sG4xgJy2j0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8038

On 03.09.26 10:34, Clara Kowalsky wrote:
> The documentation PDF build passes "-D" to a2x, raising warnings such
> as
> 
> a2x: WARNING: --destination-dir option is only applicable to HTML and manpage based outputs
> 
> Drop the unsupported option for PDF builds.
> See #18.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  doc/asciidoc/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
> index 782c7a23f..669decaeb 100644
> --- a/doc/asciidoc/Makefile.am
> +++ b/doc/asciidoc/Makefile.am
> @@ -91,7 +91,7 @@ html/%: %.adoc Makefile
>  	$(A2X) -f manpage -D man1 $(ASCIIDOC_MAN_OPTS) $<
>  
>  %.pdf: %.adoc Makefile
> -	$(A2X) -f pdf -D . $(ASCIIDOC_PDF_OPTS) $<
> +	$(A2X) -f pdf $(ASCIIDOC_PDF_OPTS) $<
>  
>  $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
>  	@$(mkdir_p) $(tmpdir)

Could it be that this did have some side effects? My pipeline is red
because of missing .pdf files:

https://gitlab.com/Xenomai/xenomai3/xenomai-doc/-/jobs/16348492423

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
