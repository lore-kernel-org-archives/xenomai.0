Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3026AFA
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807182; cv=fail; b=JgcnCUV8lRBEN+hiRITr8NGEUqbSR2ovHQIoif35eF0brK8t5TCamYX42lxiBMvKfTO6wyEsrR5y84m7UN5GxbWVFy/KT+1YArBDMk4nh2WA8bK/Km/lGfVo6LTM4GQf/ui/f0dmgMc5qM0AbF6sDkQ6chU3JbGtEtpBCrrDfbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807182; c=relaxed/simple;
	bh=xc06WDT21+eC12KUIKinOZj0heA8bzmgbPbQB0uJX20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9f5UHZ5om3swzYKtKl2DXB6nIOZaHGEVsW5HDsTAqE0tBEKHafz1JZOtsVTp61Dxi2hf8aXpqkjLrN4jDTT70qUgIJPgJbzYVjLel27VYye8YSgH1W9hJ9ReJV0ze2N+g7keGQE3rE2ZAAl2lDAn2Xwo9fcWtUSjTTgCsUu/hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=phXoafDH; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="phXoafDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3U+VLMNfxuYePLBEMuF+h+nWoCh76vJeMnBQyEKRcbSUOFG4+e3e5e7Tn/0pJLzYO3QbPtv2r23vDTZJb4XgVdkeOMF32RrRn7MmpBYBh8Cch10R8yT5HNihCuIEte89531mcGGjE4zNP3/f4t5heJygPDNmrDeJTvxsE2Seuzg/aUPZ4CkSgyUSlYAQW68rPdK2KGywSip6sJMOeFV0ub5t3YQZwqW7Pkoxazyji94Kn6jIhJoEFQrDRTns/h+egv9umwyFMHt01+obuqhSUiG26QRuLoYHk/PNqM9xbfSZQD+Cet7rBoTpB9AW9QXFyDObcQhmOb557fiBD/7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSn8oVbtI3EbVDBbJC2qcgwquei4SlEfLwD2XsCzlz4=;
 b=e46N8uLKWFQE8A7apq/u2nTfHrBSQAKR2BXEimKnD7ll3d1yslQFoA84MOp/Q5rvOtEgDTX/CC4Rf8OaFKu6KbOd3CbA5pEG5BWKVYpXP9ai5DirEqxnRmK8wrJbGKYc4xwzzjQjjYtwIinNC60/hNdPAwfeyZrbMdmJ6efYMLXZs4Fl5xzgnMFrOR9d6+w8RdRwqbHR/J4LvM0xJXyFWbsI0J5X0zGt/OQ6TxWzOeB9So7p2R0KYcRKzwuwwDY8dxlTR5mfKs55mBBqrBVnlvVNJcvevf7cpfBoutOW3/pqSzG7OC2o/ocuMH2sN/rTDQpVcyzgbfaX6ve/mU+NKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSn8oVbtI3EbVDBbJC2qcgwquei4SlEfLwD2XsCzlz4=;
 b=phXoafDHNjs9JpC5oR6bdzERE70hMDVm4irlGNJlhyJxDtWMwj78xiPM0TD6+7jvP06biVzgJWjp3D/7QBcBZiM1pTk0MDsLaBTOvxnVEzbqZbttCPyTMHGM+9vH5oDV6AoOIcrOEw024GdE6DcSQUU8Go9rSQRBUB1fKTJ07YqRMOicOQaQgWN8z22ATv49SEDHaPrmnKrRYb2s2ET96D2ziftHC0a2DVLfCqxFgmLjLN+SML+hznu40zrv2vOYJIlkKLD9kZZNz2XCGkRB/U/M/a47bpBAFahxunP7O8dLNsYaQTKF3PVht9BIU7dwnA9uOtUJmQDBAJYD4ZpaqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:52:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:52:56 +0000
Message-ID: <67f9e18d-f8eb-4b79-8ec5-97d73f70432a@siemens.com>
Date: Mon, 27 May 2024 12:52:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] prepare-kernel.sh: Fix shellcheck SC2046 warnings
 wrt. check_filter
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-6-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240525115806.12101-6-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf61fb2-1adb-4613-2734-08dc7e3b2aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGF2cVpwdERsNWRqMWx3aEJxRzdtYVpFb3NxcEdERGU2ZWtwWGRWTjJYM1pS?=
 =?utf-8?B?UHpCRHQ1Z0V1TDBJSTdRc1hCTVZ0WjNsRXpBWTRXc3pUcVpIRGozZXZ4U0NG?=
 =?utf-8?B?VE5udC9lTm14R2F2dG44SDNGSGpSNWE5SHJsQmh1c0EyQk1ueEJGZlZldHh0?=
 =?utf-8?B?Q080Uk41M0ViS0FxNHJ4OFp5bWhqTC90OGJVQ0ZkRDd2ZWdYd21uelU2QnNY?=
 =?utf-8?B?Q3NlaVpISHIrNHlCMEozbm5VZmMybkc4QkpUQktnWmdYM084cTFWaGpKR0dv?=
 =?utf-8?B?RXZZeTBSeXQ4MXFqbnA5R0l1SllJNWhtME1vM0pPdkp4aEVKOWp3VGtGbUlO?=
 =?utf-8?B?WGpCY05ydjU5Ymk0S0sxeTAwNGR4NHhLd3QxSVMxWERVc1l0SlB0R1FkVHVY?=
 =?utf-8?B?Y3V2VTdmSEpXU3ZGcUtrWElIN0ZoeFVDV3RHR082TEYrY0doMkhvTXJqSkNP?=
 =?utf-8?B?MEswNk0wOStWUDZKUmxsWnZROXhSMHVXWGV3VlJkS1NOY04yWjVOVEFpSHlE?=
 =?utf-8?B?UGFrR3puaVg2dE1NN3ZCY2RlMW1NZVZ2bGJxejdoMnRRRkRDbEJ3em1DSU85?=
 =?utf-8?B?U3MrclBabk9QRE9WK1NRNFpzclo4d2NVVDhyQzkweFlaTno2bkt6cTN3VDZO?=
 =?utf-8?B?YkRyYndIRU1vbHZiVGV5UXdOZG9oS1h6S3BBL3VubDRrOXhCVVZ3TEM5Nm1Z?=
 =?utf-8?B?MVRkTFJBN3Y5dUNtbGRHMkFzK3IvZDkzNHdZQlcwaHlFNStVeEFrYU1sWndB?=
 =?utf-8?B?UElIamdqNm5DZ3ZMeDlIRUF5S3hnYnJldld5eFNGaTNTcjNNVEd0ZEpHUElu?=
 =?utf-8?B?OHBhdjhmdU5lNHd6MTlrMVRySzlGT2wyV1Q1VWF2NzNyN1FuRWVoVFFJWjFk?=
 =?utf-8?B?MXRXUXZFZGt2b1JobUx4K2p2aldlTWlrVTJPU0pFaFdVUjdnRStSczdQc2NK?=
 =?utf-8?B?ZXE2RVRWdnNVTkk4MWNGdGR3b2QzS3JnTkZMY0pBRUVqRlNiM2pwWHFuOG1P?=
 =?utf-8?B?R1I1ajJYeG0wMElGR3FFMkdYOWtvZU1BZ3FmcldUWmkzYzYwSElsMThiM3Jv?=
 =?utf-8?B?QjFhRzRwT1BLUW84N2JTZjNkZDNUcjAwRmVlTkhnRUFGTWZyd2E2RmY1YTRC?=
 =?utf-8?B?TDdoaGpqL2Y2YVNaY0FSdkxKdWZHUWxtejRWbGZYbEJwbW00dmNPYnR1bGFW?=
 =?utf-8?B?eFhtRU1vSFh2NUxvcVF1THhpUmJZR0RTVzRNUlcxMkNXTFhMRnJyKy9EWGVt?=
 =?utf-8?B?cnRtUUxUb1E1L2lQV3VuV3NnaFU3MkJKbksvcVNoMGdRNFFnVVVlSXNLRVFD?=
 =?utf-8?B?SUdRa1pPVDVBbDBEYXF2aGFWdmpmOUFubkVQV3pUbzVOVU8xZzFDYmlaS3U4?=
 =?utf-8?B?djdWYUM5UzNia2I0cm9OMitzc0NNZlFIM2hBeXEzSklRMXZ3L25saCtSb24y?=
 =?utf-8?B?YzU3VmkzS2IzNkcxTFIrd3NZWlQveE94NEdvMjExZExXUTNRazdlcnVlVzNW?=
 =?utf-8?B?SzdyWjVqQzV4KzZ3ZFpaVS9CaXc3VmFRb2pQaktzSS9UdGtFaXBxcExVKzVn?=
 =?utf-8?B?ZkFMMlFRejFteGFEWi94RFU4d08ySlp1U3lhcy9uUHhiNi9wUEFtWUJraUJx?=
 =?utf-8?B?aWw5aXRFMVRua1I1aEZnK21WNjZSbENTQjlXVzZOaC9VSVhuUU80ZzV1K2tH?=
 =?utf-8?B?cWN5Q3Z1WVBKWU5VODd2TC9XREhFOElIY0s2Tk1JZXRVNkhBUmp4Yk93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDBiMDJ3OHpGSXA3N1Y3bHZBRG1CWkwyVXpRMFcxVnNTZTlCdWFIZWx1dzBo?=
 =?utf-8?B?cVBkZVVvblhyNWc2M2hjdVU1clNYNURzNUtsM2FILzZYSTF4WlEwTis0QjRG?=
 =?utf-8?B?UU1nMDJkMmppeDY2cWpzOGlDaUlXREx2dEl4NEVpd2o5ZktERkFrUkNiK0J6?=
 =?utf-8?B?Z3N6bE5NcHd2OU01VkxyVE40UExRNm5rb05OUFk0a3RXdm9oUzRtcC9BT0lT?=
 =?utf-8?B?bDJtSUpheEw5RjUrS1Z4U1JvV1RLS0o2d0w5UW9ldUxBVHgrUGxETXM3Vkc3?=
 =?utf-8?B?NkdWUlBaVlNkcGo4WUtGWjNhbUxXWUZReFpMVG1qVExMRzFWZXFmY1FHaEo5?=
 =?utf-8?B?dXlGV0hjZE5NMVJNeHlPbkNLK3dzT2tkaGp3emxrd3FBYldxV2JRWStONnFJ?=
 =?utf-8?B?TlFpckRPUENrRldnazRjOTArY05xZHZCbGNLMmZUUHhySCs4cENlU0R3c0dW?=
 =?utf-8?B?c1Vra01pYk1xQzNibktEUlFKT1QxSWFPclg2R2w0S2twOXlsSHRVeXBxY0pz?=
 =?utf-8?B?dWc1TlgyUU8wSUVlZmhuL3pJMGJzejFDRzZyRG1HSjBFc3lWeWRXZk0yYUt4?=
 =?utf-8?B?aTVGa3Fobk55bmNIM3VNUXV0RGlYQVpaU2I2ZDJoYWhzeUI2T3BGQzRWNXJz?=
 =?utf-8?B?bEV1ZnJxYkMycnBlbW1VWmJwMU8waXNyS1djcnE5UjBnYk9OVDZjKytWZzl3?=
 =?utf-8?B?YWZ1VHEyemsvZHNSKzJocmJ3OHhSblNRM3pvcHlFRHpqcENnWlgvdm1IRWtR?=
 =?utf-8?B?ZFZSMENKT3JpU0FST2d5dnJ3NDJCUEllMnFRc3l6a3NreFh0RXYwZXhFV2VD?=
 =?utf-8?B?NGw2RzJraGQ3WkxYMDNRaWdlNEJKdFNXa1ZqcTc4bUpSZVJtZ3B6VlNSMWZm?=
 =?utf-8?B?STlKSHF0R20zRGZIeVFCaTlRaUphWWtBSTU5L1VxSHNmd2FIVm4wWm1jVjRS?=
 =?utf-8?B?ZGNnaE8zTmU5ZHNmTmZpUVgrYVlBdWlRYnhaZGJyU2dEekpvcUFaNmQ5V1lv?=
 =?utf-8?B?RGYxVk5lcFNYOHgva3o3OGwybi9FV1duYWtpK282KzZTbkt0bC9yRDJwYVZw?=
 =?utf-8?B?OVNVZHllcWlNZTNEVUtGb1BmUUdSNW1WZ1ZNMFpUTlcxa0kyTGVNVXVyUGY2?=
 =?utf-8?B?V3lxcmJBbE4xNWlDREhrMWdDWEJPTWp3ckZicXd4OTJSM0VQd2pmV1VJdHV1?=
 =?utf-8?B?RU9id0pobk1zb0Q0alBhWmV3VzJ2Y1QxM2ErVFJYR1ZTNnV5RWtaMzdvVUFO?=
 =?utf-8?B?ZFdpQXc3eHc1ZHJSOU5meTZVdnhscmV3YXhkcWVMRmV2QU4rRnFlazlpczhq?=
 =?utf-8?B?Y0RXUmtnbFB0VHJCeGJVNHFsVGdoZnZwanl1V2lMcjNTc2VsdzcyNDFpeko5?=
 =?utf-8?B?Mm4rZjNEVURvZ3MvdDhVNGZmUkZDYndvcWl2dHl2dFNoeEdyamFXdkhqYk8y?=
 =?utf-8?B?cW56TG9VMkVBZTJ6dmoySWJQNkJ2WWYyZ0g1VFhVN295QXpZTVdwQU5sNmJr?=
 =?utf-8?B?aTNzaG5FcDBId09ManpzbGtDbU01MkNJSnFpS3NCTlhINTNrZkZkMmg3NnAx?=
 =?utf-8?B?a0FaZFIrdjJZWldULzcyeTdBMlVxTzZYaGN2dm9jQVFKUGcwbExGZ1pjdzIw?=
 =?utf-8?B?SnlqajV6UXFkc0djOWg0QzNPQk9zRzVnazhXQVM0ckFMSjJCaHFtVkNxakhh?=
 =?utf-8?B?dDArZGtOR1M4ZC94bXRBc3M3MUlKNzMvWXZ0UStxdVcydmZYdlJSbDdCMzMr?=
 =?utf-8?B?TlNsczU5KzV1VXN5YUF1S3FPWFRMbDNWUytjekhueVlLWmtLekNPYUFLbCtI?=
 =?utf-8?B?dVVvK3pOV2xFUGFwSmZKUUlRclEzd096aE43Z004TTJFTGllYjN4RTBtN2N4?=
 =?utf-8?B?c0FiVUg4cmFMNGxldUJvTzRjaHNKN1RBenZPT3JDQjZTS09OdVYrZWxSRGND?=
 =?utf-8?B?MEUvZnNUdGJMb1lvODEyakxNcGE4OW9iLzFIQloxUG15T2VsM1R5anU3Qnov?=
 =?utf-8?B?RzZwSmhLWjBQTkJ2dGtmdFhHaUxlckJEalUwb2x3N21yOGJGcWp1Mm1sekgw?=
 =?utf-8?B?MjhQVS9jd2lJR3V4UW1EVytqSzJvd1BwV1R0eW9GRVFrNEhMVFRLaTRrUllr?=
 =?utf-8?B?NjZYc3g2dFkxenNhSVN4d1hiYy9DUzFIR25iOEg4cFNFbER6MkN0ZUovSGVB?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf61fb2-1adb-4613-2734-08dc7e3b2aaa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 10:52:56.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2otGcU/RPw90iBXYDZvRLVUTjPVIX5vOBmkNDfOoCr+prB14g6sc3U6sD0FTVODbmelEONhcfO6Vgj594hgklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8131

On 25.05.24 13:57, Richard Weinberger wrote:
> Fixes:
> In scripts/prepare-kernel.sh line 64:
>                 if test `check_filter $file` = "ok"; then
>                         ^------------------^ SC2046 (warning): Quote this to prevent word splitting.
> 
> In scripts/prepare-kernel.sh line 126:
>                         if test `check_filter $link_dir/$f` = "ok"; then
>                                 ^-------------------------^ SC2046 (warning): Quote this to prevent word splitting.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 800528058..d8d63397d 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -61,7 +61,7 @@ patch_append() {
>  		chmod +w "$linux_tree/$file"
>  		cat >> "$linux_tree/$file"
>  	else
> -		if test `check_filter $file` = "ok"; then
> +		if test "`check_filter $file`" = "ok"; then
>  			patch_copytempfile "$file"
>  			cat >> "$temp_tree/$file"
>  		fi
> @@ -123,7 +123,7 @@ patch_link() {
>  				fi
>  			fi
>  		else
> -			if test `check_filter $link_dir/$f` = "ok"; then
> +			if test "`check_filter $link_dir/$f`" = "ok"; then
>                      		if test -e $linux_tree/$link_dir/$f; then
>                          		echo "$me: warning: $link_dir/$f already present in Linux kernel tree, output patch might be defective" >&2
>                      		fi

`command` is legacy. Can we switch to $(command) at this chance? Applies
to succeeding patches as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

