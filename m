Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565D3730DD
	for <xenomai@lists.linux.dev>; Tue, 11 Nov 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879019; cv=fail; b=jnLb3KtP+EDmyyXSVMlu8lHm1t/Zk1JnfolYlaPrRWujUpzJzRXkaAgVbriBmTlYgeLxW8tabLKM+uVcA+M4t+2VS6ZjkgRRGQN0bhPWuMTBOI4U5qSVJIh2UKWDvCJlbz/6wY++iE56EdmBBnhOc+D/yi9qYHGLd/vS1fX1EyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879019; c=relaxed/simple;
	bh=Nz4FPyFlKJRRS5X7cPGdWyg/4sR0qwYwGIN/hI4XpqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NlbdQEnml2GkKI6Q1BdGwtA8zSJBhgWHtUw7VoaHd9ZU9SMMIJm8FVS2Rd7nZAcz+XZxVWecrPA1J92uTIChoLTiFdSgYOThN7PULQJR1FeA8kQpxPvWwV3/qWQjNTKW0zjzrEYQNloSS4HlGcVgmpz+rNRrY8Qu2bGYKZUznU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qe4b+3Cc; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qe4b+3Cc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+EU1ELu1bvb13WWu9IbjL6wpkgDYwbUKPfKIHDSphyAfB/Zc6G9nDyoAcHUo0oP2mfawBerT+6palv7X+SDbKa5XG+MQpcjq9GiDxXtkVYlhYcQ51jV2gXyubXYWyVG9cFypkKzslZK09BwgHeEZtmvaht2IjRSFx8F9XOPuSn5bjlhM2dBCzPks3IbAJJBm988mPTIggX6PgAwt571CkYFiRHiiG/blI1XPOCagCWhtyyNilbX5/xjV9dL+pqcFpS8ixk3XrPE0fw4Q/2jhHID+V+zWJwKgy9G32QUyo7aowCYm61zF7otVftZ/ikDVOZM1Q1+n3LBoD4/CONF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3KpHqrZI7m+50WCDPY16SkBUtW/SbzjZjlIJRe2U34=;
 b=cKDKDS0s+kr2dhQ9ZvZPGyErXnjv630AWuplTDHrXaDiCFRHiKlaECk7T0vtFRAUh+BoGf3TZ/En6qeleI0sTB2eixUWqJqzQxOHOjgRjIBifg/OV6nGjyQe2i3OVvVkWwXkX1vkrHrByKJiy3a+8UMeenAV5WVPhMQN/yZD8lfUbN9Xn6l2U2G/WfJjeBbIK3upP2NuoIadpBUgmQ0KSDpU8W9ywVSReRZ/1QKCq0+Wo/3YQkgRFg5eXHH04RMJt5zYOK7xtTFc0QChrJ7Ph/spd2BW9IudgSW1XCkWB7sqG3yVmO0QrSMOBYFXjjK9oES+nWROGyzF+2LXFKKfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3KpHqrZI7m+50WCDPY16SkBUtW/SbzjZjlIJRe2U34=;
 b=qe4b+3CcmJ6RCna49owEDvs6BMJy7GIu02nr982Vug5SJ8Zge6x35CdBBFQsycZ8ar/SlL67WlM9zHiqrQ31B3fwE0woT3nCW8DTx5PxHwqG8aB4jCG1Ijo2FH3tgCKI7KaoqCpOag7qKIdE1iVVuFEo87UYDzBEnQgV7d4ggzsMReb5aTL+KiZDmvcJ/9VZCC5vsuyqHr6Fb7bjtPYYk3vWx9HyA2kRpmzs2iGt+ZwdD81sqZub5m9Lv/T3pjAQn8jtTGJp04sHrkqhu/Pb1Z+D59rW3HySvRL1kOvwG8/97eAfBCDRjRonDI3MFmS9PlsszgDFQTTl+qLUnOSkmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VE1PR10MB3821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:36:50 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 16:36:49 +0000
Message-ID: <7876b2fb-e3cb-4815-91eb-aa262c1dabbd@siemens.com>
Date: Tue, 11 Nov 2025 17:36:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 1/2] linux-xenomai: Add arch specific
 debug kernel configuration snippets
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
 <20251107080005.1272435-2-tobias.schaffner@siemens.com>
 <1c4413b7-6d87-408e-9854-bd2c6e0daac7@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <1c4413b7-6d87-408e-9854-bd2c6e0daac7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VE1PR10MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b759f9-3ef8-4b2f-9691-08de21408348
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTYwUVJvd2hFL1E0NVB6eldZcjNJYTFFK0MzRzVrczFWRVFZWnFHeGt0czYr?=
 =?utf-8?B?OXFtRzQ3SjBVZ3FIcWpQT0YvejBsMCs5YUJUSFdXbWJKeEtSWitUNHcyODcz?=
 =?utf-8?B?QWJxR3RVNVVRS1BMUGQrN0E5d3FhTkQ2dDFOZFFuTUNBTXFVQ01mNGpINThV?=
 =?utf-8?B?a1d5ekR2cmc0SE5yYVZZYUZzTmJBdm5YeEdCMEc2TzFFdUM1VENJcHROVFE1?=
 =?utf-8?B?SitCYzZrcWpMVk55THJuaDBKQkx1TFdkNXVMd3FJU1FjdEJVS3JPQkYwZVFl?=
 =?utf-8?B?T2tXWGNqY0tuVUpaUDFEZWtFVlVNc2tqNE1PZzR1Y0xETWtVeFhVMVVYbGky?=
 =?utf-8?B?dDV3ajdSZ2NWenVMRkpNS01jK0ZuQ3NGRW5WT3NWLzVBUjdtblczR2NsaVJL?=
 =?utf-8?B?V0M3bTNQQlByWUU1dHpBSDVqUjRMeVNhcmRQd0NCMUhiRkdBVmVNWE5LNWxF?=
 =?utf-8?B?MWdmWGNZOG9WYjcrTnlkNlBJV1Z6aVM4ZHVTMklyRVBVbzhoNHhTOU94Zk8x?=
 =?utf-8?B?SnpVTDhBRlNoWGY5QzlINmoxQkRKVmE1ZUNmMHl4TWpkeFVtQXoweDN5dWYx?=
 =?utf-8?B?SWFuYy9XRFo5SUtmMmxXTTFCNUpuTThpaFl1ZGV1Q2UrbVpHanVMMm1QS1da?=
 =?utf-8?B?ajdrMEdxZmN5a1l0dVUyQkRSbmJkTkVSOWE4OHNTV2lURDZmV2hqNm4yUGZB?=
 =?utf-8?B?TDMwRjJtS2JBcEsrRWtYUlNlVEh4SjY2SDlvRldzRm4wTExSNS8vWGxTTjNO?=
 =?utf-8?B?eWhsRDVnMWs0VkoyeThBZmpHUi93N0VkU0JWWGFiY25OTi9ROVhQL2crRUoy?=
 =?utf-8?B?K29RM1RCRytFbHROcTJDNjZDUmNqbU05WUdIeWpVbDJ0QXJwZGZGQTVYWXl0?=
 =?utf-8?B?bEFRU0EyOFJTVE9JdXU1alB1YzQ3Y25SeFdDNjhtRFlCeXFpWG9TaXZqVUtM?=
 =?utf-8?B?TFlNcDdPQ2hTdVN1T1BpaU9DMlRHTGlyd0VTN3lNQlcvd3hNUUJLdVppUUtq?=
 =?utf-8?B?V2RmOVZHV1IyVERhYk5qYkdNSGpYUy9pdm1HbXlHdDdPNEdMbW5EWHJDZFR3?=
 =?utf-8?B?NWxLM09HS2IvZ1ZHZ1lKWWh1Uy9aeFlmeHlkZ2NBeTBmNkZOZ2ZxQ0paeERU?=
 =?utf-8?B?aFdLOHo4ZTU5bHpMeEwxSTVPaXFiV2xkRk5wY2t5cTY5ZlN5OEswNmJNNmFa?=
 =?utf-8?B?a2VJUjdnM0FDN2tZSXh0NlBZeFdjN20xUkROOENTNjhJWVZsUE1FVEt5Q3dR?=
 =?utf-8?B?Z1JkNXc2aS92TGJ0L0c3TUoxeGNFazlHcGNzUjRONTJqN1hudlNFTGxLeDcz?=
 =?utf-8?B?UngrSDJVRkpiWEFacy9DL0k2T1hDUTgrQUtVYS9nVUd6blFKTkJjZkZleUY2?=
 =?utf-8?B?cDlDWVh3YVhqeElmV3p2RkRCZ3VCSzY1cWNBTEhEK1YyY3FEVVV5THNDYjUx?=
 =?utf-8?B?Zkl1SVZHcjlzVnZwR3FLeENOREZBTHlFWmRkTWpDQkZHRTJpYXU5c2xmVXlF?=
 =?utf-8?B?NjJheWljdlZMdVBtb2VlcHg0VExDODdiZHgrTFdWYkhDeENoWmx0dHR3V2VM?=
 =?utf-8?B?a0tKbGsxQXZhQTVuNU8xaGpJLzVBSjdoQmhnTjB1WFZ1SUs5SDJ2TDB1OS9J?=
 =?utf-8?B?a2twdnJmV2pDMGp2N3JTOFhjd2p2K1hsQnVkbFVNMVdzYW43a2FoNU9zQW8x?=
 =?utf-8?B?VVNnUlFabEM4Z0xWYWRwc2xRZEwxYTErd1JnSFFkbEZCOFVXVTEwR3kvT0Zp?=
 =?utf-8?B?bWlodlpsTlNXeW1JdlZhSUc0OVZtOGpnK0llVUdTeXJDM2dhWlFqdzlWazBo?=
 =?utf-8?B?U0xsSFZISUNOY1h3M2xYekNjdE1DVmNHMTBBc1gyeHlSdTNveTAwZlIyckFM?=
 =?utf-8?B?cDY1OXJIVE0zNnFMdmZtbkQ5RmsyTWNqT2lSUFZlSVhBL0tBK2x3WlBLWkRa?=
 =?utf-8?Q?qUYr41bzSa/HRJPaipabModfgpCc8fY+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJieUQrcEtOU1lHSUIyV2o4TzVidHY2OGFSYUNnaHpCSlQwZjNSakVTNnBC?=
 =?utf-8?B?eE80NW5qamQzNEF0TmN2NzQ0aVRGckpGbmErWkUvNWgrNWVIcmVIOVBOblhu?=
 =?utf-8?B?NmFwTUJvRUN2OTRjNldCMFRQZFExb09YRXJ4VTZGZFBydzY0YzVHVHdrVmdZ?=
 =?utf-8?B?TEx1cStuMk9GM0ZrbXRrODBiN1hpUGI3Q1NaZzdYQWRWV3BSZ0hHQVVoYUxm?=
 =?utf-8?B?RmVCSFU3SDNwa1V2cUp5U3ZjMGxuWjFNWk1oMmVRUnJlRUIwUWhuYUF1N2Uv?=
 =?utf-8?B?bFlWTG8rKzEwTERzY2pURVBScWZ5QUMrOURXVXc1YTY4azNLOTVEVWx4Lyt1?=
 =?utf-8?B?UTdzcDJRa3hBR3UxQWU3ZFpNNTlXZElVTFhzMXh1d3FMU1MvWEtvVDBoeGNF?=
 =?utf-8?B?N3grdzdORERVanFMVGQ0anBmWGJKeDZjTS9uU1hFZlMvcUtkYlRZVWwyTGJP?=
 =?utf-8?B?c3Z4QVl3WUpNbDJnV3pIRjFFaUVMUUNXT3JyVEF0QnpZbHEwNVNaS0QrdnBK?=
 =?utf-8?B?T1J5SUt6djdyeGlzUEZBcnpieDk0YzBNRUkwNnJ5YkdYckREMGJIL296SHJG?=
 =?utf-8?B?cEVMSkVlUWxYcHdma2gvZnRjcWphcDYyMVltem5oNC9XczZpUHBtNEFtbFdy?=
 =?utf-8?B?OEZHamtRQVpFNDloRjl5VzFLWTNJV1podTJLbVlnakdjdU1sK2QxT04xaUtE?=
 =?utf-8?B?Rm9kWGxoQnJvSlY2SytOL1B2RGFDQ3p2MkVpNHkycXJEVWZHblRwbkVQUmhM?=
 =?utf-8?B?bk5zaCtzaTc3ajQ1dVVQKzY2L2Y2MlJkckpyRlRzaHlBREdEU1BDYVc5Q0Jm?=
 =?utf-8?B?N2VndXFvVlNsdVF6eUhuZU9VMnBza0JPbHF0S1VQNFlINllqT0xzaW9OdXNW?=
 =?utf-8?B?blNQN3l5bzNzZ2IrVHFFYVZSWmZEL012YXpOYUg5Unp4eGN5K2toNDRkYnkr?=
 =?utf-8?B?c1U4ckkyMlh0MjdGMGJIdEh2VkdiME1RUjN0NGp5ZktkK1Rrd1BYbWFDaXJi?=
 =?utf-8?B?bXV6NURUZlRCd0twTFI0UVYxZk9BekxJTFNycU1Sa0s4R2xVaGk3ck9MeHJ1?=
 =?utf-8?B?RkZTeVMzeTljRWxZb1JIaWpJdzBIUElHQmlCRGcrSjIyaWxMYWxrc1V5MWhn?=
 =?utf-8?B?QVQ4TjNVOXZ3RktjdEFZYWRud0U1UjZEQVRNSG9FZU1OMzBBeGd6VEc0ZUYw?=
 =?utf-8?B?bXpRRUI1YzRNRFlNRlliSmlmQXNmUkM1dXZyUlcxKzZnc3ovV1RadGZXb1Vl?=
 =?utf-8?B?M2tuclJyUHdHc2dJYndXZlBVenk0TUtnWEtrU3VjeWU5WUlmaCtaTU9SY3Z6?=
 =?utf-8?B?RUY0OXM5N1R0M0lEd2pJZ2JsSm91WDR5WUVURXFxU2RDUC9CMUFZU2liTUZn?=
 =?utf-8?B?eFhWTDFXUUw2R29aS2xmK1NVMjh2RGdkamdJS1hGK3NDbDFUbTlZTUprOCtZ?=
 =?utf-8?B?STJGMy9mMEN4U1doT0JaQ1JNUXJXek1MNFFTN3hZOUZYTGNnaG5yUzJ6eUdL?=
 =?utf-8?B?MXlSc2YzSXhsMjdybVBnUUF3RFUySnFkenZCMHpoM1ZGend0QWpxdmZibUxQ?=
 =?utf-8?B?eVU1aVoxYUJ0Yk8rM2dPYlBrNzIvSlNSbzA5ZDk0Nk5vNWphUXlBMmczUjZs?=
 =?utf-8?B?OFVHa1hJb1NaVVNuU0VkRlM2OTZ6OWpjMkc5Z0Z3bDltc2dVUDB1QktSWk1X?=
 =?utf-8?B?cUszZW1uSkZ3UjRrK0RMa3NWd2x0VXpGa0ZvWHc0K0I0Tkw0ekoxUVU4VHVG?=
 =?utf-8?B?VFE5V2VwOGNCQXlpVGNFWS84YW44dzNFd3Z4R202QXg5MlJhcmY5MFNEdnZw?=
 =?utf-8?B?S3JqZmlzTmVDOVJJZFI3U3lWNWZESXRVME54aFVaRnlVaGNLTGREU3Q3OUtU?=
 =?utf-8?B?VmZuaW1UZDdUdE5BWWZPc0UwOFJaZ3FmT1pNZjVvbTgreGMyT0VmTTA1Tldm?=
 =?utf-8?B?UmJaVWx1clFUYTdHb0pUWlFsZWdrUmxkTEs2cFRQTXFTOFNia0IwNU5aRlkw?=
 =?utf-8?B?U2NuZFVIa0ZRY1BQK0Z2L1R0YUNLMFZNazhtVm0vTHlhOHlvYzVUY0xOL2sv?=
 =?utf-8?B?bk81aGd5OXEzTXVpWCtXZXlHUDZkcWYyMWJPcG9ZYzV0M1hPTlNLTEtoZDlU?=
 =?utf-8?B?cExwNnQ2YW9kQUFyRXFQOEIrUjZaUzROVmVsaEQvY1huRTZRMG10NzU5T2Fk?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b759f9-3ef8-4b2f-9691-08de21408348
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:36:49.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itc/hvUBZgKIH0OFNxxTmpkAb13MKvc+3iOvN1WKEWk8O1FjSuovXS2zm8nCjk/hCqj3vHn78Ipeijjj63SS0R7Na5a3p1KwoU8426wMZ4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3821

On 11/10/25 07:25, Jan Kiszka wrote:
> On 07.11.25 09:00, Tobias Schaffner wrote:
>> Add dedicated debug configuration snippets for each architecture to
>> consolidate common kernel debugging features. This replaces the
>> previous approach of using an inverted no-debug configuration to
>> disable debugging options.
>>
>> Separating debug and no-debug configurations improves maintainability
>> and simplifies future consolidation of debug settings across
>> architectures.
>>
>> The change has been verified using the kconfig library. Applying the
>> new debug configuration to the updated defconfig and running
>> ‘make oldconfig’ produces an identical resulting configuration to the
>> previous defconfig for all supported architectures and kernel
>> versions.
>>
>> Several debug switches that were previously left enabled in the
>> no-debug configuration have been moved to the new debug snippet.
>>
> 
> Do you have an overview of those? Would it be a lot of effort to factor
> those changes out?

Hi Jan,

these are the config changes for all ARCH - kernel combinations in the 
nodebug case:

------------------------------------------------------
- AMD64 - ipipe-x86-4.19.y-cip
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_LIST n -> y
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- AMD64 - ipipe-x86-5.4.y
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_LIST n -> y
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- AMD64 - v5.10.y-cip-dovetail-rebase
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_LIST n -> y
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DEBUG_VM_PGTABLE y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- AMD64 - v5.15.y-dovetail-rebase
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_LIST n -> y
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DEBUG_VM_PGTABLE y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- AMD64 - v6.1.y-cip-dovetail-rebase
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_LIST n -> y
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DEBUG_VM_PGTABLE y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- AMD64 - v6.12.y-dovetail-rebase
------------------------------------------------------
  ARCH_MEMORY_PROBE y -> n
  BUG_ON_DATA_CORRUPTION n -> y
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  DEBUG_RODATA_TEST y -> n
  DEBUG_SECTION_MISMATCH y -> n
  DEBUG_VM_PGTABLE y -> n
  DMADEVICES_DEBUG y -> n
  KPROBES y -> n
  LIST_HARDENED n -> y
  MAGIC_SYSRQ y -> n
  MTRR_SANITIZER y -> n
  PAGE_EXTENSION y -> n
  PERF_EVENTS_INTEL_CSTATE y -> n
  PERF_EVENTS_INTEL_RAPL y -> n
  PERF_EVENTS_INTEL_UNCORE y -> n
  PM_DEBUG y -> n
  PNP_DEBUG_MESSAGES y -> n
  SCHED_OMIT_FRAME_POINTER y -> n
  SLUB_DEBUG_ON y -> n
  XENO_DRIVERS_ANALOGY_DEBUG y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_GPIO_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - ipipe-arm64/ipipe/4.19.y-cip
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - ipipe-arm64/ipipe/5.4.y
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - v5.10.y-cip-dovetail-rebase
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - v5.15.y-dovetail-rebase
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - v6.1.y-cip-dovetail-rebase
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARM64 - v6.12.y-dovetail-rebase
------------------------------------------------------
  DEBUG_FS y -> n
  DEBUG_KERNEL y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  PNP_DEBUG_MESSAGES y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
------------------------------------------------------
- ARMHF - ipipe-arm/ipipe/4.19.y-cip
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SCHED_DEBUG y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
------------------------------------------------------
- ARMHF - ipipe-arm/ipipe/5.4.y
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SCHED_DEBUG y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
------------------------------------------------------
- ARMHF - v5.10.y-cip-dovetail-rebase
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SCHED_DEBUG y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
------------------------------------------------------
- ARMHF - v5.15.y-dovetail-rebase
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SCHED_DEBUG y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
------------------------------------------------------
- ARMHF - v6.1.y-cip-dovetail-rebase
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SCHED_DEBUG y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n
------------------------------------------------------
- ARMHF - v6.12.y-dovetail-rebase
------------------------------------------------------
  DEBUG_ALIGN_RODATA y -> n
  DEBUG_BUGVERBOSE y -> n
  DEBUG_FS y -> n
  KALLSYMS y -> n
  MAGIC_SYSRQ y -> n
  PERF_EVENTS y -> n
  RCU_TRACE y -> n
  SLUB_DEBUG y -> n
  STACKTRACE y -> n
  XENO_DRIVERS_CAN_DEBUG y -> n
  XENO_DRIVERS_HEAPCHECK y -> n


> The approach looks otherwise good to me.
> 
> Thanks,
> Jan
> 

