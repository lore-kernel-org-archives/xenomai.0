Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1800186B
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 08:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuZIpJEPZN/4sK2xmuK2r8omrbN2K2iFl3p/vJQxN6Za6gIJDgf4ivOsCkjF3sg2fLwWofn+ZROcHn2C6DqktT2oEbfgzppSrI+pmkr9XFnuJo6SUYACF/1n8RIXH7TAEkyR1BEkH0azmt8Rc4OxX+2QjCJ9yb3atRGGc6DXn8pwcZltGEqAmwKaczZF8hX7KyLOu7TsrCr7WHpnDN4NW24x/W+JGmxq4Pj8ET/6rLPCBO8k+N8h4MOc5LdDcTYfZEffdzMlWK9Qvssd/glAdcEZUCFyfbagSC51iXz+YplqvqLzztRisHq0UjnuioV2pHO/Ono5RF2q9FLvoTnEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grJID3O01WnMKYwD2l21rtkLvo4SzdW+eSITxBAsol8=;
 b=UnKk1OIyOb0h47NKQFp1lxcagAwQs5M74mG1rk0k9wTHV1yASi+/pwqQtsT/xm4wSqRTiwTxnD9DdWXFVzi1pB56yC8c8lbWZEPNQou2xpW+dlaL5Totd+YaQnQmRjxBHtBxjd9ptB0Vg3NBPjqyoBjmPUnVVjaB8Swzd4SfVm0cfnjLweWZnO0/iqgbjxUC7cL44HNUMJUAoxbvk5EsUz+eWwwTBqYU40gDKgyLfEnT2vepgTrGSCGJbyUfadg0HUolUHbjTH7YxT0RIyVFsEIMRjRLAaeRHA45zIJ/7dI81eRBYBEV9u7H+8RJHWfR0QweVZooHh5glHYQ/WL1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJID3O01WnMKYwD2l21rtkLvo4SzdW+eSITxBAsol8=;
 b=bBeWbw6xCt5ZEcmRYbaDzb4iNfBe3eO1uugcRBtjCtBQNQQ1QsuyV/yyI3fGlwiTrvyl6a4izf4Phyqaopm3QA3sE24jLfGVHYWn93NZNXc4o4voT6LvwAD7WgbJ6oNlHUkTDJCT2w1w2r3Rh3MvZ2XmygTPiQfb5055W8DwyiLtFmDn7K7CKURMTNAAhYsWqtwZeTFNJyDnyvPTJffhR6dmNcm1du0hRyOb82kQGQ7zBBw78FukJ2uQJJC4SE5/fOWU4Ot2yD3XT6+GA9ku34muVDVuMx8Ix7ObSlwzVcpLHX9WMiRhtolvpcYvBI/UD8C9mZBlO/qsGitMp3vLzw==
Received: from AS9PR06CA0188.eurprd06.prod.outlook.com (2603:10a6:20b:45d::15)
 by GV2PR10MB6187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 08:37:02 +0000
Received: from VE1EUR01FT104.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45d:cafe::b9) by AS9PR06CA0188.outlook.office365.com
 (2603:10a6:20b:45d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 23 Jun 2022 08:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT104.mail.protection.outlook.com (10.152.3.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 08:37:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 23 Jun 2022 10:37:01 +0200
Received: from [167.87.6.167] (167.87.6.167) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 23 Jun
 2022 10:37:01 +0200
Message-ID: <aacf04e4-91e3-6232-5b1d-c6570ef6e3f4@siemens.com>
Date: Thu, 23 Jun 2022 10:37:00 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8bb2afe5-2c91-ec51-e544-65278d56f841@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.6.167]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.547900-8.000000
X-TMASE-MatchedRID: 0sa3XW9m2I34AkTW3FFRihr3Sp02t5CNPg9yfk4YC0Z7ofPRmlJvlyKp
	n/iCVxz890btya4ycSgvSsSjlkTOPOjhnw4zCphWP0XNUDY7MGird46AcF28XlqrE4WJVkoBS1z
	wNuiBtISU8ftiyKjZrWtwOoXDbvJw3YJuIDhA7WtsGcpYVjbbPkASN/wlEVsctbv6jY5MxFx/7i
	VTXtdMVbKeTtOdjMy6q8Bv+OwMt8xrZoF0MUSFWjY9eRDvjeTZr8Ye16HZPPptJUNOnvRlC3oCB
	x19i+GMrTz0igpFp415bBiV7e/VjAkHolGY3Ud/XHmljqCp8PIHKdtUS/l9oQxxIOrYW0TsMVx/
	3ZYby7+04seKBdYiOWBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9gxsfzkNRlfKx5am
	WK2anSPoLR4+zsDTtJC9jS54qtzVNRxw0tUPpLdvwa5Iajvx+jGpC7MPnirxMSqOzrkYiqw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.547900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 7101977E711F6572C978A75AEFBA273048869700B88299001AA97A63FD86D9CC2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc2ea2c6-8bd3-4068-3ed0-08da54f38b62
X-MS-TrafficTypeDiagnostic: GV2PR10MB6187:EE_
X-Microsoft-Antispam-PRVS:
	<GV2PR10MB6187EFC8FA4A47BDD826526B95B59@GV2PR10MB6187.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	24vseZNuRvJ9hU6NPABSNs3XAw3BohAvGJKdLEvdt1IRTwgiw9fUYaPyBYKC0wpmYStyHsPMbmh+gJOQmSKqNsugXuDPagiwXBt4vtJioRp7hxlyPY6vMWXHR/xlqJuRxsXnjrREbKcN+Y96bVXrqLsqd3nk+SXxRsadfef6s2uo1ZywpjSWkBULXFBS6prVQe1+0mPLJ6UHmAIOzC4EfHooGCTNi8Oo92IUlCASfDYPqir4EoEmZxB4VvR4xLwwLV7OPocMja6AC1uoZKadracA8LsBflUm68PldZAmQw9geQNKo23+sV5pDAbVA8iryLxc4LOkpDBDECEXSHLDXeyLleT66goZAG4ko2ZALSObeeYj5XvyjK9j3hdRLjzd0ILuy3hMM1FESPDoBU6L+xP3OzRKpaYHM5ueDwQ/1uWhzdrrbfr65uFmae+BDAkrjIFKcMznx+ZdFt8o/xgVVwnmCN1lOg0OuOnq2IWlbAiYhKq4vKR0JheKqSH69UDbm+EJfDsnQez623INMRqG/AeNKQTFf4Ff8S+qguvriXJSKAUysGDHf5mUFyPnio2CBTbkScyHzytcyJi8uV2kNvZkjsDuh6MukfzuiK+GpIxvCUY1rNAEbTclNlFuXF7QForD6dIZNL0SDpHqktuZBASFUjWf6kfHDLFujvn9BiTzVwAWsyy79MkAV4B+AtLwyeyAjE/cJQOFY7Vv0JoIENOXyyx1+PTH8PIJE/EO/roMlXCdDbtHdsDUyHI490876B40FDI2pTUk0fOEsNESsBh7y+erNS+lXJ7AMFYZVke1s0pVn5t0bjcDEixPOdwv6EX6hvtpy56fbm+yYRYP/uV39VG5tQZDIDz0kAA/nH4=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(82960400001)(40480700001)(86362001)(186003)(16576012)(26005)(316002)(82740400003)(356005)(336012)(8936002)(956004)(36756003)(16526019)(478600001)(44832011)(2616005)(110136005)(6706004)(5660300002)(41300700001)(70586007)(82310400005)(31696002)(8676002)(47076005)(70206006)(53546011)(83380400001)(40460700003)(31686004)(2906002)(81166007)(36860700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:37:01.7979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ea2c6-8bd3-4068-3ed0-08da54f38b62
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT104.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6187

On 23.06.22 10:05, Mauro S. wrote:
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

Still wrapping and removing trailing whitespaces which are important for
patches.

Jan

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

-- 
Siemens AG, Technology
Competence Center Embedded Linux
