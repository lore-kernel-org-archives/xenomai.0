Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3171B0136
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683368; cv=fail; b=tDVXZJnA4Ho4w0sxJ3cZaUnA4lai7gfdVvniqarHJrM5yAQh9+z0GPSxU/aG9HeO41pKqzQa5XsthI6AiaRNpjuJbFdBj63G/tNHQX7Y8VXy+Z1gtB8U7ObF6oVAweSyg3Nn8EulsLT4OKkXeil8NvcCknA5IoR9butVpbWuBoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683368; c=relaxed/simple;
	bh=YLqLanG1TxyHXxAz0uWX/wcXUzeXk8dBzpDPRKw+4uE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpQBIt402lGwtSqmT/md6omMoBqNzVCrcEDmpOW/DDWsBocKq+JGI1fEROPmfWlew6JwycHo6AcMjajCK3EwAcrUC5i37lF4pskVCzxk6ShGxTFctYVvzlD05x/0bH9Y3VWvOPQiU/+JepbTFvzUSo36jVE0ZrE3kJTKT0Z5nyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gbTh+m1z; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gbTh+m1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCTKKss36hMVkyy+h3PQz3vItce3Y+ggM1klYuMAmeY7bNB22owy12/X38hzl3a1EeoE2BnXJVF8l/K9q8mMFbPEiBRXcuXULsamufsLtvZjGa+pzmkjQeXJ4T+Rugd/Mn3fho2lYegDbsvWNKCGOqdFn+/J6SjDyoA7PVCH1bGzneRN/orUcTbZcjqe0k3hk81wxg3U7wba79PTjkQlk/blgv4sknINpK/JPjsNXA+msFeCk2blFNJI7Ehld0v2KmuE/G3LUhK3U3KoZLasCeFZdPRyuQGcamwjRiCwZWL1oU7QCG8bqFdNK4NzixRUxOStBRqwakGl3uKUSfLSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOvfpgwTIjUZL4dxw5taaVY72I5Tfn5s6pArGIrlsb0=;
 b=mylWDP11p1R0zGzDC5S487qEUUFHa+bc+5+fTXPj5r8bgrDW37DjMHEYKxQVlhLs9lhyUYc/u03BczipJ9GbHNrs9R7G4XU6DfDLatXt3OLwEKDITH6Wpt3KHPVlgJjFr5q9v883wkaJKbV1V+FHxm15FLh+EFD7hp6GhQHZh86xHaYA+ge0ALU/odG6gL6++BLFERRIHVkq/Y5XZd2DYlSGDfAFifC2pEA3kdFzPu+uXcZLsZhknOy1WpdF/QxKBhc9DOKTeJfAg3cKrqD4r+E91gLb7nJmaio/3nk242uNMbC0cnWNEcefQ97cSFa6d8BGeOO/wnsDFMqu4DjjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOvfpgwTIjUZL4dxw5taaVY72I5Tfn5s6pArGIrlsb0=;
 b=gbTh+m1zUOi6BOUP8sxsQM3FTWeTCyVmft0BC8Iviuqmb6dm3yhBMDrSXxWjkgVi7gjWEfTDp2C21bb+YI5NDA1x2c6+8UufWGFfK08YmIrXFsv0zaRXAVW3YbGlfU5mpV5q9b10Jt18hBQEk7E+k9AY+qlWiJidfRncH/2RyP4glFNNsLobLf9lRSzyWODdOpZKUfjkKB06mC1qClwHsRUk6GvugvEUrt6H+jfXTo0YL2wWmcCCQzjLKmK6yo0eY4GBcwshj83exiZuxBZNbQbv1ctsDX34Gy0jcB62kZrqszsOsLWoPmyvVO/3DNGHrgSWSHuBU6IqlIb/h+mKog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6450.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 14:15:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:15:57 +0000
Message-ID: <1e7424d3-7063-439b-99d7-1f9b1350ff4e@siemens.com>
Date: Thu, 6 Jun 2024 16:15:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] README: Fix links to documentation and tarballs
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240603083136.1691504-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240603083136.1691504-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bf4534-b81b-4a2c-4fc0-08dc86332f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJvN3RoOGZqVkorb0ZpbGpuUjZQYU9XeVpqR1pOc0NDeWRXL0RHQUNYeVZM?=
 =?utf-8?B?U3dDSFlJU1VkejBSOCtBd1BzK01vVFVER043dUQ1ZmhzeDBuMitqQWxDQTVF?=
 =?utf-8?B?bml3Ty9XcDFaK28rMkhrRkhEeXRiMkpQVVg3MmxZNDFxMXNoWWV4WU90VjlO?=
 =?utf-8?B?STRtNTNPejZqWGo5QmZnczloZEQxSVJUUUhCR1I4RkpPeHh3T3hidzMwekt6?=
 =?utf-8?B?dmVSUHpXejcvN1R1Q0hnNGx5YnBydzkzeUFSU0JZb2tXeG9NUGl1RFVBTm9U?=
 =?utf-8?B?Z0I5OWhQRlNJemxBd3RGYnBEczJIRWVJNy9CMVRTZDdNR3A3NXpjYy96RGoy?=
 =?utf-8?B?RXd3Y093U3ZOWHZ6K3I2dVdxSUNNNm1yY0ZoUDRidzM1aGJQVmJXQnd0MWxp?=
 =?utf-8?B?UkNiMUY4R3JLbGJUMFBPU0pkMkZOZjdmcjF2clN6dERQQkFrdGZCV3o5NVd1?=
 =?utf-8?B?TVZYOEN5eDZVZEQ1ZnB3SHdlcU1icGp5Vnk0ZFpiY2x5eC9RS29KOHAxYWgx?=
 =?utf-8?B?cjVKWGdjb0ZOMnFzSUIxQTFKSTQrY1dNRDdWN1RlaGlxSllTZExtSm1PVnFl?=
 =?utf-8?B?UnlKV09JakRNeU1ic01qKzdSS0JhZVVwOTVXZWsvYndyeGhuUU8zdmF2REtw?=
 =?utf-8?B?OGUzelpGcDV2R2xZWk1YMHU0czE3NjdTZFlwa0srOVBVVCtrNndVTTBSVmpL?=
 =?utf-8?B?bkZsNlRyQ0pBM1ZjTGdMWEZLSkF1L0V3VE9WVDJtSnU2a2FITUU1L3lHNFR0?=
 =?utf-8?B?R2ZlY0czVFhPU2dnRUpDZHFoZVhWeGdxZzJNK3VJays1WUNPeXRBTXR2c3hn?=
 =?utf-8?B?OW1hVjZpb2NXd3Q4eGJkN0dIWTkvSVJzNWx5Qi9XRDNhU1JRTVYwY1FFOWRH?=
 =?utf-8?B?VTlCWlZDOUdvSVVpNGNxbW02VFFIOUZpWW9TOE5oQ1I3MERnazBtZU0vOFBq?=
 =?utf-8?B?V3ZFQkhwWTBVdThjVXFVVnlzeXVETVI3UmZ5Qm9OWG5jcHZBMlZxYVpCMXZZ?=
 =?utf-8?B?QUQ2OTdBRndvUFBXM0l5eld6bkNPNWFRa1BBeVJ4OXZNaUw0cjlVb2JITVZM?=
 =?utf-8?B?cFRVcVZPQVRkNzdyaFQrbmJNaVgwc1lmT3NKT1ZDMExMa1Q4bUI5QUtKK09B?=
 =?utf-8?B?cGY4OVlUQ0dvODd1SXR4aW1ROVR5bGoreGE5OUZlQTVWWVY5cHArRXM1dVdv?=
 =?utf-8?B?R3ByZVptQ0xPbFRzeUdEWTRUb1hzWkVMaW5rbWtXd3hxZkF5YVIvazQ2eXhV?=
 =?utf-8?B?STBKTWNSUGhycG80dUlyVHBlalN2aGVVRzhoZFdPViswRTZRSUdNWjlpWVNh?=
 =?utf-8?B?dDZkVTBHWEFuRFhxN21wOXBlc3p5V3VYY0dxY2VtTURRSmtHRXpCZjVETlZT?=
 =?utf-8?B?aXEyWS8zWE5GNmNnMjlnbjI0dzNGcjVoSENGb3dTY09kYS85Y3dSKy9kOW5w?=
 =?utf-8?B?OXF2K0VkV3Jld05MYm5YZ1BZYU1wdjlzc2hRZkpNKzEzaDBrakpZQWpVYXpX?=
 =?utf-8?B?eTBtZXFNcU42WTQxM0VBZFhSYnQ0ZjVOcEEzSDI1dUFhY2c3KzhIdytzTjVP?=
 =?utf-8?B?V2l4QU90NTFvNTRibzR4S3Iva2NKaThpbDBrZFB3L0JNWU1FaVNIbXVlZ0I1?=
 =?utf-8?B?aW0zWWg3WWNDb09QeDVrcGF3UzRvZWlxekw4eWhFWkVJN2t1YlFJaHhwZkI3?=
 =?utf-8?Q?7190Bk4ux6TAlzD8Y7Pa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ZrNk80d29QUk9jZDJGOTEvT1B1VTVmQ0pQeTZiS1U3Szkyeng3eXc1ZVJD?=
 =?utf-8?B?bFFCa1lJOGt3Q3RRL3VhU0VMNUkyZXcyY0dkczRvZm5Gc2RRSVJ3VGovY1M3?=
 =?utf-8?B?S0w5cDg2VzhkaGVUdVM2bUhxaFd6aG1vbmE0RnlrakJyU0JoNnBmNk9QNEZ3?=
 =?utf-8?B?eWdUZDZPaFpUTm1KOEo2dlNHNEgzSTZyVUpoeW41c05sOVFlRFBKNGNZbjBs?=
 =?utf-8?B?eW1acm5VVmlMUE1TUVdnUHFDdEU0cnI5WUEyUm12NHpBVkMwQmtZMmY3cFFE?=
 =?utf-8?B?VmJVajJLTUlZZ2Vyb2haQkxQOEc3Q0J3L2tYbE5mSmlDb2tZc3dLQUtEYVl5?=
 =?utf-8?B?dFRYWldNMVpZRGVoWnpvZ3hKcUVyWXhBY1pKZkZaOTh4QmZFVkd3emU0ZHU2?=
 =?utf-8?B?N3JmV0d0b21CVEdXaGx6ZndzdngzWDlaMkduWFdQeVlqZFJRbE44YlgrNGRn?=
 =?utf-8?B?bU1PYzEzMzBkcXFuQkVjOHE1bDV5bkV0Yk51QlBBRTEvZkMxMFYxM29ETWxK?=
 =?utf-8?B?T1JvRzRHTkNVU0tqWnZXdEpRd1Q0cmRUb3VuU3VGU3JHQXZoK01ZbXBRTUxu?=
 =?utf-8?B?bFR5SzROTUYxTmFzUlc1NzRvRjY1TVU4bWx2dXk4Rm5ZMTlVc21URjNlUzJZ?=
 =?utf-8?B?WUUvYnlFS0lBWHpqaHEyNWZxRXVSZllwbldORXhMS2RzZmpSMHZ4VUxBQTdo?=
 =?utf-8?B?YzFPUVZIMXhrQjUzaGs2eWVFZE5jTTUvKzVjTCtSK2hlM01VOFQrcm5XZ0E3?=
 =?utf-8?B?cVdaTW1BbC9uZnh4Yk42Z0t5ditubGVoV1loc1cwSFFLRm1XbVpMN1lLNElO?=
 =?utf-8?B?amk2VmNhTWdXcVp3N1NVWU9wRFpLSSt3K3VIRlhMYkovUkhYaDhCYkpGOWti?=
 =?utf-8?B?UkZoVlIwbE5MSGJscW1LZCt6WW9tNFlWTm5Tczc4cDJNc2liYjRZbjJNUDRI?=
 =?utf-8?B?MzA0ZGtWUnFSbjRuckUrWnA0WlNiMExkMjlKRkZsQ25tNzRLclJwcWVrbFNt?=
 =?utf-8?B?WTg5QktPN1NmYXRaaXJiVnNUMXljQzFkeFZ3N2p5WlF2Smhxdit3eFRTanhi?=
 =?utf-8?B?Qy9BWXdEbEZHYTZFZGtUOW5TRnp6YUM0cmVaeWczZDNaYStpVzEyOUFNTGM4?=
 =?utf-8?B?QXVIRGhWN2lsZkhIczBJUzUxZlVuZVNKd3BPQkJYZDNGVW1BL1VITWxtcXNm?=
 =?utf-8?B?bkFRTkFreXJtbCtualJ4a0FuL0NnK3dkWHo4L2VTcHhKUnkzcGlQZjh3VGFK?=
 =?utf-8?B?bVZuRGNDSzFwNGdkNTluWktFMG12eUJMeENjbmdqcVVReDFVWDRkTFI1S2do?=
 =?utf-8?B?YWJGS0NHM1hGU2ZiYklQRHlSYjVFMDJQcCtyTzhaQUxKUnhRckhTSmlwSGhx?=
 =?utf-8?B?eWZZNWNMYkZCM0dnQk5XOGVKSERDRUxFK2hrZzZkdTlhZzQzb1pOcVBwKzZX?=
 =?utf-8?B?U05rdWExOWFsbVdibVFQdHN4ckI2MTBHalBoS2x3ZFBhMjdPVFFZTEwxM1Mz?=
 =?utf-8?B?REtNalRKTW02YXFEVnlQN1JWQlM0cWVZUnhWT0dMclZzRkZnTkQ4MFNUejZI?=
 =?utf-8?B?NFphWkY0bW5Id3VJNlVqaWROSWd0N1AwdjkrTnh5NFhXYXJQeUF1THduTFJS?=
 =?utf-8?B?eHZXQUkvcndtenA1b3VRMmo0VlAzQm1KeW0yeFdzLytDZldLUnB5Q0lLZENP?=
 =?utf-8?B?aFdCeVptT00rc0J6UnBZcFVzYTRXTWVwWjFxRHBaUFFzdEFiL1lHN3NURW13?=
 =?utf-8?B?clIzVHBEdWJEWjBSM3lYdmpTYlpjdVFyRGJKQVpGaE5ERmtaZXMxQWJYNmJP?=
 =?utf-8?B?OGpNV0tFbGY1R1VhQW04eFRoOVhVZ2habXBOTnY4QU5RWFF2V3ZKR1lmSGlP?=
 =?utf-8?B?U0xiVGdPVU5KeDNySmVWY2EzTm1oUlVUS0g0c3hzMEpLd2VwVThiRFczMTVV?=
 =?utf-8?B?V1BETFN2bzFZV2RRTktFWC9rMklMUkdGRUxvZ2l2RHgwbTlWS1NVdTQ0RVVt?=
 =?utf-8?B?L0JjeEtoQ05jQUFpbkNOVjMvWWJjejUyVEE2L1dJQWc0eFNQMTU0dlBpQjUy?=
 =?utf-8?B?czIwMVVNa0FBMUt0b0Z3c2JXZXVBK2pXRzFhbzNseW9tcndxcHA2bmNueURN?=
 =?utf-8?B?UHN2WklSemY4anBOekxWakpPOVozYjBla3I4U2l6VVpGeXRuWDJ3ZVl3a1E3?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bf4534-b81b-4a2c-4fc0-08dc86332f42
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:15:57.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v2RFh9m2GLTF8J/VMHEeLW2axToWAr3m0x/LTNn71da8CvbwFZVYf+w7XsHibfPZv7pYULtV2T82hOioF4mow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6450

On 03.06.24 10:31, Tobias Schaffner wrote:
> The links in the README were outdated. Point users to the new v3
> subdomain. Only point to the essential entry point and leave it to the
> website to guide to installation, troubleshooting, etc.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  README | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/README b/README
> index d7241a179..90a6e107e 100644
> --- a/README
> +++ b/README
> @@ -2,7 +2,7 @@
>  Where to start from?
>  ====================
>  
> -http://xenomai.org/start-here/ is the best place to start learning
> +https://v3.xenomai.org/overview/ is the best place to start learning
>  about Xenomai 3.
>  
>  Also, make sure to read the per-architecture README files, i.e.:
> @@ -24,13 +24,11 @@ Online documentation
>  The online version of the documentation is available from our website
>  for the current release:
>  
> -http://xenomai.org/installing-xenomai-3-x/
> -http://xenomai.org/building-applications-with-xenomai-3-x/
> -http://xenomai.org/running-applications-with-xenomai-3-x/
> -http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
> -http://xenomai.org/documentation/xenomai-3/html/xeno3prm/index.html
> -http://xenomai.org/troubleshooting-a-dual-kernel-configuration/
> -http://xenomai.org/troubleshooting-a-single-kernel-configuration/
> +https://v3.xenomai.org/
> +https://doc.xenomai.org/
> +
> +If you want to migrate from Xenomai 2 see:
> +https://v3.xenomai.org/legacy/migrating-to-xenomai3/
>  
>  Building from sources
>  =====================
> @@ -41,8 +39,7 @@ http://xenomai.org/installing-xenomai-3-x/
>  - GIT clone:
>  
>    git://git.xenomai.org/xenomai-3.git
> -  http://git.xenomai.org/xenomai-3.git
> -  http://git.xenomai.org/xenomai-3.git
> +  https://git.xenomai.org/xenomai-3.git

Let's changed this to the redirection target:
https://source.denx.de/Xenomai/xenomai

And we have a mirror for China:
https://gitee.com/xenomai/xenomai

>  
>    Once the repository is cloned, make sure to bootstrap the autoconf
>    system in the top-level directory by running scripts/bootstrap.  In
> @@ -56,7 +53,7 @@ http://xenomai.org/installing-xenomai-3-x/
>  
>  - Tarballs:
>  
> -  http://xenomai.org/downloads/xenomai/
> +  https://ftp.denx.de/pub/xenomai/

Nope, tarballs should be fetched from the git forges as also referenced
in the announcement emails for releases.

Thanks,
Jan

>  
>    Source tarballs are self-contained and ready for building.
>  

-- 
Siemens AG, Technology
Linux Expert Center

