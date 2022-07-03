Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0333DC
	for <xenomai@lists.linux.dev>; Sun,  3 Jul 2022 17:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUBVdP0ja0jkPv2wvfEWa+QKNcmXVZJQF+XToFbN+VkCNfwvP+OLngslL7Msht7wUVQLtnTEzt0VFyfw1IUbTtiFo0cOG8eLsn6Tojku3eKZyimieb6xx0PQJNJw9e5YpD1wifLZEdRyqex60vT41M1bM1MWZ3A+K6vbUMu0WiUMDBuWiJllPWrWHLeQYgiagUzD1nBbHP2rrs3GIiNfpKH11RzUK6nuSlS+EkrAcYvC3tWVM5HxIM3kpmVIrbOe7zinQjPql4Doiu6naVB3WbeekyS33iaZFZNfB1jc/vSUPUduX7Co3ChSSxiKDD2236AzNDkMc8ZYFvbkKB89ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC8G+ugbnEyUwo3i9ep6F7DZTIrNWXuMW9YYaaq+NHw=;
 b=ndbCLsA6gW2PcZ5GfCkQdmJiTYz5+2WFqKA1+0peKfCgFFBu8ISls7uP3RAFWUXxrimfbLWdTbThIuNPCRmXuqFrN5H3yGZyI4PIG9JC7DaoiM31Bxf0k2FjdRYsy1RJGkdkCVc6PIaAMqLGNMm0PFitQH4I7+SajxW5JSN6DjlMF1qsaqvVbD6+JWTU2Xf6DBXgYupoDzz7A0kmT7/U8WN1dz65fHMf34hmnf1zVqHD31vxCuiplBnzaVMrt+6UQbW3Mu5SFglINqNIOWCAVPfleWX6s8NnJkW5Ldef4AVPPlphdiFQ7Z/CQzxJCGUcqi4A98w9kUbztmxHTCfCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC8G+ugbnEyUwo3i9ep6F7DZTIrNWXuMW9YYaaq+NHw=;
 b=MaPLGxrdtviXdKMj2s5OMFQI5l8GqYYaw18CSHQK96RfEor6i+tAjEoUqSRg7AfmM3oPDyQSr6wWSYl5yA4Nc9lg+jOwPuqVd1x9V/oIlwFWlvGw+XkORSOhoCnojQfus50WepuxQt8oasKtul7vLimMHQsy/mplTBCHAI9HKkEO+0oGV6A/yZk8OrYOiowyPbrMEIsWTQLmngqIgps0eKFYv3q1d07kbmMQhqZ5iixHcq765KwnoBmzLA5yD+7fYX4QvJ4lUo23pt+dwTa/dpy9Anscphp8QrUqcdnYHS5lg7bYSsSqgMvxVjTA4kLoZzXCX+lRVToOhDequKAa3w==
Received: from AS9PR07CA0050.eurprd07.prod.outlook.com (2603:10a6:20b:46b::8)
 by AM9PR10MB5098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:437::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Sun, 3 Jul
 2022 17:35:03 +0000
Received: from VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:46b:cafe::42) by AS9PR07CA0050.outlook.office365.com
 (2603:10a6:20b:46b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6 via Frontend
 Transport; Sun, 3 Jul 2022 17:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT030.mail.protection.outlook.com (10.152.2.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Sun, 3 Jul 2022 17:35:03 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 3 Jul 2022 19:35:02 +0200
Received: from [167.87.8.65] (167.87.8.65) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Sun, 3 Jul 2022
 19:35:02 +0200
Message-ID: <a9c17c08-b870-c258-b2ac-0ed5b7f7d628@siemens.com>
Date: Sun, 3 Jul 2022 19:35:01 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] utils/net/rtnet.in: add delay during master configuration
Content-Language: en-US
To: Mauro Salvini <mau.salvi@tin.it>, <xenomai@lists.linux.dev>
References: <20220623123647.29418-1-mau.salvi@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220623123647.29418-1-mau.salvi@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.8.65]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.775900-8.000000
X-TMASE-MatchedRID: U4jXvEiKZBX4AkTW3FFRihr3Sp02t5CNPg9yfk4YC0b0VCHd+VQiHkFJ
	jqTH4zXxYq4PLSQobHQvdxtZJg3nTO3KKKhzBK2tavOGe6H/D0VBHJIBGzDHo8Yv//yaWh0DiK5
	qg1cmsr/XLRpcXl5f6Ic0B5OUL/u1kBnQ42vyFpbVZV3idYVZIbSw/pyY1ik4t0cS/uxH87C061
	diBteN17jxqq8lZC0I2Huw61jLswC5iSL2djl2VZxbmQZOs9cOj+eP/kt+ego/ApMPW/xhXlQQ0
	EgzIoPRNv1MHbxRuSJdO6s6MJM91h7O02Jb2mDnBOvndXhUjRvc71kF8NZX3IY5QY8KaJtTMOhR
	B5C/8I/I9EDAP/dptnKg3ZCIm2XRgon9+FIIlmUpLTU7LzCxjl1T+8tZ1aF2bSVDTp70ZQurlTq
	w7wfC0/Za5f++8Y0gyHI9pvh+9W8r59u/gzv5MLUzq8RBkJuGcNYIRle9ggeeAiCmPx4NwLTrda
	H1ZWqC1B0Hk1Q1KyLUZxEAlFPo846HM5rqDwqtzbMlBcuD7WiB6aM3d4l1tffRChy1HzJDu1ab4
	2UNzY4VNeyqswioug==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.775900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 A4A0FA9E4BB31AA307EC75E72D1B573AFE64AF6B12DA7B209FF7749C34EAC49F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129a8078-5997-455c-dec6-08da5d1a5ccd
X-MS-TrafficTypeDiagnostic: AM9PR10MB5098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dcR2k3W7rv/7OvWCtMjvDvtwy4VtZSimsvsG9DKMrGPLWjnPju5wZRpPdXSKb5cZSf5RdLqMbjmjsyP7PzDlf3EX1Eos3CCUNePD8MVBtcTT2NltMJLganyaCcw/M7TaGnZQdGDpctteFw4x7RvsEG+z3UNLab0hE+JMwH3pBYJkbwIQiimKXb/IVAxACEpdNZZPjwE9AglzRmTCrelOzZ4wfGVp+BMzFMSILQvFXFed7NlVIgjPy0Zp9FW5TxGh3+BsP8ANTgggoLzttN/vEjAwjqkqFoRQhfYDxPPsT6GnnTLWnt0ClVJhCs3teY4gjeGK5H03y+MJMI9gBT5vPIwArC8staMmmDZvZGDEDpuhil5WJ5jFqcANb5XoVv6YKNc2952lhSmMSi6T6R3yLzuJYnqo17EPWnN0/41dkFWV7lHkWZnjzSklf3HPe4ZE0bAUxgNEJ0VjN+VIxG19bBwM3VoagOxMzfj7l/5nUYVtkgiPX+HK/7tM4+fNLuWJssGJ7Y0VTLOgLJcymwBcCCgN+oToE5aCXORO/tkXQYMptCLcuLtqUKRTpE69y1Jjup8lule6cgDjXA0lDSD9lkKxqy1rTGh0hS/WEdCNDhJ8rtNCv5HuHItLAFVpREcGV0eIAR1tfF6NBaF1YsoAw+gxJHLmxI6zatKSrqSjngvYwJfqnCb54Y5M0xQ7Umke7q1+rfwMv3F9Z0AgBD2KLBkJWKZ6rt1VUjZRwK9FZRa0Bn//WOflyN15h9DV8gtH+1reXxDD2KMRKtQb/ReU37/NiTNSIgJ81b3QBjxd5xB58lMGjBYuct5hpuxI3t+0L10u6WVSGYPzEScJ5f7SbPKSt2I//3gkNjs2A+3zJHsXR5zWcuW/jjNfW9GvGMLvu/vqjUniDZOYDyEYhPYrMqCZZC3nhxqWTIDlJbAiY3A=
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(70206006)(70586007)(36860700001)(16576012)(36756003)(82960400001)(41300700001)(336012)(82740400003)(316002)(47076005)(2906002)(6706004)(8676002)(110136005)(31686004)(40480700001)(82310400005)(86362001)(53546011)(81166007)(16526019)(186003)(26005)(5660300002)(8936002)(478600001)(40460700003)(83380400001)(356005)(31696002)(956004)(2616005)(44832011)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 17:35:03.3406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129a8078-5997-455c-dec6-08da5d1a5ccd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5098

On 23.06.22 14:36, Mauro Salvini wrote:
> Some cards are slow to get the connection link up after the
> "rtifconfig rteth0 up" command, e.g. on an Atom-x5 with an Intel I210
> (rt_igb driver) I detected approximately 3 seconds to get the link up.
> 
> On master, the "rtifconfig rteth0 up" is followed by TDMA configuration and
> start. After the TDMA start, the sync packet is sent at the defined cycle time.
> 
> Sometimes, after "rtnet start", the dmesg fills with this error:
> 
>   TDMA: Failed to transmit sync frame!
> 
> and the rt driver locks. Then, the kernel watchdog is triggered and the
> NIC is hw-reset by the kernel, producing more errors and another lock.
> Sometimes the dmesg only fills with the error message and the NIC does
> not lock.
> This happens because the interface is not up and ready to handle
> the sync packets when TDMA is started.
> 
> This patch introduces a configurable delay between the "rtifconfig rteth0 up"
> and the TDMA start on master host. This allows to avoid these kind of problems.
> 
> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
> ---
>  utils/net/rtnet.in | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index cd24017b4..9b5f70440 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -15,15 +15,19 @@ debug_func() {
>  usage() {
>      cat << EOF
>  Usage:
> -    $0 [-cf <config-file>] [-v] [-c] {start|stop}
> +    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] {start|stop}
>  	Start or stop station according to configuration file
>  
> -    $0 [-cf <config-file>] [-v] [-c] master <slave_ip1> [<slave_ip2> ...]
> +    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] master <slave_ip1> [<slave_ip2> ...]
>  	Start station as master for given list of slaves
>  
>      $0 [-cf <config-file>] [-v] capture
>  	Start only passive realtime capturing
>  
> +    The parameter -d allows to introduce a delay in seconds between the
> +	"rtifconfig rtethX up" command and the TDMA start on the host
> +	configured as master. Useful to avoid errors/card locks when the
> +	RT NIC is slow to get the link up.
>      The additional switch -v enables verbose output.
>      The additional switch -c enables capturing mode to allow use of a network
>  	analyzer such as Wireshark (if rtnet was built with --enable-rtcap).
> @@ -76,6 +80,10 @@ submit_cfg() {
>  	master)
>  	    $RTIFCONFIG rteth0 up "$STATION_IP"
>  
> +	    if [ -n "$UPDELAY" ]; then
> +		sleep "$UPDELAY"
> +	    fi
> +
>  	    $TDMACFG rteth0 master "$TDMA_CYCLE"
>  	    eval "$TDMA_SLOTS"
>  
> @@ -144,6 +152,10 @@ start_master() {
>  
>  	$RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
>  
> +	if [ -n "$UPDELAY" ]; then
> +	    sleep "$UPDELAY"
> +	fi
> +
>  	$TDMACFG rteth0 master "$TDMA_CYCLE"
>  	$TDMACFG rteth0 slot 0 0
>  
> @@ -258,6 +270,11 @@ else
>      exit 1
>  fi
>  
> +if [ "$1" = "-d" ]; then
> +    UPDELAY="$2"
> +    shift 2
> +fi
> +
>  if [ "$1" = "-v" ]; then
>      echo "Turning on verbose mode"
>      RTIFCONFIG="debug_func $RTIFCONFIG"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
