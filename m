Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608F1C31
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1655987832; 
        bh=xJYR7vNYnEISTT9UekOV6TdGZ+sBoP7PhqkAp/wRcgI=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=TKmFLrSUtz/gVvNAeXzDW8xIF5WMNaK6NXjxRLFpgW5tGF2JLKpzd5d/79xCOkD4rdcDLEQ+4i/XV6k+2Q0Orrr769tqCoLWgDHWzgx5tu8V3+SYSxYZuQ3h+An6IqOzawFORIGzOZouShLKf8Vl7HXEgftMeST/dCIypuvCLd5dPS1n1i3+0BEsP6XaZ5OraSNCs1i1kmcH8Vrw8KVx8j5rwOahpJPxLMDprKSEgssZzN5tDxLDg8bD+A8UNiTiGfuLpHxKLhc8sE+SVbQuV4h1sBKANsb4VIMyBr3QnA+z4si30pFTKJUx9cZ7Dt+r9gJJ4dFCwd5fQePVq0PANA==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffosedttdertdertddtnecuhfhrohhmpeforghurhhoucfurghlvhhinhhiuceomhgruhdrshgrlhhvihesthhinhdrihhtqeenucggtffrrghtthgvrhhnpeetteelheevgfekjeetgfeiveehkeetgeetkeettdevudeuffevgfeiudffjeelleenucfkphepjeelrdefuddrvdeirdeftdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlrghpthhophdqmhhsrghlvhhinhhirdhfrhhithiirdgsohigpdhinhgvthepjeelrdefuddrvdeirdeftddpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehmrghurdhsrghlvhhisehtihhnrdhithdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqjeelqdefuddqvdeiqdeftddrrhgvthgrihhlrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghoihhppefkvfdpmhhtrghhohhstheprhgriihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from laptop-msalvini.fritz.box (79.31.26.30) by mta-out-01.tin.it (5.8.810) (authenticated as mau.salvi@tin.it)
        id 629738CA02D0FB68; Thu, 23 Jun 2022 14:37:09 +0200
From: Mauro Salvini <mau.salvi@tin.it>
To: xenomai@lists.linux.dev
Cc: Mauro Salvini <mau.salvi@tin.it>
Subject: [PATCH] utils/net/rtnet.in: add delay during master configuration
Date: Thu, 23 Jun 2022 14:36:47 +0200
Message-Id: <20220623123647.29418-1-mau.salvi@tin.it>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

Some cards are slow to get the connection link up after the
"rtifconfig rteth0 up" command, e.g. on an Atom-x5 with an Intel I210
(rt_igb driver) I detected approximately 3 seconds to get the link up.

On master, the "rtifconfig rteth0 up" is followed by TDMA configuration and
start. After the TDMA start, the sync packet is sent at the defined cycle time.

Sometimes, after "rtnet start", the dmesg fills with this error:

  TDMA: Failed to transmit sync frame!

and the rt driver locks. Then, the kernel watchdog is triggered and the
NIC is hw-reset by the kernel, producing more errors and another lock.
Sometimes the dmesg only fills with the error message and the NIC does
not lock.
This happens because the interface is not up and ready to handle
the sync packets when TDMA is started.

This patch introduces a configurable delay between the "rtifconfig rteth0 up"
and the TDMA start on master host. This allows to avoid these kind of problems.

Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
---
 utils/net/rtnet.in | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
index cd24017b4..9b5f70440 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -15,15 +15,19 @@ debug_func() {
 usage() {
     cat << EOF
 Usage:
-    $0 [-cf <config-file>] [-v] [-c] {start|stop}
+    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] {start|stop}
 	Start or stop station according to configuration file
 
-    $0 [-cf <config-file>] [-v] [-c] master <slave_ip1> [<slave_ip2> ...]
+    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] master <slave_ip1> [<slave_ip2> ...]
 	Start station as master for given list of slaves
 
     $0 [-cf <config-file>] [-v] capture
 	Start only passive realtime capturing
 
+    The parameter -d allows to introduce a delay in seconds between the
+	"rtifconfig rtethX up" command and the TDMA start on the host
+	configured as master. Useful to avoid errors/card locks when the
+	RT NIC is slow to get the link up.
     The additional switch -v enables verbose output.
     The additional switch -c enables capturing mode to allow use of a network
 	analyzer such as Wireshark (if rtnet was built with --enable-rtcap).
@@ -76,6 +80,10 @@ submit_cfg() {
 	master)
 	    $RTIFCONFIG rteth0 up "$STATION_IP"
 
+	    if [ -n "$UPDELAY" ]; then
+		sleep "$UPDELAY"
+	    fi
+
 	    $TDMACFG rteth0 master "$TDMA_CYCLE"
 	    eval "$TDMA_SLOTS"
 
@@ -144,6 +152,10 @@ start_master() {
 
 	$RTIFCONFIG rteth0 up "$IPADDR" $NETMASK_OPT
 
+	if [ -n "$UPDELAY" ]; then
+	    sleep "$UPDELAY"
+	fi
+
 	$TDMACFG rteth0 master "$TDMA_CYCLE"
 	$TDMACFG rteth0 slot 0 0
 
@@ -258,6 +270,11 @@ else
     exit 1
 fi
 
+if [ "$1" = "-d" ]; then
+    UPDELAY="$2"
+    shift 2
+fi
+
 if [ "$1" = "-v" ]; then
     echo "Turning on verbose mode"
     RTIFCONFIG="debug_func $RTIFCONFIG"
-- 
2.17.1

