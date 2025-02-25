Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712A256C93
	for <xenomai@lists.linux.dev>; Tue, 25 Feb 2025 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464750; cv=fail; b=Ko/XoyCSnucEpaZbxAkbBOLV6vUfIilYtYVbhxB8zp0Y614rI/TW9JCX3+WRVBpM47Sk2/eeoW/eXgV0WiRUWybYF8kor5XdKw9lNrnMMqPpSPRzRbNlfK3Hks4WObEKD2QaMuikR/2LzKzYYz/9dT0Pk0uVn76gfQyEd/YZfrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464750; c=relaxed/simple;
	bh=B9xs45qf30zLzwTHF21KwYwjvgefqNjQc1+4RzDnt+k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NMAaF99bFyYwQ9ZQumeDsYtDorxKyVkxWmkD1l/1rqbyM8dS0SweOpWO+Ty66bYvzCqE4pDvHxQQ+gv3LKIngqolU9QEgSl4fxeerfjcnrDX32ppZnLkv7LLJIvWwEKqjCI3wxIEDQDCl7vagotZ8HsUPLUJ9RGgGuH26Tl4vKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HzEEnUa1; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HzEEnUa1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yiav8/7F1c+ItBhRfTfN7kD7N6z5R4ci0sv6DvUhFvc5yoEh/HWRZpodhWC4sz8me2knW+QR9h01ToBX8ZzIeIzHC3zhXEzHN9PAd3diX98vQqFKAfyOOuSuOXB3JvwZNIE7WY9/9TEgja2zWKpt1MfkmWCM0i89c+g7OGrfie/tLyw3RBwLu1k8DmaOoH1e1itc0Eulm3t9CHt7rfbDJLBNoKsDGZLYOwIh9jwCnvRrI3SwOAoQWIB3B3sYYj87vPUFymFgu5Y7aERAtc3KlrytvZOO+9v1f87+3JVHF5R+SBgeRJsEEUjh1FE9iWc+at0KRuguzaYHxAKPdK6boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbw1wpUQMJh/+tJeQ2NrzE/olMg6F6ZMdpyJy/jDBNk=;
 b=WC8VvbzD6I26iiF7ABtqx62O+5P20GrTAAn2s5vx/Yt8vrY+ARzbmRMnSB2TRZKR43kjkiNl21LRcXXaM4HAyMAwB+2eAUrexquAlFqsPN+1SzpPHGp+0F2Aor+jbL5MAWxUkjf8yelbhfMMihZIMbWYQA5Lq8ByHtKN7mDSjM93gZWuLhfme9qfXReECsKUifDNsUjXBg90hMk6mWIoygbOgcDUqrg5MUhZvCszBJ6+DfynkVYcGGXAITFlRMicx3GcTjswV/DB9kcZTwu4TTxzMTZOTZTXSSgrWeERzKNKMBYl4RU0DfK/XZAqxnw5L9GT18dIQEkzTxnR4/Urtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbw1wpUQMJh/+tJeQ2NrzE/olMg6F6ZMdpyJy/jDBNk=;
 b=HzEEnUa1U82HQ8HFMG0N0qX8or5AqDC4vSMneezSdQwM+LrXzp/Itx5pgmP/FBAIDwL92uAKxO/f+CiK2opBs020SKSWwMbb3IXh59sApaFRjD42JqslI45ErugyGmGHJqu0DOrJ/mvi3s9rI+cGyRAZQyyoCS45odvr/zauiCM2Im8cHkzFh5CLiG9NAHhvZeZdJixVUkqgwOJlyG4w6+PsKtpTs/V/vHp2sYkAZi9z0JFNG7HTNOILIkWEthHIxTnxWFGIz/xsLhXGSRyH830SdMoLaE61xyJbTDXR4o4tgjGvvGH66YAs9iuO9zB+B0kiS5V7osJL1lk8vQsKuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:25:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:25:44 +0000
Message-ID: <df4a397a-9178-43cc-87a0-1dbfada87c56@siemens.com>
Date: Tue, 25 Feb 2025 07:25:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai 3.2.5 16550A driver with irq sharing
To: Johann Obermayr <johann@fam-obermayr.at>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <6aca85a3-49a5-484b-9546-840fb92e86b4@fam-obermayr.at>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6aca85a3-49a5-484b-9546-840fb92e86b4@fam-obermayr.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d356b25-3174-46ce-e30c-08dd55653c43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z21kRFBTTUp1TzlMRlE1VzFoVGVPSWFpYzl0NDlZcDB6SkJPcVRZd052Uzdh?=
 =?utf-8?B?dllGUCt5ZW80a1JKSHFNWTExMmNndmtQdTYwdlJ3d0NyMHpleUVHK3ROMzBm?=
 =?utf-8?B?K2NsYi9Cd1M3V3dWeXpobFRpYmo0dFJ3OWZGa1BNMnFSb1EyYkU0WUd3Z2dV?=
 =?utf-8?B?emRGc3R2NUIyMVkrSWcvMlpSV0NPTFE5UW9sa0ZwQy84M29RaW1KQlNCODVK?=
 =?utf-8?B?U1VrNGFReTA1Y01OQWhsYlNqMm54M0tITVg5Y2g3bi92SkN2dkttVm1LU29T?=
 =?utf-8?B?d2d5bFAwWXp3ZDVvbmhRbU5tbXVYaDFkbUNtM1Mvc2dxQ01uVE5FR2lhelVQ?=
 =?utf-8?B?cGFiNUgwcjF5L1JmY0VWL0NVNGx1OTg5UCs1Z0k5WjQxZDdIR0V3ZEVSQ3Rt?=
 =?utf-8?B?clJRMGg5NkVWUVRHU2Nmdk9ia2habDcyUnNySk5nNkhnWUxYSUp2SlhEQ0dC?=
 =?utf-8?B?Wng0WUYyNDRncWpETjRua3QvQ3dGQ3l6Y1RGRFdaWkpqRVBCTmZQOTJqQ3A0?=
 =?utf-8?B?M0RZTFdUUGk0aWowQlkvZ25LcGFDa21EVy9uR2lJWXFDekZtelh5ZUZGblor?=
 =?utf-8?B?NHFPZTdQUG51QWExd3Bpa0FxNEt5RGFKVnNFNFMyVno1QnU0Q2JhT2gxYzZD?=
 =?utf-8?B?b0RKSFcveXVjUVV2RFZycGdYTGIyS3o0b3RNb2NhOWo1a3JySkk3SEYvUnAw?=
 =?utf-8?B?R1h4cHRTNk1UVGFvM2E3dHRDdDVaSGdOUitxN085N05rWDJCT3R0TWdDRVFE?=
 =?utf-8?B?V0xRL1Y5TGN2aEM5cFpWUWJ6VHNqaVhoN3dPVU9TREZpcEJrUHo4b3ppUXlZ?=
 =?utf-8?B?eXJPRmJPd0JlRU81czlwa0NrbWxOTlVDV3ZPMXdURkVOY0pKUVFOUklSOUhr?=
 =?utf-8?B?YmJWbjJFRDJBZ3Z5aDhER1ZlaVlpNWZRTGpvK3pHWHJLeVBYVnZhYmdaNmo3?=
 =?utf-8?B?OVNuVEtkRGw2SWRXdGxHUDFHbncwQ1U3bEJpU1JtcU9qbU1LQjY1U3l3aVlG?=
 =?utf-8?B?dVFtZndnTGorMnhZOWRXVDA3cnVIRXBsaU9tSlROQ1oyLytQRUNVY3Y4a1hB?=
 =?utf-8?B?ZmZUNEM5eEFXeGxlSmVxT0dZTE9Fb2ZONzJBNnpqQk12RHhZTDBGeFNpeHpj?=
 =?utf-8?B?eWgxaHhkKy9HQmUzSmJESVBnK0NHMHhicEtkaFRYZ1hlRFROL2xyeWt3dGgr?=
 =?utf-8?B?TXJ1U2gwUGNYTWJKemM0VTV2MDVza3d4ZEtQS0VmdWxBTnNZbFpTTmxVSjZl?=
 =?utf-8?B?emlJUzZ2U3RkbmhPTFpLVGw3a1lKSWNBNWFSNGlqM1I4eSthd3hUMmRpa1VM?=
 =?utf-8?B?OUtRTHB4RlNJOEYrZ3RROEdOR2VCd2lqR0xtMVYxTnlxVkE5cy9rUEl6b3l2?=
 =?utf-8?B?SGVRNS95R1MwUlZmSXpqRm1RMW9JaGJOaS9OQjZ0M21KZ1lreE50UmRnb0h6?=
 =?utf-8?B?TzBzL0l4RkZJZlpkemNnTms2RUVkeDFVd0xGazVIUWh5ZUxZdW91bHVCVjIr?=
 =?utf-8?B?T2lIVWRsTWZwcUpPMTlONTNsb21xZ0FmaXE1MU5qY2JkNGZhMHFYNVQrZXV3?=
 =?utf-8?B?SUJWK3RFaVE0KzlIcFZ3TXlaQzd1U2daT1krdTZIdld1WmJCWGZFTGo0SHU1?=
 =?utf-8?B?UmZBeTY3dnQ1UGZBSFN2YTBCT3cwNjNZN211aDNjeFoyVHhHekFkYkJnOHlH?=
 =?utf-8?B?NFN6a2x2eUsxTXpwNlgrZ0Z3N3ljejMzQjgxL3g5SG9JNDFjTExtQmVYT3Fx?=
 =?utf-8?B?UHZWOTdBNlVUWDRnV2JkK2VhU216TEYxN2pRTlY2cXBHNXFNRC9NckhkUytj?=
 =?utf-8?B?VG9YTVNJL3Z2SU9YQ3FyTWRwSUcwd3dQakVlVWpOb2xEYXpyZjFkRUlxZmYv?=
 =?utf-8?Q?pyGSmlkOQivZ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0FieEpNMGlXR3J5NTI5THVJVVdqTWY0YXNka0ZSYnJRdU9HSTljZzdRQktr?=
 =?utf-8?B?OEJBVUkzYlhLamxQY2xya2NqeXVrSk1yQml0eTh0L3prLzIyeFZCWHFCb3Av?=
 =?utf-8?B?OS9KZW9QS04zcENXRUhPdXZOYmVBWUtIVHpvL0pweEZqTlh5YXJBdlc1V0Qr?=
 =?utf-8?B?azZpK3VjLzhvMGV0ODdrWVE2Q09aWHFqRmxCbG1nTUdtUElidjluYUt2M3Fl?=
 =?utf-8?B?QUdYck9ma2VZWjZkaHFDcW9idVl3dVlyUmh0cGtaOEdFYlJnaUdpRHp1dkVP?=
 =?utf-8?B?d2d4VWpXMmF3WHozR1l2NlBORmFqZmNyRCtSK3habmZpSTBBWWUxQlFDODZK?=
 =?utf-8?B?RjQ2bkNTSDdhMzdpSi9TZGVkTXpFeElQSERDNXJ5QXRzNjRkaWhxd3RTdnI0?=
 =?utf-8?B?WExLcGNBajNKMERRQWdETEE1WHA5MWxEVGhPT3k0NWNuc0tuZkxUK3hObmdL?=
 =?utf-8?B?aG1JUVBlYU92cjdWNjJzWVNTL3o5dTFhK3B5U1ZmOExOVFd4YjlzaXFqWU9v?=
 =?utf-8?B?ZFdlSEV5bmg4Vm0wMVMxT2pDdjJuY254L2phNWJTOThqSEVnZ1N0K0dRQy9B?=
 =?utf-8?B?R2p3NUN6bEp0MTBGS3J0WmNDdTBZa2cwYXV1eURhNGxZVTEyT1ZkOUpEUGxu?=
 =?utf-8?B?b3J5RXY4TzhCNVBxWGtsNHp4N1ZSci81THRYRXVNaVRIU1NmZnBEUUw2czE5?=
 =?utf-8?B?bHFwRUZNbjJUb1FHRHFHTHlLako1QjBubVRsVkxFeEk0Wkw3S1c4bnBjN1FK?=
 =?utf-8?B?Q3A3MDVsQ1ErTDFodFBpcnQrK0RVeEJrVTBqc2tRUitySVVmRzVwNFN2aVZm?=
 =?utf-8?B?R0lsaTBYNW5lV0pYc0pWVzRRVUpnNmxOMHVsM0t2bWN4eFQveDFESWpHNDRl?=
 =?utf-8?B?aFlNZHVhMUtjd2I5TldObzdoa0lRZy9nYjVpZnlVVlJTK1VOYUdqU3lIdy9H?=
 =?utf-8?B?N3owTUhtQWljcnBTd1I4SzRMTU16ampkRU1idkswWWJjUGorWGpaNHg0UFFT?=
 =?utf-8?B?STFybEhMK0VDck5hVDZxbHRqdmhNZDdKNUZCeC9UVy82RmVFSDJrV1phK3BE?=
 =?utf-8?B?aG1MeHRrVU1mcnpyUzZxWHhTek5Ec3ZPUDE1QzlRSXNsRzZQYmVVaEpsZU1L?=
 =?utf-8?B?VXZkcDFMdUpnSzlyRmU1anRwN25CT3pGQ2RJWEo4YnBuUHZNcXhQQS9vNnJH?=
 =?utf-8?B?azQ5bUtPcjZWQjZYekpsemxHTWdQb2F1MWlLejQ0UlVVM25CY3pPa0Q1MXRm?=
 =?utf-8?B?Z0xFWE56S2dkdmVOaVIxd1BjRWNUakR0STNTWVNIeFRSRmRXS1RJaWZWTURJ?=
 =?utf-8?B?YXFaZnNVUnVFZEJvYUE4S3dNeDFsZEE5Qk56WDh0NzB0ZFptMjBTMjVXTjJS?=
 =?utf-8?B?T0M4aWNaU056clhEVEZJd2puSDVBQWo1bkdERlN0OEpnRlJ1VFpnRkRFRmkv?=
 =?utf-8?B?QUJkQ0NiY2QvajlyZjdzUWo5Nzl0WDBDNEYzRVRCYVo0a29BV3B6U20vckN6?=
 =?utf-8?B?QUQreUpVVE1IenhRU1JYdFFOdWpxSEpuMHA2UHp1b0tKVE9XM2hRS2RQMXhq?=
 =?utf-8?B?YU5VamQ3QUVmUjkwL1FSaVA3SURodmdjcUc1OWs0RGxXYkQ3a3dHNDhBMHVT?=
 =?utf-8?B?amxYbDlxakkzY3FubnJBRTY4empWZFhnZjVaZlpQZmlwR3phN0NWODB2a3hk?=
 =?utf-8?B?K3R5K3MyeUNWRVUwUWlBUTBwRXI2am1ESEswL0g5eWdBWTJPMnFjdjg5VHdp?=
 =?utf-8?B?OHJwMWh6akRTUXhTVjVURU1vMnArWHk3bmh1SVpuUnJEcmd4bXpxcmJBY0t0?=
 =?utf-8?B?S0t3Qks4czBrbGxYSjJ1N3BNRGhONVZqcTJSODJiOWZWV2djcUxmVUtwVjNV?=
 =?utf-8?B?bWVJM1RXemhPQjEzVEw5SlJmRGU0L05MNVoxMnEyc0lMRWMxY05MOTlqQ0Y1?=
 =?utf-8?B?bU9WSHh6K0phVHdqalpOenh0TG1XWFhsQ1FHTWpFeEJRWUhKZHJScVEvK2gy?=
 =?utf-8?B?aGFQOUhpM1RBTUZtQnhCek5zRGVuV2RRS1J0QUh6Y3lVOWpCWU1oOFJNTy9z?=
 =?utf-8?B?cFZuODAxQ0tmbGsyaEVXaXBlTlh6NVJ3Q2ZjMXhuclFIdHk1eDYxRm1QdnZ0?=
 =?utf-8?Q?sF3E2u184+Uq29tOhq/1CbcL3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d356b25-3174-46ce-e30c-08dd55653c43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:25:44.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49Bz3TT5IyN2x/KTy1HuSEJ/+o61FL1qnXVdNDPV4t1CBRiKemSmiJBRAQdsQLHSteuaejsTn2TsH41wX56OZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3945

On 24.02.25 22:43, Johann Obermayr wrote:
> Hi,
> 
> is this correct, that xeno_16550A driver does not support IRQ sharing ?
> 
> i load xeno_16550A with parameter io=0x3f8,0x2f8,0x3e8,0x2e8,0x2f0,0x2e0
> irq=4,4,4,4,4,4
> this work, but after open a rtserX, I get
> 2022-01-01 01:27:41 kern.info kernel:[   93.857347][  T579] genirq:
> Flags mismatch irq 4. 00210000 (rtser5) vs. 00210000 (rtser0)
> 
> irq 4 is only used by xenomai.
> 

This used to work. Maybe we lost some bits when adapting to dovetail.

Hmm, xnintr_attach only requests IRQF_OOB, there is no IRQF_PROBE_SHARED
while the generic irq core expects this here. Philippe, is there any
reason we cannot use that with dovetail?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
