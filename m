Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225AF29CE6
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586725; cv=fail; b=KnbZ8Lt7aYVqns3GyItcNd7H7zaFNIB4z918ByXnYaNgFL5VRAEgGQRZWaSyCZIXLr0UVbYsQVqSwxzKM6fop1XsHnT7ld6HVhHcqJ5xv6bU3S1ntn2k90V5b0QTGnkQ2p+xG89BIKteycVoUEpF/K40dqYqIXaNBIWwCeAEX/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586725; c=relaxed/simple;
	bh=ITFzTwf8ZULGx6BaEwqP39s7oBPHXQAtm+Xdk4bzJk8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DNXQgB0c54aXs1FGtkCwRN2CZ1sPXy1MF1nKIw+1fB70h6WRpK2YCjluL33r1Zs6HxyfKKndP3G90F74cuW0zZQR4gBRuEaR9tMVm+g0YjiSzihzWVNdDL/fFi0v5qUllztoaT0xSjJfFYgmhYL1ftsJATruWwHciPN2zIY3KiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JTvMAjU5; arc=fail smtp.client-ip=40.107.104.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JTvMAjU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBGwS2fVt8hXMB7HJLBlEUzvyuL3L6wgDAfPr87ggnEXV0jz73C7ad2HRJ8ZVLoAbdQJfsxe6FEGa82X4uicLR4YQWPvktKnYpMdHq17Z+S2i2KClLfv5pHLpSppadl13n0dprNaibqx0Tc4eLs8QsFORGmnR8aLJaPMK8u7cZXQKMjZsqhZApCCF1pipe9a0wS8Wzwo24XYmQqSHCTv6guAX785NoSC0/UFog9Vb+pUm7my3vpJBFki0JrljK8ISGskuELFhSRQ+cJtECbmQatqhOS8IbYa6ov0CchckCg3vsR+iCZ9VWCBT6MdqLW2lWcD9NWdJXxXsfm/FctfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jBniUpCVHU4I/9X93DKWxAxN5/C4BrHbWA/B6hEtU8=;
 b=SCnOkPaitZn61gd4x6Y/urXhRkoGtKrK/zWeuZNVa0vLLFSVttE3PA9qv7CfnNRrZW1uCaL17YQckvU9GzGYYo1w9bt7mi3tlgbMWy0mNLznYnk8GggLoq4rLpBq5u4YMkcgdPxcKEvXstcQVRif74c/e4BQ5D9PB+x57dohhOf6h5c9NaYubRoq6hFIGmi/77mVr1x7XqHliamS+y3O6rxBQO/D+geFFgLjfW+wfAUJpASwluLQ9HNuApVyCHiBp46Ia/bsdvFZ+v1dIGhACUFJzNLy+ue4bRXF8+zD/fhBelAkCLRVlp3vlrafGaBLVHbpcYMi+1Ds2sGotcAGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jBniUpCVHU4I/9X93DKWxAxN5/C4BrHbWA/B6hEtU8=;
 b=JTvMAjU5+OwNI3M0ZG7tWWoSkZ4dPMOPkw6jiTaLM/m1rl4T21EYhSumuCwslEKfsxTfWwuC2fIiKYihC69SeN3Z0I7WoKewQc33fInIcyG11UuQcDhuu1ulEmadJxcSIoBaih1v/pFPTIjYA8/myHlfiQ6V73c8KRaOrtN5wqk0S4HEkum68sMX3qbuFAUYn2OjhwjuzzhNRSOFuTMD4Bn7pYp4cSEQJiYLKjX6TV13IP70r4DteJUc7g9ADbBTuOpXwlbEZkNmR25kVvC2itLembuSSdBOmaywW/hneY0kjZLa1Pit6LvYkn1Vqal6tgNTgwn1HATNenqVWtOplQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 04:45:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:45:20 +0000
Message-ID: <1249dde7-39ab-4410-a114-d811da4f8cd9@siemens.com>
Date: Wed, 10 Jul 2024 06:45:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ci: Add latency treshold to longterm tests
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
 <20240709083524.739194-6-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240709083524.739194-6-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 495f4d8b-2c94-4982-d1a4-08dca09b1a70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG92S2lwMHFlNHp4a2J2dGFDcU9md0NyWVpnMnBIOW0wQXpwUStGNXJ4ZE85?=
 =?utf-8?B?UlpncVpYdjIvbktBKzRvazlDd0h3NlFMSmxUNWI3c0JJWVR5OW91NHZEUGNF?=
 =?utf-8?B?MFViUzF0UTlJSFhIQThic0tla1ZZMVJoa1dFRHBMamR4VVZyTkJoUVVtWkpy?=
 =?utf-8?B?Zm5rVEExZXZNaHJYb255SWdyLzRUbDJPMHY4YURDdExCakFVcXNKZDRPR25y?=
 =?utf-8?B?WWxoUExaZ1JIRmJHWitLN3BHSkJuM3ZZelVYeHBsYTlEdmkyeHNzM3BEVXhr?=
 =?utf-8?B?QUdXcmQ2RWhYalh3b3BRVUdMWWdSRTlJZjZOcGNmNUQ5UEJ1MTZxZjhrblds?=
 =?utf-8?B?VmNyU1NYZFpNSjFWYzQ2TnUrY0o2T1pKbHRYaUswL0NOS002ditobldqWDZn?=
 =?utf-8?B?R1JjQ01oVWtTUU9HQk9UK0E0U0lTdmdxTDh2aU5IMnVIZFJsTG5IRzRyd2ZP?=
 =?utf-8?B?TWtSem1Od0g3OCs0TVhpaStCSnRaTm1MSjlyL3hSU0s4VTZNZ1NGdlNJNFRs?=
 =?utf-8?B?SW1NTDA4ODNxYVgxalZCbmgzV2NILzNiTDEzR1h4YkkzTmg5dzhiVzhYZVQz?=
 =?utf-8?B?a2hjdTJVV2pvekpWYzRCTEFPTkRrOXpNNk9QRXJCaThQcXVxVm1hMU96aVYr?=
 =?utf-8?B?SmM5YWE5T0pYOTdhd1ZpL1VubGN6UTdiVlEzaHh2R0VMWDlTK3h0czhBSGNy?=
 =?utf-8?B?L3VPcVNxYmpvMTdxYW5WNm03aTl6M3N2SVNsS0N0T1Mwc0JZYy83UjZ6K09i?=
 =?utf-8?B?QW1VTExPdExLdFEyWk4wSDR0amhyZVhLeGRZK1dOOVRkc0dzRW8xNmhlLy9L?=
 =?utf-8?B?NUlSVFF1cEFVLzBlWGd4c21NbE9NdHpEUmdkQVNPdWY1R21KdC9TdW8waUdH?=
 =?utf-8?B?QmwxVk4xOWlVUkxMSEE2d0xFVkRoTzVrUEtJV3lIZUxVbXFzYVJBTlFwWTFI?=
 =?utf-8?B?RWF2T1hzNlAwYlVla3FOUU9VM050ZXdDdXd1WUhFcVU0TUt6bXA4TmczWFg1?=
 =?utf-8?B?WUQ1dlFtTzUrZ0hwOE5rc0tGditteENHNEsxM0tQeDlUQUFHMHJSMGtqcW01?=
 =?utf-8?B?c0FpMnVGSVR2MnZTYlYyNEFiNkIxa3hFSTY2c0JKRTdjMXR2M3FDVnVYcVQ1?=
 =?utf-8?B?bjFkQVgwUU1lNFhLMVFjbnl4bktkeGxVdkczR3RtWmE4MHl5WGtaQUNrYWxo?=
 =?utf-8?B?bHVhUENoRkdKOXNrYWh3WFpXK1BuZytLQnh3dW42VTR3b0lVTkhmYVB0Z01S?=
 =?utf-8?B?YjgwcXp1Ti9KbEFqWXZBZVpEbWRnV092TmYyVnVXK0d2alVodlMxMVNrS1dk?=
 =?utf-8?B?QnZLRTVOTUNETjlQSi9sZ3pxN1ZTTXJ1UjVuRzk4azRMa2loRCtwNUVsRlNv?=
 =?utf-8?B?R25BRGhjT3gxQ2RvMkxsWVBkcUx3aVh0Z1hmL0tycWx3T3JGNWtxbWt0RVpv?=
 =?utf-8?B?eGdlYzllQTFMUUN1Zy9hdVFXdTFmTGdkc0FBN3k0MzZUOExDZ2pxYU5sU0tT?=
 =?utf-8?B?ZlBvcTFwWDFmb3QrVFBJWjl1Nm1Fc3MwMHZpbUhJMmFmcTRETzVPdmZwWUlZ?=
 =?utf-8?B?T0lWR3NLQmFMWERhQUkvUUwxN2Q4U1BiZXFHOW5PN1ZxKy9aMU85V0k3SlFn?=
 =?utf-8?B?bEF3eVlUZllLWE9TR3hjdXZpVHFMNHJJR05wVnBhR2hjTUxJQmVxc2tkNEV4?=
 =?utf-8?B?T1YxOFBQYzR6UDlMWnlCa2RDRjN6SWUrNlZRc0Yxc3U1WW9YOFV6MTBzUkVX?=
 =?utf-8?B?NU1VYnRBRkJkcUdEdFpYSWFtSFgxS2dZUTg5Z2xqQlRzc2dtZE1pcTB5eThL?=
 =?utf-8?B?dmhvb2N6SW9zZVNnRXZzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2k1TmRVdXFjcGZ3Nk1uLytpUGk3VUtCUVJyQjkzeThoRXBrZnUvOU0wcHdP?=
 =?utf-8?B?cHphbE9uNHZXOCszL25TOE1ZQkxIOW5uQnd4TnR6UC9QSSs2T3R5MnN4bUo1?=
 =?utf-8?B?ZWJOVCsxSmpUMUtVS25mTEdoQWsrcWlQOS9vR0ZJTWJja09rVUpTais3UHZP?=
 =?utf-8?B?eEhIRnkzVmEybjFPODRZTGxtWGszRGpmOFhybE9BVjdqS1YrcmlWZVFUU2Qz?=
 =?utf-8?B?QnhCbTlMWlMyODA5SkJHZjdpT3JPRUIvMmZUMU1SclQ5WEdzVmd1dXQ5Y3Ru?=
 =?utf-8?B?alJDTmMwR1dvWGxKbnh2QzhDdTlSNEZhaVAxOUFuYzcrNXM3dW1iQVh3czVp?=
 =?utf-8?B?TlJkOUNvZU1qMWJYbnRuWDkwSVJaSTZmclBGTFRJdXpXdWhwaHY5d2pUUVJs?=
 =?utf-8?B?elVWYytLTDZzQ3VpU3B5enpnWGxQbEo0dW5EZkZ4QUJGYnZkOWhvSERpek1L?=
 =?utf-8?B?TG5UV2tpR2ZMRGxTZXpWMGp2YkJzbHdYWThVMnJnZHAyWk50WDkxWkpuYm12?=
 =?utf-8?B?SEx4QVNVQ1B5OVFWbnE3SXUvNHBETjlpaWdBNG5qeFJaMTBUTHRSR2hkLzV6?=
 =?utf-8?B?VUxXalBRNDNPQ0U4U3BuV0M4bmdKVWZxTlBNaFI0U1NyZ2ZwdVBjTEV0bFp4?=
 =?utf-8?B?MEtWcTU4ZitGY01PV0FBV0pic0V2Sit1UkRRZTdLMEY5dEdNdTVkN3R6QVNy?=
 =?utf-8?B?cXkrbHlXU1FicUo5Z0o4MnFDSy9aR3JVN3ZGSmxMZ1pKeXJPSGREek5Za0hB?=
 =?utf-8?B?MkQ4RHNWdU9UeDg2YjlnU3Y2ZGRaTnNJWDJRT3gxTHRzcmppSG95ZW1xTWhD?=
 =?utf-8?B?OXIzcDV5U2VEQUVrc1ZMcXhZeEM4ZHEva3ArTXc1OUg0cElYdkJid3FCNzE1?=
 =?utf-8?B?UHY5MnFwV3FPWDM2b0prQXNIMFJZdjk3ZEZCTllqdFlWZkFWSDQvUnFsRk5m?=
 =?utf-8?B?N3JCbm5WcjYwMGtVN29wazZ2ZlZzV0svajBsVmtzU0FaU3dDS2QxZ1FvUnYy?=
 =?utf-8?B?TThYMFRnc0dadXA2eFNZemtxb1RqcmFjcCs4S2ViMmI5K3FiQVR1cTBYQVhN?=
 =?utf-8?B?Q0o0dHJtdkV0eWZhR0w4eXI2cnNDY09ZMmxDVnRMd1orTnVwZS9qN2t6cnBI?=
 =?utf-8?B?aDdod2pURHVhSUFtTkVwS0hrYWtBNU15TDlQczNMZlgrYStKT0szOXYwVUEv?=
 =?utf-8?B?NTlIdXhlY21mU0xneDJxYmZTRmVUeHhXanJkNEdRKzBIb1hvTHhiYTJ1SVMz?=
 =?utf-8?B?cm1yV3U0RlRNS0JmRDBkNlZ4R0l3NnlSWmlzbkZONEVubWVEUm1zRVNrRlF0?=
 =?utf-8?B?bjQ5bk5wY3Zqc3lQRllncHRzSkI2Tzh5dytWYVdPVjFvUHFiTy9pTkx4elp2?=
 =?utf-8?B?emdjekt4SUZNRm5sYnVhU2Q3NndWT28xeWNmWHZ3Q2VtL0plaFNYVzB3VHhz?=
 =?utf-8?B?WUdDNjE2M0Z2N05zRmhHRldncERXQWlHVFdXSVJtYUN4WUhMQzl4b1dhM3lW?=
 =?utf-8?B?N2prY3BqY3FaV0F2T0R5bHhYVFJKY3IvNWxySmxEZmt0TW1iVHRoMHBKZDhh?=
 =?utf-8?B?VnFRVTcybkl0cWNBMFNlTWF2cVVabTgyWk42eWg5UllxZU9vU3dMSU1ZdWVW?=
 =?utf-8?B?QW1CVzJUK210cnowdlcyaFh3akdJNUIrMGo1clBXalEzNU5jbks2UUMrMVAy?=
 =?utf-8?B?Vno5enZaR0JPSjE2S0cyVjZ0K1Q1WXZURjJYVnRkZEZRb0lGYjJJamtlYy9s?=
 =?utf-8?B?ZnBWVXJ6cEhGZXNBV29KMGo5WXZvL1owZkk1Z3h3clk3eEpmU2NxZ3orb25B?=
 =?utf-8?B?ZzY1ZTlNczRpUzdKSXRXN1E2MHpQM21uclJxT3NQN3F2MFdJL3JWOWNES0J2?=
 =?utf-8?B?YjJ4Q25WeDhSODhQMDlzV1dIZmZsazBQRS9iYjkrSVNZZjJrWTRyOGJtd2l3?=
 =?utf-8?B?UUZCaFFaTFNNbFJSa05Od1VyaUJyNmZQZDVzaURrKzRrRFZIcUgyU09wRG9E?=
 =?utf-8?B?SytnaG02bFprN1dkQ012dEZZM0R3akpFZURzNWJsNUZoU2NjNXUrbGo0amww?=
 =?utf-8?B?K2tPcmVVczBJUHBJOXdza3ZlbjBCYlNyT0d2TFhSVExjRUQ3eTc5bldCYXNV?=
 =?utf-8?B?NzNLVWgwZlBWZFdFZE95RUdVZGZIQ2tuWDBRbU9yYmNQbHYvdjkwUjhydzR4?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495f4d8b-2c94-4982-d1a4-08dca09b1a70
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:45:20.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYITg6ui0bHYoCvdflOCvFUPXzFLG0kR9dsEwmHmj37v10+6QzNV5H79jLl83VlWZjuH3F6xtBROOYDPvjsL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3178

On 09.07.24 10:35, Tobias Schaffner wrote:
> Add the latency treshold patch to next builds as long as it is not
> merged. Use the new treshold option in longterm tests to guarantee a
> worst case latency of 100us.
> 

This threshold should rather be per device: 100 µs might be tough for
low-end ARM devices while it is not really a challenge for
high-performance x86 machines.

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/xenomai_3_next_long_term.yml               |  2 +-
>  ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
>  recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
>  3 files changed, 79 insertions(+), 2 deletions(-)
>  create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> 
> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
> index 0edaca5..d5a93a7 100644
> --- a/ci/xenomai_3_next_long_term.yml
> +++ b/ci/xenomai_3_next_long_term.yml
> @@ -17,5 +17,5 @@ variables:
>    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
>    XENOMAI_VERSION: "next"
>    LATEST_KERNEL_VERSION: "6.6"
> -  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600"
> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600 -m 100"
>    TEST_TIMEOUT_MINUTES: 80
> diff --git a/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> new file mode 100644
> index 0000000..6adb7d8
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> @@ -0,0 +1,76 @@
> +From 032a29ccb649cc2d076f14e7769bdee8eba8ecfe Mon Sep 17 00:00:00 2001
> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
> +Date: Fri, 21 Jun 2024 09:35:08 +0200
> +Subject: [PATCH] testsuite: add latency treshold option to latency test

"threshold"

But I haven't seen this patch on the list yet? Why should we carry a
Xenomai patch in xenomai-images?

Jan

> +
> +Add an -m option that allows to set a maximum latency treshhold to the
> +latency test.
> +
> +If the option is used, the test will fail if the maximum measured
> +latency is larger than the treshold passed in microseconds.
> +
> +This is mainly implemented for CI long term latency tests to
> +automatically let the pipeline fail if the measured latency is higher
> +than expected.
> +
> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> +---
> + testsuite/latency/latency.c | 14 +++++++++++++-
> + 1 file changed, 13 insertions(+), 1 deletion(-)
> +
> +diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> +index 7856b48b8..52e315d9d 100644
> +--- a/testsuite/latency/latency.c
> ++++ b/testsuite/latency/latency.c
> +@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
> + char *do_gnuplot = NULL;
> + int do_histogram = 0, do_stats = 0, finished = 0;
> + int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
> ++int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
> + 
> + #define need_histo() (do_histogram || do_stats || do_gnuplot)
> + 
> +@@ -536,6 +537,12 @@ static void cleanup(void)
> + 	if (histogram_min)
> + 		free(histogram_min);
> + 
> ++	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {

Overlong line, I suspect.

> ++		printf("\nMaximum latency exceeded: %11.3f > %d\n",
> ++		       (double)gmaxjitter / 1000, max_latency_treshold);
> ++		exit(1);
> ++	}
> ++
> + 	exit(0);
> + }
> + 
> +@@ -614,6 +621,7 @@ void application_usage(void)
> + 		"-c <cpu>                        pin measuring task down to given CPU\n"
> + 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
> + 		"-b                              break upon mode switch\n"
> ++		"-m <max>                        fail if the maximum latency is larger than max\n"
> + 		);
> + }
> + 
> +@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
> + 	cpu_set_t cpus;
> + 	sigset_t mask;
> + 
> +-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
> ++	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
> + 		switch (c) {
> + 		case 'g':
> + 			do_gnuplot = strdup(optarg);
> +@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
> + 			stop_upon_switch = 1;
> + 			break;
> + 
> ++		case 'm':
> ++			max_latency_treshold = atoi(optarg);
> ++			break;
> ++
> + 		default:
> + 			xenomai_usage();
> + 			exit(2);
> +-- 
> +2.40.1
> +
> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
> index a2e8802..07a63ec 100644
> --- a/recipes-xenomai/xenomai/xenomai_master.bb
> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
> @@ -15,7 +15,8 @@ require xenomai.inc
>  CHANGELOG_V = "9999-${PV}"
>  
>  SRC_URI = " \
> -    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
> +    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV} \
> +    file://0001-testsuite-add-latency-treshold-option-to-latency-tes.patch"
>  SRCREV = "${AUTOREV}"
>  
>  S = "${WORKDIR}/git"

-- 
Siemens AG, Technology
Linux Expert Center

