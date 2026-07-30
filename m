Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31620369985
	for <xenomai@lists.linux.dev>; Thu, 30 Jul 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432085; cv=fail; b=KyOdKIYxjzXyNNR1QlxmeMLzZxBEUiXvF069uTaSw8XUcdJZymGnjH5d2sdt8LTGTNX0rEw8AikF9P9AzunwU28nXk1bIDxlXDMcvuuKmyf0D+EwYah7VN+VTbGQY3t6UcX4c6e0CH6++FRdJi1AhxRqGmA6bFXh3zJc2uLW3M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432085; c=relaxed/simple;
	bh=9bjc+GAKzG32eUHAn0mZlhEDn1Lo7jDctyf8+bUwaP0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gERT9wVdamlZWBn31r3ujUzX+LzPvPsRSnJgftprQfaKK0VJfCg2wPjtCI/rgw4cRg3vn3D0BObsc82zRChpt/6AaZT9sW0lOhA1K4at5Z58XtJZ18InVhOXY95E6cYILv7TQhM8BKqFbBoDicsx7pZPZeQGSX9aOL36JvIr4hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KAHldLgL; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KAHldLgL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ4LVNRGaiYpT70q/COJOrFgZwVTwgjmF/uEMWEaQDdQgq3VS9f8PL8fsVN9P/taWvISYvmjXU5OZVcv2kE4Vu1yx7EtS+BIjiLoSU80VHbQrqe+8eeF+SJ6wWEEodh39wopilqJO/Fc9IHFEyOPAJdTLds+H9lwGCPsTF/IXRSPkYEBbi1Tc5OZtjqHwFBDMtf8zdx0FtpVqbAVtZVb8q7HOL3s8ORTvWADUyiDHQSea6ACJAEB4vBNmeSsff9go6qhADT3oB+IDYrSY1Ls0Xc30RABzcBWo9WqBJfoyUMAHatDxarn9tEvitYVXYavaoEetF7x4onrjzTcceThLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH2OwQ0lCymcWVdWrH+L0WAGGZ15yzVKaAdkkXRH4eo=;
 b=FKL7rltJ/xlCFPn2KIsMSNDXSap2a3FW2CLJ4dwJX0YZwwvcw+qakZjazMDkRHDex2w3+QoBdmnY1FkjLdergzjiPUJ+eUtk8kpVetLfAaiTILXJ6//ceIi30XHe8ZOOruiFPGvY7juKFKbnKQaWywzAISkTM/TxZbqerTPrhWWAKRrnwecqJ0wx/GNa+QWwBk+GtfxA/GDVT/3NulEYzUSghcJHDT9PVYZ3POulZ9YOVs1YEovu3eKYzExLaSSbkUrMFSeNr58dYTp0PZg2oc7VNv/zK0aeRJS2evDmRxe0k+ZFiOvNIaeH8ao/TfEtcsxCC6i02X7/lHjOru74qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH2OwQ0lCymcWVdWrH+L0WAGGZ15yzVKaAdkkXRH4eo=;
 b=KAHldLgLBroezjxXoPg4T8e/rm1Ts2Ou4NElEaDVeZjWBXbB664NJTxpbg0OcJEPzYlP6hVm+O80W6onRaC/wGBw+QWR6uylPnLtqO1vcWqAYT4RpdQ/28QGIDxOj1tQqujTj7zF29SyJTliGbMX9GRqtaENYNPEOwzdhmJHLZjuG/YlIgPHfVWE3/an3jYg/BT59vHF/xqtP1cILvOz8Y3wvq0oTPUcQhC4XsyB+8xpVG0uFnE6CCrSW95OlYyGNSfUrRPFJqOWxBpZEJOeUaRWi8tis75IiFLQGUWnOW1A8uaC+ax612DfUPqiU68Ok3usYhokPJl4+ys3zLwMNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 17:21:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 17:21:18 +0000
Message-ID: <3e5c078d-7e83-4589-901d-cb216721b83e@siemens.com>
Date: Thu, 30 Jul 2026 19:21:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debian: Replace SysV init script with native systemd unit
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260730154748.2343236-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260730154748.2343236-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f20ff8-7910-41a2-ec13-08deee5ef7e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|6133799003|56012099006|55112099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	M8Mm9ISn/cDldIDwsvTxviw5+l+dNuuLGl6xjlrVMDNKPDxWR/g8aB76IIIpXiYgNZwucblNMhPPIJXc7+gnH2knZ4ATQx61Wgaw4AqR5Zk7nk7O3T53PhrY30Fjbg62xgSA1zRZpJnRSb45nvPAnU0BH7sO8KRknD4DudfvnfPVLuir8t8cehXK32GuY7FqFpNbcUHEtMO2OlcydjUD8SteelKMmcx4qhSpLsu1jWmuarlwWGYCo4BbXqu2hG0nXqXZraSga+mr3qUy1ncCQp7fnadGeNmq8BxP1pOf4C66Lrr74ehwHv4Fd9lCBED1igxSCTiH77DToWnqwGokxCdNC2lL5E3FA3B9cqt6KI6LU8HD4W66OZADVH+P7tdWBjfUdHBHexNyLcqKD/LOhQYAnC1Q4UcVRM+AcP+UzsmU0xNCe2cMwKRYJh/Hp7QZHWzY+tgajYOHazWvrZia9OIl45QT1Qvdnxc198CaGMI2OZ2BZJAfdNTmKX4CBXQ0jj2FQzjnwalRPXTdHiErQaEFopxVmTxHDSRx9N1P4h5N94T6VNKsG5k7Ly3gEbFStTCHp46aLi+rvMciYI6+YaaRL0WC9nO6C5ybp/c9iLgHDp7vUtnizcCacHKkSby/YNIjF3g5LtnkhGV8IIkg6hIYv9o7gTB/LOQVXO1L/Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(55112099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1MydDdFV0JVdFVTMCtQbDJQNjFhL09uMVdBZEl5S2xWbmpPN21jMXp4NFZF?=
 =?utf-8?B?N0QwL1ZCNWhsbFhWWGJZbWhOWXBVNVBZZm1TS01vNmt3TjAyRzNWSjkxbkY5?=
 =?utf-8?B?K0h5K3FYOHJwZWRpWHBSMnJOUTBtbjlGUzhoN2VhWEpGejd4KzRhdzRBd2NV?=
 =?utf-8?B?STdVait5b0JqaWdITnhacFovdzkvVjNZbzlGRGhjRzJtUjBIdnBmQkJzaWF3?=
 =?utf-8?B?dzgwZ2pESDVPaWp0Rk0rZUI4ZUIvNFlRbnRicEtpN0hVcGxoWVRZNEw3MkJB?=
 =?utf-8?B?NDlCN2NZTXNxa2V1RUVzMXcwd05wM1RWTmlzcURyc0FMUjMxQXlDK3pzdUQ1?=
 =?utf-8?B?cUVNM3dWVEE1R0hxNjRrQ29PQUVrakptTjJiTTUvQ2hjNDhQREtoeWpxUmNv?=
 =?utf-8?B?clpZWHcwZS9LdnJaTTc5dHpVMzNuYWFjY3hrenA2dGIwblgyZHJvc1ZVcFZK?=
 =?utf-8?B?TFhBTm1TNUdseVluWXNkVGl5SEozcC8xSEdKendJYTg3dmRKa1NqZGNPZWZJ?=
 =?utf-8?B?bXdmUlU4WnFpMnplTmlGOHloSlJtVXJDNFg4M1Z5OHpHTUM1clpJQ0twSHVt?=
 =?utf-8?B?NmNNS00rNzUyTkFGRGZrL3ZhNGdFemVEMEhnaCtGV1FTT2tpdndaTFZ0MUNj?=
 =?utf-8?B?azgxbTdKY2IrZHdOaGZLS2tpWUVuNGFUL0xtV2JINmt6d0pYSi9iNE0xbjlv?=
 =?utf-8?B?cUF0RXlodHdxbEVRZnNnNFNNVkZib3ZjVXdpbTR0WFFUV09tRXVIczYySnNJ?=
 =?utf-8?B?WUxnOWVUVzNrbHRoMDZ4UzBZOVVIVkFrdFdyZUQxK2VaRlJMRW1ZbzlVcU8x?=
 =?utf-8?B?bXIzMHU3V1hORTVtWkhpUWJWV2JVeXBkRFdZK1dYMFZGeHd0bWJoV0Q5dEtF?=
 =?utf-8?B?eWgvZDVQMzVaa3hsTGJmRjk1THZjS3FYTUIrRWJSTEE2eUp0NWFzTVFVYWt4?=
 =?utf-8?B?RjdFWFFXUlM1THRabE1lcXNDWlc5b3E3bWFjekRqNkpMakxvOWN6VEtEbTZi?=
 =?utf-8?B?QjJDYVVMWWFDSzk3anVScnhRK0cxcTlYTCtGemM5OUx2dVhhUVhYaGNoWlJ1?=
 =?utf-8?B?T1JZM0JCQ3lNc2VSVDAvalowV2NCNjAvYW8vN2cvNzJka1l0eUtpQStzN1Fz?=
 =?utf-8?B?ODhhN2VxbFhGOFlMdFVxRDZWbnRMVmhCYmRRWDZvZDJrTHdPS2xhVTdzOEFq?=
 =?utf-8?B?aS93TlYyejRLVThHV2RjZG5SR1lYVDFEaHZxMUxNWVlMYXRxSW1hSDAyVE92?=
 =?utf-8?B?bzBoVzcyd1Q0dlFiNE93U3M5VkJvaE1CUTJvck5Vb2JJNFdtb2h1RlNJZlB6?=
 =?utf-8?B?RFFja1B2V203TkEvWlMvVmticStFbDFJK1k2Z2NPSG9DVDBSNFMyZEJhaTIz?=
 =?utf-8?B?YjlqUzRDcThmN2pIZVBqbDlYaEExZEs3OUR1SnU5clZLUkN4OUErYWM5Skxw?=
 =?utf-8?B?NWVHN0I3TTM0OVBUZndkL3FwMERmYXh1eEJJNDQ5RjZZcjJSVmpLQ2pXZWxX?=
 =?utf-8?B?WVJHaHFvT3ZoT2RrWlZpajNQZFZRVzF5OEdxZXBlOVd6UXQ3NHdKeU5ib2Ra?=
 =?utf-8?B?TkdiZjQzUGhWMHE3cTBncXFUUlpiQUV2Y0I3S3BwU29HTnpzUDVvYnFscGty?=
 =?utf-8?B?d2dCZ3EyRWhDaHJsTDlWNmtxOTAvM2JKWjEyS3V3ei82OU9rZVpvL0JzOHkw?=
 =?utf-8?B?ZHNxbVErSDVlK0hxUlFvc05GMDQ2RDN0SGhjSk83MUFnakRJNFFEbEZ5NjZP?=
 =?utf-8?B?S2R1bkdzQlFtemVFM01ENE4zczBUWkN3U25ka2ZHMC9HT2tYdDNrM1pMWnpa?=
 =?utf-8?B?WUxDcjN1SlJuOTZnMnlTZjA5Ym1Qd0J5L1k4ZnhNK2k2YUtzdExKaTVpNm5j?=
 =?utf-8?B?byswb0FLc2g0WktKMXJQRjBTei93TERtR003UFY2dE5DNkJlam9rRDBBSUFZ?=
 =?utf-8?B?UTlybGExMndXeCtUN3EvMFM5S21ON044N1pPbkJueEhadmpsZjVFZVROazM2?=
 =?utf-8?B?bmlNamhmeU1ML1hEeDRIYjI4NmJja3lOVlU1T1haeERKb3NVWTJXOTIwTDhH?=
 =?utf-8?B?d0kzaHBObGluKzYzZEFrVlRoakt6L0o3VG52ZUs4RUovR2t3NkMwTzE3aWxF?=
 =?utf-8?B?M3N2d0c0cHNQdmVZSnVKWDRQNHM2c0VmKzRieU8wRGpZbnhkdm9zMWN5MndH?=
 =?utf-8?B?V0ZHSUV2RXRRNE83ZGtzdk50SDVxaFZaT1h0d1R3YnA2N0VIWkNobnE4dkll?=
 =?utf-8?B?SnB5RHFPenBmaFFUV2F4ZVo2eStQT2hqeXNYb0lMZUcwNDNzTUNRWDI4VkZa?=
 =?utf-8?B?KzMzb052V2pPUHJ4eEFyZjRObnVtMG0ySlc1b3RTaGdYZnI2M1dsUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f20ff8-7910-41a2-ec13-08deee5ef7e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:21:18.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuFnCkyGiLwLsge+KrO0HOx3Fk1OgxBfx1BCFaO8duHln+aDqHh3MbABN0MAA22FYmhIrCLP3g0qlE10KhMPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8562

On 30.07.26 17:47, Clara Kowalsky wrote:
> Debian trixie warns when relying on the generated compatibility unit for
> /etc/init.d/xenomai.
> 
> This addresses
> 
> systemd-sysv-generator[1423]: SysV service '/etc/init.d/xenomai' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> systemd-sysv-generator[1423]: Please update package to include a native systemd unit file.
> systemd-sysv-generator[1423]: ⚠ This compatibility logic is deprecated, expect removal soon. ⚠
> 
> See #54.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  debian/libxenomai1.xenomai.init    | 36 ------------------------------
>  debian/libxenomai1.xenomai.service | 13 +++++++++++
>  debian/rules                       |  2 +-
>  3 files changed, 14 insertions(+), 37 deletions(-)
>  delete mode 100644 debian/libxenomai1.xenomai.init
>  create mode 100644 debian/libxenomai1.xenomai.service
> 
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
> index 000000000..4494dc00c
> --- /dev/null
> +++ b/debian/libxenomai1.xenomai.service
> @@ -0,0 +1,13 @@
> +[Unit]
> +Description=Set Xenomai group
> +ConditionPathExists=/sys/module/xenomai/parameters/allowed_group
> +After=systemd-modules-load.service
> +
> +[Service]
> +Type=oneshot
> +RemainAfterExit=yes
> +ExecStart=/bin/sh -ec 'gid=$(/usr/bin/getent group xenomai | /usr/bin/cut -d: -f3); [ -n "$gid" ] && echo "$gid" > /sys/module/xenomai/parameters/allowed_group || true'
> +ExecStop=/bin/sh -ec 'echo -1 > /sys/module/xenomai/parameters/allowed_group || true'

Why "|| true"? Can't we detect the condition when we should not write
(like in the original script) and give the write the chance to properly
fail the unit? You may even use a script to deduplicate that part of the
logic.

BTW, how did you test this?

Jan

> +
> +[Install]
> +WantedBy=multi-user.target
> diff --git a/debian/rules b/debian/rules
> index 9e56de260..dd52cbaf0 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -103,7 +103,7 @@ binary-indep: build install
>  binary-arch: build install
>  	dh_testdir -a
>  	dh_testroot -a
> -	dh_installinit -a --name=xenomai
> +	dh_installsystemd -a --name=xenomai
>  	dh_installman -a
>  	dh_installdocs -a -A README
>  	dh_link -a


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
