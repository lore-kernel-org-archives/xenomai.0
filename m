Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE2156228
	for <xenomai@lists.linux.dev>; Thu,  7 Aug 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561135; cv=fail; b=mOCtN59g7LCuPAUsNkJo3m2lP6npCRAPnlPySKpuxZrEpE4/xS8dwfUrdLGMpTh8wAHSihEAvNFIcNPqQ31TANi4XQGDLiAh6iOtklwDKSFkvS5e/uYhmF0SKKYn19CKiGZJ30/1RtsSaJeNm85nFZCXZH4CL+bNeHTqQaS0ofY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561135; c=relaxed/simple;
	bh=zo1FbogmWA6Zm8YiM0hCwJOabg/w049GWyopHI4nT5Q=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Ze9XGnRPGxi91kq6XqtJTeCpOSOp43lk6kVg6zA6xsWvmnRriSW2YrrauZyNfMpvbjhLW2G4sVquAmvhEDsK1TRNH3xlqvptYqqM7D8eELKI+EhLFbK8ARllHYJ1S3LcWUyw+2GtbzE1mPLITxS88mHyfwRGj8IJArw+zR67FKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yNj90NBi; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yNj90NBi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQwb7yEkwtNXAjZET6uutRmr0wMyswSByxDuo0WyA1A3RpIep/RMnI9N5faTQ8sWjx588LxHJLRGU6MoE+xjU+tsyL3llJsUC1m7/vVLvbANtjObD41fk52S6tjRfUodWdnkfqX/F0P3oIFCmrXdEubXMmeUgLr0IQsxp9UKSRF9m6e+sUidi7kDJwRrRtkGTSynZGzsOfGxJIaVRM3uYSDnGqw30vSRtqggAxWcdT2QujF8QVZDlvo+lIzvC6Sl4A1F+oJh8fxspLj/38lXwwPbHyoT3MkRFoX+ffS04l4KJzSuYDQMISNFXsIM8dnqurOX8/btUAet/2QbIRJwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avyb42tL+15o2/+q7OR3gdPvDHO7LaFjN9JWwcoMcQI=;
 b=nNQDNyk3w/fnv5kwZUhFHFFWELZIv9n8ViM3kT726J0wLX4x0zm1uKGd2fKsC5zBpdlBFl8Cg+/yi5YDIiA3OsAvLH85QOtGb1G0Ag2UqZ8R+PoRnEr5TZB8DoVJRSfpjP2qOT+9ijtbAV1e4bB4g9X57X+8felINYm4EXJ1b2nd+YvGiB7bX37MIFCKjPAbBM26AOHpevYXXbMShr6kH4IiqbU5lK7GzgnzfHzIrCIx3/uyxaB8wWh4QbffdCMbbEIDoAaYpeDifvQ6xctjzy9F4N1zb7KrO89vXl4IddKBoKO+M8DnG0yU5iAcyoHMeYp4iVucXm1D41bpRmPWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avyb42tL+15o2/+q7OR3gdPvDHO7LaFjN9JWwcoMcQI=;
 b=yNj90NBitgGfpay8egE1VIFrEi00eiwKPuOosAp5zdwSlPyJ17ESooreST3xxr2TUjUfessy6bfk1n3gPxPbTUMZkBjcCJ/Hg7FCawwF8PbU98e1HhKdqRQMQThV/AAbjjZkwgsdqM+ASEW2iW6RFlkOIyx8jdFzp8glyZTK2tl2ATcZSlHk6myrAIM89hmaM720dhZAUekWYWMXowfo5ufN6cCb0rWukPFMyxHm4XRa4WfFRwUdD9dmcPuxdi4SIYE2L0ay0uXnpGTMwMN5TJVGfGC63XLGzDroqW2X2Z3zOEnrgP2x0Qtcq0waFsM2/Q3HCCANKMkGSDUr/diSzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 10:05:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 10:05:27 +0000
Message-ID: <a9189449-d986-4c1c-9f25-e067f4adb2fe@siemens.com>
Date: Thu, 7 Aug 2025 12:05:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] Switch hosting URLs to gitlab.com
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:610:e4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a0459e-defb-40c0-1c0c-08ddd599ee9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rmt3QitVLzRCY0FXUUI5NzRHQ0xORlkrVkRiY01nZFlpb3VOYkxDUmI3ZVVu?=
 =?utf-8?B?MzRVc0hSRnQxL2JqRS9JWWhoQVJ4MnNYL3JORnVsS1A0WDNwcENoODhXMEIr?=
 =?utf-8?B?d2NmUHZJNVVWa2pSVHBZVVVHbXZmZFJEeGNFUys3cWo1MjRuUXVLV2lIaHEw?=
 =?utf-8?B?T1JUeklzS3E1cGxTN0YwTHl1eDZoeVVlSTZKckFqdjduSTNqbTloWEIwcHV0?=
 =?utf-8?B?blBReWx6MHg5ZmtFckxjdnpwdTQxaFViK0hrVlFmQm84WnpHdDNIWlhCT3V5?=
 =?utf-8?B?empTc2YvV3o2anhEbTlJSy9RNVBWZWF5d1ZRalBwVVF2UmFSTWd3RE1nNmFE?=
 =?utf-8?B?eFgwcCtZZktJcFJBUEc2ZW1RSFNHQlpuQnJHYkVmY1l3M3dseXBkQkFzempH?=
 =?utf-8?B?ZmdEM2c0U2ovUElERGdnQWdkVis3Q1NRd3dQRG44bi9NSm5yem4yQzRIWk1S?=
 =?utf-8?B?b2FhV0lQTFU0ZG1ST1FpY1pmd3l5WHdaWU9yR3hwSXErZFFtUWJCbDl5OFRS?=
 =?utf-8?B?L1FGNjlnZC9TUGNKekYwS3FFd0xOV3FFUDFKT2ZGeGtlNnlNclJEMnFhKzFz?=
 =?utf-8?B?c20zRzJMakIvTzNPYnBtdUtJVUhqM1RmSHpPYVFhK0lhQVplQ1ora2VMTzlM?=
 =?utf-8?B?Rm5IVDhxbU9WNVBZMHRyQ1lPYXlmRm9yZVp0cDRRQ2VoeEwxOG40d0h0KzUy?=
 =?utf-8?B?Sk91ekFBMithaHlNK0dKLy9MNyt2MGQ2SXBSWndWVjdwb2pkdUJVZVdnMkoz?=
 =?utf-8?B?RUl5QlZKcTVVdWYwU0ZrR0JyT2ppK0J4ZkFMTUhzRVphVnYrcnFMQWhUdmFo?=
 =?utf-8?B?b2tmVkxBUHA2L3RuT2gvUGVPVE1TSm5zcmFPS2tiRXFZMzhkWXR6UWtFV1lQ?=
 =?utf-8?B?YTB3TGtoUGVFa1kzT2pYTDBlcVpIQ1UveWlKODg5WUxVTVd6RDlhcG8zbTh3?=
 =?utf-8?B?LzhBYnRldVdQZ3pHNEs4VW95dldzbnU0eC91NGl6UTY4eWYzR1ArSWdrMzF1?=
 =?utf-8?B?eGJFREpNcFJqcFIxYWRzYXVzNnRCQ3d1NGdyS3YvMGM4cE1aa1FvZHh5Wml5?=
 =?utf-8?B?aFBZaExDZkVrZXVaSGJzUkdBM2VmS0FzQ1l3eWtKamdVdm5wTHpyQTN3T2dE?=
 =?utf-8?B?UEZ5L1Z6bGYvWFIxYlhOeTBiNmNCTnVKc2NHS0JXanRTbS91Y3RDb09ZTGNp?=
 =?utf-8?B?QWFVNm9iTVV5L2o4eHd2Yzl3V1FsYUk4K1NiRHZ4NGhwZWVmaEt6M1dUb3Av?=
 =?utf-8?B?elVJQ3paNVgwc0pBNjB5SG1JQ3h4Skdud3JJR3hBeENLaTBSSmlmaksvWklZ?=
 =?utf-8?B?T05uVkNKVEt5SjVYaFNYNG12OHJpeFNBWGFOeTJhQWF4S3BzTVRGOTZOYXVp?=
 =?utf-8?B?bzJYQzBEZ0RmdzF0WFptaVpzdDRxb1VHbUFHYTMvTWNGTGNGSHJNNi9CSFRi?=
 =?utf-8?B?MW4rb085bkVRYUZaNkxrb3FUYXNyMDE2UE9vMVEyTXBPNVlCUm5mU3Z1c3ZJ?=
 =?utf-8?B?SFpxRTV1WWZsNUdTWGkxN1Z6NTY1VzI1aTVxRW0zbktIalZucTkrUVpxQmd2?=
 =?utf-8?B?V1M4OUtmZUIxNzJGQ0xqYXdKaXl4V3FaOVB0blN2N3NWZmxkQlBLWTMxL2VO?=
 =?utf-8?B?NndaSGVzYUhLNm9jT2gzUTNOb0xReTk5c3pwY0x6RkFrOXovSktRNGczSXQv?=
 =?utf-8?B?aUZOdDVkYmpsY08vQVpaemhiaGxpWStDL1RMZUNGTlVSc2gyeGR3d09LVk9M?=
 =?utf-8?B?OUZqdTJYenRSTHpHQlZrT09yTk9pVzJNNzZNUUVlYTYyRGJoaEtEcTF4R1Uz?=
 =?utf-8?Q?icApip0+pZHOfopI9QOoCfmGG/64HPvyRmxc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnQ1a205QVN4dDhqQVhYV2hVSzh1cVk5WFNqK1VlTHFVQlJLS2xzQlFNN25R?=
 =?utf-8?B?Yk9XK2dxVnBJR012MW13U0FlUWVCTU5XallaRFJaV05nSmIxb2Z3KzA5K3hx?=
 =?utf-8?B?VmVGMkRieDdJM29JamF5cisxYy9GS1hwTStKaUFrZGR3OVVsZENDWHRseUh4?=
 =?utf-8?B?eHZ2ZFMrZnEvUlVuUHFhQi9hekJWZ1gzUGE2V1RsRk5TMlRFa2twTEt6NUYz?=
 =?utf-8?B?bXBYSmpNS3BSRS9NWjRJbU1FV25sYWFMNzFuSWJHdlg0ODc5aUhsZllDdGps?=
 =?utf-8?B?QjZ2TjA4bkZtdzdTQ2N3WW5IQzVzSU1rV2wwN1RGbE9aT2NjT0I2MzNBYjg1?=
 =?utf-8?B?Sks4YnMwV1ZoNGNFWlhsMlVSWDFGK1FBano2dEFGemRkbmhsVHR3eFRYcEdq?=
 =?utf-8?B?VFVXRitDMTRFSHJYSS9uNXZyOXVIcFZ2WXlUYmxvWUFNSlA2SVI2ZHUyYndI?=
 =?utf-8?B?VkwvbHFWYm82ckZzcDhQM3hSdTVBeVJKRXNHLy9HWXhGU0luZlV3MDZ4a0pI?=
 =?utf-8?B?RVRUeDczRUVZNm5PM2MzU0JwVFRUWWZvRFRhalhxOVhFZjRSM3phbkpvVzlE?=
 =?utf-8?B?R3I2TFRaVzF5eWtLWmR2NmZUUmp1Q0craW82R3Y2WmtYcFJlcXl1d3NHRmdk?=
 =?utf-8?B?TVRjNUZEeEw2TlpOeDlycGlJN0FybXFUN3VjTHcvbVFWd2JnZ1dlL3BSdGhG?=
 =?utf-8?B?YThpc0ZvV3hUSTVodlBENkpWNkFrTUg0cm1GcXl2NFZEQkRiUXNNaDIxNzgz?=
 =?utf-8?B?THN4NWIrZG0zSE9Eenk0MWY2UW5ObHI0cWxrSlROVzg4Si9LNDZiQzkzRU1E?=
 =?utf-8?B?Z2dobjFrYXkzQURnRnVaT3JCN3lZSVlhYVMycitHL1RrTVBraEpGQ2VzeEVL?=
 =?utf-8?B?eUFzTHptTlFSRk1nTTQyZnM0cThEMUI4REROZUVQMlR3T2ZuUWpWaUNjeXdT?=
 =?utf-8?B?Y1JIRVplb3dhMDcrdGoxaVlycGszZmhaeEVKaEhZR081b3dQSVdXei9wV004?=
 =?utf-8?B?ankycndPZWVCWTRZSGJybGl1eUEzblI3TkhMZE1aeWtVR2xycmV0TmxZQXhD?=
 =?utf-8?B?V2NVcHl5R2x6Z1ZLeDRKNDFRZWVhZER5aVZGV3h5VUxtamdVdXFIM0xleGxX?=
 =?utf-8?B?NlM3K1BNQmtyVkJVeVV2NjkvbGk0dlloeU5lRTNIMjF4RFJuVzBvWUMwbkJw?=
 =?utf-8?B?bUEzRFRMVEdJbDQ1YWNsTUdDWUNIRkR1Zm1QaUE4b1J3b0d2T2JZelFKeDU3?=
 =?utf-8?B?TDBnSmJqUUNlMnVwTGlhZ3hIc2JKbUs5VzlZck01d0JQQXN0TEdVSFh1WmRr?=
 =?utf-8?B?ZFNYOVFqdWJtKytKRlYvbitWcHBjTFZrcGZMNDE2ODRQY3BicGNENm9FWWtK?=
 =?utf-8?B?Ym1VbHhnc0RVOW90NkJPTzFJV0N0VnBIaVNFZ0dzK2hPYXNraEM2dkRrQ1dF?=
 =?utf-8?B?eHRxemJUQ3ptdy9HWEVBZkJPSTN0djdYKzF1ZVRGVlZ4KzVkbTJJalV0VmpT?=
 =?utf-8?B?MHdPU1pFVEpGYjVYcFhIZWl3dzZLb0hlQi9ESzljY2xHWDV4YU5ZeGMrTjFD?=
 =?utf-8?B?VDgvbElPbU9PSDRPMmlreW45OWdNUWpReER1TjJLcXd2TmZjVjlwdkhreVRN?=
 =?utf-8?B?ZVRkdnl4VWhTV1h1VzR5dTVLMENkL2VoeTFpVXVPY0RGWTBiZWhrR21GNkJB?=
 =?utf-8?B?ZDNOWHZ2WlY4TmdrOXVQUjliZ0VzdkZMYVdTVFJxNEJKdVRnMVFaV0hLT3Vs?=
 =?utf-8?B?VjVsaE0vY21lWTAyajdhNFQvSW55MEJjamFtaWNjcTladGtyVzlzRUt0eDZw?=
 =?utf-8?B?cjFaTFB3TGtaSEthS29scFVoSGo4VjhFV3kxdHhyVHpxamNjL1F6MGhLcjZR?=
 =?utf-8?B?ZVhZWlBxeG52c1E5RU5wQktJckpyRlRCWWpnVmk0anM0b0JhaXExKzZVVnZo?=
 =?utf-8?B?czBTWGoveW9mV1I2MC9STCtMSGFHM2RlOEdWdTFiRzArbjh1ei9Od3dWTzFQ?=
 =?utf-8?B?WlpIZjNqSVJGVnlYaVBqVFlDUHp6bCtZRnVYS242alB6RzZQMVZKcWU4OGV6?=
 =?utf-8?B?ckZJaE5BdkVORlBHbjdmYmQ3Y2x1b3RFOEYwaXA5UVhaY3duSnNWMDN1Wk5t?=
 =?utf-8?B?d0FqVi9DZjFjTzh3OEdnYVdQTisxV0VFKzdVR1pwVjhRb1dYTjVGNEdJMWUy?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a0459e-defb-40c0-1c0c-08ddd599ee9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 10:05:26.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa0rvh7vPNVZ4l6IdovIOq4npNSqNRQC1uf1DGp/rAkoiPMj3jCEFV4eWcdmmczgmGKAifuLEOUb2BSu/ZGBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5329

From: Jan Kiszka <jan.kiszka@siemens.com>

The Xenomai project is step-wise migrating to gitlab.com because
source.denx.de will eventually be shut down. Repositories are already
mirrored, so we can start promoting and using the new URLs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                   | 2 +-
 README                           | 4 ++--
 doc/asciidoc/README.INSTALL.adoc | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7f15abcfbe..fd23775965 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ variables:
   KDIR: "/tmp/kernel"
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "1G"
-  PIPELINE_KERNEL: "https://source.denx.de/Xenomai/linux-dovetail.git"
+  PIPELINE_KERNEL: "https://gitlab.com/Xenomai/linux-dovetail.git"
   GCC_VERSION: "12"
   PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
              autoconf autogen libtool pkg-config ccache flex libssl-dev \
diff --git a/README b/README
index 897e90c7e8..cbb557808e 100644
--- a/README
+++ b/README
@@ -39,7 +39,7 @@ https://v3.xenomai.org/installation/
 
 - GIT clone:
 
-  https://source.denx.de/Xenomai/xenomai.git
+  https://gitlab.com/Xenomai/xenomai.git
 
   Once the repository is cloned, make sure to bootstrap the autoconf
   system in the top-level directory by running scripts/bootstrap.  In
@@ -53,7 +53,7 @@ https://v3.xenomai.org/installation/
 
 - Tarballs:
 
-  https://source.denx.de/Xenomai/xenomai/-/tags
+  https://gitlab.com/Xenomai/xenomai/-/tags
 
   Source tarballs are self-contained and ready for building.
 
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index b74079dc2c..cad32f3d56 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -64,7 +64,7 @@ $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
 
 `--dovetail`:: specifies the path of the interrupt pipeline (aka Dovetail)
     patch to apply against the kernel tree. Suitable patches are
-    available from https://source.denx.de/Xenomai/linux-dovetail[here].
+    available from https://gitlab.com/Xenomai/linux-dovetail[here].
     This parameter can be omitted if the Dovetail has already
     been patched in, or the script shall suggest an appropriate
     one. The script will detect whether the interrupt pipeline code is
@@ -271,7 +271,7 @@ _Cobalt_-specific requirements
 
 - An interrupt pipeline (Dovetail) patch must be available for your
   target kernel. You can find the official patches issued by the
-  Xenomai project https://source.denx.de/Xenomai/linux-dovetail[here].
+  Xenomai project https://gitlab.com/Xenomai/linux-dovetail[here].
 
 - A timestamp counter (TSC) is required from running on a x86_32
   hardware. Unlike with Xenomai 2.x, TSC-emulation using a PIT
-- 
2.43.0
