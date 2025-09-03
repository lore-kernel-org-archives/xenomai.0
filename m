Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD5242925
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920965; cv=fail; b=aWirsea9+XBq4xwVzVidQ3iya93TEQMtR6/QzjC8kJ1EkYgr8Z35rVcaNKL8MtAriD0D+yu+2XrU4rmzlCoPOgC4fFWHx8NXzOisnwGBrqPVGPGIu37eO0llVuNe3nzJmo1/3PyBB3zp/AHifipEQLm3a+lA9TNe5tuwaCpkRCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920965; c=relaxed/simple;
	bh=/FRWmRnbUkvPq4kxFTo8rFdGyUc7dqAAPtaFAadnrHE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=QM6YQdr3dQXFwEHDGPcbkm2CDoaZbx69EVo3Lq06XBTxkUYIUKhOpr6iNMMD38rRoL66jq2Auk4dMl55zP+JPGyZu4DrnFgOykLiujiZnt5XwDR3oOkBugKDEFnlvwDbKQjAQGvkdW9g3I7/1ZE/6Gc+K/lBa+XkiBpQy4A1p60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i+uO2Nj7; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i+uO2Nj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngz80jH1OQ2x2SAO4u3ZkB9r2CseGN0hXiVhmo0oQtHLTl9LpkYo313ALIOCAa+j6CtRUCP4tCmCSvnChAc/0CMu5NJyCEYENk5dtmgE0h4I6nFZbcRvbG5cXIt3WsGTo1ZbcOeGR5zQJN6Nvnot/j/ji/slMjLFRNT13ZfebD9bz39dAhuZEi+2+xrrSgTyLrBD0pgVtAgyImfjs3FmdXCm2/OAU4yXyzOxC+PZjcmfBDmXUgrZmeEKlm+6rdIXJ7ZnqszbtiSi4eSiFX8y4py4ARO+0u8lrBfwlrmv1uF/ZcMBJbMd1YnHR6WGedV+867+IPDMTCzeEO3nFElieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHj7RonWikFm4rqKlrVk0xpjk28ziSYE4+aPRKqYdgQ=;
 b=ne9uvA5CzosnXfqYUn03wz3ucPUlxVL5z0soCx8dvg2hV/qqnvhJjF6x1lgh72hOfhB4GfPHVjhm5Zf2uaRV8EvNmMoJFUHCGeSDiW/9r8XYnMJeQnqGcfqzvXmP0CV23PfliRoCih07394qyJxIv+wSbxUbtdyT25+u+j1w1cQ+UbDxlfxQT8zqJUtmcwtfBmQrua+STCLcPZGiBt8jmdunFnDwZ56M/oFcYrIJ24bfYFQYIVT781Xt+vMb5evehGwfO0/7tXzhP/kAvxJSwus1Ls965+DXexkF4VcId24HkqxuA+0TGmSXWPQnV1MABnYik6bnk0F5yEqWSC0nQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHj7RonWikFm4rqKlrVk0xpjk28ziSYE4+aPRKqYdgQ=;
 b=i+uO2Nj7jmHH43kE+3j6QEyCz1IKusg73VF8bkriQFYnzZt1PLmlaiTsAFhGaDHDMRymPV2xmwdj9QEKWXa+r+qIaTep2tBv4IH4Z9KQz25ZzIax+Xx44k0DtPyEairD4atfqL/u/v+AgorPtE5G1IVChq+f5J4ASimvrik0qeJ2/Q9rAPtFUF2eyAaow3LeKKlFsj6YKJs2C+SwmoEqW6feJefbU6UI8HYFln/ELmXVhruJAqWO9SMXgnLtOpiJhn+Ww+YkHq3eZP2t1W7NvyI02sAJbb4v5ev3+Fcjt81C4tFHTXMUMoTcK21omeI0xFJNLdrgC5ckzaaRRqwv5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:36:00 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:36:00 +0000
Message-ID: <e430b834-3c7e-4724-9146-b336cc5f40af@siemens.com>
Date: Wed, 3 Sep 2025 19:35:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] README: Update project URLs once more
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: c88a3dd1-f598-46fd-e8a1-08ddeb1058b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0U3cmhVUmd2YVM5QUpoa1o4OEM3d0s3V2Zia0MxeXNnNHhnU3NBdkEweEJN?=
 =?utf-8?B?RTlCRlRHU2haSitJQWFFdjBlVHhrUFE0Yyt1QytvdVhBeS9NaW9NTHBSWEZH?=
 =?utf-8?B?SjBXWE1NbTZRR0Y2YUV4UUw0a2pRTGZSMFV4SFNsMU9JQUZ0ZzhRN2FIV0hw?=
 =?utf-8?B?ZW9LOXRNd1dmRGVjbnlWU3RPUHNOZllST3RhUXlnWHNVSGViUnlzVEk5b3pm?=
 =?utf-8?B?QzZLdWJVdFkxTU9HYjBxQzJNUzVnK1d0aWlvVDdJVzJQeXhyUFNiNnRpdXd3?=
 =?utf-8?B?enhYb0QxcjI1dEVMMWNMZ29LNkhGR1FDREtKYXFTMWh2dW9ZM3FSOWs5WUNE?=
 =?utf-8?B?L0R0SGFpakxXZFJOZWg1WW5kbm9EcGU3eGY0Q2lRdkk0RUdaUHBXaXZ1WXNv?=
 =?utf-8?B?d1dFdUovcVpQNEdnUklPZmF3NDVZOGY0VUVFUjBTV1F6dFFDU3hSYlB3ZDVV?=
 =?utf-8?B?Y1VzSjdxNU5HVlN0NzN2K0NCemJVbytNelB6WFpEQ0lqcTZ0N1VRUTY2KzVE?=
 =?utf-8?B?aEFqdCswQ0h1R083aHR3TFdvT2JYei8zdnQwbXYzVUs0QkpLUXVuTFlxQ21i?=
 =?utf-8?B?V29tSHowcjh1OTYyd2tsc09kVU1NUFlEaTZWSmNRSkUvSFJyZDBTWDZhNmRO?=
 =?utf-8?B?Ly83RjE4VnNwNEl2MVVPWEpuQjhvSGN6Q29LeU4rYzVOL3FuTkZUaDJYK3d3?=
 =?utf-8?B?Tis4QlRsVWlrelNwYkdFVmxjZ05LL2ZOOWRweEgxV0pza0ZDS1dEUW85Qi9W?=
 =?utf-8?B?bjYyekh5SFhRaUQvS1FweE1DVEwxSUtHR0hWRVpaZ1JuVFFRY3JBbFU0RS8w?=
 =?utf-8?B?OGI4NEZUUnZMWndVK2JMOGhBRXU5MTk0OWRZdXRuRlZabDBJamtQem5DVXB5?=
 =?utf-8?B?WlZtSExwTXQ2bStjL0tiZDEzVEwycnlXWCt1NTdHdWU5dXd6aW1SeFBuU05S?=
 =?utf-8?B?ZERkWk45cVVTUkt5dEtqZGdmekdONFBsYS9tejJMWmFGRWdWdFBqTEVvM0F1?=
 =?utf-8?B?TnZ1Uy9hWkd6Tm1IRDZ0Z3loWUpYQm1PU0NPWEpaYkwrNmVPaW0zbzJyc1Bn?=
 =?utf-8?B?MzJpQjc0UVVFeHJFZm9IYWIwdFE2QldCMkdTd0Q3OEpqVzVQeTQwalpOQThC?=
 =?utf-8?B?NWtJL2UrTDJZMm5YMHhGejRKZFVhTnpyRmFXZTNMV0RkbzVnY2RXU3psWjBl?=
 =?utf-8?B?RWdaTFpQci9LS0o1bVhUNmZiejd2M29sQWJXTlU5MmYxbkNWeDFXRkU5M3V0?=
 =?utf-8?B?Q0VZT0hWVkRyMndvc1BnSFJUQU0wUUt3dTh0cWlPbVdBOEIxa2N5VldZeWZD?=
 =?utf-8?B?SnZENUY0WmlGdUI3NEhqejIxL1haZEl0QWZacStOUUVadE9oSXM5SXpROGZW?=
 =?utf-8?B?citRUnJ2MjJXSmxWcHdUS1J4MHphczBOcVBQdnJnQ1Y2OXZVYWtHajdSY2ds?=
 =?utf-8?B?TkRXbXBFbGh1ZXk4b3VVTE9iejJ4eHhqWVg2NmI5eklhaHRsK1N3dGFocUFt?=
 =?utf-8?B?eWdHcnFkdWVTVmg2ZXNtdGkzZStNWTZjYjBGK1NVbEg2N08vdXBkMjRsQ0xZ?=
 =?utf-8?B?Y1RRc1hhSTJ2TDJuUDRLeGdwd281bHVhZ2lUQVhkcVN1L3ZhdnBHOHoxOWNP?=
 =?utf-8?B?RkZjQ3podmVIQUxHTDY2aDBYT3Y0RHNzTC9VYzRPZHowM3IxVm9rNW9pVW14?=
 =?utf-8?B?TzYxWkpkWXdQcklJR282N3BZMDNtYndYYURaQlprREc2Zy9wQUVVclJNeFBJ?=
 =?utf-8?B?TnRHWkRMVXhITTFvazg4QVRPL09SUEdCckVtUWNGekNrR2xFY05nUkNleWkw?=
 =?utf-8?Q?Jo2WW5VRg1b9CgnuwJP+MeSIEWVnAKuzuaQLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtLZWFUZnFIVzBMNnZ0Mkg3NU1KNTFEa3FaaUN1NXBEbExPQUZIeE5ESFk3?=
 =?utf-8?B?VmJDb0ZsM3k2dGl5VFN4YUo5MFpyd05XU2FqRnhpYklyQ2JUcnRUUi9ON3ox?=
 =?utf-8?B?dXJFbk5aM1Jsb1NobkhzREozR2NkdytkbEl1QlFJYjZKMyt0U3FPN0sxdjA5?=
 =?utf-8?B?SXlFNUM0TURPbElYM2toU2MrVlp1UHArWVZvUnpKSUpObnZVOVBkL0JzWnB6?=
 =?utf-8?B?N0xzSEZWU2VTV0JSVXZlWUVHZnNDODBJV3VXakprTE5YSzhxZk1KRFFYT0Yy?=
 =?utf-8?B?ME9tZUpyamlzVmgyVzg3eTRYZFJCaDgyNUpGKzdIRHJENFFITG43VzZPZGU0?=
 =?utf-8?B?ek1YdFRqRDErbVZPQlRqY0ozL2s0a1Q0S2l5VHpLWlpYUG1LTW5DZVAwR1or?=
 =?utf-8?B?UzFVWityM3hiQlNvM2wybFhqZW9PU29IMktBcXNyVlFERWQrWkhoU1ZmVHI3?=
 =?utf-8?B?ajdla2tBS1ZzUXU5U05KY2crTTJzSFdSL25EY3hHSUdkZkRqbWczYnV4ejFz?=
 =?utf-8?B?Z3pnK0Mya3NaQXE0eEFBRlpLOGZEdWtVOFBTV2k1QW9ra3Jpak9HbmFQWGp2?=
 =?utf-8?B?eE13YkJwMzNwV1VVUGtGTG5mb216ODdGV2UzTXhmWWRCYnNrYzBOUXZKVzVK?=
 =?utf-8?B?Nk1wRms0RXFXSnpLWTVZNFpUMi93UlMxUTNtL29GdmZsajZtM0ZlTlVDYVpB?=
 =?utf-8?B?K3l4TG5pV2wvRG5BZ3J5SkRYbUNUdEVoVTRiWmRlSGhteWRqMDBxWkdUTGEz?=
 =?utf-8?B?bmRJSnIrUlVQUTB2L3NGUnY5Y1h4dzM4TXhjZ1hqcFQ5V0t5NWRZU01DeDBK?=
 =?utf-8?B?Q0lGWXB3WjRReVRPSVlleXI4am1Cb1JiMTRsMitaNEx5Q2xRczFmVDRqb2hr?=
 =?utf-8?B?b1JMMGs2bEFETEZqcitYVFd5aGdBSjV1OUUvN0w0d3B0dFlIdi8vdWNmRVVi?=
 =?utf-8?B?M3BBZEZmTWZwRWQ1bG5KQWJHck1KZkR6NG9DQzFzUEhUbE5RN3NwWGs0V29U?=
 =?utf-8?B?QkFkUStkOUx2bWlvdzAzRlh3YVBBRlZQeXhGZUNqQ0NiL2EvVkdyN00wa25q?=
 =?utf-8?B?WFoyNlNNSlEwdkZORmVsVm92OFNseDlVYmxDdXFlQXJKc0RqUWtIdjl1cTN5?=
 =?utf-8?B?UTdHZjByY1l4MytGWXY0eGlmN3Fjc1lBVFgrMDVNQzVXTjhLZzhaYkxzM1Bu?=
 =?utf-8?B?TVIrUWFlSHk0K1c2Y25XL3ZUUWptTEgrWEJzRlB5T2JjN2dsSmNzeUxaSTBx?=
 =?utf-8?B?bWZoU0NlS2owYVJ0aEVZcElFSERXL0VjcG5uaEgzMnI2OVdiOFY0Z3doaDNw?=
 =?utf-8?B?QzJEUHM2MlFsMHBWU0tZTmJGeDVKejYvcVlqZytxWFQwak8wWHZsamt5cHNq?=
 =?utf-8?B?TXNlelVMM1FvNnZUUjNYcHBKUTNOaDU0RVhxVkw5dnBTeXhWU1I5cWFWNEVl?=
 =?utf-8?B?dlhpekd2c0hGRDRSSDhPK09sYUdUcjA0SFI1YWY5RURrRjFKekxnZWZjb1hs?=
 =?utf-8?B?K3hhTEptMkhRdzE0NGd6b2QzdWUzZHA3UFpBVXU5a3ltVmNBNDdFT3lidWNs?=
 =?utf-8?B?Y0ZmSmdxNVAxVGQxZi9uTXlMdU4xb20yajZkR3hvZXByTzcydWpSNVVoNExr?=
 =?utf-8?B?aDdsM1J4RXBhUE8rTVhrK0xxOTlTaTNGbjEwTUtUdWg0NzVWNmlsczFQZHBz?=
 =?utf-8?B?V1ZtY1ZURi9zY0ExMUpBdFZlNGVla3JVSEx2bHgxKzZvYVZrL1dDU283UTR6?=
 =?utf-8?B?VEdTeDBqQTE5MnF1TWV3TW8rMzhVbVdrK2s0eE00b2xzbnNCcUo3RWhVd1Fj?=
 =?utf-8?B?Qy9XSG5rR1k4Tmh3M21abTVEYkVKQmppNVQ5S2haZkJaeTY5MTYrWWxyVjRF?=
 =?utf-8?B?MzJtYVpLc21RbjhIK0IxU3Q2TzlOWW40NVdyT25qV1daTTI5Z1lzNlQ0SXY1?=
 =?utf-8?B?Q2k5Mnd5Q2doNUZyVk5GVEFGUWUramMySFhEWFBab3k3MFZzaUdaZ0VkZzh4?=
 =?utf-8?B?OEtHMGdOTzdhZ3M5Q3pTMTlXVGtvbDQ4bnZWUEJmWlBnYUcwNlloNEFQUnFl?=
 =?utf-8?B?R3ZDbExxNEF0eEs5K1I3eUdCV3FOMmZtYjA5eXR3VWJobnJ0NEM5Z25rSWcy?=
 =?utf-8?B?bVQ3dmFlUzI3UlBzVHlkM3BvKzRiS3BkTlJzejZwS3BLMHZwVnZ6am5DRVNr?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88a3dd1-f598-46fd-e8a1-08ddeb1058b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:35:59.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVnxlnkOXMRuGIfissQ+UQreKwHGlo3FkSjW3zC+2KZj4m1X5XnQ0Rnq0HL7m1aKJgLrmIQ4Id7OtxMjYXDh9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769

From: Jan Kiszka <jan.kiszka@siemens.com>

We moved now under the xenomai3 group.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index cbb557808e..d974dfbac4 100644
--- a/README
+++ b/README
@@ -39,7 +39,7 @@ https://v3.xenomai.org/installation/
 
 - GIT clone:
 
-  https://gitlab.com/Xenomai/xenomai.git
+  https://gitlab.com/Xenomai/xenomai3/xenomai.git
 
   Once the repository is cloned, make sure to bootstrap the autoconf
   system in the top-level directory by running scripts/bootstrap.  In
@@ -53,7 +53,7 @@ https://v3.xenomai.org/installation/
 
 - Tarballs:
 
-  https://gitlab.com/Xenomai/xenomai/-/tags
+  https://gitlab.com/Xenomai/xenomai3/xenomai/-/tags
 
   Source tarballs are self-contained and ready for building.
 
-- 
2.43.0
