Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0143EF
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 08:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBJBDC9hoW9DmKfzCAh5DAkXpn4cNzp7EhgL5lD5ldevY+2UQEciMHEUdymkMhWzGbyQ82TnRmdwnRSOAcCYRZhNRpg7AYPSlm85WgKAng3KQiL+jOl/YUwpu3YkNj2FBrEwdciqOXdbnYkbirKWltTtCaYYxcShrlqntfUJiEb1Vf7gTPzVcKqon1F25IyTgVuib5D/E8AqE2bZ1LeN7+Ryr4R/bOE7LZTfDkx0HdaAGG5GffftXuM8r2vF/G3FCuQeTFUbsFfwSdGkaJZIji8WL/Abvs5Ldtoez0ZBE1H1LeCVQKe3xujiUhw+1/DqlCvc94ltkioggMsR+iRt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxbLii9+T3iz9Ch7UzyPDxoPm/9cvgL2QhRrLh2JlXY=;
 b=F+0R2JTHarQyCIqy4CrutAQLrWfrXzSwPoGQOFpaR/P5QpUYDXzBj6gOQkE3YctTKbjHkq1jxl7S44ITHjoHEIUPZRznS73McU4/zB+/+wpqpQxok4YW7bjcjRjyBKBqxkk0GB/IsUbdqE2NkvOSsVwg0ZbSozWm7LB1ue1dYzhG5abHP1FQOuZq6qwAtNidnIEiX/NG6bw2bphgU0FtYqNoJnZal+MdQXyjHLf0fPAJah1dMv9U+iAoG6xBgPGoEUXnw2AOw1yK5a971lmqPCOml+hIKedXtzsgTEP2Gn/eyClFrqiECXknZJL0pDCblwi9QxzN/Gqe2FPu/54dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxbLii9+T3iz9Ch7UzyPDxoPm/9cvgL2QhRrLh2JlXY=;
 b=qjyqnZSu67/CWool+O864nXCDJNmERilX61wN5CPN5kwbB6lHZP7yLdeokMqGtH06Ra/iPHx0sFNHB6n3Rh7BoIMj0WxQriBRxwUXvX8qRmAuI8NPLPC/k0QJ0R7pNNMC8ThwM6pDnh/gAyD8LzgJbEH8MC307hkRfBnE6jFP897ykMBueYHKMCu5qYfI7Ll3Ux5BjMS/8zHGP+j4jAN/iy6AVwjR4eNzUHnnfdduuwQeG3DY60O0Kf2opgyOFuXX7oTbG799/gr0M3h/PoNRSHX8qfsQ3wZwrQpgs3f8XPdmoCwfGHqeZ4iaUQCwccwPaiVKVOtz4J5MynQuaib4Q==
Received: from AS9PR06CA0467.eurprd06.prod.outlook.com (2603:10a6:20b:49a::20)
 by DB7PR10MB2428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 08:59:34 +0000
Received: from VE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:49a:cafe::b) by AS9PR06CA0467.outlook.office365.com
 (2603:10a6:20b:49a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Thu, 23 Jun 2022 08:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT038.mail.protection.outlook.com (10.152.3.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 08:59:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 23 Jun 2022 10:59:32 +0200
Received: from [167.87.6.167] (167.87.6.167) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 23 Jun
 2022 10:59:32 +0200
Message-ID: <2897f396-1074-bae0-4cf0-46a97084da2c@siemens.com>
Date: Thu, 23 Jun 2022 10:59:31 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Language: en-US
To: Mauro S. <mau.salvi@tin.it>, <xenomai@lists.linux.dev>
References: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
 <63e4b7c7-bc03-6ca1-f4e1-ac8b77d8826b@siemens.com>
 <7f7ea65a-a58e-33e3-1680-2e59289b2be8@tin.it>
 <fc9fc714-e1e8-8132-7cc3-76e7ee1f4d87@siemens.com>
 <d9a4b75d-81bb-28ea-4bee-293f19637c05@tin.it>
 <cdef20fa-8134-6706-e43a-b94a2e98334b@tin.it>
 <7556be30-4977-143c-f341-cdf1074bf4a3@tin.it>
 <868172c1-7a1f-9a3a-2a3b-55a12aa73958@siemens.com>
 <8bb2afe5-2c91-ec51-e544-65278d56f841@tin.it>
 <aacf04e4-91e3-6232-5b1d-c6570ef6e3f4@siemens.com>
 <86d5b170-dedf-000f-5f23-31bbf9145fd2@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <86d5b170-dedf-000f-5f23-31bbf9145fd2@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.6.167]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.762600-8.000000
X-TMASE-MatchedRID: qeBAs1Oleyb4AkTW3FFRihr3Sp02t5CNPg9yfk4YC0Z7ofPRmlJvlyKp
	n/iCVxz890btya4ycSgvSsSjlkTOPOjhnw4zCphWP0XNUDY7MGird46AcF28XlqrE4WJVkoBS1z
	wNuiBtISU8ftiyKjZrWtwOoXDbvJw3YJuIDhA7WtsGcpYVjbbPkASN/wlEVsctbv6jY5MxFx/7i
	VTXtdMVbKeTtOdjMy6q8Bv+OwMt8xrZoF0MUSFWjY9eRDvjeTZr8Ye16HZPPptJUNOnvRlC3oCB
	x19i+GMrTz0igpFp415bBiV7e/VjAkHolGY3Ud/XHmljqCp8PIHKdtUS/l9oQxxIOrYW0TsMVx/
	3ZYby7+3hFu8mEEHisygAl+yObROcJLdFUva/pcVAc7TcGR4oEUUIbywgVRPbl4CKqupkMr0VPv
	T0zx0mKfub87GOZij8P7ohAxHFTnnzlXMYw4XMAGLeSok4rrZC24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.762600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 8E0DE0F51D384320ADB6741DEB758523D45565870C696FB7D5F415F61DB6921A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d332216-670a-4472-f472-08da54f6b122
X-MS-TrafficTypeDiagnostic: DB7PR10MB2428:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR10MB2428719AC3E5C06465A8941A95B59@DB7PR10MB2428.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NyG4U+P8YTcmQyIwW1gBEBj6RcKs5WIq9vhkZOkk7+rKPf/USEf1X5vHCzHsjSzLYSwBxbN+NGfzf7zGnfDFsl2FMuOwOYl5gVQqacgnGxuG2gZI9S3xqAGLK9zyrzfkcWjwYYDUmdwi4yWHTzreWgawjSgWklEGuCNpuccoBzy5tdoYIDZW8CHYYB5Vq9iKewksEHkiEyp/xl/5Mm8KQKGislVhQBXHqjKcKvAz8/UrAM9zEh63LCqCInNk15NTELhVlXDAk9OXruw95ItELfa8nWZgNWgorXP7kpTyVfvw+iQwbVcX1JcT+D9PVP8Q7aFCmfPOb9aa54NXNmVlxa0VVyrQaWFRhdUgR5fJGiQzeWqoY0SdSuXKpeEUKgGXXZlxuKJOP7E0TjCceH6fJqOBT/cLTeyEOJjWLzXruhUus5KVWLxIDNPBaxLwlgBJyy1XIQ48xAL0n0w+u1/kVft4shnwcO2MUjdrhf1x503AEA07hL8Bqgo/fBCq3FzDAJa1dVMBpBZ67y4LV0i4W+Kb6QXBYnRNUuy9e5PqruxqIpbnulj3l0Ww15aOl/z/4oGGjI/aUru8N3whBaD7B85metfYFxhzFoQGC5D40HgRnBIZLp79tyNIcNyzMwY5cNJVK+eX+evLAf1x2xycyH2z98JXbaFqZEmjBENqs24s8NdGPDBsgdkzU6a5XXR5pBuAP0InMCny8jLo5OMiGF41kTMWfg3Ie0n6sjdEK8qP3TOGxutxqiFlN+lQ+WTT8xPOlgmssc7qeN5QO3mfroMzsiXYb0h2qR8SY7CgudyT8VVBHrnf1nwYYIB8l9WWwsZn/WuQ0y5N87QHgTOcuGlzTRfR8aHRizKdDlbFjGU=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(31686004)(8676002)(83380400001)(40480700001)(8936002)(16526019)(16576012)(70586007)(478600001)(110136005)(36756003)(70206006)(82310400005)(44832011)(316002)(81166007)(82960400001)(47076005)(5660300002)(2906002)(2616005)(86362001)(82740400003)(41300700001)(356005)(956004)(6706004)(36860700001)(336012)(53546011)(26005)(31696002)(186003)(40460700003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:59:33.6423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d332216-670a-4472-f472-08da54f6b122
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2428

On 23.06.22 10:48, Mauro S. wrote:
> Remaining shellcheck warnings:
> - "SC2086: Double quote to prevent globbing and word splitting."
>   line 120, 153, 289 (variables STAGE_2_OPT and NETMASK_OPT)
>   Suggested fix not applicable because these variables can be empty,
>   resulting in command failure due to "" in command line
> - "SC2153: Possible misspelling: STAGE_2_DST may not be assigned, but
> STAGE_2_OPT is."
>   line 296. STAGE_2_DST comes from included RTNETCFG file
> 
> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
> ---
>  utils/net/rtnet.in | 86 +++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index f81a7bb0a..cd24017b4 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -9,7 +9,7 @@ RTNETCFG="@sysconfdir@/rtnet.conf"
>  
>  debug_func() {
>      echo "$*"
> -    eval $*
> +    eval "$@"
>  }
>  
>  usage() {
> @@ -33,35 +33,35 @@ EOF
>  init_rtnet() {
>      modprobe rtnet >/dev/null || exit 1
>      modprobe rtipv4 >/dev/null || exit 1
> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +    modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
>  
>      for dev in $REBIND_RT_NICS; do
> -    if [ -d /sys/bus/pci/devices/$dev/driver ]; then
> -        echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
> +    if [ -d /sys/bus/pci/devices/"$dev"/driver ]; then
> +        echo "$dev" > /sys/bus/pci/devices/"$dev"/driver/unbind
>      fi
> -    echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
> +    echo "$dev" > /sys/bus/pci/drivers/"$RT_DRIVER"/bind
>      done
>  
>      for PROTOCOL in $RT_PROTOCOLS; do
> -    modprobe rt$PROTOCOL >/dev/null || exit 1
> +    modprobe rt"$PROTOCOL" >/dev/null || exit 1
>      done
>  
> -    if [ $RT_LOOPBACK = "yes" ]; then
> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>      modprobe rt_loopback >/dev/null || exit 1
>      fi
>  
> -    if [ $RTCAP = "yes" ]; then
> +    if [ "$RTCAP" = "yes" ]; then
>      modprobe rtcap >/dev/null || exit 1
>      fi
>  
> -    if [ $RT_LOOPBACK = "yes" ]; then
> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>      $RTIFCONFIG rtlo up 127.0.0.1
>      fi
>  
> -    if [ $RTCAP = "yes" ]; then
> +    if [ "$RTCAP" = "yes" ]; then
>      ifconfig rteth0 up
>      ifconfig rteth0-mac up
> -    if [ $RT_LOOPBACK = "yes" ]; then
> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>          ifconfig rtlo up
>      fi
>      fi
> @@ -74,9 +74,9 @@ init_rtnet() {
>  submit_cfg() {
>      case "$STATION_TYPE" in
>      master)
> -        $RTIFCONFIG rteth0 up $STATION_IP
> +        $RTIFCONFIG rteth0 up "$STATION_IP"
>  
> -        $TDMACFG rteth0 master $TDMA_CYCLE
> +        $TDMACFG rteth0 master "$TDMA_CYCLE"
>          eval "$TDMA_SLOTS"
>  
>          IPADDR=$STATION_IP
> @@ -96,7 +96,7 @@ submit_cfg() {
>          ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
>  
>          echo "$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
> -        $RTCFG rteth0 add $RTCFG_CLIENT -stage1 -
> +        $RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 -
>          ;;
>      backup-master)
>          if [ ! "$STATION_IP" = "" ]; then
> @@ -117,7 +117,7 @@ submit_cfg() {
>          fi
>  
>          echo "\$TDMACFG rteth0 detach;\$TDMACFG rteth0 master
> $TDMA_CYCLE -b $TDMA_BACKUP_OFFS;$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
> -        $RTCFG rteth0 add $RTCFG_CLIENT -stage1 - $STAGE_2_OPT
> +        $RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 - $STAGE_2_OPT
>          ;;
>      esac
>  
> @@ -142,16 +142,16 @@ start_master() {
>      #   Sync / Master Slot / + TDMA_OFFSET us / Slave 1 /
>      #   + TDMA_OFFSET us / Slave 2 / + TDMA_OFFSET us / ... / Slave n
>  
> -    $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
> +    $RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
>  
> -    $TDMACFG rteth0 master $TDMA_CYCLE
> +    $TDMACFG rteth0 master "$TDMA_CYCLE"
>      $TDMACFG rteth0 slot 0 0
>  
>      OFFSET=$TDMA_OFFSET
>      for SLAVE in $TDMA_SLAVES; do
>          echo "\$TDMACFG rteth0 slot 0 $OFFSET;ifconfig vnic0 up
> \$IPADDR \$NETMASK_OPT" | \
> -        $RTCFG rteth0 add $SLAVE -stage1 - $STAGE_2_OPT
> -        OFFSET=$(($OFFSET+$TDMA_OFFSET))
> +        $RTCFG rteth0 add "$SLAVE" -stage1 - $STAGE_2_OPT
> +        OFFSET=$((OFFSET+TDMA_OFFSET))
>      done
>      else
>      # Get setup from TDMA_CONFIG file:
> @@ -185,12 +185,12 @@ start_master() {
>      # slot ...
>      #
>  
> -    if [ ! -r $TDMA_CONFIG ]; then
> +    if [ ! -r "$TDMA_CONFIG" ]; then
>          echo "Could not read $TDMA_CONFIG"
>          exit 1
>      fi
>  
> -    while read ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
> +    while read -r ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
>          case "$ARG1" in
>          "master:")
>              submit_cfg
> @@ -217,7 +217,7 @@ start_master() {
>              STATION_MAC="$ARG2"
>              ;;
>          "stage2")
> -            STATION_STAGE_2="$ARG2"
> +            STATION_STAGE_2_SRC="$ARG2"
>              ;;
>          "slot")
>              TDMA_SLOTS="$TDMA_SLOTS\$TDMACFG rteth0 slot $ARG2 $ARG3"
> @@ -233,16 +233,16 @@ start_master() {
>              TDMA_SLOTS="$TDMA_SLOTS;"
>              ;;
>          esac
> -    done < $TDMA_CONFIG
> +    done < "$TDMA_CONFIG"
>      submit_cfg
>      fi
>  
> -    ifconfig vnic0 up $IPADDR $NETMASK_OPT
> +    ifconfig vnic0 up "$IPADDR" $NETMASK_OPT
>  
> -    echo -n "Waiting for all slaves..."
> +    printf "Waiting for all slaves..."
>      $RTCFG rteth0 wait
>      $RTCFG rteth0 ready
> -    echo
> +    printf "\n"
>  }
>  
>  
> @@ -251,8 +251,8 @@ if [ "$1" = "-cf" ]; then
>      shift 2
>  fi
>  
> -if [ -r $RTNETCFG ]; then
> -    . $RTNETCFG
> +if [ -r "$RTNETCFG" ]; then
> +    . "$RTNETCFG"
>  else
>      echo "Could not read $RTNETCFG"
>      exit 1
> @@ -281,30 +281,30 @@ case "$1" in
>      start)
>      init_rtnet
>  
> -    if [ $TDMA_MODE = "master" ]; then
> +    if [ "$TDMA_MODE" = "master" ]; then
>          start_master
>      else
>          $TDMACFG rteth0 slave
>  
> -        $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
> +        $RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
>  
> -        echo -n "Stage 1: searching for master..."
> -        eval "`$RTCFG rteth0 client -c`"
> -        echo
> +        printf "Stage 1: searching for master..."
> +        eval "$($RTCFG rteth0 client -c)"
> +        printf "\n"
>  
> -        echo -n "Stage 2: waiting for other slaves..."
> +        printf "Stage 2: waiting for other slaves..."
>          if [ ! "$STAGE_2_DST" = "" ]; then
> -        $RTCFG rteth0 announce -f $STAGE_2_DST
> -        echo
> +        $RTCFG rteth0 announce -f "$STAGE_2_DST"
> +        printf "\n"
>          eval "$STAGE_2_CMDS"
>          else
>          $RTCFG rteth0 announce
> -        echo
> +        printf "\n"
>          fi
>  
> -        echo -n "Stage 3: waiting for common setup completion..."
> +        printf "Stage 3: waiting for common setup completion..."
>          $RTCFG rteth0 ready
> -        echo
> +        printf "\n"
>      fi
>      ;;
>  
> @@ -317,10 +317,10 @@ case "$1" in
>      $RTIFCONFIG rteth0 down 2>/dev/null
>      $RTIFCONFIG rtlo down 2>/dev/null
>  
> -    rmmod tdma rtmac rtcfg rtcap rt_loopback $RT_DRIVER rtpacket rtudp
> rttcp rtipv4 rtnet 2>/dev/null
> +    rmmod tdma rtmac rtcfg rtcap rt_loopback "$RT_DRIVER" rtpacket
> rtudp rttcp rtipv4 rtnet 2>/dev/null
>  
>      for dev in $REBIND_RT_NICS; do
> -        echo 1 > /sys/bus/pci/devices/$dev/remove
> +        echo 1 > /sys/bus/pci/devices/"$dev"/remove
>      done
>      if [ ! "$REBIND_RT_NICS" = "" ]; then
>          sleep 1
> @@ -337,7 +337,7 @@ case "$1" in
>  
>      capture)
>      modprobe rtnet >/dev/null || exit 1
> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +    modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
>      modprobe rtcap >/dev/null || exit 1
>      $RTIFCONFIG rteth0 up promisc
>      ifconfig rteth0 up
> @@ -349,7 +349,7 @@ case "$1" in
>      modprobe rtipv4 >/dev/null || exit 1
>  
>      for PROTOCOL in $RT_PROTOCOLS; do
> -        modprobe rt$PROTOCOL >/dev/null || exit 1
> +        modprobe rt"$PROTOCOL" >/dev/null || exit 1
>      done
>  
>      modprobe rt_loopback >/dev/null || exit 1

Please use git send-email in the future - I've fixed up the
misformatting manually this time and merged to next.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
