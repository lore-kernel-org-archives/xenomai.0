Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17637445AD1
	for <xenomai@lists.linux.dev>; Fri, 14 Aug 2026 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703180; cv=fail; b=Vs6yPuu7kiSvOUhCITgI8udCd4NGfSzkr/fGjUUY4C98riF9tv2Y7XDfkT4k2Gwvp32CcZwktE3ns7ouYdb6GqUT7uMlxJk0fq8LZJVDepNb527mm8KojfGXzDyBVKeNBnL8yeCZGbC9PR3i7YzpeBc5ZiEW4ckYuqrt5ubRqbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703180; c=relaxed/simple;
	bh=t/uyIBQ7QglkZZyNfsnmWH/Vr3B0X7jgjm8Q96GWb0Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bjg3yxotrRh2I2hSETRLUUQmeHl5xii5Dw6K0nOBgMpXJ2moHD47woylfWHNFl0xQmvzMAVevbxo6Y4ltQ0M7B44SPeg/U9sIqiwqcRxArBTydjalfOS+3VjhsrciLcHLCNohA38Gt0lydMY/iNtb5qkubbP5wwOHAKcfDAdnjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Wq6Ddsg4; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Wq6Ddsg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8ZOSJfyakg9vxfFoWxiSxTXEwltfHusyoy4pnPYjunzU6v6YXg5KvhaTuEdiiJcIy3x44+fq37c9R0k+XkPvf865J7TqNZxfPpfiZlyk/+KcGx33EizGq0uzpKc9kuWPPU4ehjVVwujYaUNi0MSuyiIATARkGCkqzKQLks0A7SWVOPpmCXrsyiYe4amDT2VeZ3eAMQIPU49WM/1cC/XzQXpX5KAV1CNiqWldeeXZFZ7xMFnCqNqumyxUMsDlyfP5TDF+R3YI2kKDHI4PlNmITzJs/mAlHSVMP/YZmu5BYTRY8Vft1J5We+vceG1sEUnfsrf9ZveJ8a/7TaqsdTEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C0hb6i20g38CARAQ724qjM74YbuWA86OBcD2WiIsGU=;
 b=Azwwmz/KfzkZBBcV6JreaDNvncB4kewWQ93KG95okAJy4yrcl1Ss/5bMvRX8Cj66x1ygimJrowFNStnpttMl6n1rZfchGjzyx2S+tjRdqcHgzpsUpl+wXyybGcOlJbyr5ZXSXsDUBR+Rqm1+fB5Z6jhjhlmRTnP3xdpzmp6MG4NN/znqDKEkHiE/X7T03ojfkjFMuUAIcqiI+4I/PucbwHmAFuVSew1ho/aSUBtE9LILohWqyHcz7L7gtbvUdCO5db7SmFk4+ZSaRE+89H68S9R6uoxOUrbXM2REXgTkboq6NhLfLh4NNkXWX2dbnHN2UYVu4C7yFvqNSVz741P2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C0hb6i20g38CARAQ724qjM74YbuWA86OBcD2WiIsGU=;
 b=Wq6Ddsg4SBQ7Wvj6Ci/fbzmDDeGWC6+VM8C74AIKx43C2CZp6jOUNl1HPCDl8/S5DiApB8bKbRvfHIxQsCfCrod0qsgWa3mGNQCe5LCmfSpXlZHXIGoDOWimhr5oqKTkCPJn6mCobzwWVlCKA4/SXEzNpImiESp3zILWSgnTRcF1Aq0xAZxyth+yqma5sxKwNRSh3L3RFdFQEQzmX4CLU+EG6qyO5LGJGCnzsSGM8fli+eBmxYIfUO58gk9TxB/4v9bDfyDhXaEIVMapP07sU9d3hh6kZVcnpPUKBLFyv6Qj/NwCOapstkfmA6gDrrLjyKgBzmqnRCK4/QTPcrfc2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3826.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 10:26:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 10:26:03 +0000
Message-ID: <b4798eab-0466-4a16-a7c7-a898dfeca125@siemens.com>
Date: Fri, 14 Aug 2026 12:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] debian: Replace SysV init script with native systemd
 unit
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260731085316.4122942-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260731085316.4122942-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0427.namprd03.prod.outlook.com
 (2603:10b6:408:113::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b445321-0838-4c84-e6ab-08def9ee7140
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|3023799007|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	IZSOzJftY2SuZGIwjExeP7vNbnlhKpVPjU8nexEQjmqWxkeCbPin/1bEHQBkZYaQW5qv82aho248zg5Ke1647dfpSoZljDXEOSF1zhVpW1xPymZQD5YSiNwAp4flSeM5eyqz+gRU7449IH2dbPlgxEw6eKaeuVGQSK2wwuy+DX/GnFzsBWFMPCTDByaXpWEDKdwqDulOqLhN8ZbnlDuZoUOA3rN5WTyOC4FBXsmcXP7yuxrvU2aRTdCqMoTew7oIKPOCIR3zu0f1Fs0U74kojc6Pwh+hyhXQlImkIfIs0Z1nUk+hwTtK3TeDDVkLgb+ZjIZwkdAZVBjYXsd5Az7pSE7YP5z3yWhWWSV7buNfgQulcSDgHkaKPdSZy1I+16tnuQrAVzJJfW5DkZTlY3za68r+yZOB/tsHUgqHB7LHWdJSW6JV7IOqZPKjZaoeRWtdXD3PFNx2mtPVNrZyIG+0vk5FEHOkG3+ow7F7V4j+pc6CiS+6oBjJFKlH0Bv3ODx3q3qAAgas2PE5d+0yJ24LEF7fxDBCMskCpLKETo4NPKBGxQsGgAHW0cRgiFHwJUFyA80bN96ajkid+jiiqpR7aMPrSiIaoYwJB6tc92LXCeJJQ10lQ7/5RSPQXw49+NxwUwRBL7puyr6WOBPs2qYVBL85XeSiR2UnGyHFHiPTQRY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STIrWUdlelNiU28zak5GbWhKbm44bTRUcHU1QU1OQU9CTHBpZkhNblNCbVhh?=
 =?utf-8?B?U3Qxa0VKMzdvbmFFbVVzVnZKVy9ZcktxNG03WnQzR25lYUgyVDZ2TVQ2bG5z?=
 =?utf-8?B?YXFlaUc5VlBDUzlpYi8ydnVDNVl3K0tvanJwSXhHMHJaN0dXdUpVZHM3Wjd4?=
 =?utf-8?B?bEx1TjcrRkhRQm5GYk42TjJMTnNiSm9JL2pvODlFOHNuVCs1Wnp3ZXM2dVd4?=
 =?utf-8?B?bEtmUTZVbndSMnNYelVxRkpvdEtwNEt3WWhJZkFqbXJMYVNKRHFzV0JLMkg2?=
 =?utf-8?B?MjkyRE85RmRQcUV4SHRzM2o4eEVlaWtmZUY5MGtKeHkwUWh6WU94a3dtTlQz?=
 =?utf-8?B?UzJDVWJDYlFaU0JKcmEvV1pYSnAzYnc0T3JHT3NiQWFtY1ZPMm5icGZPaWlV?=
 =?utf-8?B?akFMOFpQUnhSWE1tUy9oMjBMOFlDYXhyemdsRmFVazBsV1BEWVMrQUhNZys2?=
 =?utf-8?B?OXRZcnc5OUF5c0wrOStXTkNNeGx0d3VPT0NQRkFPVm1PcnNveWJtNUo2Ulpt?=
 =?utf-8?B?cmYrcFBFNGkrbUFJZ0JwWDllTG5XZURPcFFycjQzRUIzRXdDZTFpRmpodkt6?=
 =?utf-8?B?dnZSSmpMWWFJajZ0OHJLcGZRRnloWkIxOE1lajhOd0I2T2VrZlY3eDJoN01X?=
 =?utf-8?B?UjRxYkV1bGtTRG1UTFJ3SnNlVFZ1OGhuTU9pZjhpMWE5YjJ5YTV3cGtvd0RF?=
 =?utf-8?B?Y3RNTVp5Y0ZWaXZrMm9hMjZEeWR0VjJ1MXo4Z1JtMHFUbGIvWmtBUTJRMytl?=
 =?utf-8?B?b2swYW5VUEtEMDh4ZmhVL3Fla2lxU3k3QkJSRXZ1ajVidW5NNDVhcmFGd3dC?=
 =?utf-8?B?MFVjNTlHMEtaeFZ3WnlycWtwZ3NVaklvalR5aWdtcWV2RjFQamhtRERkVDhz?=
 =?utf-8?B?Rklndzl1M09sN1ZyWTFNa3QvRytwQnZZb0hCcHJBM0g0V2s3L0wyK1puaXhz?=
 =?utf-8?B?WWhZdDRzUTcxQ3dsVDhuKzdiMWhlK2tMaVNMQmdBZDhPaGxIcGIyVmRxRTJH?=
 =?utf-8?B?djNVMFlFM2hkTVNka00xS2JKaGthTlIwMlB4WW0zSFNMVTl4U0pQNldyZS90?=
 =?utf-8?B?VE9KcGVmUG16SU1TMmZOYWZhNXRJUk5LYjdnRlZwUkpQdDh0R0dET1E3MExp?=
 =?utf-8?B?aThMRkNQQldEWm1OVG5RanpIanNpdnh5Zk0vZjh2WEZpSnBaN2dmR0xSS0x4?=
 =?utf-8?B?MytvWUQ3NmNqZ3dqeVFSOThyZndjV3dXTHBvaDd5b1FTamtmT0dJWitsbFJI?=
 =?utf-8?B?QXY4QTU2dVdFN2lLcUgwOE9wejVKejZMZ2w3ZFhCZkszSDdtWFE2RFFJSE0x?=
 =?utf-8?B?d1J3VVprZXU2VktZK1ZmVE80Q1V6QXFlem8zeEM0Y1AzMmRJckdtRW9VcG5T?=
 =?utf-8?B?ZGc2dWZsSGczZGFzQk1WYWJNMndBeVZ4SmM4bWJ3b2dVZzhkcEVvcytkUHpw?=
 =?utf-8?B?S2l4d1FzYWhTblBoOU9jYkh5SFNpTXdrZkVnWXZnZlM0OW11dXRSb20wTzY5?=
 =?utf-8?B?WVJPUmV5cmdVY0p5bzlmVHlMRXRKUEFJc3c2VG1UKzYvTWdtZS9hQnFvQ1I1?=
 =?utf-8?B?ZEI4Mk1sU2JSNHcwZ0lGWlYvWWI3YmU2TlM3NUY1N1VKeXgwWXJwM3d1R1I2?=
 =?utf-8?B?U0xnOWxNR0RqZE1sN3FOY2VuWkkxbTFMNmMzVkw0b2RlTTA5NXdDc2hMd3dF?=
 =?utf-8?B?WThoM1Evb09udHUzK3JGbFVRbStVYWZhbzVUQ3g1aTNjdWVKdmlla09Wa3k1?=
 =?utf-8?B?VDhGY2N1ektIT0xZbVhNb29rWVpEaWpOUDVoVFk5d3NhMFBKRXRsc2Y3ODlG?=
 =?utf-8?B?bU5FZjdwNGh5NCtRbXdHUG5TMFNsaVVUTjg3THNJcWlGOUpmbnpoSEhheUM5?=
 =?utf-8?B?MUFSdFBBQWZrMEdad2NUR21VcGxlU3AxaEpBaTZBMkVZOTJWckc5SXR2a0Fm?=
 =?utf-8?B?US9vak1LNGFtdVVNcWtrSDdxY3kxdVZvZ1p5MFBiSm1xZHVOMktiaE44dkpJ?=
 =?utf-8?B?OEFCQ05DeWt4WFBCMnJiSnRXdktFQ2d3MFlOaUdpQlVUNDRRMGdzYVhRY1E0?=
 =?utf-8?B?bEc0bEpzT2ROeTl1STNqM214STRzMldlRlJKRHc0WU5IOU9mc0N0U1owdDRz?=
 =?utf-8?B?YTNrSjVLNlRuL0dGWjZnTTh2TDRDc3hxajRpcmRVbTljVHBsTWh4YnMxaTd2?=
 =?utf-8?B?NVJnbTA1SE9qb1RyQlpQOVA1UlRNN1QrOFFpMjIwdUpvQTdlQXJkbjdmYm9V?=
 =?utf-8?B?anAvb3BwUTY0bXQyY05VRkRXV1IxWjRDVDNscy9icnpoWjdkdXpLVHozZ2hm?=
 =?utf-8?B?UlFRNzhjSng2eDdDZnlyeElHeUNuVDQ4NGZTek91NGJPeHVZWTZ3bzJqVmVx?=
 =?utf-8?Q?1IVMy8BLHHTTH28M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b445321-0838-4c84-e6ab-08def9ee7140
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:26:03.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHM4Sy/drP9gsUkw2c46ZfnX6ZJPgINA+A+6aBrP/VNBWMESDGRyiQKN1+NBZmvGMVjKNDNq4jNACKNm45PB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3826

On 31.07.26 10:53, Clara Kowalsky wrote:
> Debian trixie warns when relying on the generated compatibility unit for
> /etc/init.d/xenomai.
> 
> This addresses
> 
> systemd-sysv-generator[1423]: SysV service '/etc/init.d/xenomai' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> systemd-sysv-generator[1423]: Please update package to include a native systemd unit file.
> systemd-sysv-generator[1423]: ⚠ This compatibility logic is deprecated, expect removal soon. ⚠
> 
> The systemd unit uses the script /usr/lib/xenomai/xenomai-group for GID
> handling.
> See #54.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  debian/libxenomai1.xenomai-group   | 26 +++++++++++++++++++++
>  debian/libxenomai1.xenomai.init    | 36 ------------------------------
>  debian/libxenomai1.xenomai.service | 12 ++++++++++
>  debian/rules                       |  3 ++-
>  4 files changed, 40 insertions(+), 37 deletions(-)
>  create mode 100644 debian/libxenomai1.xenomai-group
>  delete mode 100644 debian/libxenomai1.xenomai.init
>  create mode 100644 debian/libxenomai1.xenomai.service
> 
> diff --git a/debian/libxenomai1.xenomai-group b/debian/libxenomai1.xenomai-group
> new file mode 100644
> index 000000000..ecb99ff20
> --- /dev/null
> +++ b/debian/libxenomai1.xenomai-group
> @@ -0,0 +1,26 @@
> +#!/bin/sh -e
> +
> +GROUP=xenomai
> +FILENAME=/sys/module/xenomai/parameters/allowed_group
> +GID=$(getent group "$GROUP" | cut -d: -f3)
> +
> +test -e "$FILENAME" || exit 0
> +test -n "$GID" || exit 0
> +
> +case "$1" in
> +  start)
> +        echo "$GID" > "$FILENAME"
> +        ;;
> +  stop)
> +        echo "-1" > "$FILENAME"
> +        ;;
> +  restart|force-reload)
> +        "$0" start
> +        ;;
> +  *)
> +        echo "Usage: $0 {start|stop|restart|force-reload}" >&2
> +        exit 1
> +        ;;
> +esac
> +
> +exit 0
> diff --git a/debian/libxenomai1.xenomai.init b/debian/libxenomai1.xenomai.init
> deleted file mode 100644
> index 811fe25fd..000000000
> --- a/debian/libxenomai1.xenomai.init
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh -e
> -### BEGIN INIT INFO
> -# Provides:          xenomai
> -# Required-Start:    mountkernfs
> -# Required-Stop:
> -# Default-Start:     2 3 4 5
> -# Default-Stop:      0 1 6
> -# Short-Description: Set Xenomai group
> -### END INIT INFO
> -
> -GROUP=xenomai
> -INITNAME=/etc/init.d/xenomai
> -FILENAME=/sys/module/xenomai/parameters/allowed_group
> -GID=$(getent group $GROUP | cut -d: -f3)
> -
> -test -e $FILENAME || exit 0
> -test -n "$GID" || exit 0
> -
> -case "$1" in
> -  start)
> -        echo "$GID" > $FILENAME
> -        ;;
> -  stop)
> -        echo "-1" > $FILENAME
> -        ;;
> -  restart|force-reload)
> -        $0 start
> -        ;;
> -  *)
> -        echo "Usage: $INITNAME {start|stop|restart|force-reload}"
> -        exit 1
> -        ;;
> -esac
> -
> -exit 0
> -
> diff --git a/debian/libxenomai1.xenomai.service b/debian/libxenomai1.xenomai.service
> new file mode 100644
> index 000000000..50ca3bcc1
> --- /dev/null
> +++ b/debian/libxenomai1.xenomai.service
> @@ -0,0 +1,12 @@
> +[Unit]
> +Description=Set Xenomai group
> +After=systemd-modules-load.service
> +
> +[Service]
> +Type=oneshot
> +RemainAfterExit=yes
> +ExecStart=/usr/lib/xenomai/xenomai-group start
> +ExecStop=/usr/lib/xenomai/xenomai-group stop
> +
> +[Install]
> +WantedBy=multi-user.target
> diff --git a/debian/rules b/debian/rules
> index 9e56de260..0ef5557fa 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -75,6 +75,7 @@ install: build
>  	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
>  	done
>  	install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf
> +	install -D -m 755 debian/libxenomai1.xenomai-group $(CURDIR)/debian/libxenomai1/usr/lib/xenomai/xenomai-group
>  	# remove empty directory
>  	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
>  	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
> @@ -103,7 +104,7 @@ binary-indep: build install
>  binary-arch: build install
>  	dh_testdir -a
>  	dh_testroot -a
> -	dh_installinit -a --name=xenomai
> +	dh_installsystemd -a --name=xenomai
>  	dh_installman -a
>  	dh_installdocs -a -A README
>  	dh_link -a

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
