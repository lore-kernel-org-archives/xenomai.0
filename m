Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182745C057
	for <xenomai@lists.linux.dev>; Wed,  6 Mar 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708761; cv=fail; b=oV8VbiSKhrvYzVWJwz5Lo72d7mvKi136tv/sjSF6ZOI4lOpwMay5T0R9y16rRvNlqnPMNZYr9L2uRWdlNDF974QyI/vWdyzG5p+0bwHL6mAcd2iBj2Oafq3gXK4ChxfYOvgHCBjZXpc08BmDy0tQOB7pOl1IQ7drS3d10nf7Rwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708761; c=relaxed/simple;
	bh=Y7JwG+52J5M9R/OU6Icpq1SXa2LFQdiziiMgWL85UP0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PeLUEO+BIGb8CBJAJGo2ttPpyJdUzSxwkiKvo6E6mJ0Hvpe3aYbtLhC9SUNg79VdTXIUBX6EkkbJLvk77m8FvZcjnGPcXDa6JBdbcMF2dUI/sNjFd3JwEHECo2jRsfb7Vb6ntJ2LalHNUxqMufoSmPl5W0kAhexjonkY6odevHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o/jUGYjs; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o/jUGYjs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGRaFQVZ8WFVSMdHVc2g7REIYRFKHi8JKJhsWkJSNs5VJvFq+7NH3ddNPkh9Wju6jCPE8yGZdm/5o7mBDaDav+XytjCPlFmbWXdDLtHBrLffL7k5Ye9zRB3RgBk9mcMuLhF95L7ontrl3NvjoK1rNzKB75r9SE9Gk7erZwf6dRXzGm8OE/WzsuEnrC61elHx6YLReNJZURBES3q/ct4yaDaLXvpnD7g7hFFWKfH4c1mxZwediBOnx5uuaQhCU+bn63YE9anQXQru8suizGslHaNZTzvxhjTgo/BXnzKLgD4eJ/yw8N0AZNbasbVpDFSYDgKNIZTni8Sf2U2395K0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrfF+T4f3YrGKLc7xt0CdOURfZPoRS2LCbfobRhxLu0=;
 b=dJC231dABJqLe47+G2nWw0X4kgV/BOY2ZLvLm02KJ2L8fZPuoEj0UULBMFFbn5Y0cQTZhpsT48MEwI4Nm28AjraAuXhDwTPaCWJRv7JjQRQZqyhD/+sEAZTzfMEwm618IHunx+0mA1KPXe6y748/49BXLRyfneWsDxin8NTH/6ucrQpgTnjqhS6DZZXu4Ycu66qykqAauAesXIg2aYAjcN+8e0ZssFTOQh7XRQ47sk0WOqwzy/wxgo2nlDhODBv7mLAbKuFdHa4f9iV1UXi1TV7H9danuZLc7ByBQnTnmOxJzpPATlTiOSffFofaqazcFbGEDTSgszJQ//Vqvt4UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrfF+T4f3YrGKLc7xt0CdOURfZPoRS2LCbfobRhxLu0=;
 b=o/jUGYjs1ed80eu8uc4Tij+F6TfmBIFxTARvDMGeUhBY5uCp2+nS5CgUtR4E5uwvh4vFW6iUfhE6yJcMRSMFsyk9BLBWc+BzTYcmQAfkHzZcsyFe9/D4dyTz7Ks8rcarVNdkfo2HCP4k8cAkSADoCsVYD+KTLFxjrhQR9dgTNfimhq84CivgOJsBZcGnp2yrID4V1QFbfojGlQDHQiQq05tiESrCZcURQD6EVdZL8fjHxkJjv+VD82FFbBq/TB0nEmpq7lfP5BjinN/QplCCw79G9hitkSa0obEDWPfnBheh/26bhRgM3UtHUR25S2iekkBMcudRE2XOzUgIl7+YoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 6 Mar
 2024 07:05:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 07:05:56 +0000
Message-ID: <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
Date: Wed, 6 Mar 2024 08:05:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: dovetail kernel maintenance
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
In-Reply-To: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 75149d34-c1a3-4d46-7a9f-08dc3dabde68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xsMrqxJzDEhFvDCBHzY8kSiyYwI3h1x3xulvTM/d+ZtmP7R9d9Ru89X6Vbs7yYBCR8yauW8pXJw7MPwoxgcK1cw4TOlNsNA7cxDIbRaQ5FegqcgHaPOS2CbuskSBDCxIHOMO8Yr3wYxKe4nT8/0+wqPGcKyIVgwFVBBp+HyHML9Z6GyZPen9XPsbykccRe/I8CgGfxpKP9ONTIV0IshF7/TcML3TJZGes/39AlTz3RJJ4Aog9nRC/pndAQZNwrD9ImrMqaFnKm74OLBjERie4BrXrG6O+/Oy1k0bFD8wi6+QC877buyo4d6aUJt0bu1WREslGOVFGkFaT71HbwPaqqU5BsAFPJYo1Mf4jzBPrtdQHfMt1gR/9BCXvNVvRQyni+J9JW82/U+qgDXd0/89o17RSQUGbrHw0HnnFptXakwwbtnMXGx73Kf3k7A2bUBJjq1yVietiOS4AEmgqAgjwteyO/wg2cwlmq7ualXH6wupDz8GXZhe8ExQi3F21CeFfOJ42A4yHRVIn+eyyv/1AOWa0xNQ+fkUcZB6If7yjlIu4k1oce8CHx593Nzre3wHPa2qIqS9eGMYytdAq+uwB5UFMOJmt1ZmfDvMEumssyZeeiz+HbPQ0CX8FOn9tUZCrLKdIL4NAY2n1ddoKIRgKXuGB7UJd2tsBOSFZrKpfxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFFmK1huVEc4V0g3Q01GeDFmWkZtMC9rVExpSjFJdmpvbE1aWG01VEVZVmpM?=
 =?utf-8?B?dGxWakJMSGhVeS9NSWp3R0RWOHNMdzFTazFsa1RHVkhJNm1RK3FkR29nT2tY?=
 =?utf-8?B?Q3Y1WHZZTnRsc0Nwc0s5RU9SeVdsaHhuNXlEamYxbG1Yc2hkMnhGVG9XUVpD?=
 =?utf-8?B?RjczNDU5T3BFRFo2Zy8xWllVUVRzNnJPaUhOS1hwakp1YVVOUlBWTlhNOWhj?=
 =?utf-8?B?SlJZTzlaek1JWDhTYm1LZkMxa2w1eE94dUNzeWEwR29nTDFkeFNDSW0wNjlw?=
 =?utf-8?B?NjhGK0FRUUVFOVNIdmpaalo5NjUwM2V5ZFpsdGVaTGI4VHFEd25zbUpSZ2pZ?=
 =?utf-8?B?RVhldG5vbURqclZjQVNYNnF0MVBWdzJmY2ZjVjlVQ3VUUUV4cUpOZFdFTkNI?=
 =?utf-8?B?Z1Y0Y2VrZjBtOVpBa0twdk14L296NVBwQWZScXJWMnpSWXRkN05xZFU1Skdy?=
 =?utf-8?B?YUJINEEvUnI2VHRMN1RKbSsrVlRQYUFRN1hLUWJGSmQ3clJWTkh0Z1RYak5x?=
 =?utf-8?B?L1BTY0tCTEdIMTkyemg2T0diSlVLNWpMQjAyb2FqV2RTZ2NKMFdmSTVFeW5T?=
 =?utf-8?B?NUNSK1VLaVFzZ0U4dUVsZjdLd09lZllxQlo1dWplT2JLc1B0dG1uNWdKa1RB?=
 =?utf-8?B?S3MwdllBTUlnbUlOSkJheWx6c2RnampZalJHTk96ZmdzbVlqVkd3RXo2N2h4?=
 =?utf-8?B?ZHVuMGgyS0RUTEFrL3o1MytlWDVrdmM0NHZpckdVcnl5MzBObXFKeDN0aFB6?=
 =?utf-8?B?QVFPNlFZaG51ZVVKdHFOT2lFS0RiMCsrQ1Z4SmEvMWVOeWFMNzJSRTJsSktM?=
 =?utf-8?B?cVdoeVcyb2JZeU8yZlpiaFBoU0hiWEFLMUJFL1Fqa1l5aFBzeVZIVkpnS2kw?=
 =?utf-8?B?eWcrSUFsRndLZmJEUFAwaDVBWWppaUJuNnNLcjBrK1NRSnNENkNFWFBCSisv?=
 =?utf-8?B?L2drSTdiTklObGdYdUl0MUpHK0hDdm0raWlHbFdTYk9LNUdhQkVZWFdTU3ow?=
 =?utf-8?B?Z0ljbHd5WFozQTIxaWd2VU04ZEV2eWtKNWpQQm5mMnVaRWlnS0xEQVZsaXRO?=
 =?utf-8?B?eXFQS2IwTmNJNTZOelVTMWs4c2M5bzRVbnp4U29PVi8rV1RLUC8vNmtzUmNp?=
 =?utf-8?B?QjYreHEzTjRROGJRYklWV3VzQ2pCTHMvZ24rc2haZDk3b0R2NG95NXhOcFNi?=
 =?utf-8?B?MWJBK21tVVltdGY0TTIrV08wUDhQUDNOcWdWeWtJQUY3VTB5c1FHblVJVjNT?=
 =?utf-8?B?Wk43QVlkMlNickJTSVZ2TDQ4QTNYb240ZWFreWZFSU5kYzFtbTBZc2pZYWlG?=
 =?utf-8?B?WGRUWk54MENjSWhVVDlYNWdjZktWSWxWY0tUVm9kdlVPS1VVeTc0ZUxqcnZE?=
 =?utf-8?B?QmRLRmN1czdnV2N2eGZaY0lBUmpnS2pwSkpWZkpuZVZOemwza3hJWk0xcHNi?=
 =?utf-8?B?aTltbWdsNHdhN3Z4VzNGeXFyYXhyK1Q2T25QZDYrMTdiRG9Tb1pwWUxZWjZz?=
 =?utf-8?B?Vy9hK3hrdnFiL1J3R0wyOXdzU014M1RvdFI0K3ZQWXphaWFHL21LM0FIcGNH?=
 =?utf-8?B?U0tlR3FBdkdlM3FKNkJVTHhydmZPYjNoOW8yNTdZWll3MldZRUNLK0pwZGxz?=
 =?utf-8?B?SVQwZGU5ZEhkOUdRMWFRZm90SVRSdGdhMzgrb1hRQmZ1K2tSd20xaG16L0Zi?=
 =?utf-8?B?VzlLak1RYkJRK0J3UFNRc3k1OVZZdkhSTWRPbUZSaHNoaU1YYlBySm85MTFw?=
 =?utf-8?B?Q2JOdDFabW4xRlFkUlhFYUN0MXVDckozT0JwWVgrWlNkTk1FUmF1UUR5TGpu?=
 =?utf-8?B?dmgyT2ZuZzNER2tjZlJaWjhkSldHbTAyMW5VQXE5QUFFWjZCZWFuVVp3Qmdr?=
 =?utf-8?B?TytZdDVmOFdsWE1BSTVVdnJBYzVrS0dUUm0wYVVjLzN0SmVONnNybm5PdGRI?=
 =?utf-8?B?ci80UTRIQThhN1hEM09VMEdHcUNvQk9CS3BpRlVjVU8vdlF3U08xVE1QRUVZ?=
 =?utf-8?B?aHYxQkhHUnpBRlRpVXpWcVE2bERnZkQzSUF3TGtXSWZINzQ5UTQ2ZGlDYTVQ?=
 =?utf-8?B?TWhQSm10RUdLd0MxY0w1SEhBRnZMdFg1WUt6R2pycElvL3ZMbFQzTDZKNUF6?=
 =?utf-8?B?MTBKblpyQnhnSXFDeWdYWjltSnk5aDYwa2wySjcxWk1ySkwrdHNNWEo5RWND?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75149d34-c1a3-4d46-7a9f-08dc3dabde68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 07:05:56.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhD+qoNFw+0McL/4uqaxwWl5r/BZm2hD+/UclW2BdZW4T/3Kb/xKjG26zIhj+LgAahEO6C0/cI05BGLhOrIPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5697

On 21.02.24 19:30, Jan Kiszka wrote:
> Hi Philippe,
> 
> people started to ask about updates for our kernel trees, and you
> mentioned to me before that you would focus on the last two LTS kernels.
> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
> then also in 5.10 (all referring to the -rebase branches). Before taking
> over 5.10 and 5.15, I would like to clarify their state. But I would
> also like to know what is delaying the tagging of 6.1 and 6.6.
> 

Gentle ping for this question.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

