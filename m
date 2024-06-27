Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934F14EC53
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487927; cv=fail; b=QSWGdKvASElFj8VDGtu2uMIlF7mRc8upe1kaYC7QiH0el+qw6f2cnrUjTZQ+rU23cHQUF5uNlzn0yFWdcsuLKtxxbvhJWJHy2ngaTXtFtoWe43njm+kocI6HyG+CSHXDPB3bNLK5FFPddzpxkCA4UMymK90CIxApzmq3iRuHrtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487927; c=relaxed/simple;
	bh=pd/luFtkbBt2XyZDUnDGRxIEdCuQU66T0H8SL4Ja1C0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mWmuQ6g6UEcREgL6p21G/PskTZN446UPidhiCqrSpqy8cJchxH+rSM8vfWNQCCQ6hKaDhYdSZAD4EVY8tg45gNjrBk4cTwIDhO7m6A90L7itGt022uXEj5T2X63fksiHp3MPkHx+1Si3/XRdEZbyDT1kLqpMmp/zr2orSsJMEA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KauCbjwR; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KauCbjwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQykFNjgHVMhqT3wIdHmdzmw5kXvWaFJobiGSOqRDvfneWqNT5UspsnltNeXIkMN3WXNTZkJWy2z5KMPNIi+PHt/5lfvT+itVFVKLRGJQZkz6NVg1C+gu0/e+SMJKOwTlCMjOi8MZ2PJ7nnwSZhqT6kO3kqi6RaaRoWW34Xs2CxXLIrYfIiCi9dz+ag7VZ9Atg4Gdf2bADYhsK1zFVVg95KPDqQCx2jl726QNrOw6wsiNANsV0NbTkkaC/6soslCQt8qGCv0FvjDefbXcMgDABCr9i9Qv/QRlLsvzPNwBrBDYed+TcLJh7KBbF4YIFFx+zZMlHImdvDWHSvccqv7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tvJVEq8g3uAzH6LmIdK2EdYkxp8p0rE80/MUx9G6ww=;
 b=h0Qku2ZzL++RpmM0624dm61PUDWfTFE1xFAL/NlTBmAUQvRzy3mLBLQvfG7to2UerwCM+M/U31D05f8pP4XFPmCdCpKWDroNQ7a0bcJ1UHPRbMTd3xki4YkoaoTE1rCP0UrWybJNg1T25FtM9qHUefKZwC8Eq2tZ/C3y2UYY1pBr4Os1WRZObkHogz0bHGUFkNU8xGw2sWWNbQqG0OHyZuTwZXRTiRy/cSTY+Oq+steB1E0KpEW4Jn3p1zdikygP6FI/4MGC0WM2pKBCWhn4j/bBW1tcqW3KgCmI7imO70tKYu+fShO7u0z3JaWUDUQ81KW2BGlRATpoGH6kga3SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tvJVEq8g3uAzH6LmIdK2EdYkxp8p0rE80/MUx9G6ww=;
 b=KauCbjwRmjeMnqAxVx4ENR5YukMo+ce684LTtxXA0kFn+Jh1gPExNLFzd3TzE9y7FOi9C+wCREueh9PBxnx5YWqHiqvaqbx+tZuGPHJYCi2pr3OjBpMyaCesE45soI0StOdy+TxnURip/QLoDZYsNTX7KP0rgAJTjxiLaqFctFbGAzrIy+o3UvbDJJSaNciARoHTX8281fmXLi1y3jzO6jOzl7qSLJQ7bQeQQZY7/BVtdaxgDLqMw2FYnDdvXie86weaPPlztYNf9euGCkfVO7kSfOimoN+dLHVjRofrun+db5p09YQ0y3uURiXFk5MqAFuBY+3o+pGBfU9tkk1NuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:32:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:32:01 +0000
Message-ID: <7d37d356-7a20-4ec3-9907-ace3c31e99f5@siemens.com>
Date: Thu, 27 Jun 2024 13:31:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel: Clean up generated syscall_entries.h file
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240627085434.8189-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240627085434.8189-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f8a0bc-3c87-4b1a-b3cb-08dc969cc360
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzAxM2RUd0pCYTJKdnZ0RkV5YVJDR1E1NzkvQ2gzbmd2Q3MvNWEwQ3hGc2N2?=
 =?utf-8?B?M29ZN0FGUWFaVkdnN1BKUVE5eDRFTEZPOEhwMFE5cUR4blk1MjZ5VE00dHBs?=
 =?utf-8?B?a0NCQ0p0TXNRYnhUZEpuakVyMEROOFl3aU1sL2xjNjFMNGx4aDVLT05iRWwv?=
 =?utf-8?B?WjJvcVd1QWhWdGZub05iTmo3SDUzVEZjbFc2WndEWVU0Y1dLSkZNRHRsbUtt?=
 =?utf-8?B?Vkh6dWhLQkEzSlYwbk5FaFlIRUc3VDVBNENjeEtHekI5bTFhVDgzTm9pby9S?=
 =?utf-8?B?RXdXOG9sbEdhVWVlNHlaWm1rdE4rM3plckVBYkNXc3p0NjVaSVc2VUV2R0gw?=
 =?utf-8?B?UnFha29kTldDK1JFOS9OVzNkWXd3akxSWkNLNnZ4S0NSMGVBRDNERG53bzlm?=
 =?utf-8?B?U2xaZSt1QVNFNG1BcnQ3bnA0N2I2MTFRRDQxQzF2TWpXME5CdmtFQStxTDlD?=
 =?utf-8?B?T0lDa2tpZnpFaW5SaFZXUGNLbTIzeVZaV0Q4YTBDUVVVcTFic1cyYy9lSllw?=
 =?utf-8?B?R3YxbEx2WFZaNjJTWm5TOXJVN0cvVFBqQnNrYUVCblZheFE2a2syMkFQQzBt?=
 =?utf-8?B?L0E5SmsxK0ZIZnR2emhOM3RZS0R6ZnpDM09KSXpjT09XejQ3ZHQ3dUsxQTgx?=
 =?utf-8?B?aWFHTHp1YjdsL0xVK3EranBITlFOb09hKys3czNmcm04UXZ5QUVLTFN2WGho?=
 =?utf-8?B?RVBscGJXdEdTTmljREUxeEZ6OFlwYUkzWWFGQWo4Vm1SWEtPU0x2bWdXVkpp?=
 =?utf-8?B?dVFrRTF6TUp4R1U5bnEzZHMwWWNjMllQNVFhdmRaK21iSkxGUWczdGZ0ekVw?=
 =?utf-8?B?eFNnbUlBT1BwVW5QdExCSWZMOVd2Y21MQVBSUXVnMFdNK3R5SDlyNXFmUXF5?=
 =?utf-8?B?WkhWenlQc3UxV2xPbVQrUG14dHJ4QXpDS1pNeFhWaXBTRTdJbjF3cjdKeHVh?=
 =?utf-8?B?a0xxTjRHekk3NXY3Z3krWnEzM2w4VGRlamFtN3phOHlTVnZad1gyRitrUXJI?=
 =?utf-8?B?SHZzZDEyRWRpU1l2UGxUa1JxRS9meXBGeFJod1p2aW1hY3djSXBEV2JaaXdn?=
 =?utf-8?B?MU83OVRENFM2TzY2Tkp0WGVyeW1iZTVGWDQ0UDVaVVRub0J6U3M3dTFnMWVQ?=
 =?utf-8?B?NU9uNEE4OUR4aTVVTi9CTlZSSnRiajg1Y3F2bUNqQW9kRG1XMUgva2tTdmQ2?=
 =?utf-8?B?ZThpYlFldnlQdyswN0JTelp6RHpISlJJYmhncHNWSG5VN3RZNEZSVlRmWTZP?=
 =?utf-8?B?MUpmQ3ljdUZKYXFLZnpuVlVoazVTeEtDeXAzUXBjOE10SmxvZHZwemhyKzVP?=
 =?utf-8?B?ZE5KbFJUa3JsUUhLZnFUZFFET2l4L1gxSUlQalVETnJTSS93QlhrSWFGdFRi?=
 =?utf-8?B?MHhhL1ZSWDZTMkg3alRXU1duSjIwKzd2ZUlyaXpSMmdad3FaT2V1cnlYM0dF?=
 =?utf-8?B?cStIdU5CanBjSmw5ZitEWW16T3BGMk0rVytVamZMbzZROTcwSzRvWlEvUkFB?=
 =?utf-8?B?RUZBNmhHQ253ajZCa255WHY5cFdjYWNoU09oODhydHZweXQrZHgxLzNXejlN?=
 =?utf-8?B?UGlWalBFRXN6ZlhKNy9xOS92ZEk2NVJiVlF4QVgwbzQyMHIrY2M2Nk9uTTlH?=
 =?utf-8?B?YStqNlU0NDRsNFlhaGlxbCt0TDg4bVFOaWtDUGVjaXA3VWdHYk55eHNZUzk1?=
 =?utf-8?B?dE0yVno1YmxvSmh3SFpNZzFoN3I2UkhTclhLNkF5cWljWUN4Z00wTDFwZ1JQ?=
 =?utf-8?B?QXJUa2p3cXRoU1ZrTG54SHlBVnFDZE05cnEySHFUOWJMcE8zcExQMXNhMG5t?=
 =?utf-8?B?R2xnRTFhMkRPaFpqTHI2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHB5NjFQNzBUeE04QVJQNlVxMXVNQ1B3ekZlQnliTElESjEwbkZ6dXNNYTdF?=
 =?utf-8?B?bmxqUjFKTkE0TkRwdGpVdDVwS1gxVHlHZDc5Z3p4QXBESHVpd3RvRUR3M1Nr?=
 =?utf-8?B?QnBLbGFVTkJ0OTVyZ1k5N3VwWW8xbDQ1MXZoR1NDU3BRdFd5MkJkNlFnZkhZ?=
 =?utf-8?B?c29MKzk5UUFEYUpCMGJFZWpvU2tPL0gvRGdBUlM2eEVyOTFXTzdsbXRFNHlM?=
 =?utf-8?B?b0JnMFhtL0lJaHFSRXBnVGZQSm4xbzhRaVJsMkNzUW55b0xia2l3VUJ0SG9K?=
 =?utf-8?B?QXFsR1pVRW5qbmRQS2thTldXaWFpNWMvZ1R1Y3ZzcWp2VHc1emdiNXlrMVJJ?=
 =?utf-8?B?a01tejBHdjczSFNhSTEzZ0VNNjdBYmNoVy8yZGc1WlpnUmFuZGZmcVhoUEg0?=
 =?utf-8?B?V2FCWW9iQUVWMk5hWHFFR2NIbUZZS0ZGaU5GNFlQTlQ1SkhuYVJTYTJRaXJF?=
 =?utf-8?B?d1VSeUJibFkxdXNEMHV0QWcxVEtJM1VuTFo0cFIwaSsvdElSRHVwTEFDcEls?=
 =?utf-8?B?VjVkZDVNdDQ4UGt5UUNOTjdoVU4zMnRxN1ZFVElqOFc2cXRRRjY0ZnUwdlhv?=
 =?utf-8?B?YUM2K2sxQWlyZGQzMFNSK3ZrWHBWUndOblhUSFVCYUNCUGx4eGFUbWxaemFR?=
 =?utf-8?B?dzBtbFhYSkxOL3prVVBQWDRvemJZOG9kSDgrZlZiNFhqK2VhMEFUaGx0U0dS?=
 =?utf-8?B?b1J5TlFrb3FUL1lmNGxUQk5vL0NjVGdOZTgvUjV3T3JRYkxjWW9IN3BMdldk?=
 =?utf-8?B?SGdyT3czSU1HdTF2WVdyYi82aDRmZFVKeFYwZnRpOUFRVXFIcW5mRlZ0SElI?=
 =?utf-8?B?cS9kUlVyZldxY3daVUNzRDRBMUo0NTB5UmxQU0pjNUdoMDYwd25nc3l0Z3Ba?=
 =?utf-8?B?NFhXOE1TWXBOL3FvRFhhemc1TXRta3pDdFZqcjI0MVBoaXpsR2l4Sk1ZM1Ji?=
 =?utf-8?B?VlVQSHVlYXVyME5jVmhyRzZzTHFqWm1WZnhhVkdSV0kycC96VjBWQURheFU1?=
 =?utf-8?B?R1FDbUlRQmRGcEtzOGhncEZlcU53QVVMdDlXUDVOYXhtMUN0aEdlVnN1V2pW?=
 =?utf-8?B?YmpONllHTlI3ZmIvSGdSeUpJSTBYVCtZSzBsbjQ4cEs0MlQ4RDRwdDNoMC9I?=
 =?utf-8?B?ZnM5MXBpK21KTkV3ZnM3NmJpZnl6Q0VlUW9wSXRyZGJSUUNoTUovOHMwR0ti?=
 =?utf-8?B?N3p3OVRleWltWlZ0aE5YN2JzK0g1bGw4RktyUy9kanhZQ202VXQxMGlZa3Vq?=
 =?utf-8?B?eVpaNnlpUGE4TUQyckpNQ3FDMDc1a0JUMGNyVlRBWkVtTElpSTRCZXBOWlJr?=
 =?utf-8?B?dFdnajZjQ0MzaW5LSVhPenh5MFRyeS9XZjVhV3UxSi8zT1JzTFhMdlk4dUlU?=
 =?utf-8?B?bXR3RG1nZXpyeWVLS3BJUG5GOFNXLzV1Q3llUzRtZ2hTTE5MYjN3SWxrcGQ4?=
 =?utf-8?B?WUxzMFRZZ05jeUZtUERPTEdiRHFXNng5QUpxd0ROTDE5ckp2NTdRQlh0bXFs?=
 =?utf-8?B?Qk11M3hRRG1nMWJDc08vSTNKTDA1Smc4b29FbzZXM2twWlNWaFowaHZKODN3?=
 =?utf-8?B?SWRaOS9SSDRhWU9YemgyYTVGS1FDSzlZSFhQYXFZMFdMTWtkczY0VHhYQmNu?=
 =?utf-8?B?WW1kMnhURHZjYi8yM254M0R5SU9VNGVpVU9FYlo0VWw4dHp0TjdTQnJHQ09C?=
 =?utf-8?B?OCs5K3QxeXdKWkVmbFBRemt2RndZa1NaM25kOGFuWUw2b2lhWUplMEF2K3du?=
 =?utf-8?B?ZzZKbHdtMzhzWGZBZTZlTEZXL3RHVXRBNk5mNm1mMkh6ajhMdFpqRkpOMHdw?=
 =?utf-8?B?WUJTM0loOUtXS3VPeWY3UklPN0c0OWYxOEw3YVVMZHE2bUhtSkZjUVovUzVy?=
 =?utf-8?B?UGxGRzlPWk5TQkhOSDhIdGtEbGpaSHRxQW9xV2pkWmMxSzVMUGMvY21hMkxZ?=
 =?utf-8?B?aDNnblg4RTN5YXlJQXVmZHMzeW5ML0dXaDNvMkYrYlBISnFjdXlkek9seUdj?=
 =?utf-8?B?WC9iWVAvczJZOEtvOWRLTGFiUnVyMzFkSTJWVkplSTh1bkZ5MjNDK3JVL3I0?=
 =?utf-8?B?dVo2OW81Zjc5TGM0aHVJdlFjcHVKN0pQM3NiaHQxek1mNEdIbnZvWHJBT0R3?=
 =?utf-8?B?aWxnNVpSVEwzVXBTcWZqMndXczJUVysvTFVXV09mT3VpTWJzdE5RQTU1alVG?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f8a0bc-3c87-4b1a-b3cb-08dc969cc360
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:32:01.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OWtel/Wvfl4kl6XYS5rWTEzghm+Inn2fvgkMjlArZKBfGUGOqbgDh/lOIVri86HF9gaZZQKFbXPuUQi8CqdVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063

On 27.06.24 10:54, Richard Weinberger wrote:
> Add it to the clean-files list, such that Kbuild will remove it
> upon make clean.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Changes since v1:
> 	- Keep target, it is needed because if if_changed usage
> ---
>  kernel/cobalt/posix/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
> index 5b4f3214a..852d221e5 100644
> --- a/kernel/cobalt/posix/Makefile
> +++ b/kernel/cobalt/posix/Makefile
> @@ -32,6 +32,7 @@ $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c) F
>  	$(call if_changed,syscall_entries)
>  
>  target += syscall_entries.h
> +clean-files += syscall_entries.h
>  
>  $(obj)/syscall.o: $(obj)/syscall_entries.h
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

