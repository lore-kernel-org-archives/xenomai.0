Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC83AB283
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545979; cv=fail; b=ECEv61+n62qYYQpYCMIlYRcnLIs4ewb1NnVFec0+c5vQNRvqH8TypYvYSwPmAXPkZorgh13XE9qyeChgJ5enLpxkT1NvdcauddVUwfD/xOaMPK0OghhfgIrp2C97NbIaKRg0C8KtdCqOKPM1IvuUjtbrHB9ztr65+Ie7/7rsL44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545979; c=relaxed/simple;
	bh=C7mXETSCUbM3ICr9aKI+Y9ImogOk6Be+todbf/1x9UA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLIr/QWjbKQB2q6z8bJRTtJTzKljE9t+XOCfMGTezbt39kfIj1aC24Hl84LhY9ulHmNyhdOlBOHZ6VBxqmUFmtw8dgSA9OXZcCYeAQd4RdkuGJQrn9zYy5kNrFtxLBVvH5F4QS0kXAc0uHXh9jh8w6knr1+U0rwO9YrjHlhZxcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dl7NcCBl; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dl7NcCBl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mztb3Q9jHciLdwdB20mVWGS0rN3LxAVicsR8SGFuUAifcTMefZPuyLDS/3jsiFC0qUrZgs443MXLdZq31VBqzpGmEUNAIbSkthAKHjrX4XJbTZGbGLSuzQ4nSyRBeYLzQZTT+WQRtRycTelRNAP+pwsWqOaAWc7T8eZLtI2YS5DwxDEWvPo8gCH0gJErzY6XOMv/TGw7fAi72400GkpIfx9ZoMu4URK9dbXN8KtBdZGc40GaIOrol8N2WFBedWaD1XWBC5PYrwiQeqBcPngww04/e14sqbowMSYPL9mtXoczL0+mSTQRWz9NgO0ENvGEG3ICDpDHRtEluDJL6zL1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyHt1z4JzGw6K0Z2dGd0uiGDLgVciqoQu1sHtpjJCgg=;
 b=OyoWt2Y2oIXZzLZWS5xjAuHYM14dZchtxS3xHVdOuBOGCAKXsjgPyko4X4RnpVyM6RvOczB3TOZQ8Ei1dvFFzzNeGkHijW2ZCjIEdFqM5zPrXxCBYKxX2MDCOVmii9/BcW2KwM2HQF602M0B2S0Oa+GvUe4ZjxmQV/RTLbGznWNYGm/LBEZkdHUSeLdQMMYiW2mUvJpctUmi58EWlmqruqTMeqnBA+67FDEIen+K2FWsj3QB/DtUoFBhSJ+ORij3shEGvTxxv49Ovisc64JIoMkZ7GU3u73/O1ShuNyWG2dde2vSCtyNXqxZ/SiThNPoMBbLhv2YXdFE2sxfLjBqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyHt1z4JzGw6K0Z2dGd0uiGDLgVciqoQu1sHtpjJCgg=;
 b=Dl7NcCBlB2kL+0ehMXDRyWcQH6VGsMZMU1e1y+RDUG140YSOOnSlkNS2R1xhogEsCZaF59UOh124EwO5J403gtXD3Fs53VaUizUFHxrkFBA3W1bew3iWUMZpXWMYau4IwSfT/KbINN5Rs0WGCXHDn1LaAV+Yo5h2qaT++d7GbJsIKaHHvAGPFXzxy8foIN5/ZXFuKSRpFbflRSQ8yJgMZJGlOjpCrKwuMuRz9/YMdG2Ar2h38u/GP4fuvPQ1i5Q7RM1mXEvok9VFkS4W8EE/ViqAy1CXTLDPgV+20flUFQAiJvaWlofzbcZKDWgkXu53r0RUmHaQpBZwextP41zKCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 21:26:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 21:26:13 +0000
Message-ID: <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
Date: Wed, 8 Jul 2026 23:26:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv
 branch for riscv
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: b572ea4f-7b82-4bb4-4550-08dedd378911
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|6133799003|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FiVd9MSu7gZ8xoaCXcKJhJa+iIiWcK8S9+4HCiD/1gkwlyiIZ7CZObBrVJdg36XATE95fVO3E/kntkqyd96cgEFskcqs7zH7E4EFGDRHo72seYq88165aUlGTThPLeh18buE2RMz/rayboTElM196L5Pzn7p6dsVcBTpBk9mudEMORjili/Ypq9zdezN7myULMjapBSqw3ggij+LKRbX+GqHBySOYPDEvvO4v8+UZy3VsPEUTL3VxrvpTm3cDia5qd7UhtCgRmwRppXumiatM3y0FUlay8NGN16SB8QlNuaL86Ir3cACAD2TUcdBSY6QeFKlg5OJ9sxCp6AR/pM3jg4RALl5yRWc3mY0+AdvX9QfB5VrzaeHh5qtGVNYWc5X0nwQzQISa4Kn1bDWrCIy3UbcuOVI3bnRZYaI/oN4qCNcPksW5sm6a3y5lh9goGGyOXsyuki3zTgTWsmaff5JE2K04ICe+WunziXZucZFSRQdZbr7wrubxFisslugI28uuMmBTtyXRhKmEo+0pTmLYZXyEZQUQ0ovU9d/aBZqPNtDBHMpcDGw0nMnYfq8Nszp19XNu7E7v40NOsNtDP4EalkQwL68UGBsXOTN2IbuQY8aFp17wZap71LMA8X2Vn1jUlJomiRbi6GtcuMEIzKmzqw7xH/2pnin34fciGBLDvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHd1ZEE1Q3pJRmVoVTE1bmpmWnRFMGM5TlNneGU3UFQyaHpFN1FzUkRuNi9T?=
 =?utf-8?B?UXpYQVBiNXFGS2JaajAySEcvMEVyL1hXNlBjMy8zbG5VbG9sYTVjRnpndm41?=
 =?utf-8?B?dExETTF0akw0Zy9yYmVvRm1zM2JoWTFQL0toUWlVeDAza2UzYnFkckZGL2lp?=
 =?utf-8?B?cEl2RUppVGs0dnp6eXJMbWJQRFpLb2dSRU1neC83MVp0Y3EzWDhBaEphdnNu?=
 =?utf-8?B?QWdVZDBoOUhMTVR3ak9FV3RWUXBkUUptNnlWajc5R290N2NYNlNmb2RFQndy?=
 =?utf-8?B?c3RUZXRSOXhYQUE1bWlXajhUOWNUUm1zbWVYWFA5SkNWUkJ0OFRWMnFkdm0v?=
 =?utf-8?B?YnQ0TDhJUDdhYXFZOGVxR2Fla2ZKbkNhMnphNW0yeDFpcW5YdkZ2QVExTWhv?=
 =?utf-8?B?RzNWWHlURVRxOE1LSDhqZzlvMXQ1LzgzRnNCTzFsRmx1bUN3M095aVVXRzd4?=
 =?utf-8?B?RDN4NDluQTZEWE1NTnNHT09rWk4zWEJ0c0VPb254ZG5JU1VmRm0zQ2JGck1Q?=
 =?utf-8?B?T3Y0TmRVc0grRm8yN3kwbFJsUXV4N3Q5aHpqVmJtZjJncjhBMXlTU084S1Zu?=
 =?utf-8?B?YjBwVllqQy9vektaNXFFMG5Sa1lXNEpsc3dCb0l2Rk1FTUZoT0JINUdNWnZt?=
 =?utf-8?B?TmtQK3dNMENoQXozSmp0QmlCNTc5cDF3c0paYjdjZm9tZGlQUmNpZzVSNWJQ?=
 =?utf-8?B?NERHbGt1SVVVVUU3ZGk1Q2grUUNjd25KWmw2SFRTSERoTnYzSmJ1OVFIRmlv?=
 =?utf-8?B?OWF0Z1JvejQ1a2ZlSitsb2ZVUk0xU3NVM3JRYTY3QWZEWXNXQzJMdk1SWWZq?=
 =?utf-8?B?T0NpR3VoVFFoNHJrcENzQ2Rqb21ZYUJnNzNuLzhTVzBGZVBHcEJWZUxPU2Qy?=
 =?utf-8?B?U2hqdXhFeStvUmNWdjZkQUIxU3dTOFY4ZUNTRllzbFFQdWxVWmlzWG1IMTdQ?=
 =?utf-8?B?UmhWSW9IaHlrUHAzdVBhM2w5Tk0vWE43TkZaN1o0L1lHdkp6MlVnSEZIS0R0?=
 =?utf-8?B?ZEpGV1VaV0dEQnQybEpSOFNxNGdFRzFyaCsxaHZ1OGlFNVZwYlNJeUx4a04v?=
 =?utf-8?B?TW9ybWtqbmRUWkFTRGQ5SDhxRkQ2M0t2KzFualI1ODkzRVZGM2s1TWVnc1BQ?=
 =?utf-8?B?cjY3Y0txRW1nUndFd1IrUVlHRmpJSUl0amo3STFVb0tpbDNaZEYySWE5TkJa?=
 =?utf-8?B?c3V5Y2VYeGUxZ1lZMDNuSmx4cUFUZDhoZGpIQWJ1Z3MveXpVem9hYVR4QkVK?=
 =?utf-8?B?dWlwdmNhTWo1ZEorbWl2N21jb2NybHJ6dUNEZ0pjMmFYUld3R3V5TkdBM2NM?=
 =?utf-8?B?c0Q5dlhpajBLblpvYzlTSkRXc2xxaXF2UjZ4cnE5aS9hYVcrRWNWVWE3dWc2?=
 =?utf-8?B?cHFIWmRMZFdUd1J5cVlZMWhXMnlndTI0T2hxZnpYclM5NWRqY3lEU2o0WVcw?=
 =?utf-8?B?TVhoQ0ZzU1hVelZYMk5SQTJvVXlUamtDQWFaNGNacFhhMmlFR0JiTU1ITDIv?=
 =?utf-8?B?VVIvYVF5UTRZcHZsVG8yeGUwMm10bUdMOVFVaXlNN0F5MGFhZGJNV0FVdWcy?=
 =?utf-8?B?K3dEdlMzUEEwTDFYL3R0R0k0M3ZJM2l0anR2Si81Mnl2WUIvUVJTa2xlcVB3?=
 =?utf-8?B?U2dIZU9rN1FIVmhldmUvVlNadFZyVUNRK09qVkdGeXlZU3lPUEU1TjV5Y3p0?=
 =?utf-8?B?Wk4zR1NpWmROR1Z0WHlnSnpobHpFNDltQUR3ZVBQbVVnMmJzN3RwZURNWFc4?=
 =?utf-8?B?aGo4MmFFUmt4UHgzOWVmWUtRVnVYbzZUdFlLdmNHMlBEMG5RMCt1UGJMTnZq?=
 =?utf-8?B?WkFjbmlMVSt3QzRMbWJkcVNYSTFrUzVtRWJOWUp2Q3JLSmxEWElKcE5WT3Nt?=
 =?utf-8?B?aUhwSmZaeDNJdDFkTEY1Z2FYb3RKbVJoa1J3eVpac3grWTZpMHQrVmV4ck5k?=
 =?utf-8?B?MGhzc3lGWE9Lb3UxUDNRdGZKWkxVWlFRYTA3UnJ0S2lXVWRUWGJyZ1dLMHpH?=
 =?utf-8?B?bVBxODJtN2UzQVlCR1BNUUxGVDJ0TDNoWmtCdmpQS0dmWFFwZ2kwV0ZMbGxs?=
 =?utf-8?B?SHY4ZjMwaW9TN0puLzJxd1V2YitzdW5iNDFiSnNLemcveFVyVkw5T0R1SjUz?=
 =?utf-8?B?YkVMR0R6dGgvSlpKNSswS2taL2dSMWNYMlFuaFlYTVZIbzIxSVhDOWNSeG9R?=
 =?utf-8?B?b0pIWktzU25BMzFnZlJZNnc1S2gzSGNCWXhvWlhYMGlwMkRiVmJ4WlpqM1Nh?=
 =?utf-8?B?cTlDN25sQXZqRDRFaWZnbUdMRkUzTVJkWFBtdUFvVXYvNnVrSTk2QXgzVUVR?=
 =?utf-8?B?OG9UZDRGc2Jmazhvb0RGVVc1bXI0aUZNTXpLTFJ4U1dBZFFqazNodz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b572ea4f-7b82-4bb4-4550-08dedd378911
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:26:13.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7Q8DzvUfw4f4hy4DuccN2lBhbGeeH3dFn13VLjmIRgmmZPbc5Hb6OqGkH6vT9CPsrP9tqq7JDpWWTSy/vTzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8993

On 08.07.26 21:40, Tobias Schaffner wrote:
> The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
> for integration of the riscv patches into 7.1.
> 
> Switch back to wip/evl-riscv which should generally hold the
> current riscv patch set ontop of the latest next.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> index 48499ca..a542e80 100644
> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> @@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
>      'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>      else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>      else d.getVar('LATEST_KERNEL_BRANCH') }"
> -GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
> +GIT_BRANCH:riscv64 = "wip/evl-riscv"
>  

This branch became stale, that's why I switched (535ce20bf0e8). You just
updated it to 7.1, but its baseline is again outdated.

Jan

>  SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
>  SRCREV = "${AUTOREV}"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
