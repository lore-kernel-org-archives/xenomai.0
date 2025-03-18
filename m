Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FC20DD65
	for <xenomai@lists.linux.dev>; Tue, 18 Mar 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306405; cv=fail; b=W7PAJwW3mrs0rmZmgblcudQjFt+QM+Qvmk4Gp912DRtLhDR7UgxXTDnzSmG7uClMH5H/b4wexRvOlMhs9TmJ3KdBNo+1LpRDu0eVwwfMo9OS7Xc6gjcNp6bljujo366Jhyn7OxBsQn461DmPU2kVno5ayOsvcb79TyD2nJCK8ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306405; c=relaxed/simple;
	bh=YxP4NiCQHLAqtX/GaVQ8Yz0rUaaK2V1Hc3jVVS3ScAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=deeR+rfnLswOTAc2lqF3LO90XvY26OdnQNov9bMsg7qGHYs5SAAIDmpnX7BwfJ4HD9QHZRJyqKx8c05oDPDqaX3lj5DrcYkEEGr/mAWbDwahXYD3vv7eb7d7OOSFCKtAKkv4GGRWRppRb38PiBaD7Pp3ySuKOlW7/Fy+5kSY3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M0tsLYbo; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M0tsLYbo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnMFKHLDq5aKeQIpZ/u+/CkylaNFDyIUaoNNdpYaXX52dI0V4ZulJmdxkLoGG+n1xsPtV78SbYrnyjKgMC0Xi9wZDeC+O2U7Ook70l5CHT4eA0CozMnBZsUYwntHhv5jGeCsGSGrmP/OSgOMO7o0wgHMoVzay16DcFaXiWU2E3OsfHA3ZEDDTGzXxxV3wWrJz25QfaZrL6QWB/ateFr2sH43mlHcmbscSDlMlrDJEys+26XVfcXFaOOwu85+gt8cB33/guJCbH4D+J8Qh299Zn8K7IBRK8j+Gt6V+8hrIio4I3XuNT2daSmUMGd9qmCokYLtsA1vpHLhrM8eHgrmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebPTm7ItRrIfk0uWN38hYEoNGZz1kD2+WMeZBOcXTF0=;
 b=ndmFY5CvaI2VcarPMS+oN52wYnCL0hbpc4OxL4DZq8YJhZWmjw9Ty+NfvucD6fZScShFp0LXFVK5rQj+NTNKipi71lv0+KIL+sv8MA+Y4IGohocQK+sY2wEzAfOs0ATi9FgVZiyjMSJ9VKzFFfY/gl5PK6lYQuP/+YCtKip713T9pSUFgelISzlSKanW2WgZD3QxovO3vQJsM2IOhWDd4sq47Iu8x1twlg6SgvmuHoYV0ss+KoblN35wczhdbfOmH1iUTwWnkCn/o8zYLCLC57zxBAPqk+aIO7bylC3Hng8Aj4kPHCg5gWSGvkUOrtckEEtRxRlkmCnARFbrJGY/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebPTm7ItRrIfk0uWN38hYEoNGZz1kD2+WMeZBOcXTF0=;
 b=M0tsLYboSTXAYkV3zZVAOExFV2KJcdI6wAEb8DkISLl93HwF5bSau1yWh1OMJNlejBKdJU3ckPiNlBbjifGz7OmSwKt3c/1VArPLQUVV6GE0ACZnmHX4VErVpyR7g+ORA9x7P7TW4i7Diu7kmE3wD/UjktKGN1yJyF2BCysWTc+pNuvt/Khp/eghPAjR4BQTWptMv6ToK5L4qzmF3iasZrOwhKSlJODfRAwLcvtcQU+FH8oaGbKK2DPn2jXkk2LWIIjLovtzSajTj6xQHQCyqT39UajNj0QmmKRFh3QtG4QUz3AWpFZZ1ohBfB3IEl11CPgTOlq2Wfpu+ncRScvgHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:59:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:59:58 +0000
Message-ID: <6a2edf87-2b06-4426-89bd-e6aa248ccc9d@siemens.com>
Date: Tue, 18 Mar 2025 14:59:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM and
 Hyper-V guests
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
 <7577efa5673691900d6b826024c30c6e74496f78.camel@siemens.com>
 <cb853716-802f-483b-a586-dad91e7f37ac@siemens.com>
 <87r02uo31t.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87r02uo31t.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: a0177491-2d22-4005-078f-08dd66252b44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXNIQkZvaGdMT3pYZ0tCL0EyMGpRWGJMakc5d1k3aGRDQkZFWDVzVGpJWUp6?=
 =?utf-8?B?WU03N1NJWnZINk9uS1UxNExIY3M1QURZdFAxR3JtNXZyTFFvQTlTTTNmeG1i?=
 =?utf-8?B?ZXJQOTlrdVcvOEFiRU9vdHNlaiszUnZySG1icVZTaE12MmdaemFaR2trQThB?=
 =?utf-8?B?T09LY3Y0SUQrdWtzQmFtd3hXcWw2WGhyNElId1A0QUtTMmNPK3gxV1dHKzM4?=
 =?utf-8?B?U1hDelBUUHpLNVZOTVd1UWEzM2JxTExyS0hJZHU1TW15M3dMTVBqOTRpWmI3?=
 =?utf-8?B?Nk03TlRQbituUndUZ3F6NjVGYkpOK1ZLbmdYSk9RVi9SNHhmMENOK3NVRG1u?=
 =?utf-8?B?SUNtZ0VSNFluSkNuVlc0L2hzdFA4TWZhUjE4STljRDZ3MndOOGpRSU5iTEJP?=
 =?utf-8?B?NFIwb2M1QW4zSmVGWTdZMWFUVmRWZC9RQjdxTVFYTGZoem1tNEFkcUJaSmJU?=
 =?utf-8?B?N1Avd21WeXU2QkIzRUZicWlIMy9yMVpkUHhpMkdLbWNmVnZYbWxQRU9KazJt?=
 =?utf-8?B?bkg4a0JvdTJsbGRyN3UxQ2h4Rzd3ajNRMjQwcWR3MEpSeW0wS0MwNXoyNHIy?=
 =?utf-8?B?Mm1Qa0diSWNSR0Z4S3U1TUFwaTR2OTU4QklsT2hxcEdFS2c1VU9tVFgzVGF5?=
 =?utf-8?B?bGgySEQveTVNb1g3Q1E0YXhCSy9zcnFMczFZYWorSmRiTWF2UzdLQUE3VXcw?=
 =?utf-8?B?K0hUbFVMZmt3RzR1clp0b3N6LzFZUEJxUUhSSW5Sa0MxbTgrak1kYVBoZ0tV?=
 =?utf-8?B?U1ZZUzd0bncrQjlPWUx1b1BkdVNDN0xsTjJLY01PMWUzVWFFRm9VMTZtWlFE?=
 =?utf-8?B?a3VzMlpNamJGMkE3VzZXUm9DQnJDYnM5RDh6ejl4RDNJam1XOXRRdjBDalpF?=
 =?utf-8?B?T2loZWg5eGFOa0ppSDFHbUpuaHBEOWdySHZMeDFKV3NNbUorMXEvT2NaNFRh?=
 =?utf-8?B?VE5rblROcDg0Z0tmYldPdWlZYXhyTkdpQUdGZVhRTUt4RzgycjhIZFFraHJx?=
 =?utf-8?B?YWFCYk5XTGUrWThadGliNFRYK25Icy9iYXBVWWs3Wm5qV1h2RFc5LzcvUVdo?=
 =?utf-8?B?dXg4aVRVOGY2empkMThYaktxSi9CR1lUQ0ZiVlpWWUdPdjN3RUZTbWJxZm9l?=
 =?utf-8?B?dlhWcHY1Tk0xM0xNYThVQkJnL1Uvd1gwcWR5WHBtRjEvQlVpcm9TUzlDdjZk?=
 =?utf-8?B?b0o0c2NMeGdNUzlGT2NkVXpOSDM1YzVyZng4eXAxQzdqaldMTGQ0ZXcxbG9X?=
 =?utf-8?B?UlgxbXdsWElEaUdBZ0lJbGUxZktvNGNaRDZJUUJiZWhrTVN5YUtZMlhQdFpV?=
 =?utf-8?B?N3JnY0h1dEZrUm9uVGpRZUNWWGExc1hLY2tXRTdnenpONEpMUUZhWGRvanJj?=
 =?utf-8?B?VENNR3RsUHhJaFF1KzBMMEVoY2M5NGtKS2lmdnEvcTBDbTlodzNNWlA4Z0Nh?=
 =?utf-8?B?V21TbXVlZCtsTC9TNHYzU3Y1elpCMmdCMVdQaGlqZFhDemtCQjBMZCthcGdD?=
 =?utf-8?B?NzQvM1Z6Uzc3ZEhrdkR5dWxrSE54Y3hGZUVqSkVDV2VzYVdXZDgyT0ZpcjIz?=
 =?utf-8?B?Q2JNZkxmWTZMWnBhSTBLSTZRODRNR1paSW5ZSVZjNTZpRnNVZ3RlWk0wVlpi?=
 =?utf-8?B?UjBCZGJiblR3WERaaVN3akRJZk9rUVFVN2tSUmV2ZFhGSC84NjZNQktscGdo?=
 =?utf-8?B?ejJ3OFVJOHhad01aOE13TFl2djdFQk5aMTZzRVVJNzVPRHdkUzluVmdzcGIz?=
 =?utf-8?B?RHRVcGtpWUtYOWl5VDdnZ0h6K3R3cDROTXhJa21acTNvcHpGaFk1ZExjcC82?=
 =?utf-8?B?aDVscEZoRUNvb2k0WG1Dd09aY1lpVmVlcUx0cllpVHpnVzkxNnBVdTVjTkxK?=
 =?utf-8?Q?ZuTA0C6aT7JrA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZHY0tOM1I0b2FoTm9zNGNBOEVEUGM1Q3NtcDgrSkJJd2VTU2Jod2ZURW4x?=
 =?utf-8?B?aXFrRC95bllkTTlza3lhaGRDaSthNXFsUmNLbExOVWc1T0JxVmpDYWZidG1M?=
 =?utf-8?B?dFk5V2FCVzZxSDlBV2t6bTBUWUtIb2JyanFGb2JoUktSeXhqNkYxc1lRVzV3?=
 =?utf-8?B?TUtxdlo2bGRRbHZJODVoQ1J5dVEvVzg3MS9VcFhmYVB3eERweEd3ZkJCdnZH?=
 =?utf-8?B?Nm5rUXRoaHN6Qmc3UlV3bE4zNWlvRjR0dEdvNmlTTW1kMXRXV3g2RzFMMjRk?=
 =?utf-8?B?eVFKTnRxczBBWkJPWU9hZnNzbWFERkZrd1VoOTBOeEZlTDIyaFRVM05WVUJq?=
 =?utf-8?B?MXp1NWFNdHNDTzVoQkErRDhpWW0yNWgrR2pxN0RSOGlXbzRweXc1anljckZS?=
 =?utf-8?B?OWdGVXJ2SXZLcnZHVzM1WDdXektER29nc3pEbDU0d28vd2tHSGV3QU00ZjBn?=
 =?utf-8?B?T2VuanBUN0prczREZ3FBUEU3cUVXVHU3ckQ5MktWSmxJZkV4MVZVMTFCck9J?=
 =?utf-8?B?aG03b2FubzBSaTVmcmZlY3JMUWVlaUcvazl3ZnVCbDZGcFNxZVdDWnZRZnly?=
 =?utf-8?B?U2JMNGU2R0FZalBFTUFPTzBqb3dmTmV1WHcvajNUdEJidHRNcTh5MVlMbEtv?=
 =?utf-8?B?NTlCcXhIZVlIcnJ2NFRBV25rWEVsai9aMHVZOVJPanY4L3kwR3pScGlGeUNF?=
 =?utf-8?B?aTVsdTRhMlVNbS95RGdsODhCTGhldHVrTVpnNHppcGRXM0p5M0orSHJWdlZz?=
 =?utf-8?B?bm9oZSs4bzV5bjdpM2szNmNFWjJXd2l3dmFPZjdyWDB0Q2hlYldVb0E0R0ZX?=
 =?utf-8?B?SWpzL1FPM3g4ajF3MVZGZnRldHIvMTVpMVdBejFoUFBwYVBEOU5RSHVvbHBw?=
 =?utf-8?B?bTVKamtORzZDRi9vaFMrOTk3UE1hWUV0cWtDNXFRd1F1ZDYvVENGTW9qM053?=
 =?utf-8?B?dUdGNGxvc1pXQU9HREF6QldqK2dxN3hadnlqRzd0TGpITXdzalhaUVdRLzFZ?=
 =?utf-8?B?VWdyV3JMZEZkY0pGSXN6RFh5N1Z1ZWhRSGF3T0haUTQxZ0twbFUrVXlPaVMx?=
 =?utf-8?B?RStHMVpuUHVESkdWZXRCN3NaRTdyTnJDQkM3alY4SW1aVjNQRTgycnlveEZ6?=
 =?utf-8?B?UjAyMWV4MG51WnU5MTdQWjRUSDVhUWI5a1BHcGhJdDBYa2ZkbGM2ZTFZL1F3?=
 =?utf-8?B?dE1HZW5qTmNWUzVoR0FmUTNCbnA2aGJkWHR4aWRreWdnZzFkMFdDNVJ1bTRV?=
 =?utf-8?B?M2hFbGVnQ2FaUExCY0pDZzZNcHowSEpNQTZ4U1Y2MHpSdk50R01CT0hDK1FE?=
 =?utf-8?B?MENaZnhncm9NYjRnVXJYZUtKdzFLdHF2L0w3ajlPb1BQOGpJQy9lSmIyZGRZ?=
 =?utf-8?B?SC9oUW45dkhKcHNRV2F4dmYrNzI0elo4QXZvTzhTdllzYmJXdE5yZ3A0SUxa?=
 =?utf-8?B?ZmVzdGRiQ2F6TnoyYUtxZnUvQncxSkN6b2grdHM1REtobzc4N0ljM0o1ZFg4?=
 =?utf-8?B?eTM5dW15QWh2c0dmNXFRZDViUFFvMmNPa3d3UDNQRlUyZU9kRm1TcXlScXdS?=
 =?utf-8?B?U25jdm9GbFBBemR5NkJBai8yak93Q29oY3ZpcExrd0hINVI5L2lmajFPWHls?=
 =?utf-8?B?SzFVMDBrR1NLTVpWcGdpemxPR1Q5Y2JmYlQ2SzRDdTBIbFIrVFUzMGdoc3JL?=
 =?utf-8?B?dlFVS1N3NXBHR0lhSnUvVDRWUlN4cGtINkoxS3FYd1ltZkQ4bUhSN1NVWmdl?=
 =?utf-8?B?Vm1EbmZNbWl5SHFDREdzRDN3TWNQNUhSdmNpWXd4MWxheWhDUC9MMHlsejd4?=
 =?utf-8?B?RnAza08xVHNxTlNHL1MxbTEwdFdLR1NWMUE1T3Z3dmZYK0dPVmtpbXJZL3ZW?=
 =?utf-8?B?TUJqQndDNk9HQ01uR0dNYXMvcUtHS250QjNRNytTK2NhR3pjS3JsU1ozdys3?=
 =?utf-8?B?NVJ0RjdBVEJKcW9Kc05zV0E3cmRrbzMrOVQ2VUFmT0RzUmRHNm1rWnQzS1lN?=
 =?utf-8?B?eCtmV2Uwd2lhZUZpMlRFYkNUL3Q1UlJTWk9zUWZFVUs0cGxPNlRQamJOLysv?=
 =?utf-8?B?QnNGdTc2OHFxNWI0VldYUHBQVm1LcHFOc0JlaFBtVEYvNGNxdkk4UTZBcDVh?=
 =?utf-8?B?UnlrRHZxbmE3ZXJvVEtBcTNUeG1oaXp3UHE0L2xId1NhN2dLQUkyazN2dDJN?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0177491-2d22-4005-078f-08dd66252b44
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:59:58.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAB8N8QfSp3KI7rgoYBSFkusQtfFMUxLxybZma3vara1ifZawYbSLNseMlTZEkrSgszg7CR9CWk+tpeNX+NdwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7249

On 18.03.25 14:56, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 27.02.25 15:25, Florian Bezdeka wrote:
>>> On Mon, 2025-02-24 at 22:07 +0100, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> These functions are called in case paravirtual IPIs are used.
>>>> Just like for hard submission handlers, we need to harden the path to
>>>> avoid splashes like these:
>>>>
>>>>  IRQ pipeline: some code running in oob context 'Xenomai'
>>>>                called an in-band only routine
>>>>  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
>>>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>>>>  IRQ stage: Xenomai
>>>>  Call Trace:
>>>>   dump_stack+0x84/0x9c
>>>>   inband_irq_save+0xa/0x30
>>>>   __send_ipi_mask+0x81/0x260
>>>>   ? preempt_count_sub+0x96/0xe0
>>>>   ? _raw_spin_unlock_irq+0x33/0x50
>>>>   ? xnsched_pick_next+0xe0/0xe0
>>>>   ? ___xnsched_run+0x491/0x5b0
>>>>   ? ktime_get_mono_fast_ns+0x50/0xb0
>>>>   ___xnsched_run+0x491/0x5b0
>>>>   run_oob_call+0x97/0x170
>>>>   xnthread_start+0x23f/0x330
>>>>   ? rt_stack_deliver+0x340/0x340 [rtnet]
>>>>   rtdm_task_init.part.14+0x7e/0xc0
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/x86/hyperv/hv_apic.c | 4 ++--
>>>>  arch/x86/kernel/kvm.c     | 4 ++--
>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>>>> index 0569f579338b5..e7b2a57c720ed 100644
>>>> --- a/arch/x86/hyperv/hv_apic.c
>>>> +++ b/arch/x86/hyperv/hv_apic.c
>>>> @@ -115,7 +115,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>>>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
>>>>  		return false;
>>>>  
>>>> -	local_irq_save(flags);
>>>> +	flags = hard_local_irq_save();
>>>>  	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>  
>>>>  	if (unlikely(!ipi_arg))
>>>> @@ -150,7 +150,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>>>  				     ipi_arg, NULL);
>>>>  
>>>>  ipi_mask_ex_done:
>>>> -	local_irq_restore(flags);
>>>> +	hard_local_irq_restore(flags);
>>>>  	return hv_result_success(status);
>>>>  }
>>>>  
>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>> index 5df1061fc6ee1..b183caf41aa44 100644
>>>> --- a/arch/x86/kernel/kvm.c
>>>> +++ b/arch/x86/kernel/kvm.c
>>>> @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>>>  	if (cpumask_empty(mask))
>>>>  		return;
>>>>  
>>>> -	local_irq_save(flags);
>>>> +	flags = hard_local_irq_save();
>>>>  
>>>>  	switch (vector) {
>>>>  	default:
>>>> @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>>>  			  ret);
>>>>  	}
>>>>  
>>>> -	local_irq_restore(flags);
>>>> +	hard_local_irq_restore(flags);
>>>>  }
>>>>  
>>>>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>>>> -- 
>>>> 2.43.0
>>>
>>> Applied to wip/v6.14-dovetail-rebase already.
>>>
>>>
>>
>> Seems we are still missing this in stable (6.12, 6.1 - and therefore
>> also my 5.15, 5.10 right now).
> 
> This patch is present in 6.12 AFAICS, missing from 6.1 because of a
> merge conflict. I'll pick it after proper fix up asap.

Indeed, it's top of the 6.12-queue, and I missed it.

Let me see if I can help with 6.1.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
