Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8962765DF
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534801; cv=fail; b=rzIuOR9+zCyPieDKP9/rb1ryeCk35PfSOvHLjTCGQyfuzpjcsYoESh8CvVuUNgTYIErV07lkdUlmACaXQdPVDlMd7XceuaCh5M/eCBKzDqS3d86XhR/4IvlVCzY/xbD0NJgMOcqJtbLFgpdzrq9ebNRPmerpRr8Mfg9A67+jIU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534801; c=relaxed/simple;
	bh=QP4V+k8haL8u9itg1eYsoW7I6z47QaQ8d/QGBDb+9mU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JqkpTF39+w+HFMs6GEo63ZWM1NboV1Q4RRwuGjdlpou9i6TFUFIQ0B3mEPB/WNB1ce3D+vDDO9MLnUC09IZhAxGHsJ8Ti5Q7ttmZoA7CNH1N7sZ0/4zafvydEaZGFzmzE91/JeFK8n+GmPze8ovwkwr9pLZXZZ02qN9DF1nAQFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cXk5Ld/M; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cXk5Ld/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4AW20HKP8IT4aaNUtkV67KinPd9wBC0ZOJOHAl+UlIrjmc1LeQ0/CrofbyOlezjRtDeNCiNpjF1M3qFmlMDo2ZUcms+FXffvkJ9/9Al8NvIHOU8yeAj1qyUtbTI9XQo/HirBpQJ0zu7xuj6b+tZ1gPnOLgP6uUvCNpNH2omurzP/UGO4lP9rDmV7yGkm/WBCP/IoYtskk1O6Q+t4aQzeSfxndYcQrzdq0+v0E3x+doBsmU5F1d1GZXhL0lGB6FsL/KMT7Qei2MXlK6CJAYWgo+aJktnsjaJ07CxT3XlBptqiJ++GQpZBFdX7j6gUiZ2k5at79qfK5ROtTkF/bxM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1IkGZBDPSVdJ0dm3PitcWgInJ+DsH70hmuK8fYu7e8=;
 b=nUGMGVBgQSYhozvQospxlyqxWRPb//gHGKdewp2Sry7aDJSGpIZeYCqJrg4n2Wh5EqbHkdnuWJdIc7Ppq9dUwLcHLWgL0vLoAq9s4ltRgVIkZo6DilSckq1aeUyRuf5S4OaVC+Bq1Qj4YafJ0Uw6oxxVfKRbxiz7GsfZDCpgtMTQ6sH2aY7IJh+lYvWPlvYE/mFYtAtGGCoCu0bDv8lYaGk1VWWbV0xsvsbHEcMwltVDT0mwoopdroyUMXgcmVk2E+3+n3ilpu5YXstfJPFpOAal79SmJn9stU0RcMYbjm2J/NVsqaBNj/tze5UmnEA2lsqFrO4ZGxc9WISO25RP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1IkGZBDPSVdJ0dm3PitcWgInJ+DsH70hmuK8fYu7e8=;
 b=cXk5Ld/M0dNnQiVV/HPP6PpFzw99+PSwUba+If/6IJY9oC7X56tS7wMZRn2VV7wBDDYQFXVtrQ2IkpFlr37Yj5vHTwpqfcfJIxn9pDF97Vzugqyo5OCoiyrjECCroH7X5j5JpG1Gbi23i51c4Sc8i/MRTXotWnM/YYHsZRdAH7gM2+E6oYmzXp54dtvJmYkN/yq5PFQVBa6OSXtq3lVdYIePdzp5vRY6jW2QCqWw1KGbO028szsgrbB6ww6lLTylIhcOGsYRxtAS2lw4ZjI0SB//0TmX+v2nVvZM6DQgRCsJHYyS1rALKobpQp5DurVmhTowIov/GxYv3gmekiRNYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:33:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:33:14 +0000
Message-ID: <bdb87782-60e3-41ff-916d-ad8a84dc1dba@siemens.com>
Date: Mon, 18 Aug 2025 18:33:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] drivers/stack/ipv4: Add missing
 MODULE_DESCRIPTION()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
 <20250812-wip-flo-add-missing-module-descriptions-v1-7-c57f195e3f93@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-7-c57f195e3f93@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4e2a49-38ea-4538-cd1d-08ddde74ed9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pDbWlYMjhkYnNhRE10WlZOSDY5ZXlXcisrWEcxRFlEWkZtaXU0a05rY1FQ?=
 =?utf-8?B?MUdWbnVEK0dBQVZRRFdpSEI4MmFQN1VXaUNuVHpMV3ZkU2djakxPWCthalVM?=
 =?utf-8?B?TFJNNVFqbzZSTEtST0R0Qm5jYTNkL3RudzI4dGxkRzFZdnkzSGJ0aWMxNmQy?=
 =?utf-8?B?NXRBYjlZcWhpd3hjZHlJdFpwZSt6SFF0eXcvZTU1TGZXcXM2VnlFWnZsYit3?=
 =?utf-8?B?TEJMM3M1emt4azFNa29vT1B4YUMyS1dTY1Nzb0swaVA3clM2Nm5PVUlmUUZC?=
 =?utf-8?B?VW05QzFnZGc5d2tBOUFVU1kyK1lLVCtBSVBrRGJaRWhzMm41eGtWT2lsTSt0?=
 =?utf-8?B?eGltZWJhNmh0RVJQb1dSY1h0VnBXREJGRVpuOU1zNHF5aDBwUGNvdy80WWdK?=
 =?utf-8?B?T2hZZi92WGdnS1BhWHBkem00YnZ1T3ozVWlncEcwNEhycnJ3U2RIeFNZVkUx?=
 =?utf-8?B?SWU0MHB3b1lPL2QwMkNaSGoxSnVIUmg4N3hSS3YvVlRvRUk2WmVzWDl3WHFS?=
 =?utf-8?B?M3RPUFdiWmRNOTVMWW40SWZ3dEJ0RWxZakxlanBrTXNTWWJ2TE05WEhNeVor?=
 =?utf-8?B?Ty9IM1V0anlUUTRZNXRRZVNySUlSMzZKbXM2em9UQXBhNlZ0MXFCWUxFaXgv?=
 =?utf-8?B?a1Y5c0JWVmdZVk9zQmhudXBDcmZ2V3NmK0grUXRoR01ZVzYxRjZqRUdNbnJO?=
 =?utf-8?B?d0svV0krckowbTYvNHpBWXFZSFJRMmJKZEx2YjBoRlhQRjdXMzZoNFQ1MCtY?=
 =?utf-8?B?T2sxQys4VWhPODdwSTgycllMVkRwc3dYc04vMDBxa0phWkxuby9BbDM3QW0z?=
 =?utf-8?B?dGM4SXpZenhxQUd5SUxDWHI4MmgrYjhLRmJ4UjNJelFXRG1pUkYxYjlYcFNi?=
 =?utf-8?B?aGthY0k1UGNERkxWZVM4V3g3dTQrY2NvTmYvNk5MQmYvSm9hMEVEcmNIcmJs?=
 =?utf-8?B?U0FVOXhKR0hYbGtoWUZ5dXQ0T3ZhRXRFM0NBemxzM3R5WDk1UUVOR1ZocWVB?=
 =?utf-8?B?NmdKZE5ObExDcmlEYVdETlJ5TXZQd3l4RVB6U01Na002a1N5dTFoQVVDa1ky?=
 =?utf-8?B?RHZYT0RVbmJxd1RIM2JNTzluMk9acUx5c05vbkhmSE56ZUlyOFZnNDVjTkdI?=
 =?utf-8?B?czVEWEowc1piK0JxR0hpZzF5eEZTNlBhSmQrNXZxaTdGQnpNckRoMkFEZ2ZS?=
 =?utf-8?B?RlBNZ2VtMjV2b1cveTM1Tjc3WlYyNk9mVkRXYVM4V3Nsa1UwQ3gwcGs1K3Bk?=
 =?utf-8?B?MDVsK3RYbld6OGNrUFNnSE55aFk1cTU3OHJnQVBiU3BKcWhVaFRyTFd0bnk0?=
 =?utf-8?B?bVdHeHF6M2hXeUkrbmZFWGVCRWRVQWlkQkdZRFNSd08zVFNEMW5OSzhhL21W?=
 =?utf-8?B?aEpsenhpcm9FdTB6YmQ0dXhPVThMZmNQWjVqMG5SalRYVVYzSEVQRlRvWks2?=
 =?utf-8?B?UHduSVhLZHF2UCtYUXYxSWZFU01FaTVBaDg5aTBEd3RES1Y3UlNRTHI5Wkw1?=
 =?utf-8?B?c1V0K0V1TVlGdCs2YWdhQk1IaG9XMDUrMFJVME8xczE3VGlYS3JzcEN4UDdI?=
 =?utf-8?B?cHZnMklzTis2bXlLQmpiRXk5K003NEEvN2VNbm9LNFdTc0lpd2ZMUlVtaU1N?=
 =?utf-8?B?UG5OR1JtYU81TGI1Tnd6elZzSGhmZm1vZVdNZFhsT0pvNi9GNUxTQmQ2ckRI?=
 =?utf-8?B?N2UzWVlDQlhSczdLYng0RGdZNlBRYU5IdnRJd2lHNkN6dnpyN1BHRGJEQ2My?=
 =?utf-8?B?b1RDSVU1N0RhY1FqWTRBSnpSMzlqbWxxakJoa09kY1NIbi80K01XWmIyODhI?=
 =?utf-8?B?cGlyUENjc0lNQjlaUVRFOFhQdHY4YjRaK1RGQkFhSlhqeFdQMHZMb2tHcWFG?=
 =?utf-8?B?eFMvb3o2d1VkeUpLM25XSVptM2VyMG5lT1ZpV1craklqNGdsZlRtWFh0ZUpy?=
 =?utf-8?Q?FyUXYiMUd6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9WUUVDNGhYclNDTjRlZTFQOUhrS3VPS1plaDdET2ZnM1MvK1ozc3pmeGtE?=
 =?utf-8?B?cU5mS0dHTk9iQWhZbC9DR1FNVi9zZ1JKbVN2Yi9KcjNiT2J0aFdMUFNBY3Vt?=
 =?utf-8?B?VGNWY2IzeXhXYXVmRlBSUHBjU0tyT2ZETHlhWWh4U0s2c2g4NG1iOGJUdjA0?=
 =?utf-8?B?d1JQVXo3Z2ZKSGZXL3ZHVWZ4MmE2UkxqQ0JKUlFwRTJUdFg4NTEwcnozL1Y4?=
 =?utf-8?B?OEV2OVVHckJpSldMQUFRVXNuMjQwVmNoVnpEUjlOYlNncFpkZk9BdEZxa3d5?=
 =?utf-8?B?NXZuUHF6OWMrTXUzekZ5ZGNwV1QrZ05QKzBDbVFHSVI3NnNod05CME9LY3FJ?=
 =?utf-8?B?Y0t3aURiT2xaeTNSNnRFRXlPVVU3QUY5ZlQ5UlREcDZRTjR1U2M1VUQ5RC9B?=
 =?utf-8?B?aWw5Qm53c2N0VTMycytVMFp0VUlhYlRZdkx3ZVBiZGlpcU9zN3pFZXI3SW85?=
 =?utf-8?B?RFhIQ3oyQ09aUmdMZzU4Y1NrTXhxc3Baa2N3Y1dUMHd3U1NONHBzMXpoU1Q5?=
 =?utf-8?B?VHNxcXJEdlE2QzNnemo2T3d2dFZ5NHplMmwwU3FBUmx2NUFKa1A3L1hMN1lv?=
 =?utf-8?B?NlFBd0kwRlluR1ZmSFF5WGhNWXBGVU12NngzeDc3c0oyVGJEWWZFbEozSW9t?=
 =?utf-8?B?eVhFNkJ6M3ZmUThQSjFwNVp5ZnkzRGFKTjBlc0NUS1IrU0hxb1d1dXpJN3Rw?=
 =?utf-8?B?a2hoeDFsSWM1a3A1UXRmTTQzMHhjdjZqMzZhc1JQaW00ZkZKUGJjQkl0dnRE?=
 =?utf-8?B?SzRSOFRvOHVXcldOeCtZUGxqVUdsaGJ0eEIvUVFpMldwQnVYVW4rQmtKbk1Z?=
 =?utf-8?B?TjZNQmJ1YkE4REFqTUhVLzl3U0xaTk1uV016TUVXYXY2VERueU1pMm9uODB2?=
 =?utf-8?B?SmFpWWxxUGhtRlk4aSsxRlk0VkdHTkR3bFd4aUNyZmJhTThOUVJQZUFlWTdN?=
 =?utf-8?B?MkZGWUFISkx0VjZpdmJFT1J5aTlmVUU0SVM3aktHT1ZQRkNNYURubWVkMUhn?=
 =?utf-8?B?SnQ5Y0ZLbkRrOEd2RnNEZlorYk9wQmNseTJ6MU9ocG41Y1hmbHNSNzFZOTVu?=
 =?utf-8?B?QVNPdHRKT1Z1dXhWUWI5VzVpMzZDSjc1SDN6V1F3SmhhL09iQVZFS2p4Mm9l?=
 =?utf-8?B?aG5URm5SOXBzamxLemNlK21ROGNPM25HRlFKZDhwM0U5S0MwcHBHWUpDb25q?=
 =?utf-8?B?L20wWk95YUZKNjcwYU5MVDhCbWxnRjVZUlJCQmpwbm1FQTN1MllzS25HbjVy?=
 =?utf-8?B?Yk9jMDNyK3lYQnQyczZ6Yk9DN1NROXBqYWwycnE1VkZNc1pWSXQ0c1I0N0Ru?=
 =?utf-8?B?RHlWLzRHdjl4b2hxemw2MkVlbHNiVjZveG55NTBXTDdlMThnbXNXYktxVHFS?=
 =?utf-8?B?Z3kzSld5TEpVUG1TV2MxNDNKVFBTRXV1T3JLVzdRT0hLVE1NamNCWnV4eTRq?=
 =?utf-8?B?MmhXcFJjcVpmQlc0VW91WGhBcnNzZ0I1blF3ZndlNm5iNHl0YU1vUFRDSWVJ?=
 =?utf-8?B?bTJ5N3BRUEhIQ0c4cEZsOUJGOHRKU3o4amxLbU5aM2xnVmxpaHhxbWY5Nlkr?=
 =?utf-8?B?VWpJTFludW5uZ1k3bzNFbS84YnVYZjFRMXpCb0JicWtOdTQvUEZXL0Fwbk15?=
 =?utf-8?B?eEs5TFk2SEdCNlNhZGxINFJkSjlIRkZYRDJqUXFpYnVyMnNUbFVFZTNBOFN6?=
 =?utf-8?B?SGR1VDNjMkxjWFE3VVEzUVVtMjMyRktqbUxmNk1lbWk1VFZ2dk90SWFJZ3N0?=
 =?utf-8?B?ckJiTVpjeU5FUS9tV0ZxYStZU3BGQ1ArVUhzaG9VUnFzZXlXY3ZVTWRtRU1P?=
 =?utf-8?B?NzhxQkVlcW5PN3g2SmptOTdKdFFtd282bGxqR3pycEhqYWZKR3VKd0wvV3BC?=
 =?utf-8?B?TU1nbkpJYnlmOWNjSzNEK1dFQ0pEVFExeFRiVUMvSXJuRzZySWhnejJrYkNa?=
 =?utf-8?B?N2pTYSttT0hKNWFSQk0xQ2FwVTAwRkcwNSthNWJMbGdiRmsxVUFmU2VwVWhn?=
 =?utf-8?B?ZlNtZ1FmdVhsSlV4MS8zMkNLQ1IrVGNQOVEvM0xEZWNQMVN1eUJoMWllNjZs?=
 =?utf-8?B?cGRsTUdkZGEzMytJSkViRkZzbVJTQ3VxMDhIZnFINlRXek5zR2gzdmw1NlNY?=
 =?utf-8?Q?sEFBUMc46XigKmN9i0+p20uof?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4e2a49-38ea-4538-cd1d-08ddde74ed9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:33:14.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJWqcsRN+zep/K9PprN8kth/0ruTBkVU2mNAjspk3TSUfhWSIt+Ih41fADou8OBt9GN8yHMsNJij9vnQRYnLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6545

On 18.08.25 14:26, Florian Bezdeka wrote:
> There is a build warning triggered when MODULE_DESCRIPTION() is
> missing. Seen on builds with Dovetail 6.16, but likely older versions
> are also already triggering the warning.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/net/stack/ipv4/af_inet.c | 1 +
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c | 1 +
>  kernel/drivers/net/stack/ipv4/udp/udp.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/af_inet.c b/kernel/drivers/net/stack/ipv4/af_inet.c
> index 8bc87d90b..cebc20a69 100644
> --- a/kernel/drivers/net/stack/ipv4/af_inet.c
> +++ b/kernel/drivers/net/stack/ipv4/af_inet.c
> @@ -36,6 +36,7 @@
>  #include <ipv4/route.h>
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Real-time capable AF_INET implementation");
>  

That is actually the RT IPv4 module. Fixing up on merge.

Jan

>  struct route_solicit_params {
>  	struct rtnet_device *rtdev;
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> index 12896f646..cb574c948 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> @@ -187,6 +187,7 @@ struct rt_tcp_dispatched_packet_send_cmd {
>   */
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Real-time capable TCP implementation");
>  
>  static struct {
>  	struct rtdm_dev_context dummy;
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 5018ba807..736ba1921 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -86,6 +86,7 @@ static struct hlist_head port_hash[RT_UDP_SOCKETS * 2];
>  #define port_hash_mask (RT_UDP_SOCKETS * 2 - 1)
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Real-time capable UDP implementation");
>  
>  module_param(auto_port_start, uint, 0444);
>  module_param(auto_port_mask, uint, 0444);
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
