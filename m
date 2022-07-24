Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30067.outbound.protection.outlook.com [40.107.3.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC333C3
	for <xenomai@lists.linux.dev>; Sun, 24 Jul 2022 14:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx2SkWPN+Qpo63oGXf3cfKNSiVXCC5P8h8no9opxyjxo/5Z353aPI78ZfInPxz62Pp9h0Qsp6yRB8XM+WJ2ya/kTteybMekzqTlj6KLjcc4BYRQSLlRQ0NrIsF7WwisaSxlb29KVImZpGFPp4OUUjlgo8QOvZDiC99cqX7RJB3uQUd/IbxCffx3+FdltmdwXR+vW/SBqm3XoEogZGmEfCpUJhGpweNbKEsFHy0YgmKSh7YW/EsCuVa01pcolW7PsfXV/Tr/XnIXrSL2PRXP6tctLRW4GtjrHdGVEPqv9IF22dc9ufzpo0mexhvkNnz+4HpbiyuDsnjXzPOHaEhCo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMc+GzCgyd+l7sKGuqFQJU8vbm0eywQwo8mgUg6J0rs=;
 b=bvp3lACj3S/t0fv/ttEG4D1pSqJbl5A0B/Zei1fdgh79a0Lnbkh4EtXTAMVPhg2Z4oxGXee+gLg+xWmtbXJmwVvzn+BHWqPfTRHmHDqr5i2gucTAk178I6oXyOZkX4q1Q5PKxIWHyuXOjAiukcI6jeYm0U3/+N8JTEp/oYJkXMpuhaMVAPjgrC2zALu7xGnN34LLcDUZFGEgjbqW5GITWXtARXmKk09hN5Fo0cLJE7Wf1aLS3JmcofrAAuDdLSG92nPw3xNC3i8HJXSjfA5CIQOiphYq3BfsRdZPDae1mN28fyKTb8oMG9pYQnSAfojOYKZIlZOevf2ofqVqCaSU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMc+GzCgyd+l7sKGuqFQJU8vbm0eywQwo8mgUg6J0rs=;
 b=Qqp478kuH/tHy16urBhx1RG8JA0yeMFsSpMahXg300AHiMYAydkGQC2UG7uKsRsdQkJ35pQakrimW5l43JKHZKvmxGsTNNitmK2mn+cI+30IuUrG3ALcj4AG6ZbUo8NwCRu3OQLA7u6bLYNg70CZHM7RshVyILdH8Bh0V6i3S1Lie63S7Nhc4WpFLemD/+slr+px07pH7YMaM6mhYFZayvF+89/H++lxWW49Hylzow0WOKKW64pGoxgWwuXwvPbkPJKZvn8HsluJTqKkXtuNWg57Aklr3sECVDK1tMQK4aWMTtAURPZ/B9nOXKIkId1uVkcXpqzh2NVpgCB2C7F7Uw==
Received: from BE1P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:15::19)
 by AM6PR10MB2535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sun, 24 Jul
 2022 14:58:09 +0000
Received: from HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:b10:15:cafe::dc) by BE1P281CA0029.outlook.office365.com
 (2603:10a6:b10:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1 via Frontend
 Transport; Sun, 24 Jul 2022 14:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT058.mail.protection.outlook.com (10.152.0.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Sun, 24 Jul 2022 14:58:09 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 24 Jul 2022 16:58:08 +0200
Received: from [139.22.104.190] (139.22.104.190) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 24 Jul 2022 16:58:08 +0200
Message-ID: <bff548f3-0b67-9a22-dbc0-bae768415e71@siemens.com>
Date: Sun, 24 Jul 2022 16:58:07 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] utils/net/rtnet: use NETMASK also with TDMA_CONFIG on
 master stations
Content-Language: en-US
To: Mauro Salvini <mau.salvi@tin.it>, <xenomai@lists.linux.dev>
References: <20220722144809.18884-1-mau.salvi@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220722144809.18884-1-mau.salvi@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.104.190]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.534400-8.000000
X-TMASE-MatchedRID: kxpaLTp5p674AkTW3FFRihr3Sp02t5CNPg9yfk4YC0Y4hD0Y/Y/a7zAn
	AH1MqYlYWfmMcjcXc0cEdn+1KiEcxJgYl4h1Vd91kGv/gaJFLh6q6W3AJ8aVbj8Ckw9b/GFeTJD
	l9FKHbrlrwOS8T0CAYs0t/VJ8ZzXex8f9vI62x3Li1xPn9On/bFTNH/IEdCNmrSAIWhdbeu8K+4
	pGZZRa9Db10bkjQ5IrcxZ+avxQRTxMueTwIBV7UwDVKsu56OuSdxht4B0YcddeYVWU5uHQ/EF+Q
	lYpjQppCtWCkj21FWSjxYyRBa/qJQPTK4qtAgwIAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwsy+y
	ev3N8f+90BnBCTKSqFDZCvbgSnABBhedsb6I17+MnP6vzc8nqg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.534400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 B7E656641BC5B4B1CF0889A61545FACBBF348872E80A263DCC61A83A62D7E3CB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a289e061-4e81-4a78-c681-08da6d84ec5f
X-MS-TrafficTypeDiagnostic: AM6PR10MB2535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yh9iL8CFeON4YyVoj9AIH1XQG0q2KTCxLakv/CF/j+WN1s1C2MRTSZozeGRFzyh2eZY/vKa32yBw2h1HtJh0puaAA7ZXZ6cmKvNVdt4W8NaBg9CT8LWbLAiAyCC+xZgMGi7wiA2h12XTu+g3p9zBlMYv06rnmQ+yo8rcjcATKfF2diU48ihrbTfW1O16AFkubwee4wRNYhl91NpT4mV5Wwv3v6b4zfC3h2UveS9NSDG+lL6ikevX8FUrfJ6qe7/wjtjH3r1dQPeAFGghuJKJ+/lUAXfMB0dkgNszjUjEFXvAneXCbO2FO8iK8By0DEmT1Ig03f2FRYbUu6tgVbM5jsm/1jMYsAW07YhjrWSSnxmZG8T8N/Hinag+1ndl6CvF0vRbzQoTyVy8QewZQF5GrA80r2YILA50zcv/XjC3jcUc5vqzdA2SLTyZkvUa22bw8AVS4+YDPVqhwbMQCwc85wILIRzxpGERIqwt/i5IHZ1KP1Aaw5ZbPcKJSiJnBN5SNsBJt25Lc4/pwDTscK392VyOMCcwAio1OAqQggya2LEO0yzpuNsGwzqXrMB0bcEq+LN2njaudCc7G+wAB7TdUWzZbUO4zKMhMADk0hY1DGQwGwtSSROE5E2kVHeo2Jnm4k0XiOsjXYgTD8w6VWgxzdJtsZV3S95uImxn96ZKRTAhZF+pv9t9t8Ol0lulQoSLRGFk6dMr0or3pG5P6G87kU2ARJa6WihVWa29FKAqvI0FWPsLuARR9fVVlhImXQ14B7T74Bo6U5OJehr5G1fUcYhVjZN/ZROzsbAI/NoMjsNctmxEt1MAVM3LA5nWczBUao5vx8Btep/49TdKTE8RKVht4LB8kZdwuXZqOzaLDuTPV14LbZzu/uWrb02vScp10pfinCowE1afJrGitDPhKg==
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(70206006)(8936002)(956004)(31686004)(70586007)(40480700001)(40460700003)(31696002)(81166007)(82960400001)(36756003)(110136005)(8676002)(82740400003)(2906002)(356005)(478600001)(26005)(6706004)(47076005)(44832011)(53546011)(16576012)(316002)(186003)(2616005)(16526019)(86362001)(36860700001)(41300700001)(83380400001)(5660300002)(82310400005)(336012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2022 14:58:09.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a289e061-4e81-4a78-c681-08da6d84ec5f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2535

On 22.07.22 16:48, Mauro Salvini wrote:
> Before this change, on TDMA master stations using the TDMA_CONFIG file
> the NETMASK parameter was not used and netmask was assigned automatically
> by [rt]ifconfig (deriving from IP class of the address assigned to the station),
> both on master and on slaves.
> Instead, on TDMA master stations not using the TDMA_CONFIG file, the NETMASK
> parameter specified in rtnet.conf was used both for master and slaves.
> This commit uniforms the NETMASK usage between configurations with and without
> TDMA_CONFIG file.
> 
> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
> ---
>  utils/net/rtnet.conf.in | 6 ++++--
>  utils/net/rtnet.in      | 7 +++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/utils/net/rtnet.conf.in b/utils/net/rtnet.conf.in
> index 12335d26e..6b542b8d6 100644
> --- a/utils/net/rtnet.conf.in
> +++ b/utils/net/rtnet.conf.in
> @@ -27,9 +27,11 @@ RT_DRIVER_OPTIONS=""
>  REBIND_RT_NICS=""
>  
>  # IP address and netmask of this station
> -#   The TDMA_CONFIG file overrides these parameters for masters and backup
> -#   masters. Leave blank if you do not use IP addresses or if this station is
> +#   The TDMA_CONFIG file overrides the IPADDR parameter for masters.
> +#   Leave blank if you do not use IP addresses or if this station is
>  #   intended to retrieve its IP from the master based on its MAC address.
> +#   If this station is a TDMA master, netmask is used also for slaves.
> +#   If leaved blank, the default netmask for the IPADDR IP class will be used.
>  IPADDR="10.0.0.1"
>  NETMASK=""
>  
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index 9b5f70440..a5c31ad40 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -78,7 +78,7 @@ init_rtnet() {
>  submit_cfg() {
>      case "$STATION_TYPE" in
>  	master)
> -	    $RTIFCONFIG rteth0 up "$STATION_IP"
> +	    $RTIFCONFIG rteth0 up "$STATION_IP" $NETMASK_OPT
>  
>  	    if [ -n "$UPDELAY" ]; then
>  		sleep "$UPDELAY"
> @@ -88,7 +88,6 @@ submit_cfg() {
>  	    eval "$TDMA_SLOTS"
>  
>  	    IPADDR=$STATION_IP
> -	    NETMASK_OPT=
>  	    ;;
>  	slave)
>  	    if [ ! "$STATION_IP" = "" ]; then
> @@ -101,7 +100,7 @@ submit_cfg() {
>  		RTCFG_CLIENT="$STATION_MAC"
>  	    fi
>  
> -	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
> +	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP $NETMASK_OPT"
>  
>  	    echo "$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
>  		$RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 -
> @@ -117,7 +116,7 @@ submit_cfg() {
>  		RTCFG_CLIENT="$STATION_MAC"
>  	    fi
>  
> -	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
> +	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP $NETMASK_OPT"
>  
>  	    STAGE_2_OPT=
>  	    if [ ! "$STATION_STAGE_2_SRC" = "" ]; then

Thanks, applied. Once again, I do not recall anyway why I did it the way
it was before and not like you propose now, but it makes sense this way.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
