Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261ED1AACA
	for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807357; cv=fail; b=tYENWKrCTJOWBUFpP4nhDsDcRzZT3QzpaWkV8pOTX6D6DcuzrDF505SDmwmLCo3oLvGE4afK7Xp5KptHXF0Dk3nmj2DQ0i9R0r0wlf0agRMfbvlDFKQpuG50Rr9F95K6BWGoDw68o55rhGcJfTvSS4ycPumL65TbVEoxfivx93w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807357; c=relaxed/simple;
	bh=E6fq8g42wGDj+E2w0f27PEE6zJYDaUh/uzlUDgufFM8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ihqO9WB9KuOZvfVNoaBUrR61k+C4gWz1g1SqheJFZA40NPPlZd8V7XPQU4cbXX03zSYVFr0r+Jtff27co9qBHQpH/wG1j3x5f2Rr+FVNy7sLkKLwNMOD1dCVUCmtwDVgx+UStShuqEmwtf0Bq6wVKQTwphl6ACWI2zGtNY97VVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XKOELXRi; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XKOELXRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPEIuEd9ScaWuPDHtlf4phQB1tRFkHtTcnnzdJxz9EUgU9lchzoDJGjjNdpSh9Ff1a5mJN8Ek3461lY/nQJJoCX0nrEgx5POcdKpwsdZKQJCw0hG/2clHGXolGXdrRTz02Kgc4R6XICB69B3EZudGDxgN3tQoz4PclT0rXfn+C80a4tiT8hH28VNYyjqoW6gsTH8DWOMRGll1t3UCjZiQmaCF9GZGeyJih0MCrM8RlcPFrKlQPQR2fDvmewNq+g5pxdFVTV/75jpo1afYlNyETjXnPFg+Rt4Ngkib9qYKeacaoAGxORfW/KyRmwv8RDeayMLIc1kcu/P7AZ/HQizVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsfXZeOEvDfmyVqQqNeBGPstd6KO5hbcI/ZVjn8LiDg=;
 b=cS3rbrOkWevtpa5Mxgp66ilanMZ53K/kJ0pxqv9xJqgvR2DG+LWOir7a7ivWDjGBUOz42CiJWc6Fnx4e9OrUq3KkJQaKAnz85htRR951ljX7pHOMYsYFWbB9IwiirtsI0m+c4mtvrv7kW+9wEDTUXQbSvd6zhXCi0ewycYZ5tsBRtl2Aipe1+rdQ7Dgep8zK7bevdjqGwTA5BSig1FkElwAw04y33BZoedhDQBrCYH4brh1/8qK7LGyFSxVTQ496PHp6f23GNUnwcuIFkb9JCbXMHfmgYs8XcKtVw6X1eso9OFWTJe0WbpX7Tjm33TkFUzQ9SttyndHPuTmR1/ZuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsfXZeOEvDfmyVqQqNeBGPstd6KO5hbcI/ZVjn8LiDg=;
 b=XKOELXRiUZ9AZ8Eiy/V5W7wQcXMF3sn92swqUjfUQkySCYOlZ6O6iFkUeQTFQGO81qXnBy6LSd0tzaCK3mHea8Hc0hNi8RtZimIS6AHDnW7c7HcOjE26FWhdRnFpL+mYfitf7RR74+m1o94loQXwVM7f10cwQOpQkwiuG5Suf5XLog5ef3OACTmj8XrmrIa5ZNIOtCjrINyvRwc3el1yAf+m+fPkzf2lpZR8AijPGr5ixgx3m4PU5G5q2ujUGG3HyJ/+WhWWUHsOcPq0a3CwHktmKbVMpQ5IZOXB1Zh4kQgjO9JLuJ+71KBW7oV+iNyJ0Uqrx86/e48aVYJsd39B8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 14:29:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 14:29:09 +0000
Message-ID: <ce3d9b5c-f9f8-412d-86dd-2d3579043359@siemens.com>
Date: Wed, 19 Jun 2024 16:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: EVL kernel config on x86 only for 64bits ?
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e363432-3cec-418b-5369-08dc906c2ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdYdy9paENsakdpK0NIeklmbXlnR2x1bFAySkl4ei9aNFJOZzlCSVQ1Wmdw?=
 =?utf-8?B?SnI5YWlmc2dFcXFlVERiYkw5N0lmNHRPcmcvaEZPd3V3T3oxRENKQkcwNzgv?=
 =?utf-8?B?TkRGU3V1WWkvb3haWDlEZWF5T0xyWDlrbHZZWGtGQkhyYzlYNDl5bjlzMFRW?=
 =?utf-8?B?SXFQMk1NaXBhQmtJRWFzTmZXNDN4TkxKUUtLRkk5V21DSC9IVzR3R0tZSEl1?=
 =?utf-8?B?ZG9pTCtVaktKSVdVSDNOMGhTN0RZenVGai93QnllWjQ1MVBhS1RsVzY1aXBu?=
 =?utf-8?B?NTk5YUN5WjdhdjlGb3ZDRU52Y0VMQ2tNOW1hdW84ZWlkejIxTTJIWWt3d2s2?=
 =?utf-8?B?and3Z2hYRXhZRmFWeCtiSVQ4UVhCNG9GMGJzTFJ3d1E5a2F6OFRlN1lPZjl4?=
 =?utf-8?B?QXJxVXg5SXJmSXRnSytTVldxUzF5YjBYSjRKcGd5VW85RXB0N2dZMWhvNXZW?=
 =?utf-8?B?blV1M05hcEtvdnRCK2Y4QklhZCs5UFlSUEN0blQ5dVpERXZaRUV5OVoyVk9O?=
 =?utf-8?B?a0tvL1lETzR1ZzBobWd4UnBpYm5QRGxhd1JlVXZpUUNxOHM1NU9KZG85NG5B?=
 =?utf-8?B?UXM3RUs4TDBBTFZ3ME9PKzBPN1JiM3YrV0Z3dUFVLy9DS2pyQllvZ3ZFbW9m?=
 =?utf-8?B?dlBWaVFUbG5PeTNQZ3VVTnV0aEJTZXg2WURtNTR0bVE2bWx1NjVCNFdtSXhi?=
 =?utf-8?B?R2ZWRDNNLzVUTlJ5RDh3cU4wTEE0ek91OVF0aG11QVk4Tmo4a2hWVHAvbVd6?=
 =?utf-8?B?NGs4TVFPL1FDZ0oxUEhHUCtEYS9zd054U01DazNhblhaeEtuNzgrbURlMkxl?=
 =?utf-8?B?NGUwdzRCbThxZVNSQ00zUVNmV2lUNVNFQWExK3dWdUZNWVBaUXJQaE9uejRZ?=
 =?utf-8?B?dlZVUE5BODdrUVNoM28xeTdTOTBEQmhOeUx0djl2WmNRQ0hBb0tVc3dUYnda?=
 =?utf-8?B?RWxUaGVwZ1Urck5IYUtYRE1FeTROeE1Ocm4vYUNKc1ZlY083YzFOV1oyV2pp?=
 =?utf-8?B?Q0VBVGxNV3VXUE9MVGtMNVBQeFVacHd4R2N6K2tZQ3M5Rk52bUUydldKcm5K?=
 =?utf-8?B?c1pEMXBXOTVHRzJ3Y2dLWGNnNVhPUWsxYmRCS2V1cit0djdRTyt4WEpBTVQ0?=
 =?utf-8?B?dUpwR0tMVEhDRTI1RUFramp3cDhhdXhjZ0JSaGZYSDR2UU11WWNVZHdVajR6?=
 =?utf-8?B?alZMSGNnRytyNGl4d2NKNW5hYzJ5V2hCWm5odjN5RU41QlJBU1lTeWYwOGZD?=
 =?utf-8?B?VlAzZTg4TDNkUEIzOWVXdG5rV3JKd0VqUFJ0cjlKbzJGNFRxdGg5KzNtMmJQ?=
 =?utf-8?B?SXlkcmpWR1FTSWRTeTQzNEdjVnhLV25SUmRhRTU2K1JTaS82OWFCRjhKQ0d0?=
 =?utf-8?B?UHEreVlKTi9kZWUyS3NNeTU0K1RsY2F5WC8xMGV1RmQzUXRNbG16YWNNTFdD?=
 =?utf-8?B?b05ZdVRIQVgwejVkOUtsSjFienp1OEl5ekRDckp0ZUdUMi9oSldERVI4elZq?=
 =?utf-8?B?alRmdzlDTzFwQkZyai9XUG9vMVJyNmdXWnQ4THBDdWV1dytUWFRDWU5oWmta?=
 =?utf-8?B?dEczaXRPdzliTlJHZWh0MVdsS0VBK0hrOU5ISWI0a1ExNzJ2YTlXaGVNbnZx?=
 =?utf-8?B?VndqT1hXRHZtRmFPbTNlVGFUQSt0cW4vTVl2LzBDdVlTV21GclM2TmlxMFZq?=
 =?utf-8?Q?oi2dz3foAei0rzYv2Wbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2V4QVZmbFZOZGpWMkpGN25yNkloWm0vSjVRSGVxMjhyZmFRSy8zYU1xNldp?=
 =?utf-8?B?ZGNxb1hBczBUWWp2ZDRIdVpZWEVocSt0TVA3bXZTMVBrY0lDdXJPMElVbFVz?=
 =?utf-8?B?MUR6bE5OLzNNUnE4b2dEemNTMC9HQXRzcWg3SzArUE1VUThjbWxsQUNCYkhH?=
 =?utf-8?B?MDhiQnB0eUs2dFBGZXRQRy9IVFp0M3lQaElvTVY2N3R2WS8xd3A2LzVWOTVK?=
 =?utf-8?B?bFQ0REw0Q2grelBsblhtamlTQThBMk51T2RwMGpxRDgzMG51MzFMMEE1V3lQ?=
 =?utf-8?B?MGFNSFdtaWhJd3J3ejlmRGw4Y2ZNTEZld29ob2NyQStzcDBkcDBtYlArTU1o?=
 =?utf-8?B?NCtyUUlQUUo2VXV5T1pLRmI2SUFkMW4rUitTZ3cxUXNqSm92T1owRUNqRG5L?=
 =?utf-8?B?cEdGVFdDSFI4SzRSMm4vaFJjRlVJNUNPUWZPRzdkTTJqQ0ZqMnRIZU8ybHo1?=
 =?utf-8?B?Ukc2cjQ2UmpLVDEvNWhPYTM3RlY0TTduLzB0WENkVENaN1A2bTl1QmRUZkpM?=
 =?utf-8?B?T1RraDZLUXZjeUxkQzJweFk0YitIYmthZ1hKUndjV2g1eFJ2YkxaZ1B5enZS?=
 =?utf-8?B?bFZxWGsydmJVbmdPTDc2MGNNM2pzZ2E2T0JXWTVBNnh0dUpmdVFLZ2JFdXhG?=
 =?utf-8?B?RWt4NTFqKytmeWpsUFJtOS9ST043bm1oc1dZaGk0WUR3dEJzWllsbjBTSXJZ?=
 =?utf-8?B?ckp0K2JhUTlYQW42aHhBMklEaHEraWpZeWltcys4Qy9tM2dGNnJMalFHMEJ3?=
 =?utf-8?B?NG1aV2xsaUh4K3Z2Slk4bzF1ajNuMjZnLzdUdzhPdlZBb1RhWmVPYS9EWHJo?=
 =?utf-8?B?Wk9PdXhGUnc5VzlyT0VuMkR5ZUwybUtTdXNQMzRyZWtjVitCaVlOWUQzYUZo?=
 =?utf-8?B?M1lXVzg4UHRpRThldzBhS21EelhzeG9qWEZhNWZJbjFCSXBPVkM0ZWZpZFN1?=
 =?utf-8?B?MzhTbUluVXpodTdYZWFmQ015eitjbUxXaWlZOXhwKzN6amVkQ1o1d2QrNEho?=
 =?utf-8?B?MS9mM09pRmw2RWNFOTVtVE1Pb1dvcjRYYStLQnpCTk5wVGtZQU5qVk16RHVT?=
 =?utf-8?B?Q2xDTURoTXpZTDRUWjVmVVN3NXprMG1QaGhxY3QvTlEwWlM1ditvVEVTTEtX?=
 =?utf-8?B?Njc2RUQ1SDFWL2hnbzB3dkE3OVRLMXBhdk1RZ0RHOVpGbHB1SGZLMzJHMTZm?=
 =?utf-8?B?UU43UWNRTENMK2xDMFI3NFNsUzk0ZVJ0R1luT0ZBazB0NjU0NXNRU00wdFYv?=
 =?utf-8?B?MktSNGhVakpvVHpnNWN6dXd3bzg5bkVXTlFJRmltTndnMGVJZVptYk5jaUxF?=
 =?utf-8?B?ekpUOFNYOEhpU01xcXBNYTFiWGNocVFXVkg5MmhaU3BaMUQzeWdrNlRNSDBR?=
 =?utf-8?B?RzIvVjBqRkd6enNJN1pGUWFTc3FmcnJvdTZialg4d1BNQ0xsa3g0TkFPdmhT?=
 =?utf-8?B?eC9WNE5rM2NTWWZQdzZCeHZKUHJMb2ViQmJyTzIwVTRXOC8zNGVLVUNXNTdl?=
 =?utf-8?B?UjY1NkxuUldBRlFIdkRGUVA4NVMxd0pVRFRyLy9TZ25kZVVtcWRKNXNDMTNy?=
 =?utf-8?B?TnJqNWsyRU1BRUMrRFdyRHhqdk0vVzdLdkF3MHdRaVhyWjBpYnFmQytFYkg3?=
 =?utf-8?B?cE9jalQxeHlhYVF5c2dXK0VxL2RNd002UEVEVXNkZDk5bFB1dG5tc2FoNmYr?=
 =?utf-8?B?TGkyMlI5UXBwYXc4NTR1N1ZOdk1zcVVHaTJwK0JWNWphQ25rM010aFZxYVlJ?=
 =?utf-8?B?bmNuSmdTNllmUUNqSGlJSWtidDVwMlNUS2FMMGRyb2FlY2dpdytqWTdESHVx?=
 =?utf-8?B?YUVUbXl1L25Xcm5rd2hNVW01MjdiT1NDd1NiaGVDRVVMbkNueUdYT0RLV0Ux?=
 =?utf-8?B?M2NyT2Vyb09vaktTVUNYaDJuSDAwSU1PUTczRTZWNDBqalRXMkVPUC8zQytr?=
 =?utf-8?B?MHE5eFMyczNDSFd2cHF1bFpJQkk5QVBqQWJvRzVqWmlINHBRaHF2RmZhMVhQ?=
 =?utf-8?B?RjVIZU0vQW9zT1AwUC9ZU3IyczRYeGtLTGR6SFZ2aWJSdVdXNW02M3FPRzY1?=
 =?utf-8?B?SHJKblVzN0dyelRGblhrSVc4WkpIR1ZtZFh5V3NsTHNaRHFSeG51R0FhVG1x?=
 =?utf-8?B?b2F4bjNaSHFDcW9jQVZiT2lXRytUemlmcTkyOTB4WkllMFdlbmxFZ21kMWht?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e363432-3cec-418b-5369-08dc906c2ee4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 14:29:09.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rodkGO2ctlw+pYkY67h9YRb+orn7fwWrY5CaWW6nhCfIQ6OJYAI5PEsWMI8F5DPTqj6wfgNhwjTNLG1uaIoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8140

On 19.06.24 16:13, LE-DOUARAIN Marc wrote:
> Hello,
> 
> It took me some time in kernel config for x86 to discover that the EVL_CONFIG menu is hidden if < 64-bit kernel > is not checked.
> Is EVL for Xenomai 4 on x86 not compatible with 32 bits processors ? And Xenomai 3 would be the only choice available.
> If it is the case, it should be precised at https://v4.xenomai.org/ports/ for x86.
> 

32-bit x86 is processors are history now (no longer in production for
almost a decade IIRC). 32-bit-only x86 kernels should no longer be used
for many years already, also on 64-bit CPUs supporting 32-bit modes
still. Use the compat interface in that case (32-bit apps on 64-bit
kernels), but that is indeed Xenomai 3 only - unless I missed something
as well.

Jan

PS: 32-bit is on its way out from the silicon as well, see
https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html

-- 
Siemens AG, Technology
Linux Expert Center

