Received: from mta-out-02.tin.it (mta-out-02.tin.it [217.169.118.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A333C4
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1658501498; 
        bh=V+QcqQ9nxYt9TxbGzMiTmC6pHqWvV3anUE9HHKZS1tE=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=UCdFmx8XrgGR8SEaq6dRf76SjQKRPaR3iKVGZZ6yp7tUSrtyEYfp2PNSaDjRtYD+DP+tIDHnWadhP2K5t4uvvFaiX+k/1RH1TtBZTVG5xVLLzMFLswaFTPmWSM8Bxk+MYbwrQG/2YAGYhmrAdKnL5gakKKZ0jWybMflTdGPJrmwIegb5zitopvXXu3ODxr5Ptop1/Vc6lYH8Nhlg+uJAlfVUa7x8QpTByU/LkqcnRL7WpypJWz2oW/ag3xEgHpsqfXor0EYYco5wL4W0Omnb5lPz8bLToxI3anrIa8Kdig6nUz0kf/p7P6if++kkR9uFd5VOEgLoziZbFFQiNn3Deg==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtvddgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffosedttdertdertddtnecuhfhrohhmpeforghurhhoucfurghlvhhinhhiuceomhgruhdrshgrlhhvihesthhinhdrihhtqeenucggtffrrghtthgvrhhnpeejueekueffkeejjeeuffehvedtlefgffetgeffleehgedvieduleetjedugeefgfenucffohhmrghinheptghonhhfrdhinhenucfkphepleehrddvfeefrdejledrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlrghpthhophdqmhhsrghlvhhinhhirdhfrhhithiirdgsohigpdhinhgvthepleehrddvfeefrdejledrhedpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehmrghurdhsrghlvhhisehtihhnrdhithdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqleehqddvfeefqdejledqhedrrhgvthgrihhlrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghoihhppefkvfdpmhhtrghhohhstheprhgriihorhdqohhuthdqthhinhdqtddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from laptop-msalvini.fritz.box (95.233.79.5) by mta-out-02.tin.it (5.8.810) (authenticated as mau.salvi@tin.it)
        id 629DB85B055B1A9F; Fri, 22 Jul 2022 16:48:52 +0200
From: Mauro Salvini <mau.salvi@tin.it>
To: xenomai@lists.linux.dev
Cc: Mauro Salvini <mau.salvi@tin.it>
Subject: [PATCH] utils/net/rtnet: use NETMASK also with TDMA_CONFIG on master stations
Date: Fri, 22 Jul 2022 16:48:09 +0200
Message-Id: <20220722144809.18884-1-mau.salvi@tin.it>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

Before this change, on TDMA master stations using the TDMA_CONFIG file
the NETMASK parameter was not used and netmask was assigned automatically
by [rt]ifconfig (deriving from IP class of the address assigned to the station),
both on master and on slaves.
Instead, on TDMA master stations not using the TDMA_CONFIG file, the NETMASK
parameter specified in rtnet.conf was used both for master and slaves.
This commit uniforms the NETMASK usage between configurations with and without
TDMA_CONFIG file.

Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
---
 utils/net/rtnet.conf.in | 6 ++++--
 utils/net/rtnet.in      | 7 +++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/utils/net/rtnet.conf.in b/utils/net/rtnet.conf.in
index 12335d26e..6b542b8d6 100644
--- a/utils/net/rtnet.conf.in
+++ b/utils/net/rtnet.conf.in
@@ -27,9 +27,11 @@ RT_DRIVER_OPTIONS=""
 REBIND_RT_NICS=""
 
 # IP address and netmask of this station
-#   The TDMA_CONFIG file overrides these parameters for masters and backup
-#   masters. Leave blank if you do not use IP addresses or if this station is
+#   The TDMA_CONFIG file overrides the IPADDR parameter for masters.
+#   Leave blank if you do not use IP addresses or if this station is
 #   intended to retrieve its IP from the master based on its MAC address.
+#   If this station is a TDMA master, netmask is used also for slaves.
+#   If leaved blank, the default netmask for the IPADDR IP class will be used.
 IPADDR="10.0.0.1"
 NETMASK=""
 
diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
index 9b5f70440..a5c31ad40 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -78,7 +78,7 @@ init_rtnet() {
 submit_cfg() {
     case "$STATION_TYPE" in
 	master)
-	    $RTIFCONFIG rteth0 up "$STATION_IP"
+	    $RTIFCONFIG rteth0 up "$STATION_IP" $NETMASK_OPT
 
 	    if [ -n "$UPDELAY" ]; then
 		sleep "$UPDELAY"
@@ -88,7 +88,6 @@ submit_cfg() {
 	    eval "$TDMA_SLOTS"
 
 	    IPADDR=$STATION_IP
-	    NETMASK_OPT=
 	    ;;
 	slave)
 	    if [ ! "$STATION_IP" = "" ]; then
@@ -101,7 +100,7 @@ submit_cfg() {
 		RTCFG_CLIENT="$STATION_MAC"
 	    fi
 
-	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
+	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP $NETMASK_OPT"
 
 	    echo "$TDMA_SLOTS$ADD_STAGE1_CMDS" | \
 		$RTCFG rteth0 add "$RTCFG_CLIENT" -stage1 -
@@ -117,7 +116,7 @@ submit_cfg() {
 		RTCFG_CLIENT="$STATION_MAC"
 	    fi
 
-	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP"
+	    ADD_STAGE1_CMDS="ifconfig vnic0 up $STATION_IP $NETMASK_OPT"
 
 	    STAGE_2_OPT=
 	    if [ ! "$STATION_STAGE_2_SRC" = "" ]; then
-- 
2.17.1

