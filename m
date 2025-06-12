Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E022DA1B
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736720; cv=fail; b=Ll98qOrME4T9d7M53qBFy9FM8BUHV5rtD0GnExZdPinozZ2/Mx0vNjRJ7U7A7NJIJxfkSJjeLaDhXZdf9F27yC2Cw+EeFrvdSeUnIkskqxpKeRUk6ay6kjn2Q9R/4i210tzDp+7g9M13AOYcWM/8m+87JbYJNBT2nFx16E/L4qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736720; c=relaxed/simple;
	bh=ScnucSEcWUmh3yZUfQK4g0iRUuSPMG5RiQ7S/qzpUCA=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJ9qLNkS3Cj59wDZNpvnTmUByNbiBuhb6qYXjMsqjKhdEZN/57XBH6QZw4FKbsfzODQmEP+uOjZ+ZeFZJQP+FsIVMIYQFQkhpCIItq7LuFriK9aAzESTnSUzHbda1RuuEqowVfzJ4oXfhvAeKmToItrWRi40kuty22sgxW5xLPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Idp9iHAb; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Idp9iHAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx3z1wy6Tj8wt/bdiQXpSxUzD47NIIY2anAcNJ2iGVzAiaLhADSVPruaYFMjPxxsP5QdndOCB38Q1OW8iFChWCilJvmY8+OWeYvT8+AK+1wwq/hsHFY9uT0VkjTzHe8ExurufnIRZeW/Jfs0iy9EbwXNnRwVv77RIIhEd6Fw+sUNdTLGQItMvUKnPxPQIcyMGCaRET2yG1NB/NcyMIBJnaORaJRqN2wZGE0yF9U9pJBDM64D0/2fcTgjQI9QJBHbp0uGtT75ZTdpYfEgbF5snu5y7OYqjpgNEJKIkL/Jv8nxjKQoUYm/XR0fFOySdSwDnyLicKXWU8JoyMP1/jO5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmZT23/kj+x2Ru3dCTLS1riCfmOZJ56znif+TJcsKWs=;
 b=QlwL8GelCC6cEWOV9L7xi13iZkMJLKaSoa/TxRaYMvS9hnFa3gDqeSCronqq7Qr5tzcrFiGl6OLAYW4dSR3YXEBBkk0wW/i0uNXwOxtYsD0ORLa+x2rX8nZMlQWfAu8odqwQze8M2+eAE88DAq5Z/tz1lvSlhxjtWvt+bMV1PQz+h2L6l730a9NztPlLw8+x4yRrE4dbF3vT/3eg1HWuok8E6afifulHShkiOG3Zq0nBIZcKxhBr2MWHp4G3HN5Twx2YGZstmTd08jesMQcTA8SIifMXI3cEVY0pefQ9dlYSkRemhsYCK0peYfo0qS2VTsTbeVRest2ptKiQ8V1Grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmZT23/kj+x2Ru3dCTLS1riCfmOZJ56znif+TJcsKWs=;
 b=Idp9iHAbFkxNcL2eVh+COU5iyF3PHe+QhRUVg9IsZwt55Y6H8IGbVvMesSJ2LI+cK4cu4ft27h+evG28cVDxb87k2vXi4lQUZb1lDxnPsiCjnJ8ILTc+GR768SIyMNvInRrS65Yj496l6hUvjmdupfLExUGZqGzdKyr5AUSHlUsCLb2sMXK8vL0fYvt8RHRgvCV9nxjC8jh0869l9BsPy+dUqXrx56+k3olwg1+fQ4kOf488WH7IDNJKYfTlu1F3H4zD2tHX4qdO2WdR7ChT5DuaLqtqwbx+gDHGybxxmXtnkmPVpMHyLyxEC1Bamoag8wXNPRzVJYsWuEf/BNdsnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:583::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 13:58:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:58:33 +0000
Message-ID: <847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com>
Date: Thu, 12 Jun 2025 15:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd88ea8-cbc1-420d-6a83-08dda9b937ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpQNXRCaGZxeUxRc0svOUN1RDBUQUI2cVAzeWVxUThpMlFnalB2bDJXTU1C?=
 =?utf-8?B?VzRTek96dytGVTdXdHR2NU9vWDNpZnRDciswWkpLOVFkaDJMRTV3Ymw2MG5F?=
 =?utf-8?B?N0pKaGJQUU1FdGNVYWNQWVIrbU45eUE4dFppWjhYb0kwblZYUUpDaThIUFRV?=
 =?utf-8?B?Y0UxRHVjTGJabXdaQzBSczB4ams4aGNhQi92YUFsNitJQU5rYmV6ODJvREIv?=
 =?utf-8?B?cVY0OEU0clhoTjFjZ2JuYWJZbzhHNU1pQStrTlovamtmSkhIVnlkUy9CcUpF?=
 =?utf-8?B?a1RiTGpuR2dXbnA2WCtIN3BqRGJ4U3lLZ1A2Y201YXIyMVUrUER5dTBYRHNw?=
 =?utf-8?B?b3d0MEQyNjNOVHBUUElNM2hGOUJlQU1EYmY5L0F1U2VjUGZrVlRNRUoyMlNW?=
 =?utf-8?B?eDVTTHNZdmNUN0JudWtWc21ISk94bzhNS1NkMjBIYklPa0w0NWlVcWorVzA5?=
 =?utf-8?B?SmhSTXcrQVBSejZCOFJuU3lnM2IxRWJjSVJYQkUxRDliVXBYQzhiaTJjSkNS?=
 =?utf-8?B?UE5wQURseVNySkdPbU5wTnR2bVJSNE9RRGNBczFMUGVHQ1NHOEN4YVY1c1Vy?=
 =?utf-8?B?WFZSRlQrQlp3RDE4SG9YeWVZYXFjeDRnYWJNbWVQME9zMG9Zemc4enFVN25x?=
 =?utf-8?B?UitmVnB0QVJCMkFjeDNzZjhjbGxFYWdzaTdVSVdMWDJRMjVHMTd3Y3FtWjVF?=
 =?utf-8?B?Rk1MY05BMUg2NkM4cEwxWnBqRXdQK3hlSzJya0pvVnBwWXZudkt6bzVBWEtr?=
 =?utf-8?B?QnJGTVhpTGdZUXR4Y1hIaEFubkhZUzJWSmUvYStHL210ZTNCMmFlU0QwSFFZ?=
 =?utf-8?B?YWFkOUd0ck4xWGhSV2hBUnhpMWlpUnpDcmhvampRTkduZUY1dStYZW0wakRF?=
 =?utf-8?B?aVZsYWRhSkVMbmJJOHNYekVxVjhVSVdtQ3B0K3dIQnMzMmNQbFE5R0dEVWJs?=
 =?utf-8?B?clVaUUgrVFBlNndDVE85YzBLdW9hc2xIZlA0QURCcDFSSWJRbjdxVW94dDdI?=
 =?utf-8?B?SmtVUERLU2UxakIzVlBERnRkdytUWEkvYWpXaG1zcnNBK0RycjAwTis2SHJD?=
 =?utf-8?B?YjhFR2hWYmNHV0EzRHhmc3Q4WW5ESnJVYXNaT0VSbVo3UnlUN1VIYStIdmkr?=
 =?utf-8?B?V0NQZFFtc3RXK0x0YnNVSUZmWXFsTzBVT0xDaENVL2ptdUVZVjZsUWZUQitq?=
 =?utf-8?B?Wk44Z25wVkg4cmRsU3VuY01OSTlDU2EwZ0w2a2UySUhIYXlwUVUveFdGZXJH?=
 =?utf-8?B?NFdWdDB0VEtOZ3VPRnlhbHVvVjVOOXBORGdNYlZsbXJkMDZnVHRmbUw5Qklu?=
 =?utf-8?B?TkRrYWpzZ3JGUTh4VXdiUVNncGRYNDIrR2FhQTNoM3ZRVW1ZL1ExU29tQlpx?=
 =?utf-8?B?K2ZlNUVKVUNVWlI5ZlB3ZkxZUVBhdmhUa0NXdHBrYjIvWmNIOWZzbGJpL0kx?=
 =?utf-8?B?SVlMM3ZNNXRtS1M4bVJySWNIaGFqT2VYYlNYUytXLzZ6eTVwczJxMUlmbVd2?=
 =?utf-8?B?dHk1S3V6Z3hWUGdKaFcrdk9HKzJZclpsRHdqZHZtTmRkY0JrWUh5RnR2QnZG?=
 =?utf-8?B?RVJsT254cXRLNjU5VFJyd0pjaXIvZ3V2SW1GakR2NUs0UTlxSmV6OXQ4NEZm?=
 =?utf-8?B?V3hsN0U5MEl4eHpRUGgrMStMZmdTTm5FZFEwMmwvVG1JcnFrTmVxa2hJWWtH?=
 =?utf-8?B?T21qNG1LT3BxbUxiVzJ6TkVDYWFmTmlkd2prZENMNjFzaUxMbUlvQ09KdHJo?=
 =?utf-8?B?T2U0ZVk1VER4UHg2Wng4WFFZZk1rYWFrcnV6SkdMQ2gwOVJiWFVDZWlaeDdF?=
 =?utf-8?Q?mvWWs+al+fLRou4w34vOLmAsBsb03a6wkHu+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z09nRDdZaW9sdGtDTXYyWlR6VURNU1l4MytGVGM0Q0hRRHg5L2JqbTJSWm9W?=
 =?utf-8?B?bTYzbHpxRjY1N2dkUVVGMVpubGdLa0RNZ05HdXJnc3dKaVJ5bXcrNTFFWUFm?=
 =?utf-8?B?dGUvRmt5QVlCWTQ3ZUNOb2xVQm81ZXZVQk9CblIxcUs0ZnJ2aW1uRXBQZjlX?=
 =?utf-8?B?NWc5azFGQXVzSE1tNmFoWU9HOE5lVkh6TStON2xHQjhjai9TMEpZemNWVTNl?=
 =?utf-8?B?NzJLUjlManNsY3ZKQkpKZVJNUVBxcHBBUVF1VTJlRE9SWjlDTjBqSUh6dFMy?=
 =?utf-8?B?NUNNdm4wd3FOK3YrZDVweVViRk9tbk5YRE5HODdhT1YxUVhMalBseGJ3Q2Ri?=
 =?utf-8?B?OEhvVkZPeDRQWWpuRzNxTTJDbkwraTdUdEVIT250amNjUExGWVBEVUk2Zi9j?=
 =?utf-8?B?eEhDbzNTdThVMExLQ2J1MVRpMmdybjBicXQxdUJDV1RsNDR6S3BmWVpwYnlq?=
 =?utf-8?B?REthT0NKYzk0RGI2UER1Wjg2bTJ4eWwrWEJXU0Y3K3ZzeXJDTzZhK2owZ3dk?=
 =?utf-8?B?T2UrcVp4OU1WckRpY3E5RTVxcGJTWDYvdkVnT1BDNTlTaW5iaXNmZnFoNWhT?=
 =?utf-8?B?ZkozQStyR0JZd3BubE1hOEY1STlKQ2VHN2RralM3RXc2N2F1OVRNOUhiNFpl?=
 =?utf-8?B?OEZKRjZyUXZiaUs2NE13K0xSbU53RnRxeit5bHhmbVZra3duK3FlQjkya3Zi?=
 =?utf-8?B?aDB5YWFwa3JXdGE5WVRLTlpPVEgwUVFYeSs0Vm9VVzRHYTRHRjcwMVJiUXRt?=
 =?utf-8?B?cjdWWVhOczY3RkZ3UWliQk1hVXlSUVRqRVdCbm15VWpyd3ZrNTluSnpyMVdk?=
 =?utf-8?B?Si9ocEllR2dYazY4Wmx6a2RoMHBVWkk0ZVB3QklNRkdrWkFGSTBYY0NmUk1O?=
 =?utf-8?B?R0Ezd3RtV1hPdGNsSyt6UCtoSUR5dzlNTmk1V2dxY2M3MnA0Y2pxQjNRS1hv?=
 =?utf-8?B?M0VXNkkwZ2p4MDNzaGdBVUpRaTQ2OXk5bGpMNkcwckNVZnVjQ0x5Yjg0Q3lE?=
 =?utf-8?B?cXJzelZXTGJiZ1RRZFhuVGl6dFUvWXFLeURXU2drcm1PSGR5U3NXb1dpSHNz?=
 =?utf-8?B?S2hPdTExdmFMOEZGcGxrcUYwam9udEFZcVRwZXBaNEJNSHRRK0hVMTZ5MndY?=
 =?utf-8?B?S2ZkdlplL3JKc0tMRDczQm40N0loblgwbmd0T2pvRFk2N2pwc1UvZ3RYMWgw?=
 =?utf-8?B?d2tGakJNQ0IvSDQyQjkyeTNnRm1hK3BnSjRJVkxCZXB4eWFiSk5menNXQnFy?=
 =?utf-8?B?aFRDZ1RyNFJVYVFoQnJKUFZOZjlQOEx0SUt1bVl4SnJDcXd2TWQvSlVUWE83?=
 =?utf-8?B?V2IxVW5kamdFaTFKRzRnaFlqb0ZXMDRUdGhpNnducDhFY2tEQmJKejRMWGRE?=
 =?utf-8?B?eHJkaURXekdIUXAzT0FPNXdkcXRKcStEbUhhVkZHblcrY0lLSzlpdkRtVzk4?=
 =?utf-8?B?dDU2bGVORnlPSXJ2Q01mRHlOemZtZVhDK2VYK3B2cCthRU5ZVnVTV0RHYnpv?=
 =?utf-8?B?cVF4bS9seTNhY2hrN0ZnV0prZGZoUDV5YUl4bWdnZ2xVTnFWRDhOTHJNdW1O?=
 =?utf-8?B?d2RkaDMxNkgwaWJOY2tUVHJDd1N3d2NraThaMUdNOEpMbEt2cVhZRW9yQzcx?=
 =?utf-8?B?eWY5dnZ3eHNJN0ROek8rZ3VPbWpHUzJyYktLYWdNTFVxY01mZWpGOHVoUUlr?=
 =?utf-8?B?R2hxL0dPbmhwZHMxWlU3ajNNSzRYTE9sS3JnZWJRSWJOQ0NCZ2JHMXVtZVNj?=
 =?utf-8?B?WFUxc285RWZrYVNXWFBtemRDYTlhdFpTS1pQcC9reVFOSzh3VG03c2FoRmN5?=
 =?utf-8?B?YzZ3Mk9HdGJzZitsZlFLL0xINUhoSTRueWZKSS9SdGlaeFNMd3c4RWpFRG1Q?=
 =?utf-8?B?Yk1tUEVWbWxkMDVhSW5UcGg4NzREaUlSTzBQM2QvQnRucnlqcUtpb3FDSlAx?=
 =?utf-8?B?Si85NHpYcU9SZm9EcUdVVERTcDMvajZoWllXL3lWazJrcUdyckwxWmx4cVl2?=
 =?utf-8?B?OU45UkhLLy9DNERJa01mQXRINndOWHk3bnQ4TVBTUnJPcE1PLy9oRzdqeFBD?=
 =?utf-8?B?T1VxNFRaaTN3bEFEaFdoMU1VYWVic01ZSkpXL041SkZzUjU3Vk9CeHB1MGpP?=
 =?utf-8?B?NHE5VGp6b2FMVmFiR0ZLZGZuV01qU0QvS3krUVdWOGVnYWovNUkxL2x4Z202?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd88ea8-cbc1-420d-6a83-08dda9b937ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:58:33.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx1VCD+8ns5Rq/CAka1TwgWCAtbfewRZjWVnWK/NdwgBb6RSaZCemH86VCJdifFmtEqkCCWAPUBPwlBACn0HJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6064

On 11.06.25 18:20, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Not yet tested, but this should make our pipeline green again:
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
> 
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index c0932a3cb220f..26be743f2a6cf 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -12,6 +12,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/netdevice.h>
>  #include <linux/ipv6.h>
> +#include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>

Sorry, this was wrong, at least insufficient:

https://source.denx.de/Xenomai/xenomai-images/-/jobs/1167536

Seems there is no way around reproducing locally. Will keep you informed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
