Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF721FF5E
	for <xenomai@lists.linux.dev>; Thu, 14 Aug 2025 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148510; cv=fail; b=Xg6Kv+9D6s4V9J5/qXCvJH3fkrhFouobk8UYXowb9UqFokgUyvFuVcWZKbnfiu5PPJ+Vetqye3af2KN5ZFgi2Vm1N6EyrUqnue4Ftn+5eN8gyXSfZl7B1BsJB6Ed1QQFodokL6GiJh6p7dv1ksuHMixiKa1RP6jyc5S6Id/sy/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148510; c=relaxed/simple;
	bh=HMzvYO/DOTInr0hagoCOvRWMCS/Gn0sHrGFoSgIM5yo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=giAMuahY+gsO1zlI5VBhARj+gvqAaWPwcfyDwP5iiOpec/5hX4BJrWtIQe8NHpk/0P9lPi4Qpi0bBXINfkpwmSnJA9On0l8eF9L3B/EYLzRTnJZ3j9ESGyTdJXFoh2PheKq1RDemr8OEgxbSby3Y9G+H87xeqjaxWvYu0+Frr+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Gs8MhAWd; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Gs8MhAWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuCAG8RyFQqobCSmqt7GzS659A/22Rd5Wpufd7u/cWcYbt/4ayx4kJZST7lMXQDK7iEfVMWXgi7s/TED5ECs/AACpYjRgf4LS5aHM4MDIRjC6ydYBm2YN0lG0V0AQSJdTzdyGqOB15cAGRMLrRUzi0EaybuKX72aPI5l8ylU1nkYk3X+wkmjeiroPo9AqNEXg0hfGb5hl+Z5Oz7+NL0LhAL5Uhx82vNM2beLfQpW7OaX2U9PDDQQR+LAnhbMEx5i51gP2b1n9K70xAzq2niGsdTeqO6Y4xHP9iKb1JSKrdiePBTmCUj1Cw5EmRfhqKm5gzeSDZ3+UFczUsg/jYEW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtLDUnHwyBk6IAoqPlfCPJnz5T12LAzd3DhSq0enWQo=;
 b=K93H7LmZebIviaS+PB+iHXx1PFqn+wKIs05r4XEdTSwxOJaDlSG95o9wUYg42yYxKumogoRPmmWIRYcHVArecojGUX2tb3OlS4joKSmStCtJ/1jQUenIovjSP2K717jitiWTO7QH6/JIuMnz+UNEJ6HV+icN/ERefvD2cHmYsFlz75rf+Nikb3LJbQuyg7RlQtdWA054kGlJbTH7jPBSS5cX+tKuZ9dkzqZPsPOU+PidCkEcPN5OxL8SKJ8B90pI25bShWqg45iYm8JxzIz4l1379SYQifcVwfgYZf0omJ2yT1wcHJqPNrTc4iAlnY4jusvrJ9EXASCIOa7YbpmMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtLDUnHwyBk6IAoqPlfCPJnz5T12LAzd3DhSq0enWQo=;
 b=Gs8MhAWd9Tjy2ADlO7wLhWkwG4T2AWB5q+ewPBcWpvqjr9/Ho6j095hj6dEtcsKYERR31Oz+AWOraSdNZktG9/G91nySNKHaSjVcpwrcZ06e9lrcDkJ7XGfvae8FhO+K1XhR7Ohium9S3Qh/HYAOjZuM0kmbFpYuwpzy/4cL/B0h+i5EVkXWWCtgJnASsT/N7v+A8duERk7uEGeETuFf5HKDoyo5uriUMBKsbLKUsY2A0vO3+iuTLCsP348Yfe4jPNzg8DndxnpYLtpv8wQaPu5a0BtPLZeYlblHt1nSXA5yJpV2bLsysAoqBvq+gX+WTVXGUgawUV10wgrkwOr4jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 05:15:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 05:15:02 +0000
Message-ID: <db191d84-2707-4444-a7d2-4c87a4d2f83f@siemens.com>
Date: Thu, 14 Aug 2025 07:15:01 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Move lava container under xenomai-images
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b33b77-4629-42d4-37a6-08dddaf185ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elJ1eFoyQWdCZUluMk1UbFU2NGdjL3RTU2J4VndnRVFXNzVaZjMwSHFlSUhN?=
 =?utf-8?B?NzNQNG1xSCtLamRONS9JUWdRSE1QSnBzTnVhN3pyVjJ2SmFja0Z4eTQrL093?=
 =?utf-8?B?TzlHQm1ETk1tNDNGa0R5TFRxdlp3aTFGYUFtMlNBTE90aThXQU05ZjhGS3dC?=
 =?utf-8?B?TVRlUWRxUUw2ZFM5Mkdma0p6TXU1MWdKVFZsakJQUERoeVo0TnVDTUc5dkYr?=
 =?utf-8?B?eWUzSVNuZ3VaZ2FTSFVwYTNIK2M0NnE1YTloaXh5ZVJWNGtMY0U4S2I4NVZh?=
 =?utf-8?B?bXVsUTg5VmhRVis2eTNUeDZuVmk2TTkwVW5odEJPblZ2YnFvS2tHL2V1dkNZ?=
 =?utf-8?B?Rkk1aFhEWEJGVVZTOGVBWSs4U1hCOE1wdWpvbEY0RUc2eHdsVnJqVXVRYUpP?=
 =?utf-8?B?WXg5WlJuSzdCWm5IL2UvTXg5Qmg1cy9tYmRRRTRKN2VUNUtJTjl0cE9NbXdO?=
 =?utf-8?B?cnN4bE5Rd3NMb00yTm9YWDdEc1dXZ3VHS2xYZGZIUDh3OGZBcWJFellvV3JF?=
 =?utf-8?B?c0o5cUhWQkhObnpDandVRzUxaytlN0N4Z0FhSnRiYVRPVVRSMzR5UzdJaUVY?=
 =?utf-8?B?M3MrNHFGajBNREhCZDk2OGZoZWZHMXh5c2lXMWpDL0xGWFdSZytieXZ2Ykhv?=
 =?utf-8?B?S3lyV1F2ajZqK3AxWkNPekZ3L3RKV0xEaUFCNzRaWWkvRWt6L1d0S2VWdm5W?=
 =?utf-8?B?alM3dUpFNUVHdUJ3SXNoeVllSHdYVmhodHNQb0pMcGVvUm9HWGtvR3BPVE9x?=
 =?utf-8?B?QzduMytpVEdYKzZTbUlkSzhUQmkwUjR4cGI4alNFSHNveGM3S3BRbVZ6aEFi?=
 =?utf-8?B?MkRucDByVjVKakIvOUR5TWRUQjRZK2ExdGJuck01dk10MldEcWlwTFE1a2pa?=
 =?utf-8?B?U25xcDhIdTRiOWRBYmdpWk1pb28xNUlZcEVkZTdzME9penN4MCtaUnVJYzYz?=
 =?utf-8?B?eHJmWExiLzRlek96MDBwcXp5WEhNRGErNXROTUpiUkxZeFJWSExNbjM2R3lB?=
 =?utf-8?B?SEpVdFVFbjlnbmdSSGpCK2VqejNBa2JZVE1QZ0s3bThoV1dhTDNNbEZFOUkr?=
 =?utf-8?B?RUpSM25oR3VWU2xNK1Rkc2pPdzdrcjdKT1FVei9taUtsbGZ0eW9vdlJHejJW?=
 =?utf-8?B?U2Q2dUd6elFWZm1ya2IwTEZYc1RWUEhtZlhCREN4RTZKQnBoUWk0SVEvcyt1?=
 =?utf-8?B?L2l0OGg2a2VNendUT09DVldpTDVJb0V0QmdydDNyVWVUUTZIcWR5d0ZZM0JM?=
 =?utf-8?B?UERCTFRzdlh6VzVtdmpkaVpTMFhhSytYemttcUgybnNlWU5IRkNxVkxWMWly?=
 =?utf-8?B?MHYxdzNWV2ZGN2orM2RZemdCM1o0VWtCOEsrVWozVDJhVEoxeTgrUURKQXRp?=
 =?utf-8?B?VlF4djJuc1QraHBmakpxUGQ4UUxuWTNJcHV3ZDl1Q3FiVUc3c2d3RGRJTlRa?=
 =?utf-8?B?N1NDTWUzbTFpclVKNjBrclVQYTA3elB3a016SE1qak9SWnU0WmxZV3pKS3k5?=
 =?utf-8?B?SU04M2RXVDBZK0JScS9QTXZ4Vk9zVnJpM1F2ajhoNFlueFkxN1ZSSHo2bkU2?=
 =?utf-8?B?TUZ1dER1ZEZEOGpaNFRUOW91dVFjNm1zUXRkT2pmeDR5b3BqRENra2tHQUYx?=
 =?utf-8?B?VS9KbTdwR1A2aG9sd2xtdUZHRjAySkFPMTdzKytsbVNtUk9WNXVKZDdEVkhZ?=
 =?utf-8?B?VHFxTENuYlJqYW40WTZWVFBaekFhL2thZnlUcmFXUUNtanpkaEJCNDZsTDMw?=
 =?utf-8?B?Zm1GU1pFVi9GWU80M0NvMmp1VEloNkVJTVhJd2F2clkrT0lCOXNjUm0wOFgy?=
 =?utf-8?B?Tzc2c3laUUMvU3c1Mis4dGFWNVRUM0xtQWV6S1dtL01DVXVNMHlpbFI3WGJT?=
 =?utf-8?B?STYrZEp4SCtBV1Z2QmY5OWNrbktPaVZmeWlRUjF0cVhSb0tvSkdvTzRST3dR?=
 =?utf-8?Q?cUosJrvD1lI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c083VWh6MDlNc0h0bTZEV09JN0tmNVR6MXBrbXdkK2c2Q2ZaeFZMTUcvb3A0?=
 =?utf-8?B?cU5nWkdjcGRjd1dNRlMvaTltVndBNHVoS2UxYnBiWk4zSzlyNGk3Q0pGWVFF?=
 =?utf-8?B?MDVWUm9SUHZBTURoU0NlR0liQlg5cFEvMHBwS1FVYVFCSkJHUmtVTGNjenh6?=
 =?utf-8?B?TXlyTkFOYitrN2pwNzE5c25hM1NDYVFzck5XQXFBQkducTZzbUF4aWJjc2hK?=
 =?utf-8?B?SVJCUG5nTkppdTQ3UEg1N2VpUGdzdE1PQS8ybE1EWUp2b01Ra01HNjREWWFy?=
 =?utf-8?B?UjlMV2l6dTdxUlZYUWZmeDNOOFkvT25iRm9DWjd0UzFNdzBpZGRQR2EyWHls?=
 =?utf-8?B?ZVFqOS9pWFpUM25SUlFmV29sbXZpdnR4bUFoTkFzQjY0bllLdGxDcWExaEV0?=
 =?utf-8?B?SWdVbHRGeFBRVWdWaWRNT29XT1NNdmREb3RyQ05ncDBoVkx0bWZrV08vMTNT?=
 =?utf-8?B?WVdsRnJiTHcwUEJHbmt2SHZIY3pjbUdPOFdhVmpuYXpZWDlNQUpWSzRhckVC?=
 =?utf-8?B?cUh4Z2UyWnpOaURSdnYybGx1N3gvRmo4L0I3V1lRSXU5aGg3VVJxanAxOFJC?=
 =?utf-8?B?NGRvL2lTVm9pbm0zdVg0Ylp0Um9PaTJqWlR2V1NGZTJ6c09CNGxuZkFTVmM0?=
 =?utf-8?B?a1dlMkg1Yko2cHl4S0xRejRBNm93QTErVHJFTVpUaWNHMEJDc2JkR2JEMjJj?=
 =?utf-8?B?ZW1ONXE1MUV0NTg0dU1LOEkxNWFveUh0NUhTS0RybUFYQUd3ZEN5YnJ5VUJv?=
 =?utf-8?B?elFhRVByWlkwYnNFUDF1OXkxQVFsMVBxTmRFREhNSFpQZ09jNTIzQmcwUVB3?=
 =?utf-8?B?UFVndGoxNTFiWG95Zy9KTzFTS2NveGFrMTNCSE5zOVhxcUttTUJSYzRMTEpn?=
 =?utf-8?B?S0VxNUNkUGduNW1lR3hLL0NtVVJFcUxDRFI0MlgwbGprWWJwcFlubEpqa1lm?=
 =?utf-8?B?Y01vdm9pR2t0aVZ3d2wrVVZZMFEzWGZNV2ZhbUpWb2hrcmg1Q0d6QUNzcW1P?=
 =?utf-8?B?UlJLa1BoYXZQQ0RsR3dwaGZhbkt0VFNseEc4WENJNmtLNEpaSTd2TEFtSDdN?=
 =?utf-8?B?eXQzZ0VGL1FpVWMyelVoMmI0R2ZTdFAyOEF6bkY1Q3dTaHRZM2J5TW9NZ3dQ?=
 =?utf-8?B?bXBXYWxPYmR2eVlQVHIyeG1KZkJ6QnRXcEFwUHQyZ2xnNFBOa0NLbTFwQS9B?=
 =?utf-8?B?TkY1L2k4Q3JZUjYxL1FWSUhiU0VhUmtLYmg3ajdLZVVuR1AxQ2Q2MmFmWlYx?=
 =?utf-8?B?ejIxOTNaZkF2dVJGOGdyZUtrTTRqWmZSNHN5cElkanVVOEVSdGkwL2lyR0o5?=
 =?utf-8?B?RVNFSDhaR3cydloxZkFaeEZEdGJ1UjJyYVRnb2lvVXd5TmNsSVUyQ1BUMWF2?=
 =?utf-8?B?dGVVYnBIazY0bmVHTEkzVURPbUhTYi9Ib3dFdUVmVVJWN2hMcFNjdFp1d3Nm?=
 =?utf-8?B?aFFhRUd3Q3pSdVZ4WTVrOUk5ajRObFhGQlFjQzlhNnI4ZkREL25GeWcrSVNG?=
 =?utf-8?B?UXRQQnMyMGVGVWp0V2dMZFM1Wlh1MUNXSmpYZ1J6MWVPeUpPR2hTWUVsSklt?=
 =?utf-8?B?K1FYamlldXpDbHBJL09Mb3BqZTRSaVRXNVZEMUFyaXZsZXFTT1phcFVKeHBO?=
 =?utf-8?B?aGpBZ0JvMkVrOFE0c3FjZXhYallRU1lxWFVXbk9JdUgySzkxNktWbUEwTTRk?=
 =?utf-8?B?S1ZJQ2tGUjRqUmwweXVPNFFkQzNxQWlPRWg2Sm1DWUt0d2xhdS9uQmlyWHdQ?=
 =?utf-8?B?YnhYWWRqNFk5akZ6VjhCbGtCUUpkZExOSzVIcDJqRVczeVNla1ZONWtKY2xy?=
 =?utf-8?B?TTNURitsanpaY3NqeUpKNlJrYXVUVjBMeU1ScFBJdDZOL1YxV0d0V3FyNXdZ?=
 =?utf-8?B?RFQ2OFM1T3JFcXdrV1pDRThQRkg3YjZRdjhOZDBRbnVxK1k1QVNOK3VnVlFO?=
 =?utf-8?B?K041OEk0UktwWXVneDJ5WkJpOGZmMU9WZkQ1WWYxNFFMdUhIT05TaHRqZm5S?=
 =?utf-8?B?eXBEbUZDcm5VeWNMdmFtVTJRdWpCaWN5YURST29LOGxNaGlQZi9WT0NUNXFM?=
 =?utf-8?B?VE45QmMrdThWSTVhRTZYRllDeUlwcGl6UlBlelNGbXE1N2ZyUVliQWNmRkht?=
 =?utf-8?Q?5mNaiHmOQmGiOckyIdpcvKq+Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b33b77-4629-42d4-37a6-08dddaf185ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:15:02.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZA9UhbHChpulmgInx+He2+zc+AJT05tOt4nQKPCWNnIY0MomkhgYfERjjiSTqtspNhp/Dy6upaE54Zx9GbMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6704

From: Jan Kiszka <jan.kiszka@siemens.com>

We are now hosted by gitlab.com which allows this. Will enable us to
drop the separate repo that only existed to host the container.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

LAVA pipelines are failing right now, but not because of this change.

 .gitlab-ci.yml        | 4 ++--
 ci/gitlab-ci-base.yml | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index de48bc3..c22a46a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -65,7 +65,7 @@ lavacli-container:
   before_script:
     - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
   script:
-    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli .
-    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli
+    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xenomai/xenomai-images/lavacli .
+    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-images/lavacli
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 25a18d3..875d951 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -95,7 +95,7 @@ default:
 
 .test:
   stage: test
-  image: $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli
+  image: $CONTAINER_REGISTRY/xenomai/xenomai-images/lavacli
   tags:
     - lava
   before_script:
-- 
2.43.0
