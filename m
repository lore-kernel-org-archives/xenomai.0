Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F522D23BC
	for <xenomai@lists.linux.dev>; Mon, 25 May 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741560; cv=none; b=uaiXARXgXouUVZzyPSy1/nHtCLE4dJBxhQkkKwSTPvlN9CJ3I9CxmeY4eDl8LtRI/DJjldnrs4tPN1L1GPt9Msu9FJ02NRt0/CtZh7Bd3OVI8NYx92rGZTuWZu4X+U824fWh+ztr5ei/f0yBlJTnJWGvMpQ6kaz5J1ZwogEyqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741560; c=relaxed/simple;
	bh=Tw0Lu7JDsGwhwyOShoEXFjELp2hd/BEEP6Fy+lj059E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrL+R8YvgUFSQ9drviCH8ILf2EvMDqbtwnJi8X2crm6RBIh2V5N9BVHoFWWSpOCw3fMFrb6ecCtHW+bSLqbpYlLOr5LJXkcaPWJnqE0RDYF6Yp3OvUgq969vKuPEFJ5gMb1YggNzqslNINvehE5fMtHRCToCx/5KrzTAh/7k9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppsLph++; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppsLph++"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so47400835e9.1
        for <xenomai@lists.linux.dev>; Mon, 25 May 2026 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779741557; x=1780346357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m++Ny3sUMxSIM8MThHPR0nsphZjCBPdyWTPGxVtT0OA=;
        b=ppsLph++fUoDa/MbnuPsOAPsEs3qtMizYhLyRQPLi+jm1c2djayUmNFiftfncYBJ0Q
         kNLiWa5HfY8i+q35gjCu+iZLKxs8ja1DveLi+PjSvRNmg1Po6L4vFico4sXjsm+bEXG9
         O/mhDWoxvYCT8E2w2kS398TfXpgRNSQz1B4urQbGzw4iRnWo/41gzvmuXh3P+HRomaly
         GgRFL/eViEec6tLqCQ0i9bqe5NY++T22x8E0KbyrTwvO886ewsUudiurul2tSkb4TyEL
         dLFGLnUyFqdxF8oroXfc/+ow8bMsx9JYXdB6WqG+0trXLBcQmYEK7RlcL0uQierrU9s8
         mQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779741557; x=1780346357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m++Ny3sUMxSIM8MThHPR0nsphZjCBPdyWTPGxVtT0OA=;
        b=Oh6Bjtcg14PnLKSmtD0qTbdZY/J6dF/qfJUUJqQF3vtrIj/vKcFUuSiS0XH7kNICtT
         j3GUvU8fkyaWYIfpGaJ4LoqHpx4l5yWVRe4QmT/Uf5sf5vsgd0pwUoMzyxe1x3Kux1n5
         m1cPdrGoc9Sfal05P6FmRMBFUS3uhIbFIjRHnd+SplSNLEinZ3Cq+9GHHSipSMQTTa62
         lJc0+v8nBDnD44mLewYevOjO59y8u2LMTLsJjC5ZhFGhocyKEbFSyeEQBUlgHJmUP+ln
         VELM12ww10Jkpl7ZhVJ+NnlOV6JukPI7gFMTMRrntYoLYonLBg7h6d2v3hy7xytZktKZ
         So+A==
X-Gm-Message-State: AOJu0YzQ57YblQt6cLW7mTTcOegfo3aCA0FzcQZ5L67nZwbGGpWU27ob
	iESv97VAH8qlWQKBMN5y2qO5yl6AGIfXZR+Q+XOLc3IaJVgl2li0NQ6oq1RFMQ==
X-Gm-Gg: Acq92OGYhHpkDbAzYvMKn+pxOckHvmh2kJgPYPYDZwuBioicNLLR18ahIlsbSbzdCrO
	ThJ4fIxlVdZmvQEvwyzLgew5Lz1GrgY+Q8HAWD2xDsnvJOx+yXnZOWSJzkgNG6N6XbyMHiLo8il
	CIbIZIir7F3v0OD6+YiOJ723gyjmoV+LJELdDiP1SAo9Sa2yVyuFuq4arua/zWcMmu1guGHX9i6
	rlGayNDDncCYsnk1n6wB4QiIj45+R961t41C2GkXYknSCi5ikig4LZd+kg9KtserGk6EYYfLmnG
	5P2Kb07GxYt8O30eOMMrVdNnDz4vIf7AONgMHFjTxw6AqDE5qY+N2VRv8X5iWp3uMoEQC+VdmO/
	QK1/4FS2ihrX+25D710LS7jA3qVi4TfbM4YLGeaCh1BXxdAc48qIZ3JOaqWW4KPiGA81JuiIlZM
	ooGGDx2NxuGLOY+9INWuH/IOfSeg==
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-49050580a91mr191550915e9.11.1779741556671;
        Mon, 25 May 2026 13:39:16 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561f682sm293045095e9.13.2026.05.25.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:39:15 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] core: net: document udp-demo server client
Date: Mon, 25 May 2026 22:37:25 +0200
Message-ID: <20260525203818.11519-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also document broadcast mode and fix mistakes
---
 content/core/net/udp-demo.md | 123 ++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 9 deletions(-)

diff --git a/content/core/net/udp-demo.md b/content/core/net/udp-demo.md
index 2b7807f..3f4aa9c 100644
--- a/content/core/net/udp-demo.md
+++ b/content/core/net/udp-demo.md
@@ -21,7 +21,8 @@ is out-of-band capable.
 The general usage of this demo is as follows:
 
 ```
-oob-net-udp -a <IP-address> [-p <port>][-m <text>][-n <msgcount>][-i <iterations>][-d][-s][-R|-S]
+oob-net-udp -a <IP-address> [-p <port>][-m <text>][-n <msgcount>][-i <iterations>]
+  [-w <wait-time-us>][-d][-s][-b][-T|-R|-C|-S]
 ```
 
 where:
@@ -40,16 +41,27 @@ where:
   
 - -i<iterations> defines the number of datagrams which should be sent
   or received.
-  
+
+- -w<wait-time-us> is the time in us before a new package is sent. This is valid
+  for _transmitter_ / _client_. (defaults to 1000000)
+
 - -d raises the verbosity of the demo to debug mode, such as
   displaying the content of the packets received.
   
 - -s tames down the verbosity of the demo to silent mode, no output
   will be produced in this mode.
+
+- -b enables broadcast mode. This is only valid for _transmitter_.
   
 - -R switches the demo to _receiver_ mode.
 
-- -S switches the demo to _sender_ mode.
+- -T switches the demo to _transmitter_ mode.
+
+- -S switches the demo to _server_ mode. This mode receives a packet from a client and
+  immediately sends a response to the address / port where the package was received from.
+
+- -C switches the demo to _client_ mode. This mode sends a packet to a server and waits
+  for a response. The round trip time is measured.
 
 You need to set up a basic out-of-band network as described by this
 [document]({{% relref "core/net/setup#evl-net-setup-vlan" %}}). For
@@ -69,24 +81,29 @@ peers [set up for out-of-band communications]({{% relref
   network device with a IPv4 address set to 10.10.10.10
 ```
 ~# /usr/bin/oob-net-udp -a 10.10.10.10 -R
-== sender mode (=> 127.0.0.1:42042)
+== receiver mode (<= 10.10.10.10:42042)
+bind--------
+IP-Address: 10.10.10.10
+Port:       42042
+Family:     2
 = 14 bytes received: Mellow sword!
 = 14 bytes received: Mellow sword!
 = 14 bytes received: Mellow sword!
 ```
 
-## Running the UDP sender {#evl-net-udp-sender}
+## Running the UDP transmitter (sender) {#evl-net-udp-sender}
 
-In its receiver form (`-S` switch is given), the UDP demo program
+In its transmitter form (`-T` switch is given), the UDP demo program
 emits datagrams to the specified address and port (42042 by default).
 
 > On the second host which has established an out-of-band port on some
   network device with a IPv4 address set to 10.10.10.11
 ```
-~# /usr/bin/oob-net-udp -a 10.10.10.10 -S
+~# /usr/bin/oob-net-udp -a 10.10.10.11 -T
+== sender mode (=> 10.10.10.11:42042)
 ```
 
-## Running the demo in loopback mode
+## Running the transmit / receive demo in loopback mode
 
 As mentioned earlier, you can run this simple demo on the loopback
 device of a single machine, as follows:
@@ -96,7 +113,10 @@ device of a single machine, as follows:
 ~# oob-net-udp -R -a 127.0.0.1&
 [1] 516
 == receiver mode (<= 127.0.0.1:42042)
-== bound to port 42042
+bind--------
+IP-Address: 127.0.0.1
+Port:       42042
+Family:     2
 
 ~# oob-net-udp -S -a 127.0.0.1 
 == sender mode (=> 127.0.0.1:42042)
@@ -107,6 +127,91 @@ device of a single machine, as follows:
 = 14 bytes received: Mellow sword!
 ...
 ```
+
+## Running the UDP server {#evl-net-udp-server}
+
+In its server form (`-S` switch is given), the UDP demo program
+waits for datagram on the specified address / port and immediately sends
+an answer to the the address / port where the package was received from.
+Say we have two peers [set up for out-of-band communications]({{% relref
+"core/net/setup" %}}):
+
+> On the first host which has established an out-of-band port on some
+  network device with a IPv4 address set to 10.10.10.10
+```
+~# /usr/bin/oob-net-udp -a 10.10.10.10 -S
+== server mode (<= 10.10.10.10:42042)
+bind--------
+IP-Address: 10.10.10.10
+Port:       42042
+Family:     2
+= 14 bytes received: Mellow sword!
+= 14 bytes received: Mellow sword!
+= 14 bytes received: Mellow sword!
+```
+
+## Running the UDP client {#evl-net-udp-client}
+
+In its client form (`-C` switch is given), the UDP demo program
+emits a datagram to the specified address and port (42042 by default).
+After the datagram is sent, it waits for a response and prints the round trip time.
+The call to connect automatically assigns a port where the client will receive the
+response.
+
+> On the second host which has established an out-of-band port on some
+  network device with a IPv4 address set to 10.10.10.11
+```
+~# /usr/bin/oob-net-udp -a 10.10.10.10 -C
+== client mode (<= 10.10.10.10:42042)
+send address--------
+IP-Address: 10.10.10.10
+Port:       42042
+Family:     2
+receive address--------
+IP-Address: 10.10.10.10
+Port:       42671
+Family:     2
+= 15 bytes received rtt=56.6us: Mellow sword!
+= 15 bytes received rtt=57.1us: Mellow sword!
+= 15 bytes received rtt=51.7us: Mellow sword!
+```
+
+## Running the server / client demo in loopback mode
+
+As mentioned earlier, you can run this simple demo on the loopback
+device of a single machine, as follows:
+
+```
+~# evl net -ei lo
+~# oob-net-udp -S -a 127.0.0.1 -m "I am the server" &
+[1] 516
+== server mode (<= 127.0.0.1:42042)
+bind--------
+IP-Address: 127.0.0.1
+Port:       42042
+Family:     2
+
+~# oob-net-udp -C -a 127.0.0.1 -m "I am the client"
+== client mode (<= 127.0.0.1:42042)
+send address--------
+IP-Address: 127.0.0.1
+Port:       42042
+Family:     2
+receive address--------
+IP-Address: 127.0.0.1
+Port:       37204
+Family:     2
+... (the server is now displaying the incoming frames)
+... (the client is also displaying the incoming frames and the round trip time rtt)
+... (the messages might be displayed out of order)
+= 16 bytes received: I am the client
+= 16 bytes received rtt=51.7us: I am the server
+= 16 bytes received: I am the client
+= 16 bytes received rtt=56.6us: I am the server
+= 16 bytes received: I am the client
+= 16 bytes received rtt=57.1us: I am the server
+...
+```
 ---
 
 {{<lastmodified>}}
-- 
2.47.3

