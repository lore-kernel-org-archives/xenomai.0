Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F826280A
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097368; cv=fail; b=Bf9YlGtwfmPhTt0QreCLphzdCITFbFFe1GJJKyTRuk6etK+K3NtaR52wTwzWMmDLV6nQJW01cZcWI3CqbnUcLXUq+0HC6hg92KI/wdr/I8My6j71VKmzemQHX2pl9xvlrGqsw48Nl1ealjNW6aVlRO6KXH4LxGKeZLBrSgMLSXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097368; c=relaxed/simple;
	bh=49wUX6fRNM1IJCI9BtZMIpe2lih1psQ+R/h6bJr0D6g=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=BaDPDwC6gU6nv/IFsXlRKegqgHk1DUkoyQyQ/vRlWV5YqTBlRvlwWtOenu+JAr6ZBLM4yfGfNJIJF8BSMd4J6Yqd/9bdAwHPKSU6tbGodlRP7KWKzfuLk9lNxUG0214bAmYRAuvuJ6y0Vv0Jl/TxnSNd5rXoW32DQWtu2Yq8RC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uiRp3lhx; arc=fail smtp.client-ip=40.107.241.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uiRp3lhx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLh4gEuLTjYV+obLina6pzoBgWOAmJ7XG4MbP9Q9D5Z5SPH5fq+VmftfOn8WhMuMyOyA9mNlmCaXblHN+l9rdzN+LXcmU01M8iBbdXaop7OUO+7qs/47MsSNpjWD0HWDScj25ckx7Kx/9as1a2x07VAk62h0/AcjfjhvSJGOm7vtvZ0AmVyTjEoxUYI+O9PD+H8WEJV6cl7HfbsWRy7ra5bxinni6n1Khv+pvMAv5O9WcjX202xO7r7gxXMwhRZ9DXCn7+JOIK3FVWxlTsnfb9+wer/Tfrw/E6M6oPkRIBSZId3y/Us3Kuf6Jaxuh+TKBQYZQvQb078i8fSYDqKvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8kobIfA5noVPTuB5ZRRyCtZ6Y5FGvdyLhCnvAFYerQ=;
 b=hic2CPfT7M9l6iuh02WIEj8oOerGOFnfTHOd+2g0QM+OvqqBr1LO37DSnGDlcNtlJ8Y1DX6WCQEHq/vLmKHsXQ5EDOODBLLH2MX2XRbE++wdZzisjLFjOm8XajUrgm2KGRJw49wwK4Ya2Dm23ZFIBlgctz13UbQCl9pelgML/cTjXSoQJkPgI2GqU91bHga/wTr+2sfyZmGGzgR0vbv7V6O34CvnGOJICgtxwKCM9Rtg889bGDEziR0sU1jA60Z3PEyRVMgVZpKwKWw3zUUMxdzNWw3dE3UkULpdg3J/QFCmqeSEYMAEpirQEdqz+p5MOlOREt31g9mJFJps7orl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8kobIfA5noVPTuB5ZRRyCtZ6Y5FGvdyLhCnvAFYerQ=;
 b=uiRp3lhxJLlOYex+zeeQXvD+B9dBlLjhXzTzctao1/4fJFpwN/zAeEzn7uVPH4ZQkl10hi+8by0PO9r1zkMqByqUplcpdunUsHsSUg0Ej3/pfELGNrPKO192BN+Jvq6Ymx2nFZD4nH9vfYfC3mJqMMPp91zScUPsyZLdeXh51VurRByU+JHJrdAEdHOotJ6O/cl2O5Czn+kFq8H+kfqTFSyWErv9PNO/qRUT+o/yrAjR5sGHuVOOsVkpKP7KZbECja0rYDGyms8+9k6mZHeHV+/Qj/bJOKOMHfOhZ1c8a6sTerZHlUMryK0KgWxFyG7o4B34CcT3Sm5jR2DATkdMbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 07:29:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 07:29:23 +0000
Message-ID: <d553c05f-d3f9-47ef-8dc1-f59c8dbcde4d@siemens.com>
Date: Tue, 8 Apr 2025 09:29:21 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Add SDK support
Content-Language: en-US
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 102ea6d1-1943-4ba7-404f-08dd766f1548
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJTcjRCUjdNaXZUR3BhMnkrOHFPWk5QYzArTDhqRnltTjdQdVpoZmI2S3da?=
 =?utf-8?B?WWJERGgvbEl1dHRZMmhnRCt4OWk1Y1lWSlJTOGx0ZTdpejdtNVBiTVZuWDZm?=
 =?utf-8?B?bDdzRVVvVzNpaHNnRnp6RjM0OEhzMTNyL1dWWlhjbnVJZUUzbXRCWUdYWEpz?=
 =?utf-8?B?dzhRVm5UbHZPMTd6SEZzZm5sUEpQV0VGTzh3bGZ4NWRhMC83NWt4QUVxMW1N?=
 =?utf-8?B?RzRYazZ5RW9sQk9hajNENnk5amowWm5rN3E2ZkYyM25SREQ5enk2RmhFdndK?=
 =?utf-8?B?Z2twZ0VxUnpaNmQ1czYxT2sxSnVXV1RyS1krbGdqSDdzT3RmajhiSjF2U3FN?=
 =?utf-8?B?dGJlTkhDUTl4YTJldCtua2pVbG9IdEJ6UVFTVjYrb2VzVDY0TDFITDZNVjdK?=
 =?utf-8?B?ZjNQdnVoU1hoV25HVDVZZHVKem1GSUVGdW1vU2xLc21LZ3gzaXB5SFV2UGFN?=
 =?utf-8?B?OGY1V3ZiYzA4OG5GbjhiQVE2SVpSdWJRQ0pPUkFWUTExY3Era0NqY01aT0lD?=
 =?utf-8?B?OGZrTXdMaXdhUWRGbHpXUDJMRDhMYWdPdTNnQUU4TFgybmhtVS9JSmR4RklO?=
 =?utf-8?B?WTBEZU5Odk01OE9ydk5pV200ZVp1Q3lRUGN2Q3I1bVRmeCtQdDFsT1ZxVEg4?=
 =?utf-8?B?K0NJWEd4elhtRHVyYk4yNWQ2QzViazBrWjd6Q3FLb1AvUnd0TmdCZVRYQmJG?=
 =?utf-8?B?aGFnVlQwMDVqUmRDZmUveTduTlJ6M3M2VWJCNEx4QnVXVGlFNW93VlI4R1BJ?=
 =?utf-8?B?Z3JkaS9WSnRWTHFtNjNOdzNZSS9XVkt0MEJoQ0xkUjltYXVKVlAzalB0Ymcw?=
 =?utf-8?B?WEtJeVdLZVJVMTBFNG5jOUg3MjkvQ3lBU2trb2o5ZE9ZWEpUQ0FXUlM3UmVK?=
 =?utf-8?B?TzZPNVYzRDZiSnRSRHV4NW1wOU1SeTA5Y1JkZWI3RTR5UDF0TmFUNzlSUGFr?=
 =?utf-8?B?ZUdsNHZvZW5qcFZPc2ZScXB6ZVdpcGNyMloveUlJeHBQN3kvSjRtWGhVbzVu?=
 =?utf-8?B?VGRRak8yNDQ4VnJTMnlkQTNIcURvS3B1MUR5dG9BWTVmbFNQcnJIM3d3K2tj?=
 =?utf-8?B?bU5LdkJRMmVhOEFzUm5rTEFKM1FpUzFhOHpTcG1BL1FtTHhoSzFNNWdEdk9Y?=
 =?utf-8?B?eVVSZnUvMmMxWE1zSk9xak5peHpaaFlCSTBNblN3WXNXV3pZVEJwVnQrdkJQ?=
 =?utf-8?B?d1hXTnpIVEpndE1nL08rU1NlTG43NEF1QWZMYmh6bnFOMW4zYVY0VG1jTlAz?=
 =?utf-8?B?OE5ieFZaeUJ0ZVFYWDhWemtNYk1GbXFGcWdZOUNRTC9ST0V3YW1aWDc3eGRX?=
 =?utf-8?B?SUpwZXlyZHh6WEhBdHlYc1oralh4UURwWjFmYkhNa285eXRBWFJDUEROMXI0?=
 =?utf-8?B?eVlsWktpeFlpWnJLOVp6TGJ2MEpkRk5EVXlHanR5eUZ0eGtDR1lvb3psdDRw?=
 =?utf-8?B?V3F1TFNvL1RaOXQ5bSt6NTlLdDIraURyOTlSeXVER3k0dlp1SEVCM1ErT0dI?=
 =?utf-8?B?U3JjTFlUNXFSc0doUzB5NEg2K0h3b0FGRGZCTGJObkZob2NiVHBSMDB4bnBp?=
 =?utf-8?B?QUdGaXEyM2hHTXVBY25TenRBbDdGODNCZDk5ZEtGTHZETWNKMGZHQlByTzNC?=
 =?utf-8?B?aVI3SndYVEtsWWl6K1dLVit4eUcvTXRkSVZiNlpMUEVxSFNUMmFmeFRxTUtm?=
 =?utf-8?B?ZitmL0h0bFFwNE1QdTR1d2hvUU1VdmR1NjZ6bDJLam96M1g3OHMzaG5zN25T?=
 =?utf-8?B?YXRyTDNFeWpHbDZSaEtRQTdWUXJZWW5qQnRPckRic0xCOTYzM2tCNUhzVFlX?=
 =?utf-8?B?cmNqZFBjbXBCM1FPNnpJa0ZwRURXVjJJZFlYS0U4TVQySUUrcmhibUkyeGRY?=
 =?utf-8?B?Q0Y3SWpOcVRiTHp1d3ZxSmxVRTVKcXp0VkpqZzRnejNMVmVoMHRJUkZjVzBE?=
 =?utf-8?Q?AWnfUwgElIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5JbUtNM1RmTmxOK2tZTDY0TGU1UXJDTWZ4N0NzMUZQcjFkOWI1RGpQUWp0?=
 =?utf-8?B?S1c5UFc1dGl5SXk2dlN4OHhvNFZWQURsY240YndiY1FFV3pCZEJobjlHZHFO?=
 =?utf-8?B?OFBwRkEzdkY0bUVlN25xOWl1QmVCSWM5dlNPeldrZDl1eFk2ZFFwWnh6V2dr?=
 =?utf-8?B?amk1VUsrQTJiVVhQRlQ5OGNWMDRuTFl2SXZLb2I0T29SQXlVNE54MkQzM0lZ?=
 =?utf-8?B?b0IyZHQ1WDBNYVc5c1hKTTF1UmxRcXBpYXRPaERPT3gwZFVDVE4rWHNydkVF?=
 =?utf-8?B?QUtXcHFsMVE5RXAyYWk4ZnlSM0dYT0VJU0xna3VuNUd4VVFhaXV3RWV5RitZ?=
 =?utf-8?B?WmR0SFpVd1lxY1N6bHp0WWR6QzJ1bmpYZzlkbElYQnNUMnFkT1pFUXBac1JD?=
 =?utf-8?B?QkQxeTJ3azQvSWY1bmdZUllTYy84UWhxR3hBSWVOQXNQWW0vQkxtUUtxWGQ5?=
 =?utf-8?B?QTZYODJsdkRDVU5TTlNIbzRjWVVnMTRhRU9WRWZvaEk2TStTdXozMkNQT2ZP?=
 =?utf-8?B?K3FoeVdTOGdJcDJHMkVIQTVveERrZkF4dDJxSHpMc1RvbllFWkV2Y015NWta?=
 =?utf-8?B?ZFhXUG0wZDJQNkY5RGJIcnMzU3UrQlFQS2tnRUZhWFZ6dUFqdnNuTVJwaVE4?=
 =?utf-8?B?ZWxabG0weGZpcVVrMTlkdGpvUlBzMDEyaitueEVmQTZXVkZUdkl2aFFSWE5y?=
 =?utf-8?B?anMyWDF5T3R1UTJlVWlPVmVuNVR2eGw0RE4ycE1XSGNHVGlFVHNJY2VtWlVP?=
 =?utf-8?B?QnN5QTUvUldtbGNuQ1p6c2FGOGEzNm9ocndmUlFLb01pWmhqSkFXeEtBTWkx?=
 =?utf-8?B?dGU4RFpEUENtK2E4OUlZeGg0WWIvRUVFeFVxTFpiMFE5WlcxTVNVZ3d1SjN3?=
 =?utf-8?B?T1lzalRwWjNjd29kYnVmcktKTVVMdFYwWS9TVVk4bkhacDhGb2hiVVdXNm1j?=
 =?utf-8?B?SWlLVEFYb2NBZUpjc3kyamVXMmlzaG9mRzAvaG8yZ1ZiZ2FDTnE3bHVYZkps?=
 =?utf-8?B?cDk4WE00dlRXQkg5N3pUcmNCRytaTVZTQXluNHl5MzVxa0JqejU2ODBzZGwz?=
 =?utf-8?B?endZNGZTaEZiT1BUa2wwUkw4V1NrM0RaMS85NWZMSERyTURQeWhva0NTMkt4?=
 =?utf-8?B?amllVjF4THcwK25vUmkxbERVWFA3bjlmaklkWVNVODVJTE9LbDE4dTdCWXVK?=
 =?utf-8?B?YUJtS09SakxYenJYUGRES05TM0VuWVZjNUphUmloZGVQUjBqc2YrdkVBMGFE?=
 =?utf-8?B?REM0cTRPUkdvZS9CMGU0a01hRHp6bVJwbUQydnFJdzB6K1VtRTBPRUFkYm5S?=
 =?utf-8?B?QUZsUHBQZHorb1haenlCbm1hREZrRjErUndPYXV4TUZVMnJzMjc5VGhHOG9O?=
 =?utf-8?B?ZEx2cEZXMnR0QkZGcHFMUlNkVFZLelgrU1owdEtQM1kyTytQdG92R0dCbFls?=
 =?utf-8?B?SDgyeU5DbW1Ob2JJU1pqVVlRYWNoUy81U2toZHVGdnBUamVhR0ZQai9aSzRw?=
 =?utf-8?B?L0xuWVNiSWVzZURDRDZLcGNRTTlhem1WVTZNZlFvM0lJamdNU1BVS1dMOUNr?=
 =?utf-8?B?SzN2R3lNN2haR0dmZktXOE9vNElpNlZvTHVKREhraHJIay9UeTZGR2kzN08v?=
 =?utf-8?B?K1F6TWNwc1NkSGxRVzI3Mkx6ekkyRUZoalBlWVlLbmNCZmR6eEU4VVgvdGxl?=
 =?utf-8?B?c2xiaXl1RHZ3WWRtU2VmdmRGSlRpS055SVZ5T0E5UTZVRnZHUUJzWGE3NDNs?=
 =?utf-8?B?RURJZk92Skoxd3FOdXMxdnRpeDFOOXIzaWZZbDMraVMwbkNUZ05aSHhvWnEv?=
 =?utf-8?B?bGdyV2FYN2tRUVh6VmM4RkE1bHorUlMzYS9PMVBPYmpESnNLNUhVWldMVFNp?=
 =?utf-8?B?TDdvZjVHdEd5eXZSRFVNbWhqajVLaUFlRWl0T0dyUmt6RUtzYjBNT1F6KzRW?=
 =?utf-8?B?WVQ4NEF6Tk1waW42L2FDYVRhWUVsOFR1b3RXcElUMExWOGdkMDRPUHlEVGtF?=
 =?utf-8?B?eUlscXFVUEVPUjlwTlM0STV5LzlqSk5QSjIxbUV1MkZBZXdvRmV4dGJhMUtV?=
 =?utf-8?B?bkZmc3I1VUZxa2x4d2Ric09XSjdRRmt6T2I2R3U2dnR5ZkJMMU8vcE1pRXp3?=
 =?utf-8?B?M09jS0Z6MTBFWHYybTRvb21mb3NTdTh4TDNLU0FqL1NkL1ZzRHQxS0VSY3Fs?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102ea6d1-1943-4ba7-404f-08dd766f1548
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 07:29:22.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMfLH3FzKzWuDAfD9XvCmHa/EomsKBVT1jkoTQ4ffYDIBqNbHOu7+aEqNFU8eja19OcuxQ4hqPwo8iTZur98HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165

From: Jan Kiszka <jan.kiszka@siemens.com>

Not much to do for it, just make sure our devel packages are included.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md                     | 8 ++++++++
 conf/distro/xenomai-demo.conf | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/README.md b/README.md
index 7c9869b..1ebef5c 100644
--- a/README.md
+++ b/README.md
@@ -38,6 +38,14 @@ Each physical target will generate ready-to-boot images under
     dd if=build/tmp/deploy/images/hikey/demo-image-xenomai-demo-hikey.wic \
        of=/dev/<medium-device> bs=1M status=progress
 
+### SDK generation
+
+To generate an SDK corresponding to the selected target image, append
+`-c populate_sdk` to the build command. The SDK tarball can be found next to
+the image, e.g. as
+`build/tmp/deploy/images/hikey/demo-image-sdk-xenomai-demo-hikey.tar.xz`.
+Unpack it and follow its `README.sdk`.
+
 ## CI Build
 
 The CI build can be executed locally by
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index d1b24b7..a113a54 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -23,6 +23,9 @@ PREFERRED_VERSION_libevl ?= "4%"
 
 KERNEL_NAME = "xenomai-${XENOMAI_MAJOR_VERSION}"
 
+SDK_INSTALL += "linux-headers-${KERNEL_NAME}"
+SDK_INSTALL += "${@'libevl' if d.getVar('XENOMAI_MAJOR_VERSION') == '4' else 'libxenomai-dev'}"
+
 WKS_FILE = "${MACHINE}.wks"
 
 USERS += "root"
-- 
2.43.0
