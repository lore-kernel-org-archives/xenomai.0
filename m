Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5F19E967
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008359; cv=fail; b=F0gt+gTrnZ97B9+Ua13Vc18GDhLHfGPjf0S/d98UcooJPJnUU/Qo5HNV9GyNaDHTwuCMLLCKmC4y9Bc7fWMIDw1s2q+OkKo1boC/Yv9o9fks0v9TiR2z2gtWdFxKI6ot1mbGKmuuK7UxOjifA1x0qKURxdGYSIawevT0ICYE51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008359; c=relaxed/simple;
	bh=n2X83B1z2EwO0n8axJqvtjL20AFLO233/uWqX9RHqIU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jwCK/FsBAwnSmqgGEA6S/PFgXXP7QYBb/vDQSn+BiTPr1hz7w1lEH+teNnv8MItEkVtbD03UR4z98svNiEwceUET0aDxz9rE8FO7AvLwgNo7yLL7ZR7E8Z66AwOJNKL6whuwkuJTgkA436E7LyQz0DJ+LcK0L2Wk72n/Np5Moig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v8x/Bp4e; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v8x/Bp4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAt2p0LI9bWED9hqR2R7Wg2DzzUVkdBme2crLtS++ax4EaH1AyV3vc55Id9CwEOqOg5LsUOrgM+o1cz2YMb+t8RApOoEX2/YMMBPAYMM9qn49OW9KkpmLgQoLmSwavTwksVfKq8uc1BMb9VNkpaEv6f8JcViGW+dtv4+0v0pi0KC48BDWVkbY1InD03WqLVwV1WjyCZokrayLWRvjPHdmKvotjyUkePzOTP1WjmfTRjXQbltaU1tu0L2u+hExD5zSmUt74t9uS5EmcGud7BR1MLxTQmgh5t2taaVGTrhoI7OKcEFs0q62OWPv6ycNpjCPDENBiByzACj6/AKitNN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Mf5GCiZgq8p2durOgxp9jZpCYgi1mVVQ41WpyNhiUg=;
 b=c4ORyRFl48eK8+Ford37/KplgMrjru9ibfmy+XTVIAtHMbrsSXRv++RFEeZQHPLtOnR8Ee+7BDSFJXG6em+NDr3MPrG0aRcMesAZo/gm4N1YS5X+0YRln7kCv/mcJX/onCiHNp5GLEAa4PGtb91wKqELUFcRE7PaoCKKm/RIT7Ii+XjBUFj71rasRxePo8u7jbjlMddcyaqkIbsE/9NCpyQmLN2wJNJ7fhZgpkv3Mvmd0jigMkXtMYw8y+OVVqTYXmy04NCz+mPM2JU+pGNL3a2psqkvxzbM76Ph2WdnY7pNm72v2UI5zLKZ/LG9ICuNuAWvufM0bZPoubn8vs+z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mf5GCiZgq8p2durOgxp9jZpCYgi1mVVQ41WpyNhiUg=;
 b=v8x/Bp4eQyOVAv998PkLk8gib4FtYVTn/ALcLPnU2zTp9ufq/DPYblQFvR9ZoCnmefkDvNM2RHq6tKKZL9Y8XYnrINUq/uCNOj+5oqISigzRPqBERPSk2zOSV0PBZfTLiG7N0IGMxEh2aCCkXbIof9TRZio2tw0/iF9rKhFmDfl2Ybpn9iIJYhqKkmw/abLefri91i/3hEGANBbmmGPZaL3T8ujbpWXaKmCpM3OR2obk3SBrO1l0AxRfBdtPl3IDV+t5cGbPKr128DxIeqAafDbMG88k5GDOQvzQQgAkot4Pso3+32gJ2ScTaEePXAvMgt1+4U/8l+UwohYpIqEGuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by BESPR10MB9267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 11:12:34 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 11:12:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 0/2] Rework linux-xenomai debug configuration
Date: Thu,  9 Oct 2025 13:12:26 +0200
Message-ID: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:610:b1::9) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|BESPR10MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ccbb22-f375-40cc-e978-08de0724bf76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME8wTHNGczNWeTJiM1JpWks2R3AvNmJCaW9Sd0lqY0dVVHRYbGM1WmdrRm9n?=
 =?utf-8?B?OWRnTUkzSWlSQ2Y5ZG9jajdzVm0rR0xDTHBBeTNScDVFOXBoaUtrZlo4QUMz?=
 =?utf-8?B?ZlBhU2ZVU21zdWQ4bHlubHp5OHhncWhDaVFRY0xyQ3piMTBLeVhSWnRQQ3ZK?=
 =?utf-8?B?UmtDVTN3aWoxVGpOQmhjRUZaSGR1Y3QxNzN4M2txT2VVNU5aN3JTOEYxY2JE?=
 =?utf-8?B?N0prdDVsTk9PUDJMc2UxL0Mrd3FQYU1WY3RHZnV4T2hsa1plNW80Z2s3bCsr?=
 =?utf-8?B?cnN1WTQ0RWNpUExqcDVkY203MnFYRlV0dXVBWlovc3VwMnBHdGY4dlA0UUpO?=
 =?utf-8?B?SlAvMVlQdjJJaVhXR2JvQ2xxZHhJRXZUNFFLdnNBcUFpQWNKdzloMzZiNVpa?=
 =?utf-8?B?cEV5VTFCc1BPMGtnOHhUZWVQL21qTzRkUXNpZ1ZLdnhwZGlOSmFlTkxSUkhw?=
 =?utf-8?B?MVB3RVpuWjA1MEMzRWNkN243S1JkYmFsMld6bVNYNXBrcVZZc2o4TE5rbGJI?=
 =?utf-8?B?Lytzek9ySFBFSExyZG5GdWZ6cTZWY0lqSjJIM0tKNkRYcC9JaTQrclF1WUlx?=
 =?utf-8?B?eFJDR05ZYkQzdm4vNHJOOTluT2NPUFY1TjdSV2ZVTGRTTUZtRmZ5bVNLWmlV?=
 =?utf-8?B?WTNYdU0wbGZBdm5zeTIrTmFERVhKa2twM2VTeWd4R2pPQUpwNDZ4dEIyaVlW?=
 =?utf-8?B?bUtqV2U2dnE3M24xYWRldEduNXQ4dzJiWWtwb0FlQjk5bjRsK3hPQS9qSjBB?=
 =?utf-8?B?RDVGRU14Q3N4K3ZycXFDbzRWbTQwYTNJMkNzNEdTWEY3SERNejVKRkg2eDZN?=
 =?utf-8?B?Y243UlBuVUx2WCtCRmZPek5YeFBkb2tTTE10U25XblVGZ2ZvdzZNLzgwOHEw?=
 =?utf-8?B?VFFQRDhRMGxOWHo0SUI2MXd3WGJmdkJ1cjgrWUNhK0FEWktJTCtMMkRTQTI2?=
 =?utf-8?B?YWhXUUV1MFlEZWdVa2h0SlA3MXd6QllEYm9jUXlLQ1FHNEpHYWw3eG1IRWJO?=
 =?utf-8?B?WGh0RVhIYkxWdThCVjdOdVVLS2FoWkhXRmxmdE1BaU5yQ3Q4MlhBYmxISmVU?=
 =?utf-8?B?UC9nbXlvdm5xRWc4RnBRdzVxS3NjclRNQzU3QjlUNXhnb0xUQmNnd1RndkJI?=
 =?utf-8?B?YXViYmxuYzJVaDFESm40aDEyNTVkRVYyaDJqR0Vhb3R5ZmtTS0NSS1F3V0xq?=
 =?utf-8?B?RWt3UFdVTUhnNW1VMGFOY3JrUjA5VTJNRTV6Y0d2V2dVbkxyemc2Y2pLM0VD?=
 =?utf-8?B?UnVGV3JpZnBHaFYwSWVEa0lUYXlvMjEycHc0ZVZSRmN2OXFWNFF6Z2hxNWZq?=
 =?utf-8?B?a0dwQnlKWGtMUzZQYnZmSHZ2bjVBODFBWjBNcm5XdFlhSTN4dlZLKzZ3WXp1?=
 =?utf-8?B?ZUZrYWFwclJWQnJsYWdhSmFyRXMrRktZMTBwRWh2WkRJVm5jT1M4aUxqV2VP?=
 =?utf-8?B?bUF1YlZoWXJIejcxZGFSWTdRTUhEK29qdi9VNHNCS3ZFUFVaMlJDQkFoUnZk?=
 =?utf-8?B?MC9tc1llSXRuNFhlL09hL2EzdEx2RHJLMHRmY0I4QllERnliMU01ODVHUlRs?=
 =?utf-8?B?N2pSSzhHUkRmTWs1SENEK2hNOVp5b3hCcUpoMS9NalVUVERySFRWK1M3NkFa?=
 =?utf-8?B?eURmTnk2OEo0SENMTTlHU3hEd2RRdVUrRzhqd2RnNkMvRGN4NGlVMXFSN1p1?=
 =?utf-8?B?clIrSGlpVzFkL3BrKzhDUzBvWG1hcnM1cmQrQno4NVVENXZSdWRORFBQVzlr?=
 =?utf-8?B?MFRkRTNveG1JM0lzbjBFWWtKTU9LY3lhZ1ArT25YVjErK1dLeHVaZ3IwSk1w?=
 =?utf-8?B?Y0hDaGxRTUNpRno2UERWenRMTDdsVlJNV0gyODErQ1FLdVZocVUwNjJpUXo5?=
 =?utf-8?B?RnNGNXI5N0J5aXdpWm1iY05MVzNCMGl2QTAzVHVyS2VhQllyVDlsdkZKTjBy?=
 =?utf-8?Q?jVWrv3B6BB7U+4rVM061L7o3jawgoHFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXIzczI3VXREWkxlNHFsNE42Y215WkpXYzZmenFJNUdWNDAwWU91NlRLa3Fp?=
 =?utf-8?B?dGdIbHFnUWk4Wm5UMVN6YTNicmhSWnJ4aWhwSEJ6eDl4bHkzZ09JTHBkNURO?=
 =?utf-8?B?RkRKSEcreEhJYjBCY2RHV0RaV3ExdVBPbHBSRWVPb3p0c24vSVZjemhKbFpS?=
 =?utf-8?B?RlZjb3A1ckxxN2JVL0pmdnpYMHRIY1JkdXk1UzBQQkxXVjJiaS9SNTVpUkNh?=
 =?utf-8?B?MUJUd1J3WXZQWFJZODZvSGdKYkxnR1BQTm5OWll1MlcvQUE5ZEVSS2crMFdV?=
 =?utf-8?B?QVFqZUx5SElweS9udzhqcFZrOGZma0taNFByQzFqU28wUzVQbkQ3aWZxMUNa?=
 =?utf-8?B?ODZoUmRTQTBwM2p4RFJlUEorNFBub3NpbVJIMzF0TEI0MVRtY1ZIU2NEbVJT?=
 =?utf-8?B?UGdaSUc1RDVZdzllWjRPOERoVDlBdERyME05MTRYd1lLL3dBOGk3dlE4TnJa?=
 =?utf-8?B?azRTUlUwMHlRL2E2akxhM0poL1FLMVdUZDRLWUFxOTZaTEpPaHhoODZ6d1FY?=
 =?utf-8?B?WlFjM3dFQ1JJanhvd2ZLNkgvR3hmVmJpUTFhcjNFaEdreFpSYWM1K2w0UnF0?=
 =?utf-8?B?RzBVa2UxRlBobVVGKzJkQmZkKzdhN1VXTU85NStSbEZvYWRMdExHWGlyUlZq?=
 =?utf-8?B?V1hSLytyY2JlOHVzdWt6TmNKMmlIbVdRdEplVEQzY1E1ZG1lRlZMblNkSHJY?=
 =?utf-8?B?QmhhQnl1dVBOd05PQ01uOEJ2VVB5REVNTytYb0R0QWlwMzVSc084LytDaWhx?=
 =?utf-8?B?TkduczFkcTVrdmtkNnpvMWQrOTY3dHl5MDF1YVpIaHh6N1JLcWhqZ3VaS0dk?=
 =?utf-8?B?R1QzSy93dlRnQ09YVlFXQkJla3VDSXUrTjhrS2dKOTVCdkdyZDVKQjVOMkR4?=
 =?utf-8?B?Uzl4VTc3Y2RDNTNyT2NITkMyT1h5eHdnY281amNsaCt1bktZSDdMRC80VEo3?=
 =?utf-8?B?N2JaZWduMnB6NU1VZWJFejhlTWNpVmRDa3l6Z0VGa3AzVjdWNlU1RVpjRnUr?=
 =?utf-8?B?YjNDK1pQMWVyN05qWUcrQnZnOXprTVNOazd2bi9iZUJ3VnJWdGVJenZvczY4?=
 =?utf-8?B?WldTY3MxNVJ3a3FzZ2VOOTF3R09iSGkyckdMbkgyck4zakJ5SFd6S0t3b1p5?=
 =?utf-8?B?MnpZWmJDdi9sOEN4RjV1K3QzbjJsZ0FITUt1NStlL2VJSEZ2VWxtNGR5ZlhZ?=
 =?utf-8?B?cTBvNldnUGU1UU9Ma0lRL0dJaGVvdW5VSHRNb2VhZVAyai9OQmZsbndWNVh6?=
 =?utf-8?B?OWNVVWh6UzAwS2RCNEt1V2pVWnpNVXpZeWtTR25kNzFTaFA4Rm9yNU9VM3VI?=
 =?utf-8?B?VERrTUpreDFLaTh0d1ZzeEhoV1VjMFYySVBzendBWW0wdW5reWdGMXNyTVhj?=
 =?utf-8?B?dUlzV2p3RnZybmU2ZG1PTkVPcXdqWDBBbkppR2pFYjN1ejJVd0pORzc5Q2xz?=
 =?utf-8?B?cTRzSEx0Z0NYUEdzbGo0b0xneEhjdWIyeU5UM29NbWx0TTZmTmYyYlhTV2k2?=
 =?utf-8?B?S2JYdEZwWFlYd2J4UHU2Z0VEMXU4T1c1NDhOOGxxUHVMZVNHbFluSzRFL2Zs?=
 =?utf-8?B?SVBtVm5OeHU1VnovZlNkajZXUDNSaTlzK2syWWEyOW9URVozdnZEWlVNbVll?=
 =?utf-8?B?UkhCbDBscUgyeEZYT0xVdW1pUk4vcDhmSEdMazdtTisrUEx1dzlJZHcxY21E?=
 =?utf-8?B?K1JaWkhIWmFuTi9va0VxSUl1T1hENzN2WHJjSWMzZDU0U0JwQVhtcWpFbEdE?=
 =?utf-8?B?UC83M0hwRkRxN2k2cytqT3ZEWkZVVEh3RXN2VXlRZkdOUFI2OHBZaHlpS25v?=
 =?utf-8?B?NjVoL0Zta1d3Ly80SG44azk3bnd6cG92RnU0S3lLYnhWa1ZyZkI3UGl4L29R?=
 =?utf-8?B?Y0VwYkdXOUx3NTJwTUU1ODNselViVFJFODlsQ29UZEc4Yzk3Y1czR1cyaFVt?=
 =?utf-8?B?dGJncVpZaFp1Mzd0aGMvcnNuZlZjUXNNVlBSYmtteTIyMzMyZm9rN2NPZU9R?=
 =?utf-8?B?L0xqMHJ4enBpbU5Ub3dtYm9MbFZmZFZ0V056NVgxbVV5U1BSbjJHSDNOcThW?=
 =?utf-8?B?N2hrSE1HeEZ0dUlUMEk2cjUrMVE5T1dBWHNHWngwUnJrdytkTHRrNWlKbFFZ?=
 =?utf-8?B?T1MybDF6OWlKbm1MSnRML1ZhSGxkelpkZW56bW5mak1DRzlhMTZGK2FtN0NN?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ccbb22-f375-40cc-e978-08de0724bf76
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 11:12:34.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHYhRPbQgSFU7SIu3R9onkXXog8OuwyfRSEI5+6plX5imCergoMCRn6O8KsNGuBt1qaoiAJuTUKHp9x8kQwok7cL/qtEEiXtigbSu1l/oa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9267

Hi all,

this RFC proposes to unify and simplify the way debug kernel options
are handled across all architectures. I initially started this work
while looking for a suitable place to add the EVL and RISC-V debugging
options. Until now, we have used an inverted approach with a
common-nodbg snippet to disable most debug options that are otherwise
enabled through the per-architecture default configurations.

The series is divided into two patches:

The first patch removes the inversion while keeping the resulting
debug configuration unchanged. Applying the new debug configuration
to the updated defconfig and running ‘make oldconfig’ produces an
identical resulting configuration compared to the previous defconfig
across all supported architectures and kernel versions. For the
non-debug build, several leftover debug switches have been disabled.

The second patch unifies the debug configurations of the different
architectures into a single shared configuration. At this stage,
this results in more debug options being enabled than before, which
we can refine incrementally.

I’m looking for input on what could be trimmed down from the unified
configuration and if a unified debug config snippet is even desired.
As Jan already pointed out, the Nouveau driver is a good candidate
for removal. Since testing all kernel versions and architectures is
time-consuming, consolidating the configuration first will simplify
this process going forward.

Feedback and suggestions on further reductions or cleanups are very
welcome.

Best,
Tobias

Tobias Schaffner (2):
  linux-xenomai: Add arch specific debug kernel configuration snippets
  linux-xenomai: Consolidate debug-configurations

 recipes-kernel/linux/files/amd64_defconfig  | 313 +++++-----
 recipes-kernel/linux/files/arm64_defconfig  | 149 ++---
 recipes-kernel/linux/files/armhf_defconfig  | 164 +++---
 recipes-kernel/linux/files/common_debug.cfg | 606 ++++++++++++++++++++
 recipes-kernel/linux/files/common_nodbg.cfg |   9 -
 recipes-kernel/linux/linux-xenomai.inc      |   2 +-
 6 files changed, 921 insertions(+), 322 deletions(-)
 create mode 100644 recipes-kernel/linux/files/common_debug.cfg
 delete mode 100644 recipes-kernel/linux/files/common_nodbg.cfg

-- 
2.43.0

