Message-ID: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
Date: Tue, 3 May 2022 10:22:42 +0200
MIME-Version: 1.0
Content-Language: it-IT
From: "Mauro S." <mau.salvi@tin.it>
Subject: [PATCH] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
---
  utils/net/rtnet.in | 76 +++++++++++++++++++++++-----------------------
  1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
index f81a7bb0a..06e796cd2 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -9,7 +9,7 @@ RTNETCFG="@sysconfdir@/rtnet.conf"

  debug_func() {
      echo "$*"
-    eval $*
+    eval "$*"
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

  	    echo "\$TDMACFG rteth0 detach;\$TDMACFG rteth0 master $TDMA_CYCLE 
-b $TDMA_BACKUP_OFFS;$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
-		$RTCFG rteth0 add $RTCFG_CLIENT -stage1 - $STAGE_2_OPT
+		$RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 - "$STAGE_2_OPT"
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
  	    echo "\$TDMACFG rteth0 slot 0 $OFFSET;ifconfig vnic0 up \$IPADDR 
\$NETMASK_OPT" | \
-		$RTCFG rteth0 add $SLAVE -stage1 - $STAGE_2_OPT
-	    OFFSET=$(($OFFSET+$TDMA_OFFSET))
+		$RTCFG rteth0 add "$SLAVE" -stage1 - "$STAGE_2_OPT"
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
@@ -233,13 +233,13 @@ start_master() {
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
+    echo "Waiting for all slaves..."
      $RTCFG rteth0 wait
      $RTCFG rteth0 ready
      echo
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
@@ -281,20 +281,20 @@ case "$1" in
      start)
  	init_rtnet

-	if [ $TDMA_MODE = "master" ]; then
+	if [ "$TDMA_MODE" = "master" ]; then
  	    start_master
  	else
  	    $TDMACFG rteth0 slave

-	    $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
+	    $RTIFCONFIG rteth0 up "$IPADDR" "$NETMASK_OPT"

-	    echo -n "Stage 1: searching for master..."
-	    eval "`$RTCFG rteth0 client -c`"
+	    echo "Stage 1: searching for master..."
+	    eval "$($RTCFG rteth0 client -c)"
  	    echo

-	    echo -n "Stage 2: waiting for other slaves..."
+	    echo "Stage 2: waiting for other slaves..."
  	    if [ ! "$STAGE_2_DST" = "" ]; then
-		$RTCFG rteth0 announce -f $STAGE_2_DST
+		$RTCFG rteth0 announce -f "$STAGE_2_DST"
  		echo
  		eval "$STAGE_2_CMDS"
  	    else
@@ -302,7 +302,7 @@ case "$1" in
  		echo
  	    fi

-	    echo -n "Stage 3: waiting for common setup completion..."
+	    echo "Stage 3: waiting for common setup completion..."
  	    $RTCFG rteth0 ready
  	    echo
  	fi
@@ -317,10 +317,10 @@ case "$1" in
  	$RTIFCONFIG rteth0 down 2>/dev/null
  	$RTIFCONFIG rtlo down 2>/dev/null

-	rmmod tdma rtmac rtcfg rtcap rt_loopback $RT_DRIVER rtpacket rtudp 
rttcp rtipv4 rtnet 2>/dev/null
+	rmmod tdma rtmac rtcfg rtcap rt_loopback "$RT_DRIVER" rtpacket rtudp 
rttcp rtipv4 rtnet 2>/dev/null

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


