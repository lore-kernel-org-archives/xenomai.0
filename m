Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA93043D3
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060705; cv=fail; b=QwStzFkCuUM/H+OhZkwvgxc2c6Z38bApMllHixQtwYz+Jh6tmgPXtFPVtzPO5zNHng59Q+ztRF09zaKgShYACV4T5+FoDJ1MWlR3DtCOxoQU9iuyenDu4nJPt0NpuchqlV66s4xfJBBRAgTKfeKoC7thFdGGy9+N7O2fKqpYNLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060705; c=relaxed/simple;
	bh=ywONFvfPGlNrmX+p4AHNf9rVlYPRrB2DH9OPdPrzeDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPGj5TBDWEDWY2QeNycbpRYCnTvqZFAhWe4v9E7prrA0L9daGBv8f5L10u/m4tswR1b0WKdDrlus84/e9SOjetcjc3HdZVedxrFLUcFgUDHT+tH7aReFkq56E3jhd75Wh4lDwhi6IItRwxNlSyiqKpR0QdXZdkGCpFawVSyf7eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rCdfaCJB; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rCdfaCJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ9WHf0jupUe4hgonJsNMxSK26mCxmXAgM+NCcZ3gWjvMO/b0QtZRmzE9tjwEK+O/luCUgBMr34pHRQY7bLRzcCHR3eTJfySV44uOF2ikYaVphP4QI+80fCwPDg8kzdIc2l+6b/9aeD4iP/MrVkuJjsaTswnc0DHss0jKvK1SBDjYOTZ+Nz9U3/yDqKc9fo821UYl+E0QnfcbRy4j3H3PbtkWuoNkvRVmGFJ638U+jJ0uBIcMzGBwL4evxk6q4nHYqW0ablJvn6f41Z+rxjXVgKgFDdi9umHQ9f8N0d+DXCgFVuFBe7Iz1i5N61wqT+jfmwlvj7vYZhskioUhL7ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp38i/dhcAyPP83WL3mE9hVCZ5ZcVeD53HQwGH5/1gs=;
 b=an5eO/E7D96mzqwkfj4yVV79du+C3PWcXcKDzry0S6+hCdFaGm3W0yFD5Lz/FEVByuTpQ6GETIWKnBO6pouDjZDQ3cUbUX7pjNhK3nMkHFsPHE2aC1BMzza5YPN3bdqz+JNK0tnpYkwnMbGn/aVkgcKzNbtvn4vbzuTD+lUguK5WQw5FM8Tm/9yYrJPvvqq5mkdmjlLcjIKglOPQbImFHD6JX1YLXo+EFk5Vd10N9Ok1O4+de0+qkovxgELJGaRksi32ejZU98mLY3bjoVutOcEVzGaMzgLyZsVyg+/OdSbUnoGUpSTQDaaH4FCKV0cGOj+hKR3mtS7Q9ePyi929gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp38i/dhcAyPP83WL3mE9hVCZ5ZcVeD53HQwGH5/1gs=;
 b=rCdfaCJBAGCfF6qV81TbBLYIacUeSCHbeQuIWEWycqou25zmkUtmkJ8jgGUfHg7wsE/SgzLhTGzMtuUX/x1aphX8wZuQJRzxdzgS97VzwrHoV5ZcTNaF9Wgh5I9wMLwJGvhFH/0Gj0ZqPXxoA4F1KeSASEEjNt0cmpJwgQ9bzXDVXPugS/tK/BgBaLo6Pt3pPieQLKkqaCkPXy2Xa1uUYGMZx7DYWLdjg3RvjJxWHR+qjbE24f1Ojyu96ECQdZz1ryoGR7XWc/Jvp9dMbvv/FOOrNADIQii5pDNcFvT6v1fvIQVUeRAplAJWCOo4Fl1m3aDmlZ4zj1FyxJPik+iH6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB8211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:24:59 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 08:24:59 +0000
Message-ID: <ecd75542-25ce-4beb-b7d5-8c58b2611cf3@siemens.com>
Date: Fri, 5 Sep 2025 10:24:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to three
 times
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
 <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
 <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6565f6-d0ce-4a1b-8db3-08ddec55b404
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djMwbkZrVk9yeDNRWTN0UjM0SzhoOVRLWHh4NW9ZbmZWOCtVUFdtUTRuV01W?=
 =?utf-8?B?SjFhR2JmVEduY1VuZXVHRWJkTHBKSHhkK2tzeUlaKzJsZGNUZ3FRMU9ZZXlj?=
 =?utf-8?B?aHUrMVZaanVKcVROREg5UnVqTGJMckkwM1ZVT3liWnN2WHNmWXowTEFta1hI?=
 =?utf-8?B?M01zdWgrVnBxOC91VS82UkZPblVoclBBaUpJbGVrVXAyNklTM0pOQ3lFN0RP?=
 =?utf-8?B?MVkrbFVUMWl6V2Eza3dqMUMwbXRTRXBoeTRFRERKc2dDOGpUelBYL1J2bm5C?=
 =?utf-8?B?T0Z5VmRIbytQRDdrc1VOazAxeXVpNWdSM1ZsbHZ0Uy96ZE5JNlNuMDYxcHZX?=
 =?utf-8?B?cWM3YWlVNVcyVWg3WlBsY1Bwb2ZkNDVzR3dQc0VRNEp5ekw1ZWlHSDlNOXB5?=
 =?utf-8?B?dUZFSWpZdlJHTUpJQXNnRDZOM21KRDlXSTl0aVczNlQrR0dPWTlLcmp1aXFj?=
 =?utf-8?B?aGRONzhxUW9GYUtaRUtYMC85Vy80TTFsK1VPSGN0enhQOGVMclkvaGtJVytr?=
 =?utf-8?B?S2RxaDZLNkNlbWNEVSt6emhzNkcxZURlZURjYWc4eHNkdWFraUtSWU5DS2ZK?=
 =?utf-8?B?Y0dudmhqeS9FNjRmd2dIWVZzUG9BL2V0WkxST29RRHYxd2xNbTlSVGc3cmxB?=
 =?utf-8?B?Y0pTSW9aN01xditjYzZkQ3VlZHdmVGwzRDVvd3IvSFB5cUYzSUxZZEdhR3pa?=
 =?utf-8?B?d3VlTEU1bFJzbjBEWklWNzdjeUViM0JiOFBrY2g5RXY1UzdCVnFGY0pCTFFE?=
 =?utf-8?B?azc1RTVIaWltYWNsNVE3RDZJR3VoblhpYkFTYnRrYURGT0lKOUhiS1Bscyt0?=
 =?utf-8?B?cldzbDBXVWJYWVdIZEFyZy80RUUwd0ZsSXN5WW44UFQ3N09JSUM0M21YdEY4?=
 =?utf-8?B?b3JlcjVLZWhXeGdHZ1lGM1V1NkhzUU5FRTN1clp0ak9Dc21kMUpwTk8reG9a?=
 =?utf-8?B?YlM0NEFXb0NzQ2ltRjdOTmtOL2dRNElSOHFuRzlXKytRaUNvWC9xOHpoN0ZQ?=
 =?utf-8?B?cis2dWFRZnZEcEV4U1JCTVVsYXRyWk94V2orTk5yMEVPL08xVDJpcUZhZ1ht?=
 =?utf-8?B?a3EvdHIyZ0JWcSttSDNqSzNjdWNLekxXbWRyRTlia0tNMjZieW9PMHUvdmJl?=
 =?utf-8?B?MGdBNXRMbGJTTkpqRWtxUVE5ejRBVHFHTTcrbk9Uei9CeWsxWTFCUlFVd2Rj?=
 =?utf-8?B?d2dzTWc4WEc0MmhNMnJuNWs1cWI5d0pWemYvSHVJOFJtMmNKMnlBN2JwRnVX?=
 =?utf-8?B?QlFVbkRtNzhicUNaT01wRWV5QVpMZlZmR3UrcGhFYVBBTGo5M0YyL1lhUkV0?=
 =?utf-8?B?bzFFZC9KMmNzUUZsMGxyK01jSUJRMHRhTlVIaDY3MkUrVHUyTkZWdVFLZktD?=
 =?utf-8?B?QTdNVWFFazhlcjRRS1ZudXprYTlFS3I1N3lSY3dzOS9vMXZnSy9ocXhpRW95?=
 =?utf-8?B?VCs0WnNpNHdvNVZJMlNwb24wbUQya0drZkZsUlhqa1FRK05WVjQxNFpIWUNa?=
 =?utf-8?B?emFwOUd1R2JIU3NmTElGdDdzUXllV1VaR0RzbTAxa0Jmb0JyUnYwelFoblk5?=
 =?utf-8?B?RDgwN1RrSnpFQ2dHRytHQjl6R01QS1dYUkpadUQ4Kyt6YWw5dmc1Q2hISzlV?=
 =?utf-8?B?Ky9PN1ZqM3ZadGpCYmI0QzhZVyttVHMxWHF5T2VvUXdsT1pvUU5JY0s4T1E2?=
 =?utf-8?B?MmFwUlZFUFRScUprb1lXOEpTK2hLeE1BdWFjeHhvRm85MmdzRlRKenlxblZk?=
 =?utf-8?B?QU9wbVEyUUptSmlNcHF2NHBYQ3NlK3oyMnhia3NCU0RUanphNUlveEc3NWhp?=
 =?utf-8?B?ZHBjL3JINVZJTTJsYy8ySnZIRFZoWXkyN3dNL1JhWlg3N0Exb1hqTjEzTGUy?=
 =?utf-8?B?VU5wQktEek13aTF1aEZ4UXpUdlBRTG5GWXN4YU02d0l4c0xzNXh3Y2oyV0tv?=
 =?utf-8?Q?pkUekMYH58E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZEM0hXNzVxNG00b1dGd1pjcGxtTE9RWU9XZU1nUWVqa1lrSDJSL2JHOW5V?=
 =?utf-8?B?Q2pOd1VHNDk3WmNtOUR6VkowYWRYN1VBRTFTMWZLMlkzT1ZSSnJ6RHZmc2s0?=
 =?utf-8?B?MTN3SDIwbHJQYmY0SVlrUEZDY3NMeWdTWitkN2wvTmxWdE1KTGpDb0xCRXd0?=
 =?utf-8?B?cTdNVkcyTXp6Q0h5NkI5Z3VOTFdXOW5XZUZ0N1ZUVkVyTjNBK29jWjh2UWxP?=
 =?utf-8?B?ZEk0elh0aldISk12UlBvOGxubzVJNEJGTFBkdVVGaXcyOFJJZWxFb204Z3ZX?=
 =?utf-8?B?L09XQnRlUFg4Z3ppWkJrS0JpYjZpREI4SzJEazd1Rkk1bEk5Zzk4MThkSFlt?=
 =?utf-8?B?Y2w0Wlg4eVlYTnRGU24vVHZFQnVGZkt4QjNaV2x4QUZrL0lMV0NhL09qY2Vw?=
 =?utf-8?B?UlJ1dmNJbEdKVnJ3Mm9KVDc1U0RuV3cyYjJNSS9Zc1RFQUczZmc5K3BNOGc4?=
 =?utf-8?B?SzdLMUx2M1NVVXhrSkFUSjcrVG5ieks0VS9zUjlySERpaHNWeXlOd3pncDhM?=
 =?utf-8?B?U0ZCV3lHRmh2Y29SMzhtcjZVenZLNHBESGdHL0NoYjB1ZTIwbXZKeEc3aCtH?=
 =?utf-8?B?V3ZSTDd3Nkc0bGd5S0p2ZUxTY3ZkVy9jV29PcWRHN0dJcklvYzJWT29PdGta?=
 =?utf-8?B?cVh0d0RmMmlGUDJqY2ljTG13WVdPOHBGcUt2OHpIbnd0YWtVUEU0WUxIYXFr?=
 =?utf-8?B?NjhRNnJHY0NSNkIrZlZTekNuZ0k5RFVnYzVrcGJjZUFvZEVwQlNRWHlSMGVB?=
 =?utf-8?B?WEM4amlyRnZ2RE04NDFYTmtqY1haOE5FZUs3VmFrUnVRY1JJOTRWLzNDakhD?=
 =?utf-8?B?eG05aER0VjQrMHlGbXdDNWo2c1ZENTFScmpzblRnNVVPYmpCM2VWclVlazZY?=
 =?utf-8?B?RjdWQVA5NmFLeHpIcVFkT0xZNU1CcXNFZmxmUk15MFlLSkh6QUxkN1BWRXBN?=
 =?utf-8?B?eFMvVXV5b1hNWVFDcFRNNnlkcllHeHRLMkwxUHJsdTBkQk41NkU0UHdFOVpo?=
 =?utf-8?B?VmJBVVZUSS83M3RhNXJEZWt1YWlMWFFwYkNSUXFVaHdackMwVEpRMWxsN1ov?=
 =?utf-8?B?b2RocjBZUEZWM1FCR1NMYXJSVFpuOXhyM1pWeHdEYm1xSkhtNWJlU01EaVRX?=
 =?utf-8?B?aks5aGJqbUJUaEo3WFhXUTdvaForYnJXa3cxRnB0U1lkNnRSU0NPV2dqbUJM?=
 =?utf-8?B?Y1ExZzFCQTYwNVRDYXdKRjJjcDhoSUFia1oyTkxGV0s3RXQ3em5Lb0FqK04y?=
 =?utf-8?B?aWltejVlYVdJVC85M3dSVXQvV0pZTTdzR3NZOU9FcURsQUw3amJvR3ZodnBq?=
 =?utf-8?B?MGdsaWJpazZmbW5VdGhTRlB4STFVbk1uSVRRMkxUNEtpNncyUzdrUHN3WXc5?=
 =?utf-8?B?VU5ScjErY1luQ3hxc25uTlFub0Q4K1VSa1VwcjJkYjMyUDFCS1VTbGJZUzh2?=
 =?utf-8?B?VXRBTHE3Vm9tNWJFTTJPc2hrQjd5N2ZWSHdrQTBQSHNzakdBSVpPdDhtS2sw?=
 =?utf-8?B?UnZaQ3MwN1djaVBuOHVCZCsxeHI0WmJqcWtkakczV3pZZEdkQ01PbExLMGtF?=
 =?utf-8?B?MEpRNHBUZU1YRzdwR1ExZ1R6QlJ4L1RheGM4dFA1dlFhdGRWY2VqOTkzVlJB?=
 =?utf-8?B?bkNyRXp4bXFlRjF4NWZub1pMZExEUHFMRUpGaitnOEZoTzk2UDdJV0EwVjl2?=
 =?utf-8?B?Q0RPVlNmSTM0M2N0WXZoQytUTm1XSG1KZ1lDbURQV1B3QmpDUTY2QUI5eThE?=
 =?utf-8?B?dzFua0F1T0hjTDRhcHBMTFlTTUZhQ3crdXdESkZ6RWE3S3NCOXBmUzZqRjVO?=
 =?utf-8?B?QXNvcndsQ2lBRmt3NDZnWGhHOEdLMVBWOHlrQ1h6bU9GSkNVZ3hWM1UvNUZK?=
 =?utf-8?B?bzJoMVpBeGJ4MFRpQ0F5N3dSS3dnYkwwcUlMZjZubGR4b1FJbUVlOTR6L0xK?=
 =?utf-8?B?RkErUFdNanhUakYveHAxa09TR0xYMDJUR2FpOTlCSlBrWUZOSEQ3L3lOckJP?=
 =?utf-8?B?R0UwSC9GSHhiTEtWVDZhUkhaNWpsOFNJU0ZqK1ZYdXd1T0RjZWYrRHN2eDY5?=
 =?utf-8?B?WGFHdFJZakx2dmZ2aytGakEvUkxhS3AxSkxlMEtmSTFhUzkvVHlWK08zWWFP?=
 =?utf-8?B?NnVJcUg3ZEF3UDZWa0VzdjhFbC9qRE1nWVNQVG15MUtxQzY4L3JGYXJpYS85?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6565f6-d0ce-4a1b-8db3-08ddec55b404
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:24:59.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UEm6deOJAD/m+IIZha3wfqgSQfYIyC+s3UeU/HMdsYnb95rN7ke9KvqQmjHQ0xbMca009k+TBdlRuDdq5PNsTqhGOmpBbl8iuDpLGCftQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8211

On 04.09.25 17:33, Jan Kiszka wrote:
> On 04.09.25 12:16, Jan Kiszka wrote:
>> On 04.09.25 12:03, Tobias Schaffner wrote:
>>> Increase test robustness by retrying the LAVA boot action up to three
>>> times on failure. Failures are detected via server-side error message
>>> matching. This logic will be refined in the designated repository.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   tests/jobs/xenomai-beagle-bone-black.yml | 1 +
>>>   tests/jobs/xenomai-hikey.yml             | 1 +
>>>   tests/jobs/xenomai-rpi4.yml              | 1 +
>>>   tests/jobs/xenomai-x86-64-efi.yml        | 1 +
>>>   4 files changed, 4 insertions(+)
>>>
>>> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
>>> index 8e47dd6..b7a95bc 100644
>>> --- a/tests/jobs/xenomai-beagle-bone-black.yml
>>> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
>>> @@ -41,6 +41,7 @@ actions:
>>>         compression: gz
>>>   # BOOT_BLOCK
>>>   - boot:
>>> +    failure_retry: 3
>>>       timeout:
>>>         minutes: 5
>>>       method: u-boot
>>> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
>>> index aaf8949..27beb07 100644
>>> --- a/tests/jobs/xenomai-hikey.yml
>>> +++ b/tests/jobs/xenomai-hikey.yml
>>> @@ -40,6 +40,7 @@ actions:
>>>         compression: gz
>>>   #  BOOT_BLOCK
>>>   - boot:
>>> +    failure_retry: 3
>>>       timeout:
>>>         minutes: 5
>>>       method: u-boot
>>> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
>>> index 50ff9ee..4074825 100644
>>> --- a/tests/jobs/xenomai-rpi4.yml
>>> +++ b/tests/jobs/xenomai-rpi4.yml
>>> @@ -40,6 +40,7 @@ actions:
>>>         compression: gz
>>>   #  BOOT_BLOCK
>>>   - boot:
>>> +    failure_retry: 3
>>>       timeout:
>>>         minutes: 5
>>>       method: u-boot
>>> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
>>> index 4f1a7d8..0014429 100644
>>> --- a/tests/jobs/xenomai-x86-64-efi.yml
>>> +++ b/tests/jobs/xenomai-x86-64-efi.yml
>>> @@ -41,6 +41,7 @@ actions:
>>>         compression: gz
>>>   # BOOT_BLOCK
>>>   - boot:
>>> +    failure_retry: 3
>>>       timeout:
>>>         minutes: 5
>>>       method: ipxe
>>
>> Thanks, applied.
>>
> 
> I think we were retrying here, but it did not help :(
> 
> https://gitlab.com/Xenomai/xenomai-images/-/jobs/11248170239

It looks like LAVA is only making two attempts.

On the first attempt, the job runs into a timeout. This could have been 
caught earlier if the U-Boot soft reboot was detected correctly. In the 
log, it appears as "must RESET the board to recover", but our pattern is 
looking for "Must RESET board to recover" with a capital M, so it 
doesn’t match. This has to be fixed in the .jinja2 config on the server.

I’ll take a closer look at why LAVA ends with
error_msg: 2 retries out of 3 failed for uboot-action.
It should have attempted three times.

Ideally, we also find a way to make the boot process itself more stable, 
rather than relying only on retries.

> Jan
> 

