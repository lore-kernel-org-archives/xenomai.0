Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2143E6
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 07:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClVMiSdrr+VzlJn/SqDMjTcgQ7P7C9BWYv/1CnDRSwT9qpcvK2nqb9OJ+MJxQ9FUmqONiRb2GzFpoXRK+ufVZMtVPsZq/27CuqrRN/70Q93o2boSkqQqtFkkITVxzbAYCEIfxaE/7nvhqS+SWf4RWSlS2oExQcvG+I0mM3uNH3mk5PMFJJgm0TGln7lNZyPH4+A5pOeQ+auCZ8Y3wuUiU+pqJY1abBmaaUiULCWARmV3uT9VsuiAwdkGHxY8RAqVItMs9SmUkvjT9ePj2rK7NVVjDlxKBZ4jPFXzHY5ZfrBQy0wKvJQRW3zos5NAG72E5S/JNQTJhth3JATSQQMJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0D131U1PXmUB5sD+sWS+ooFKLmMnffoFcSs++NUllw=;
 b=E8mMPb+Vz5TX2vY2UZ7DcBlgqzY4bf5LHY6ITJH7f3SaHnkr6+flsxtvJwyzdIBAE+k4BTLxZzUoUY4Dh9Vx9AekJtQETcUc6yi9DqsKxqDljV5v07aAyo7TRw31/tWQDarA9ab6uY6Qz2TGCgKuUUnP73Z+youWWpKWQOUqvCKpDcpL1QlOTQULH/cMX4cRBhhly55jFiVgkTj4WzNOlUi3x6qw90ybVTMW8H63L8dL/DtCZ1SaqPb5SsxhY3hiaTL1cq6YgB5Zw+vzUUOF0MRU6+2C1m8mdCLvMhvgW1+1NGHJlnYPvswSGzAgd9WkgaIqUy4qyi/xEpRxDREjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0D131U1PXmUB5sD+sWS+ooFKLmMnffoFcSs++NUllw=;
 b=R7C5GxIessmNguPJ707QEMY/8E8vYJPKEjg7X7G5z0rnf+5TojLmeOr36L+o9UpcbAR9VMrBnwcMHL8vn+gv8Znew+Ull3DztI+PpuietcnuAPfNl1pMB4lxK/5ymgMzVsdCBAX8c4tM/0BVCIStjcizGkDiK2pfEaxhhqoYvCbcJ3OzP672kNiLF3/sBpobN4tR5u1xEeJQjGb44bFHGw7aNgWd5mFLkmaYgj9ErsZf/HZILZW4lVLEfwUZ9DDHdhCp4W029bI5dZyamNYDdQTxjq58io+v7S4ZrO5Y5mhffq2LGqsaeKPn5SVwMDJoEVGq+AmoVkXJYeLT3XzxNA==
Received: from DBBPR09CA0046.eurprd09.prod.outlook.com (2603:10a6:10:d4::34)
 by VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 07:46:44 +0000
Received: from DB5EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::3f) by DBBPR09CA0046.outlook.office365.com
 (2603:10a6:10:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 07:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT011.mail.protection.outlook.com (10.152.5.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 07:46:43 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 23 Jun 2022 09:46:43 +0200
Received: from [167.87.6.167] (167.87.6.167) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 23 Jun
 2022 09:46:42 +0200
Message-ID: <868172c1-7a1f-9a3a-2a3b-55a12aa73958@siemens.com>
Date: Thu, 23 Jun 2022 09:46:41 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7556be30-4977-143c-f341-cdf1074bf4a3@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.6.167]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.510900-8.000000
X-TMASE-MatchedRID: aZnThng3P7X4AkTW3FFRihr3Sp02t5CNPg9yfk4YC0aLdOs6EBREoauV
	OrDvB8LTzP9LEqj2Yni/PA740bxeAOJ/HqdNag5SvQO/TBZr4U1vGmUAc+i/uj8Ckw9b/GFeVBD
	QSDMig9E2/UwdvFG5IhUsYg9U/g5BNk1GcmpNXFJk1/zd/XzAp5RHynoondMaLyz9QvAyHjqC7C
	2rJeUToV3tdA/z3A6IsFe531Fr7DQzhXE6c0L0dxjC8NJMIbYEPaLblkTDWBSqFx2c/3V5cY6ES
	GgCXvgoJLfQYoCQHFZNrM2nGOywxLZHJ3kIMPxN/OSi0StnSYFkyAgx70OF3BIRh9wkXSlFCvuK
	RmWUWvS3CLdtdG1oCIjndkVu1lPuJFsX99TsuxTvBBHhCihMro5dVuh2ywvhXmFVlObh0PxBfkJ
	WKY0KaQrVgpI9tRVko8WMkQWv6iWhMIDkR/KfwI2j49Ftap9EOwBXM346/+yXtUigHnn7GiU7pI
	jqFxO7WpCPTqJmAIX+GDKQaYCQbn48nFPdcgol
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.510900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 546C7C87C1FC28DFD182D643353B10007B72B963DFFD639210B6E1345C354B3B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac31ab3-8bc5-47e1-58c0-08da54ec8478
X-MS-TrafficTypeDiagnostic: VE1PR10MB3887:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR10MB3887B8A8D987D7B252840DFB95B59@VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xsSD48oIWOTrg/SvXCvoFerFcOu8QBeo0Dg71j2+0hYUwoLKYDQcZlTJP9HKlGJbObnac7/4iSDVWMMhPokfPBXOagBTv8346AGTVezpj748Us4s+rSaWMrPcgpr67zmNELkZfdLd7E0U1uQlkOqolgSzvRidAbZtT0Ex/9Pj/bmZCvSF9eSsWXNC2hYjJ6LvXa6qRcdznnpSahnNaqGymrtOE3Jnk+7RAwUcSvQsypmD3VhiHOm+nvQVxpUH6Sj5+RRvuakNCHfLJin+rNVYJhkaHy5yWXVq8WTFIMdMOthE3WREX0WbLb8BK06zwDTZ33pIe1F1EsCPBp8/jV2nhpY5sqyYGJgNoi4+sbExhQr0Vm9yokydpGQ1Old+bsJxwoC6o3ZNEPodf+gVfXwEli71zUWyqK67rEo/8BoO8BVdgQWbjcVC8Upvibi3bvzcO4tMzLbcsiutBljj32bE0x/WY6RTg9UpbU6kv9SOEZr72KKuJNY81VVk3YoasNw8G7Y+8T0AfPKyq8TUovuSpnNaoDIvJCkK/RdHOZklbp4QB3gOr+fUjzjimFpUDZmJyBEfGHop1wqPpM1w2HL1mqEtt1l/v4HIdKp5cIazIxfJdliKiskGlihQV/QSjroGlAejcntDwWxuk+xhEA6YtWfuc198HtPOxdzK7rjv9gLcvDMNlxY2m2+Cut5o/mP6Iprm6X8JKmr6mLVH7Q48mz/RFpbvtR0rtPFnq6vp++YtgclfnvA8B9p9CzJd76f4YvUpZ1QmGyRWx7bEDpaV6TrSUhf2Bm3qotvDgGattE5hATvrpHznMgTL4ZQVlqX2FZuReYDliKSbt28bc7yGI/jFEC8364QYBNEXHBrz/s=
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(46966006)(36840700001)(41300700001)(81166007)(336012)(2616005)(82960400001)(956004)(26005)(6706004)(36860700001)(16576012)(186003)(356005)(16526019)(47076005)(53546011)(31696002)(83380400001)(82740400003)(82310400005)(31686004)(70586007)(40480700001)(86362001)(36756003)(44832011)(5660300002)(8676002)(40460700003)(2906002)(478600001)(316002)(110136005)(8936002)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:46:43.7216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac31ab3-8bc5-47e1-58c0-08da54ec8478
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3887

On 23.06.22 08:37, Mauro S. wrote:
> Il 12/05/22 09:00, Mauro S. via Xenomai ha scritto:
>> Remaning shellcheck warnings:
>> - "SC2086: Double quote to prevent globbing and word splitting."
>>    line 120, 153, 289 (variables STAGE_2_OPT and NETMASK_OPT)
>>    Suggested fix not applicable because these variables can be empty,
>>    resulting in command failure due to "" in command line
>> - "SC2153: Possible misspelling: STAGE_2_DST may not be assigned, but
>> STAGE_2_OPT is."
>>    line 296. STAGE_2_DST comes from included RTNETCFG file
>>
>> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
>> ---
>>   utils/net/rtnet.in | 86 +++++++++++++++++++++++-----------------------
>>   1 file changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
>> index f81a7bb0a..cd24017b4 100644
>> --- a/utils/net/rtnet.in
>> +++ b/utils/net/rtnet.in
>> @@ -9,7 +9,7 @@ RTNETCFG="@sysconfdir@/rtnet.conf"
>>
>>   debug_func() {
>>       echo "$*"
>> -    eval $*
>> +    eval "$@"
>>   }
>>
>>   usage() {
>> @@ -33,35 +33,35 @@ EOF
>>   init_rtnet() {
>>       modprobe rtnet >/dev/null || exit 1
>>       modprobe rtipv4 >/dev/null || exit 1
>> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> +    modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
>>
>>       for dev in $REBIND_RT_NICS; do
>> -    if [ -d /sys/bus/pci/devices/$dev/driver ]; then
>> -        echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
>> +    if [ -d /sys/bus/pci/devices/"$dev"/driver ]; then
>> +        echo "$dev" > /sys/bus/pci/devices/"$dev"/driver/unbind
>>       fi
>> -    echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
>> +    echo "$dev" > /sys/bus/pci/drivers/"$RT_DRIVER"/bind
>>       done
>>
>>       for PROTOCOL in $RT_PROTOCOLS; do
>> -    modprobe rt$PROTOCOL >/dev/null || exit 1
>> +    modprobe rt"$PROTOCOL" >/dev/null || exit 1
>>       done
>>
>> -    if [ $RT_LOOPBACK = "yes" ]; then
>> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>>       modprobe rt_loopback >/dev/null || exit 1
>>       fi
>>
>> -    if [ $RTCAP = "yes" ]; then
>> +    if [ "$RTCAP" = "yes" ]; then
>>       modprobe rtcap >/dev/null || exit 1
>>       fi
>>
>> -    if [ $RT_LOOPBACK = "yes" ]; then
>> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>>       $RTIFCONFIG rtlo up 127.0.0.1
>>       fi
>>
>> -    if [ $RTCAP = "yes" ]; then
>> +    if [ "$RTCAP" = "yes" ]; then
>>       ifconfig rteth0 up
>>       ifconfig rteth0-mac up
>> -    if [ $RT_LOOPBACK = "yes" ]; then
>> +    if [ "$RT_LOOPBACK" = "yes" ]; then
>>           ifconfig rtlo up
>>       fi
>>       fi
>> @@ -74,9 +74,9 @@ init_rtnet() {
>>   submit_cfg() {
>>       case "$STATION_TYPE" in
>>       master)
>> -        $RTIFCONFIG rteth0 up $STATION_IP
>> +        $RTIFCONFIG rteth0 up "$STATION_IP"
>>
>> -        $TDMACFG rteth0 master $TDMA_CYCLE
>> +        $TDMACFG rteth0 master "$TDMA_CYCLE"
>>           eval "$TDMA_SLOTS"
>>
>>           IPADDR=$STATION_IP
>> @@ -96,7 +96,7 @@ submit_cfg() {
>>           ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
>>
>>           echo "$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
>> -        $RTCFG rteth0 add $RTCFG_CLIENT -stage1 -
>> +        $RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 -
>>           ;;
>>       backup-master)
>>           if [ ! "$STATION_IP" = "" ]; then
>> @@ -117,7 +117,7 @@ submit_cfg() {
>>           fi
>>
>>           echo "\$TDMACFG rteth0 detach;\$TDMACFG rteth0 master
>> $TDMA_CYCLE -b $TDMA_BACKUP_OFFS;$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
>> -        $RTCFG rteth0 add $RTCFG_CLIENT -stage1 - $STAGE_2_OPT
>> +        $RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 - $STAGE_2_OPT
>>           ;;
>>       esac
>>
>> @@ -142,16 +142,16 @@ start_master() {
>>       #   Sync / Master Slot / + TDMA_OFFSET us / Slave 1 /
>>       #   + TDMA_OFFSET us / Slave 2 / + TDMA_OFFSET us / ... / Slave n
>>
>> -    $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
>> +    $RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
>>
>> -    $TDMACFG rteth0 master $TDMA_CYCLE
>> +    $TDMACFG rteth0 master "$TDMA_CYCLE"
>>       $TDMACFG rteth0 slot 0 0
>>
>>       OFFSET=$TDMA_OFFSET
>>       for SLAVE in $TDMA_SLAVES; do
>>           echo "\$TDMACFG rteth0 slot 0 $OFFSET;ifconfig vnic0 up
>> \$IPADDR \$NETMASK_OPT" | \
>> -        $RTCFG rteth0 add $SLAVE -stage1 - $STAGE_2_OPT
>> -        OFFSET=$(($OFFSET+$TDMA_OFFSET))
>> +        $RTCFG rteth0 add "$SLAVE" -stage1 - $STAGE_2_OPT
>> +        OFFSET=$((OFFSET+TDMA_OFFSET))
>>       done
>>       else
>>       # Get setup from TDMA_CONFIG file:
>> @@ -185,12 +185,12 @@ start_master() {
>>       # slot ...
>>       #
>>
>> -    if [ ! -r $TDMA_CONFIG ]; then
>> +    if [ ! -r "$TDMA_CONFIG" ]; then
>>           echo "Could not read $TDMA_CONFIG"
>>           exit 1
>>       fi
>>
>> -    while read ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
>> +    while read -r ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
>>           case "$ARG1" in
>>           "master:")
>>               submit_cfg
>> @@ -217,7 +217,7 @@ start_master() {
>>               STATION_MAC="$ARG2"
>>               ;;
>>           "stage2")
>> -            STATION_STAGE_2="$ARG2"
>> +            STATION_STAGE_2_SRC="$ARG2"
>>               ;;
>>           "slot")
>>               TDMA_SLOTS="$TDMA_SLOTS\$TDMACFG rteth0 slot $ARG2 $ARG3"
>> @@ -233,16 +233,16 @@ start_master() {
>>               TDMA_SLOTS="$TDMA_SLOTS;"
>>               ;;
>>           esac
>> -    done < $TDMA_CONFIG
>> +    done < "$TDMA_CONFIG"
>>       submit_cfg
>>       fi
>>
>> -    ifconfig vnic0 up $IPADDR $NETMASK_OPT
>> +    ifconfig vnic0 up "$IPADDR" $NETMASK_OPT
>>
>> -    echo -n "Waiting for all slaves..."
>> +    printf "Waiting for all slaves..."
>>       $RTCFG rteth0 wait
>>       $RTCFG rteth0 ready
>> -    echo
>> +    printf "\n"
>>   }
>>
>>
>> @@ -251,8 +251,8 @@ if [ "$1" = "-cf" ]; then
>>       shift 2
>>   fi
>>
>> -if [ -r $RTNETCFG ]; then
>> -    . $RTNETCFG
>> +if [ -r "$RTNETCFG" ]; then
>> +    . "$RTNETCFG"
>>   else
>>       echo "Could not read $RTNETCFG"
>>       exit 1
>> @@ -281,30 +281,30 @@ case "$1" in
>>       start)
>>       init_rtnet
>>
>> -    if [ $TDMA_MODE = "master" ]; then
>> +    if [ "$TDMA_MODE" = "master" ]; then
>>           start_master
>>       else
>>           $TDMACFG rteth0 slave
>>
>> -        $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
>> +        $RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
>>
>> -        echo -n "Stage 1: searching for master..."
>> -        eval "`$RTCFG rteth0 client -c`"
>> -        echo
>> +        printf "Stage 1: searching for master..."
>> +        eval "$($RTCFG rteth0 client -c)"
>> +        printf "\n"
>>
>> -        echo -n "Stage 2: waiting for other slaves..."
>> +        printf "Stage 2: waiting for other slaves..."
>>           if [ ! "$STAGE_2_DST" = "" ]; then
>> -        $RTCFG rteth0 announce -f $STAGE_2_DST
>> -        echo
>> +        $RTCFG rteth0 announce -f "$STAGE_2_DST"
>> +        printf "\n"
>>           eval "$STAGE_2_CMDS"
>>           else
>>           $RTCFG rteth0 announce
>> -        echo
>> +        printf "\n"
>>           fi
>>
>> -        echo -n "Stage 3: waiting for common setup completion..."
>> +        printf "Stage 3: waiting for common setup completion..."
>>           $RTCFG rteth0 ready
>> -        echo
>> +        printf "\n"
>>       fi
>>       ;;
>>
>> @@ -317,10 +317,10 @@ case "$1" in
>>       $RTIFCONFIG rteth0 down 2>/dev/null
>>       $RTIFCONFIG rtlo down 2>/dev/null
>>
>> -    rmmod tdma rtmac rtcfg rtcap rt_loopback $RT_DRIVER rtpacket
>> rtudp rttcp rtipv4 rtnet 2>/dev/null
>> +    rmmod tdma rtmac rtcfg rtcap rt_loopback "$RT_DRIVER" rtpacket
>> rtudp rttcp rtipv4 rtnet 2>/dev/null
>>
>>       for dev in $REBIND_RT_NICS; do
>> -        echo 1 > /sys/bus/pci/devices/$dev/remove
>> +        echo 1 > /sys/bus/pci/devices/"$dev"/remove
>>       done
>>       if [ ! "$REBIND_RT_NICS" = "" ]; then
>>           sleep 1
>> @@ -337,7 +337,7 @@ case "$1" in
>>
>>       capture)
>>       modprobe rtnet >/dev/null || exit 1
>> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> +    modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
>>       modprobe rtcap >/dev/null || exit 1
>>       $RTIFCONFIG rteth0 up promisc
>>       ifconfig rteth0 up
>> @@ -349,7 +349,7 @@ case "$1" in
>>       modprobe rtipv4 >/dev/null || exit 1
>>
>>       for PROTOCOL in $RT_PROTOCOLS; do
>> -        modprobe rt$PROTOCOL >/dev/null || exit 1
>> +        modprobe rt"$PROTOCOL" >/dev/null || exit 1
>>       done
>>
>>       modprobe rt_loopback >/dev/null || exit 1
> 
> Hi all,
> 
> kind ping.
> 
> Thakns, regards
> 

Thanks for the reminder, fell through the cracks.

But patch looks mangled. Could you resent in plain-text or via git
send-email?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
