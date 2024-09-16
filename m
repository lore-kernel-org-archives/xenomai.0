Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E128F7
	for <xenomai@lists.linux.dev>; Mon, 16 Sep 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479071; cv=fail; b=ZESlIxA4E3VWWYE1VTTjW+O/CBDczcz6X+2k5zTWcPBWYXJe7r8kiV1HMutsGNPA9UUS1jHUxqMN+4KST6ozsmfm2LCG8Mb6WWxbzAjOAEshD92k15JDpOPuyzHR9gg2FtBclI8qN4IeKDjKKzbnVvtAkvNQ0FU9+4T8Qarizro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479071; c=relaxed/simple;
	bh=Z3r/xv6+7B2qYJfTX3l/Uw9TujJnKXylUuSqGCMTid8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3QseGXC0fDUtJZqGvc/iewobJZSwGU69U0WxF6oh7MfdsNvBK36lkRRRnrr35z1TGb4bOpIU43PgO3UieKbN0FcFEXFNW71wSEPtFRafnFkjC2jtHLuU6gFSNsJ3IFvaCIPxR55Io5eIbGzn0RITc79s44cgkOSisNV3O829k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AFrexJZx; arc=fail smtp.client-ip=40.107.104.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AFrexJZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQyalI6XFoj9DQOQ/ZGnULJwAWtDRL/F5bJVD/ODDzAvHD7qDtLkMlr9caRR+ETyRe3G397M/0Uw8pSYn+wxzcG3cOUm0+cGDvFphlPCQROZVUae5050yqyr3t6vZUM3/TYAKJOpg8T0Ztswnq1RldBXS6OWC4ZCmsIHtlpufBp3ArnRUHOLOPIQvkKHn4idkGWAOet1fKsvLrDvr8wZH9fJxR1R36PM/lXnIh4xB/xqY5+23slwcUrvjVibRqvbZpkzK8VNE2X3OqdVf25L9w8GNffn17LFkqV5/VnsjdRDdxu/FKtoi5hKhQQdQlsuiVrHc6kAtCCHR0AGkPyWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgGOIa7wnfE7RSyWSiATELmjKQAtjw0TfqJcRjUM+bU=;
 b=eS3J80w6pH0ttXu5W4B5OiGQ9gra21eaw3tDl0h989mlcWKePCKHZoaOmJQaJAWgsy59j++RB4kMPO5Yv/I/enYpriUCmtjo86BaQ+0ucyL2m2S9JbfJaB6dNWZxRziARAQzvnapo/WbKthlPKq/C180z5pzPCUAUGHFNb4pAQGxHYz448uMFRTL6iiYbkftsTSek6b2avzZ94PNfkixnXB66FE/rfgJwCySP/CHz1OJzK/yz5SyYWRc+OQpe3UN4IBKAOVH4CPrk81AgjA52+V50PSXuQOik97orwUWzG6lPxJ7RyzV81RhrdzEWKMQN0EgozDPmrv8ioOkeui/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgGOIa7wnfE7RSyWSiATELmjKQAtjw0TfqJcRjUM+bU=;
 b=AFrexJZxtLFuQb6GA8y8DY+vUrrvyOFpfnPn4F2TXQVBQLeZXBxttBib3CZ94q9TzJMpNqfSuc5xxPxdW3y7YZnW0T56z58geF9on26J5dF5rkvSCDKO/ghXBu/5hD3rqCVkTEA1/yKA0tWqkXKWktOHmGYjLr9JO8XA6fzPug2GLNJTW/lWAP2Gz+xRaRlFX/ntEzdzEVP6sg7TxoHjLxRmlMbvVmI1hfvryPmXokReQwwEeepk9MhFaQkyHwSl/s/pCtoKImXZwTfZ3HorZtu8GhQJg+gL30fCgRpcKPFtXGjecpky0FSzfsP/Ga6dTQckN41osJ7VaPurEq1zTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Mon, 16 Sep
 2024 09:31:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:31:01 +0000
Message-ID: <33f73941-9739-45e5-8064-d4fcd40ed18e@siemens.com>
Date: Mon, 16 Sep 2024 11:30:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] smokey: fix build failure
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 xenomai@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com
References: <20240914131026.1035993-1-dario.binacchi@amarulasolutions.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240914131026.1035993-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0213.eurprd07.prod.outlook.com
 (2603:10a6:802:58::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3289:EE_
X-MS-Office365-Filtering-Correlation-Id: 168858e8-512a-446f-f8c6-08dcd6324756
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWVxZms3Mjl0UjhROHM5QUVNU2FwT25CZ0pTejM1c25iYVBaN2hhS29LZGRx?=
 =?utf-8?B?Z0hubjN3d1JmRTV2Y1pEZkt6NzRKbS9XQjNUVGYvd2JMRzR0eFVndFVkWk5z?=
 =?utf-8?B?SHN1SDFnRmovRWltc3psVVNlZEtaQnR2Z1FzZ2FCOXJzdDYzenlHT3dybkY0?=
 =?utf-8?B?MTgzMS83aG8xTUh2WURRTHd0Sk9TZkZCRTRNWXZEcnJhRW1ISmIwNU9IZGl0?=
 =?utf-8?B?QlRMN0JURVh5Q2FSVjIxSSt2aTcwREVzMEd6cC9xSFVuUEltNFE1eTh4U0hI?=
 =?utf-8?B?cjRhb2JsK25VTkVxUDFRd1hhRW1UUzRlUUdOZVU2bkRGN1hXUFI0dlQ5ZHRa?=
 =?utf-8?B?MkNtZFZKMGVNWU9lUkVibVU2cUNua3J2MzlzZVV6cEVtOEVhaVo1OXhkK2c1?=
 =?utf-8?B?eFRKZGhHOStyUU9VZ1JvSGtiNEZsZVhjOC85bGNDOW9lQklxU1laNnZ3VTl2?=
 =?utf-8?B?Rk9FVW9FUHg3UVRobTRkL1dQNmI3ZW53bmpXVnh0S01HVkdmRERuNjJyWHh1?=
 =?utf-8?B?UFRuTytGemM2TmJ1dkltazI1d3FWQzhGQ3UrVFMvYWNUc1F4a2tLdkN4ZnJy?=
 =?utf-8?B?cm5JTDdMOEU5L0gzWEtwdm8xakp4alUrTFVxdmRDbHZ3ekZmWFR2ejNVRzQ2?=
 =?utf-8?B?RmFZM3RXZXIyU3JNcllHWlNCZkNJNW56WUZKU1QxMTFIWEd4NnlnT21lcmhU?=
 =?utf-8?B?aCtQWkhBanZLWksyWEZMTk0vblY5WWplbmlvYU9GYm5TMk16TkpSUzN6N2Zj?=
 =?utf-8?B?azBLTlIvZGIxdS9UbWRBSDFncnd1VlNzK0lCR3dNS1FjN3hrbHArM0dONUQr?=
 =?utf-8?B?Y3krVTBRV2llUUQxVFIzMUdHc0JpVWQwK1JsNFhCdEVMejV6S0xiZi9RQlBW?=
 =?utf-8?B?c1NTL2EvOHVDc3liVXVWN0RvcGZhcENFY1hMcW9xQ05LdXgwM0xVcDFQYS9q?=
 =?utf-8?B?K0NsSSt6VG5hQVUzYkFsNHQvZWRHZzR0OWFkZTZMN2pCa2JHOTlIZFFaV0VC?=
 =?utf-8?B?VVZ2OFZxN3Y3cFFHUHROOTNNOVgxSEVWWFJhcUYySURweXVwNWs2RnpSWlZv?=
 =?utf-8?B?N1g0RU16djZmY0VySVM3MDJ0TkZSTHVMMVZlLzBIVlRjUWFhV29sZmNaWXJ6?=
 =?utf-8?B?NzYzZGpHaW14ajlYWWVrV1JxU2t3T3FvOS9rSUlNZGIrSU1pak5xT3U4VnJV?=
 =?utf-8?B?b3M5Sm5Ud29LVHY3eld4TFBhcndURm8vYlBIa3dFdTNhWjc1YkpsZGVpRVFw?=
 =?utf-8?B?Vzl2aE82SVZwNC9BajBsM0JreTFiVXpMOURLWkpSdGNrMWlyRVAzK2FmU0lS?=
 =?utf-8?B?NXFiUFNOL0g5UUQ3Snl1SlRCbnkrN3NVM043YWk4cnprZ255MFNVU3ZxbXVu?=
 =?utf-8?B?OVZkZWgwZENoUEZQMldPQ1JkTGI2alFObVI4YmpJeVh6ZVoxTVhyRXl2VWZI?=
 =?utf-8?B?czZQWVVmTWxLL0dxUE1JVGs1cUd5b1FkeVhYUnlYRkRtT0VTb1g1bWdVNjVu?=
 =?utf-8?B?WnJkMHlIaURQOVlSbkxocmUwYVJidzIwOE5rYjN2M3JWRlMwMnJLeXhNb3FG?=
 =?utf-8?B?cFVxV0JiUkhHYmRxV2JMdGIzd2lnZDVaY1VGYm9KNFRBTkhRNUZvZTlVb0NN?=
 =?utf-8?B?V01kQlR1THV0Z3N2QU9hL0NZbVhlSkU1dzhmdlgwd1FieHpoV3hpZ3FmMVht?=
 =?utf-8?B?dmpoNXMxRm5reW1CdWk2cXFpMk0rNjJlMmpJYnNQb2lqWXVzQ3V1eXc1eTlS?=
 =?utf-8?B?VmFTdTEzNkJ0cmlpWkdMQ0s4M2w5K1AxWG1WM0lRYWUxcW5NY09ISXl4Vktn?=
 =?utf-8?B?QmxGMWk4empVak9sRU5QUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXVLVEhhTENkKzVDUHZtOGxjaHBla1loSmRJQThEcDFselI0bFF1V3RlZ1ND?=
 =?utf-8?B?RzZtQmZpTEVidXhiTkE3WlJyMVkyWVZvUWtkam1qNzk1cHcxYjZNZ2lUbFZB?=
 =?utf-8?B?aGpPSHhNcnE4T21GbmRvMWFheDZLUFU4ejVnV2lqcVhjNjFZWW9idVBPTzdu?=
 =?utf-8?B?WTVNZ3lYR1pabERhTnhwQ3Rnb1FDUDVrKzF4ZzJocko2aUhDbnJLSHloU01H?=
 =?utf-8?B?STZ4azExcXZ5LzZpaDNyRGR2SkJHR1BBU2twZTU2S1ZKa1BBUzkwN3YzeHZG?=
 =?utf-8?B?eHlQOGRvMEsrSXVCdWFEdUdXYkptbEtSSWNpMUY3MjdRTTNicGVOcXQranow?=
 =?utf-8?B?NWl2SkY3dGpPUVRvclZLVXl0amhZTHBMbU1WTUNVVHNIK2RXOUdYa0RCVWUw?=
 =?utf-8?B?Rkk1RkhEOE1ET0tZaFRySGhFM0NDODdRcGJHMmFYQy82R3JNMDYwdGU0bjBV?=
 =?utf-8?B?VzBGUC9wS0lnN3R6U0FNVU8xR2pwTC9qc2RpQnUvQUplWmcrQWJSOFllVWl1?=
 =?utf-8?B?VWlLYzRKWEptMnQzZ0dPL3NIaElrdXhMQXA3S0hFUFZxRmhiOW5rYmhLRlZv?=
 =?utf-8?B?VU1GVVFHYzZva3JJMjJoYjRQTjdsUnFwOXlzbkdFUU5NVm9YL290SmhJTmx6?=
 =?utf-8?B?b3o4Um9hUENEZXgxS0hkWnlYVEdiOWRMaWJSWUFVUHNtWGRDTy9wYTV0STJz?=
 =?utf-8?B?MUdKc2EvWm5FUkl4eUFmbDdlZVg1dlZ1QURndSsvNHV1dzhFemZpVjZXYlNm?=
 =?utf-8?B?UVRTaGJNQ2t3eVBHSnlqd0hUejZzZzV0dzZqZ0JIeHZLRVQ3RGdaQzExR3ZR?=
 =?utf-8?B?NklDcWhoa0paRS9wL3UwdUx6cnQ3S05oSFBIaEFXMnh3OFlpZmNJb1crQ2wz?=
 =?utf-8?B?d2p2Yk5mUE9vS2M4S2xWOEJSU29URXVkQTRRekE0S1BBclJPZmxDaWUraWhG?=
 =?utf-8?B?blNMbHhUZkM1MlZhbzR3N21YQnE4SzBROFFYUk5vYzZVb3VKTjRzTEI2Zzkz?=
 =?utf-8?B?QVFtMHkyZkZwdTV2WUUwTFh2bGdlajZrbnJpYWJ0enNKa084WGhVbHJkWFpv?=
 =?utf-8?B?QTFwbm5CVzlhcUdtdjNWZzUvUjRIQVAxU3hMOUt2OUljVUwxU2NHWUJNQ290?=
 =?utf-8?B?Z0J2NFA2UmlYTGpjK3psZ29vTmgvUUtDQ1ZlR2k2SkxORElvbGVzcGQrNDFn?=
 =?utf-8?B?NlV2Nm0vaUZuTXlFVDQrTHNncEFlMU4rS3g4TTZKL011QjB0ZEErNlp6S1Rz?=
 =?utf-8?B?VXFMZ0Y0aVJzSE1zd25hYjRJbXhxWlVQVmVObStuQnFhODRQTWE0Vk42RUlk?=
 =?utf-8?B?RUdRTVRGaXlQdlNwZEt4T3dOYTk2eUl6bjIxZ1ozc05kODU4NmtwNXBSayty?=
 =?utf-8?B?TENYWm04UnE0ay8xV2RiYVhneURUNFFGb3Jjc0o1a3QwT3AwSGxkL1lPTVlh?=
 =?utf-8?B?SXhJSit1TjlNZlMrUS9jRElZL0I1U1ZGZENxQ2tib2Y4QTdaYkFTbUVGVHU3?=
 =?utf-8?B?TWJRTHhXUzJUN003d1RXNnRUQVMrVjFQVVB5dldhR0hlWUx6MDdpMGp0Nlp2?=
 =?utf-8?B?R2dpWnZVc28yVlVUQy94TTdZZkxMZmVLZmNNZEJuRGVXOVJvMFFWa0xIdnRC?=
 =?utf-8?B?VmZIU3VzaFZMNXZubllCclZFTi9KTGVoQkl2Y3FsaGtWNVVMZ1NLV0k3ODRR?=
 =?utf-8?B?cXFmMHR5OEZ2aTF2NkxNS3NLTUdtbGtNSkViZTJybzZWUFFwd2lvbHNpeUM3?=
 =?utf-8?B?c2gyekt2QVMzNURIVmhYU0RvMFJaajZ3S3A5RWRUUFMzenNYc1I3R0pWdTVr?=
 =?utf-8?B?ZEZZcnZtZXFYcmxlNDNubmdRV2U0UC9pbnJWQjZnT0RydTR6TEFDeUZnby9Z?=
 =?utf-8?B?WGJCTEdmb1BJRE1ackcwMWx4ZlcxcnpJd2h5UGhoTVdsYWZ0dEFQdnlRTzNi?=
 =?utf-8?B?aklVUlExQVlsdmlXanQ0Ym9OTXp0Vmo3aG8xOUMxaFlZeGJtOGJjNlNuSHdq?=
 =?utf-8?B?WE9BQlJnZ2czSlJMZm0yTlpnbWlMV0NVV0ZuUFZIajNxMTg0c3ZSVTJ4WURB?=
 =?utf-8?B?cy9yZWZVcFNlbVpJT3hSL3c5OEsyOXAvQnNXdSsrZUJ3eUt0RmtMTEthSUN4?=
 =?utf-8?B?U3Q4dCtabEhNNjgydTVLVHl4eGhpb0Q4SXZNOEg1RTJudUhPUDlqY1FOSitF?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168858e8-512a-446f-f8c6-08dcd6324756
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:31:01.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/NYt6w2GZE+NUE8d/8KRqzNMse9ALCKYgJmnjM5SiLs97WpEjJ3wsLJEoiq4Fx0baaMX146pZpFvoyNNR0yXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3289

On 14.09.24 15:10, Dario Binacchi wrote:
> This patch fixes the following building failure raised on bumping Xenomai
> to version 3.2.5 in Buildroot:
> 
> In file included from helpers.c:29:
> ../../include/smokey/smokey.h:258:39: error: unknown type name ‘bool’
>   258 | int smokey_modprobe(const char *name, bool silent);
>       |                                       ^~~~
> ../../include/smokey/smokey.h:27:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
>    26 | #include <xenomai/init.h>
>   +++ |+#include <stdbool.h>
>    27 |
> In file included from init.c:33:
> ../../include/smokey/smokey.h:258:39: error: unknown type name ‘bool’
>   258 | int smokey_modprobe(const char *name, bool silent);
>       |                                       ^~~~
> ../../include/smokey/smokey.h:26:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
>    25 | #include <copperplate/clockobj.h>
>   +++ |+#include <stdbool.h>
>    26 | #include <xenomai/init.h>
> helpers.c:299:39: error: unknown type name ‘bool’
>   299 | int smokey_modprobe(const char *name, bool silent)
>       |                                       ^~~~
> helpers.c:30:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
>    29 | #include <smokey/smokey.h>
>   +++ |+#include <stdbool.h>
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>  include/smokey/smokey.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> index cf9701966db8..45dd0dcd017b 100644
> --- a/include/smokey/smokey.h
> +++ b/include/smokey/smokey.h
> @@ -19,6 +19,7 @@
>  #define _XENOMAI_SMOKEY_SMOKEY_H
>  
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <pthread.h>
>  #include <boilerplate/list.h>
>  #include <boilerplate/libc.h>

Thanks, applied to next, will go into stable-3.2.y later.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

