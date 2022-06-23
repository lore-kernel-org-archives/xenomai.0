Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C71874
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1655974142; 
        bh=LXAQLgOnXCOzpX05JnL1YaBmxeiAxQMuJUJaUdFhezc=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Io5p+tMIFvp2WCIBdbiR+PB51E2mJdpApUG68h0Y8fNk+CWD0kJWUxNbuP4Ghu5IlveV45h0M15IZhXylyJPQsJfSwmFbahitG/LQsQyP+qxngv8x9Ys6fS0LZP3+v2VRDzk5mXhEDcy4Swjw0QnG/CaNa3KwoYNbgF/luN6JUr1sQ6cPDDrAj957dERiUprAQ6hELn58u+nu88okia8fCGi/TGbqLR0yrDr/bTg92Crq/4Fmq/m+/CMjwQZM+S2FVFdxi4HtiDmrARrfWhJ0/S80ci2LGKq1Gbk++fNZ3z7d6ppy1k4+cb0LyzSCc175HyrNFccD1/4PAqKFUuvMQ==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhevhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpedfofgruhhrohcuufdrfdcuoehmrghurdhsrghlvhhisehtihhnrdhitheqnecuggftrfgrthhtvghrnhepgeduheeugfehhfelffekfeefvdeiveelieffiefgleevjefhvddvheejheevveetnecukfhppeejledrfedurddviedrfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddujeekrdeftdgnpdhinhgvthepjeelrdefuddrvdeirdeftddpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqjeelqdefuddqvdeiqdeftddrrhgvthgrihhlrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghoihhppefkvfdpmhhtrghhohhstheprhgriihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.178.30] (79.31.26.30) by mta-out-01.tin.it (5.8.810) (authenticated as mau.salvi@tin.it)
        id 629738CA02CB1BE2; Thu, 23 Jun 2022 10:49:00 +0200
Message-ID: <86d5b170-dedf-000f-5f23-31bbf9145fd2@tin.it>
Date: Thu, 23 Jun 2022 10:48:58 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v3] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Language: it-IT
To: xenomai@lists.linux.dev
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <aacf04e4-91e3-6232-5b1d-c6570ef6e3f4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Remaining shellcheck warnings:
- "SC2086: Double quote to prevent globbing and word splitting."
   line 120, 153, 289 (variables STAGE_2_OPT and NETMASK_OPT)
   Suggested fix not applicable because these variables can be empty,
   resulting in command failure due to "" in command line
- "SC2153: Possible misspelling: STAGE_2_DST may not be assigned, but STAGE_2_OPT is."
   line 296. STAGE_2_DST comes from included RTNETCFG file

Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
---
  utils/net/rtnet.in | 86 +++++++++++++++++++++++-----------------------
  1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
index f81a7bb0a..cd24017b4 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -9,7 +9,7 @@ RTNETCFG="@sysconfdir@/rtnet.conf"
  
  debug_func() {
      echo "$*"
-    eval $*
+    eval "$@"
  }
  
  usage() {
@@ -33,35 +33,35 @@ EOF
  init_rtnet() {
      modprobe rtnet >/dev/null || exit 1
      modprobe rtipv4 >/dev/null || exit 1
-    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
+    modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
  
      for dev in $REBIND_RT_NICS; do
-	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
-	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
+	if [ -d /sys/bus/pci/devices/"$dev"/driver ]; then
+	    echo "$dev" > /sys/bus/pci/devices/"$dev"/driver/unbind
  	fi
-	echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
+	echo "$dev" > /sys/bus/pci/drivers/"$RT_DRIVER"/bind
      done
  
      for PROTOCOL in $RT_PROTOCOLS; do
-	modprobe rt$PROTOCOL >/dev/null || exit 1
+	modprobe rt"$PROTOCOL" >/dev/null || exit 1
      done
  
-    if [ $RT_LOOPBACK = "yes" ]; then
+    if [ "$RT_LOOPBACK" = "yes" ]; then
  	modprobe rt_loopback >/dev/null || exit 1
      fi
  
-    if [ $RTCAP = "yes" ]; then
+    if [ "$RTCAP" = "yes" ]; then
  	modprobe rtcap >/dev/null || exit 1
      fi
  
-    if [ $RT_LOOPBACK = "yes" ]; then
+    if [ "$RT_LOOPBACK" = "yes" ]; then
  	$RTIFCONFIG rtlo up 127.0.0.1
      fi
  
-    if [ $RTCAP = "yes" ]; then
+    if [ "$RTCAP" = "yes" ]; then
  	ifconfig rteth0 up
  	ifconfig rteth0-mac up
-	if [ $RT_LOOPBACK = "yes" ]; then
+	if [ "$RT_LOOPBACK" = "yes" ]; then
  	    ifconfig rtlo up
  	fi
      fi
@@ -74,9 +74,9 @@ init_rtnet() {
  submit_cfg() {
      case "$STATION_TYPE" in
  	master)
-	    $RTIFCONFIG rteth0 up $STATION_IP
+	    $RTIFCONFIG rteth0 up "$STATION_IP"
  
-	    $TDMACFG rteth0 master $TDMA_CYCLE
+	    $TDMACFG rteth0 master "$TDMA_CYCLE"
  	    eval "$TDMA_SLOTS"
  
  	    IPADDR=$STATION_IP
@@ -96,7 +96,7 @@ submit_cfg() {
  	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
  
  	    echo "$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
-		$RTCFG rteth0 add $RTCFG_CLIENT -stage1 -
+		$RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 -
  	    ;;
  	backup-master)
  	    if [ ! "$STATION_IP" = "" ]; then
@@ -117,7 +117,7 @@ submit_cfg() {
  	    fi
  
  	    echo "\$TDMACFG rteth0 detach;\$TDMACFG rteth0 master $TDMA_CYCLE -b $TDMA_BACKUP_OFFS;$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
-		$RTCFG rteth0 add $RTCFG_CLIENT -stage1 - $STAGE_2_OPT
+		$RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 - $STAGE_2_OPT
  	    ;;
      esac
  
@@ -142,16 +142,16 @@ start_master() {
  	#   Sync / Master Slot / + TDMA_OFFSET us / Slave 1 /
  	#   + TDMA_OFFSET us / Slave 2 / + TDMA_OFFSET us / ... / Slave n
  
-	$RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
+	$RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
  
-	$TDMACFG rteth0 master $TDMA_CYCLE
+	$TDMACFG rteth0 master "$TDMA_CYCLE"
  	$TDMACFG rteth0 slot 0 0
  
  	OFFSET=$TDMA_OFFSET
  	for SLAVE in $TDMA_SLAVES; do
  	    echo "\$TDMACFG rteth0 slot 0 $OFFSET;ifconfig vnic0 up \$IPADDR \$NETMASK_OPT" | \
-		$RTCFG rteth0 add $SLAVE -stage1 - $STAGE_2_OPT
-	    OFFSET=$(($OFFSET+$TDMA_OFFSET))
+		$RTCFG rteth0 add "$SLAVE" -stage1 - $STAGE_2_OPT
+	    OFFSET=$((OFFSET+TDMA_OFFSET))
  	done
      else
  	# Get setup from TDMA_CONFIG file:
@@ -185,12 +185,12 @@ start_master() {
  	# slot ...
  	#
  
-	if [ ! -r $TDMA_CONFIG ]; then
+	if [ ! -r "$TDMA_CONFIG" ]; then
  	    echo "Could not read $TDMA_CONFIG"
  	    exit 1
  	fi
  
-	while read ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
+	while read -r ARG1 ARG2 ARG3 ARG4 ARG5 ARG6; do
  	    case "$ARG1" in
  		"master:")
  		    submit_cfg
@@ -217,7 +217,7 @@ start_master() {
  		    STATION_MAC="$ARG2"
  		    ;;
  		"stage2")
-		    STATION_STAGE_2="$ARG2"
+		    STATION_STAGE_2_SRC="$ARG2"
  		    ;;
  		"slot")
  		    TDMA_SLOTS="$TDMA_SLOTS\$TDMACFG rteth0 slot $ARG2 $ARG3"
@@ -233,16 +233,16 @@ start_master() {
  		    TDMA_SLOTS="$TDMA_SLOTS;"
  		    ;;
  	    esac
-	done < $TDMA_CONFIG
+	done < "$TDMA_CONFIG"
  	submit_cfg
      fi
  
-    ifconfig vnic0 up $IPADDR $NETMASK_OPT
+    ifconfig vnic0 up "$IPADDR" $NETMASK_OPT
  
-    echo -n "Waiting for all slaves..."
+    printf "Waiting for all slaves..."
      $RTCFG rteth0 wait
      $RTCFG rteth0 ready
-    echo
+    printf "\n"
  }
  
  
@@ -251,8 +251,8 @@ if [ "$1" = "-cf" ]; then
      shift 2
  fi
  
-if [ -r $RTNETCFG ]; then
-    . $RTNETCFG
+if [ -r "$RTNETCFG" ]; then
+    . "$RTNETCFG"
  else
      echo "Could not read $RTNETCFG"
      exit 1
@@ -281,30 +281,30 @@ case "$1" in
      start)
  	init_rtnet
  
-	if [ $TDMA_MODE = "master" ]; then
+	if [ "$TDMA_MODE" = "master" ]; then
  	    start_master
  	else
  	    $TDMACFG rteth0 slave
  
-	    $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
+	    $RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
  
-	    echo -n "Stage 1: searching for master..."
-	    eval "`$RTCFG rteth0 client -c`"
-	    echo
+	    printf "Stage 1: searching for master..."
+	    eval "$($RTCFG rteth0 client -c)"
+	    printf "\n"
  
-	    echo -n "Stage 2: waiting for other slaves..."
+	    printf "Stage 2: waiting for other slaves..."
  	    if [ ! "$STAGE_2_DST" = "" ]; then
-		$RTCFG rteth0 announce -f $STAGE_2_DST
-		echo
+		$RTCFG rteth0 announce -f "$STAGE_2_DST"
+		printf "\n"
  		eval "$STAGE_2_CMDS"
  	    else
  		$RTCFG rteth0 announce
-		echo
+		printf "\n"
  	    fi
  
-	    echo -n "Stage 3: waiting for common setup completion..."
+	    printf "Stage 3: waiting for common setup completion..."
  	    $RTCFG rteth0 ready
-	    echo
+	    printf "\n"
  	fi
  	;;
  
@@ -317,10 +317,10 @@ case "$1" in
  	$RTIFCONFIG rteth0 down 2>/dev/null
  	$RTIFCONFIG rtlo down 2>/dev/null
  
-	rmmod tdma rtmac rtcfg rtcap rt_loopback $RT_DRIVER rtpacket rtudp rttcp rtipv4 rtnet 2>/dev/null
+	rmmod tdma rtmac rtcfg rtcap rt_loopback "$RT_DRIVER" rtpacket rtudp rttcp rtipv4 rtnet 2>/dev/null
  
  	for dev in $REBIND_RT_NICS; do
-	    echo 1 > /sys/bus/pci/devices/$dev/remove
+	    echo 1 > /sys/bus/pci/devices/"$dev"/remove
  	done
  	if [ ! "$REBIND_RT_NICS" = "" ]; then
  	    sleep 1
@@ -337,7 +337,7 @@ case "$1" in
  
      capture)
  	modprobe rtnet >/dev/null || exit 1
-	modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
+	modprobe "$RT_DRIVER" "$RT_DRIVER_OPTIONS" >/dev/null || exit 1
  	modprobe rtcap >/dev/null || exit 1
  	$RTIFCONFIG rteth0 up promisc
  	ifconfig rteth0 up
@@ -349,7 +349,7 @@ case "$1" in
  	modprobe rtipv4 >/dev/null || exit 1
  
  	for PROTOCOL in $RT_PROTOCOLS; do
-	    modprobe rt$PROTOCOL >/dev/null || exit 1
+	    modprobe rt"$PROTOCOL" >/dev/null || exit 1
  	done
  
  	modprobe rt_loopback >/dev/null || exit 1
-- 
2.17.1
