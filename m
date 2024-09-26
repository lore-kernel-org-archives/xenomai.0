Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C452F88
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358310; cv=fail; b=HERBp6QPV9LkeAFDlj8w6MA6RK7IGTCMjVlv4WdFqO5o94fvKx9pq0YAH1lHTBmJB+dy2Y4zdk+POaKuAvrk/qJZa+dHYJmPFhN+E6v8KZNBQCycfQ77y2XGOU3d8ueVXbNB+GsGYVPDwkLs1Ym3P66pOCQ6FOl2LEvLZl3N65M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358310; c=relaxed/simple;
	bh=/Sxvp8LYZkqykcS6FxWBPxrP/0AKgjV+HYl83F9SyjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7/Vel9d7H+o6B4ASrZG6v6fdaDuTAqytmGnlZPBiaqNwBytyhaRdsw6zgSQDizq1CShtSDS4OKr/WNQrkUN4sFpgm9EWk1WNjnRjXaRMeZNBSP5fZmdtEsJSRTsIKVY5VV0I9MjnC6yLl+k/DDzZyCxORtxpuZW2FtKc0kT76E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BP0mYWf7; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BP0mYWf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ispwUBWf98eZGnRhQ4l6JIY/FvBFW3J/LE2njxGpFzjKk8KWj7sgbeejitzb7jZPb+INu03cBVI7IbS9+chbQH4GB1TCxIevhmzqV3CZfHYmKGGMoOQhRmLJQOabZATXiFevk9u2LqDcqCEWLp+F7MK18LEaQKXHEU7M4ao6Q8zR27yBiK5w2Ne8/PE7vfO5FK1UKQGeIIM+/GQZjy0NR8C95KaQ5dLJ4NcZbw5oT3iOQVuCMg/5vtorxqXDy+IrsjPs3ZDjE9CNzi5agTkPsjagwbYSFMeZY9/a47xAWoc3cN0Yvt2gdVaHpbrpWyYvS7yXpQy4bmfo7YBcUwNx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg08fKtVnI2QXDeXxYlVRyVlffIUbY6gEEd52mDvpyE=;
 b=Q/B+MGzBIfztO8ehpDPBW+FxAfscGvp2phwzX0KObjyf6wiPCPurfRlxjDcGDOT+LUQR9kPiA4xrASAn8R8VGH1jLaNc98yQbotE0xW5PVQMwbMEOzBFoB/uKiBqpJiygZRNbwxS4H/g4T6dAef7XMMLJ73XGiuPYglT/K3lFzdNNUTJ9ebwRmym5unP1Gqm3ZVwr9JNlQcL4b5WZkDexPBFAkHGs0m3hfCmlqi4WT0Whr9bY5Vcg+ko2cVBAfvuVY5UU15yycwGVWtMGSpQiNZf6dqrUky8DOIzv/mQM2G4sMONvFdbcZCdNOuoQLcjIKpRU1zooq1xuep49/I3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg08fKtVnI2QXDeXxYlVRyVlffIUbY6gEEd52mDvpyE=;
 b=BP0mYWf7FNd8yJptqMAQ+H6iW418NWY5MfbK95kFZhU6LY/Lb8iLBvU1gzDUFqearNRl0aSU+ET4oSC5rgPKlMVQH+ISs3ZZESPYZUwrU7WaApnUr3BDlnvDNZPRZlNurVyWZZZ7dG4DNRLb8melS9ijbcSx8PHCbP0Y2frT70L09MOc6bWIPHigI+IN6zDEJhSkqfGOMuakr479jGrTuisq2eEOpNzOqP8Gg6EiNKWTMBf8K+dZWE6zY4DuBlyhoLAYITqum3c7lwljxhRYpjGAdOwDq9+d7Tr62ip7niXfzokbsXTG7OgH96Je8ECNM6Egmv4kSUFuUo6SRUaaXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 13:44:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 13:44:58 +0000
Message-ID: <a993c124-6d31-4507-a942-f6df2e1f0920@siemens.com>
Date: Thu, 26 Sep 2024 15:44:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Get wallclock time from rtdm driver
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@lists.linux.dev
References: <10db-66f55280-9-49b09a80@50985091>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10db-66f55280-9-49b09a80@50985091>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 75647825-3bda-4914-4bca-08dcde31692e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWhIaUlCTmlOdjluQkFpU09seGdKak5xbGE5VUt6TjhtSVJRWTVoYXdCS2Vs?=
 =?utf-8?B?ei9YUWRTeGdEeXJxQnlEWXI1ZVpNMlRWQnlKMXZqMGFkNzFhVkkwNjRLUDhr?=
 =?utf-8?B?TG1mWktINTljalBxNHQ3MElSN2NrTzZISitVSUkyQnZxQmQ4TmMzRmxabHpW?=
 =?utf-8?B?TkdMS2JaalpFVUlobFRVazQ5WlpkeXlPRGMwRkUvQVlzV2hjMGppL1E4ay83?=
 =?utf-8?B?b3oydFRGUDN1R1FWOFpGVGxrenZIVjhLTUpLQWZtMXdwUHJYczdDdGJ5K3RF?=
 =?utf-8?B?dUxndExKNksrM3VCUVpjZjNRUjNwZ3VkNGg0WFdiRFZUeFRJVGR0VythbWUz?=
 =?utf-8?B?eTBaa0g5Z2I4cmd5VFp3SFpvN2tqVVE4cjJIRUtGa3l4b0NyMXlwMkNVVXpq?=
 =?utf-8?B?UStFcTd2SWs3bEY1eDA2OWtKT3BJQVpjR21XUzFmaVZ2NkJEWVpCYUpweWZp?=
 =?utf-8?B?ek9UT0U4MWhMeWo1UTh3UGdXMC9IS2xHWm1zbWtCRndsZEZabGxjdWJxek5a?=
 =?utf-8?B?Wm9HTlZWKzRyeVlwYlVreHQ5a2xHTTJYT2ZBbGl5Sm84bnZad1dWRDliS2dE?=
 =?utf-8?B?Ny8yKzRMUmVtbHZaekcxeFcrVk5pVEVlZjJQR0hUazZlSXlaeUkrZWNpeEM4?=
 =?utf-8?B?bllVM2tIRlJTN2tWeU9uZks3YXhBbjhUeGtsUTVaNTVpRmxUcTZaNmZLSDV4?=
 =?utf-8?B?cmU3TDV5WEk4cGlHUWJsa0IxVzJEZWlOR2orcndTZS9HVC94bHRncVF5bnNO?=
 =?utf-8?B?Ukpvd3JEeUtOaXArSlczQkNXR0F6WHY0ajVuU2FXVEQ5VHE1bk54L052aS95?=
 =?utf-8?B?dThOVWF3TVVSTGlFY2pnc3Yvd2xuaTEvRElacElTL0pYZHpsT1NsYWhCSXVl?=
 =?utf-8?B?U1F2S3l3MnJ2Tk16Y0VvYlM5bkN1Qmc0K1libkpxWHg4NWtZRVVjSmJxUlRO?=
 =?utf-8?B?MzFjbVA3dUtsdVR2QjdZejZzMVVwNlFibDhUbjV1WXlMVlBRaHlXTFc2SUtK?=
 =?utf-8?B?Rk0rMWw0Qjd0RkF3UVhoeTJIcEovYVRDRUU1OVVPd3k5bW56eFRsVUo0cFJZ?=
 =?utf-8?B?WnB4QXJLeEZNVlNRS0xqaHNZVm9VTjR3bkIvWXd4TVVERkdHM2p3aENPRmRV?=
 =?utf-8?B?ajY0b0Y1MW52UVJUQXJUMnNSdENtWW4vVys3elFPZGFsbzFrTGxLRk1TcldT?=
 =?utf-8?B?aWNXNWlDUHBCYWZGQ1dIcytmbEc0T01YZlY4LzJoTUtEMVBxUFBZUktKNGlG?=
 =?utf-8?B?cVh4cUlLaVJ3a0dwejg3N2RtTmMydTkvK201cDhGaWZmZm1LcjlzYUQrNk11?=
 =?utf-8?B?c2dDQnlma3BrcEZpY0ZoOUJxeENibU44NFVRUjlWSGp0dmVrbVA3ZmVaUlpW?=
 =?utf-8?B?SCt6S3o3MGUwY1hmdS9rd0tiTzVYMTdGR3VHU2d6ejNiY0dPc0JMTm5yRVpn?=
 =?utf-8?B?NUEraFJqUklxbGkyR2FLcW9takpOWjZtMXVSc1JVUnFSS2hpQ1Jua2ErVGtI?=
 =?utf-8?B?RHp1bjl2TGJ1UkVqa0Z6b2cvenR4Z2YvL0YyT1lsaVA4M2lxcjZTZXNSeWYw?=
 =?utf-8?B?ZTdlbXkzcFJUbndlQWpUc0kzamJNWUticnZzVlVwcDJjN0w3dldvdW03NTFm?=
 =?utf-8?B?VDg3T2Q4bUJ1VndiMzFaTy9ZdWdkUkpDYUVzMEM5em1NMFFOMVE2RkRiTWYv?=
 =?utf-8?B?SitDZmhGcFFKYXhaWkRuZlRGbHdXbGgyMjlycHkyNjI0OHJKMjZFcmNZSEFX?=
 =?utf-8?B?azF5aEwwYiswVkt4SE8vRW9ZaHg5YXczWHBDbUxuaXB1TG1FZXE4MytOanJl?=
 =?utf-8?B?TXNuWlIzRWk5V3N0T2Yxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhYZTVxMzJBcFJZR1hyYzNtUk5XazBlaHFja1lnWlhCQXQvamNOblNwZHJJ?=
 =?utf-8?B?eEVDbG5ibFlBZXRIRnJlRnZMbzgzeHZ3T1V3bE05TUFCVHN6dlN0dGx5ZXFh?=
 =?utf-8?B?SnNURjFTN0kwTjVZdTlVT3pTaDdzMTltNktsMThiY0pONXFDaklRb1dCNE92?=
 =?utf-8?B?RGdFTGpRbGkrVUZ0Sm1Xd0dlNFFmRW4zZmE4ZTJmZzR6RG45eVh3eWdVdzE3?=
 =?utf-8?B?clVGREFiaXpvaFgrMkVpUFVhNWZQNzAvK0E5NDRMVnBZS1ZPejRXeTZ1OFdy?=
 =?utf-8?B?SlkvUmdvbFU0RGNCWVczdWNGbTI0Z0VDR29iYUQ3MitjSlhCdDN3ZER3ODZ5?=
 =?utf-8?B?WWVCRm9URDNET2cydktER2xpSnZQYm9Gc2tyVDlaRUI1emxwNy9MbjJrcjBS?=
 =?utf-8?B?U2Y0ZW1NS1JQUWt0WU45Ull2dDMvUitlNXo4ZHNKWTJ2TUhPRGROOWpUYXJp?=
 =?utf-8?B?c2EycXBoalJObkNzT21rUVE0ZXFhU1h0alNpeXl0dkxWUnppMjFGeTB3VVRa?=
 =?utf-8?B?SkZtM1lsMDVLTm9rUytQQThIZUxPeFhFbGJqMUZaa2NlSzYyTC9SQmNXcEU2?=
 =?utf-8?B?Ym5MWi9zUGV5WWIwb01zM0ZId3pDalJlVFErRFlpRGN0a0E2TVVURlBQQW9i?=
 =?utf-8?B?dFVXUk0rR0NySGIzUGFrMlhiWnMxY3M5VzFGQmthNEJRYkZ2N3ZqdnE3YmVV?=
 =?utf-8?B?M2JvS0JMV3pUSnhLaWcrVjcyc0xXWkJYRlFYWGRJYURqaW1KemlFUjBVTE9D?=
 =?utf-8?B?b2s4bzBtYVAwMWMvVStPUUVrNk1JbmkrWmxTdXJocmxTSkRrZFJhQWZINis2?=
 =?utf-8?B?TENZRFNZai9XVzJ6ckF2MG0xMWZVcmxHUmlXYlVnT0Zvc2dibUtJMVRWb1A4?=
 =?utf-8?B?SGxQVVB2MTdLdW1lWVpDQTRSdFJPQmNFeDFmRE9sQnZXdzg4SzVMYlF2V1hY?=
 =?utf-8?B?UFYwcmRCeVNiNkpPMXJlcGpndkFxZVdaR05Lc0ZPc2hVYXAvbmFCOXJ5ejdw?=
 =?utf-8?B?WjBsZm1SSTNQb01iczQ0Z0lQNUhsTk1BVGp4SG1TVWhUWXpUc25pWnlCcmc2?=
 =?utf-8?B?MnBLYUZmSFFCVURqMlZZR05QOEdST3pSZWttekRZVGp3SFJGeWN1SzdYbjZC?=
 =?utf-8?B?cjhCWnIwUHRPQlNnc3E2TTdQd0RpNU1kcDdvUHlIUVc1SWJhMUc5MnVqSWhU?=
 =?utf-8?B?N0VpVHdUdmIxWjFwZnFMNDlNaU5hK2diQ3krczZhUzlvWC9JWmpIYmREc0Fu?=
 =?utf-8?B?YzlKdjBhQkNGUjhNV2pQZS9aZ0haYWlFd0FUMXNYTExrQTdDWjlPcFVTMjND?=
 =?utf-8?B?TnhqUWRtcHJuY0lpQmZMYkp1NHFicDRPaks2Q3ZmUWZUQUIrVi9NalVPMUg4?=
 =?utf-8?B?aFg5WnlhNHFZUC9VbTVNVXhqeDRpYUdZSDMyWGpuOENZTUtzU1RDaC9aZFVT?=
 =?utf-8?B?RDN5Rmdwa0VrWDc1eUZwTlh6SnFQRGlUMzk5eXBTSkZMQm5Zc1VuSkV2M0lj?=
 =?utf-8?B?QmNsNjl1ak0wdHg3NzhwWFo1L1pCNDhscGR3UVRvdXZlMDlQRC95Q3BnZEJ0?=
 =?utf-8?B?NHF2d3pMdTRJWjdZMzZLVXUvVTB0VjUvbndCbHJQNU9yK0JEMVlKZGJ6VEF3?=
 =?utf-8?B?eGRZZDBCNitFWXNhaUhQYndTbzF3MGtUdTFHR2R4SE1oZjQzUnN6TU1ydTNr?=
 =?utf-8?B?Rm40WGlXMndPeHdZRjU3TVB1Q1ZBcndrNEtMd1RjTnhIOGFYa0cyMk5KMkx3?=
 =?utf-8?B?cjQ1bTVwSVpEZ0tqcVNNcnovWDBwN2JhQ0t0ZU1QTTF5UjVVL3dPOXV0ZW5l?=
 =?utf-8?B?R2d1TFRTMEwwZ1VDbE13MmxnOTVuNkZ0eGlaRHZuUE9nNi9SWDE5aXBkeGI2?=
 =?utf-8?B?VkNJRnpUaE9MbjhTUE0zeFpYSnZjYWw0WGpCOWJpaXVKRFg1bmRORStPOXBo?=
 =?utf-8?B?TVorSlRrbFRuQ0NvRTJ0RjI4cDlLc1dhNys5bllPU0VZeGpiSWdOK0hlNTZH?=
 =?utf-8?B?UE1GbVc1Y1ZqZ1l5Vi9VZTRTeWtwLzE1RzlidVNLOGZBOVFMVStuWnF2R2t6?=
 =?utf-8?B?YjNDZTFFelNYSzJTRzF3YWR5OGx4eDV6N3Rpclp2aEJWNjEyWTdSNE5kWVV4?=
 =?utf-8?B?T2FWVE5qRkZTM1BhUFpXUGhVRmlCbThMNTlmNHYrN2FTbmI2dENJZGZ5NVJ6?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75647825-3bda-4914-4bca-08dcde31692e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 13:44:58.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqZtZce31GJ+XXq4H/3wiAR1R3u9a30Fh+FTK2bC16I4YTCpiy9YBLo2LoylLBfe4jszp7veI8WRGaCYL9gzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6970

On 26.09.24 14:24, François Legal wrote:
> Le Jeudi, Septembre 26, 2024 12:51 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 26.09.24 12:03, François Legal wrote:
>>> Hello,
>>>
>>> in my driver, I need to get the current wallclock value. I tried rtdm_clock_read, but this seems to be the boot clock and not the wallclock (the one that is updated by ntp/...)
>>>
>>> What shall I use to get the actual wallclock value from my rt drivers (the equivalent from clock_gettime (CLOCK_HOST_REALTIME)) ?
>>>
>>
>> rtdm_clock_read should give you CLOCK_REALIME, rtdm_clock_read_monotonic
>> CLOCK_MONOTONIC. Which version are we talking about here? And which kernel?
>>
> 
> I'm talking about rtdm_clock_read. What I get from that is about the number of elasped seconds since system startup. Not the time corrected from RTC or NTP.
> 
> I'm on linux 5.4 Ipipe.

Then you need to compare to Xenomai's real-time clock, not that of the
system. They were decoupled with I-pipe.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

