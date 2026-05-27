Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE76250C06
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857528; cv=none; b=jMO/eId+UpjfLVVcAhb9DFwlDjtIGEWuoGRg9AujW3LqxqA8BenxLp7KNXkMXByyvaU6N+VjcRRpsEXeA9nGqde66McDWswe94ItZlZu/YvhsZm2FjwBEYWsVgQhflbmHXhSSTFFVEbEFcYwNqmxuXZS/lsxqjiAyqZ7S/yvPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857528; c=relaxed/simple;
	bh=IikCBkL2/dv/dVQuopbgnIKMdzGJxUhtzCXdqOgiLr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBI7WQHQ6y0bf6h5zlUQdFF3H7SXorfFu/wbC3xE36T9QrkaV3WVhSnnbPTueIKn76IeQWLwpuyktuALWcsdxi5pRVrndssFShRHfsHWGDNEIXdREBlaA+wc1BxX2eOjMCfRtQwUlh8i+ICksKRkHCsLIKcZL8QpXJPNtARGAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VFxK9mhi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VFxK9mhi"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD89C3EC67;
	Wed, 27 May 2026 04:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779857524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vRBKrK/Y3KyGUA4UpC7oJxcLp9kvLzn8giYnxQF2a8=;
	b=VFxK9mhiJrDHuGfpxNpuJXvLfmOmoChQd84B4Qe0fqGMWv0DIFjjPZ/9iz54ow/n/GAZhV
	trXqWmPC/TR5yW42AF7lt5j3ORqV68mwDLn8Q9JdZj6/JSAoDJ8GQ+ex6eWmi90QcoZ5xR
	tZgTBJPaMJkDGCQxXFN8z8A9snD0nhT/syfp4Z5TrWoEENsOh+idRBAG7B60LE1PnysVbH
	k2oVWG8nLWfXQrpFtqQZj/xI4fBn8Uffu00sCfCpa0ZPInbaok5nrgfonl9Z01nzuyHT+1
	5Srvwgja4NR0/gxn3kAT1jeocEYyjlPpPS9SzzPDkscYiIVj2Fp6D6mdMeCLWg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] core: net: document udp-demo server client
In-Reply-To: <20260525203818.11519-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Mon, 25 May 2026 22:37:25 +0200")
References: <20260525203818.11519-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 27 May 2026 06:51:59 +0200
Message-ID: <87cxyhihe8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFageP14NpvRAbRz8b8JbcFChAQHU9T5nWiG10D2c+F4hIjNzoHsVeiKt21zptND9lFl/JOUSLyE3qimw+joNrOUEqQ7/LWYFq8pTG2mod11pYSvUNz9+1cLdAs9tMUxefVN51FlVluPDSESTPLNi3oIRWfOf169vfWTYYUoREbYox3K2XaCi81OnVQfZWe2xtGb2OCN4ugNbtwb82loHbhhNh3OgyGQYKp7U9CXzS3Ew+Efgmo/udDi3SoytKPHqTPrNPSlt4RfIr4J0LJNOhuIlXSv5N6nCfKnogtzaFvjulf4SVkggPOBZIHEspUNNEEDcVWfZGnN1NdLoy7pLsLtRHrz5H/tZNuVAv3lfjR8WavVYKHrg4IF3/v20y3GMeRodmKB0B75RN6evpyX743/HtBkos0x8c/LSfEu1X1BGa2A5rPEcl39eBZ41UnMQtvCGOr1JJEOBdBBOKVFrrF3FoIDQmwTjXyizK4ht7OXTXjtsAOHnpx466/ptPshTcCN8uVgTDHS693riJmeS/Ow6GhDlo3RRKclinNJ/s2AJQowOcdaYb5c+XGPS5jOaMBALi4M+iSrQ6j3eqb+eGbZumWwZJitiRNh/myfG30sg40+bfEgrTOQ2S0FB2RdCxDJYucwx+6/yyVQ6gUn40mZffaCOx8QndTq6aaoczPVQ

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Also document broadcast mode and fix mistakes
> ---
>  content/core/net/udp-demo.md | 123 ++++++++++++++++++++++++++++++++---
>  1 file changed, 114 insertions(+), 9 deletions(-)
>
> diff --git a/content/core/net/udp-demo.md b/content/core/net/udp-demo.md
> index 2b7807f..3f4aa9c 100644
> --- a/content/core/net/udp-demo.md
> +++ b/content/core/net/udp-demo.md
> @@ -21,7 +21,8 @@ is out-of-band capable.
>  The general usage of this demo is as follows:
>  
>  ```
> -oob-net-udp -a <IP-address> [-p <port>][-m <text>][-n <msgcount>][-i <iterations>][-d][-s][-R|-S]
> +oob-net-udp -a <IP-address> [-p <port>][-m <text>][-n <msgcount>][-i <iterations>]
> +  [-w <wait-time-us>][-d][-s][-b][-T|-R|-C|-S]
>  ```
>  
>  where:
> @@ -40,16 +41,27 @@ where:
>    
>  - -i<iterations> defines the number of datagrams which should be sent
>    or received.
> -  
> +
> +- -w<wait-time-us> is the time in us before a new package is sent. This is valid
> +  for _transmitter_ / _client_. (defaults to 1000000)
> +
>  - -d raises the verbosity of the demo to debug mode, such as
>    displaying the content of the packets received.
>    
>  - -s tames down the verbosity of the demo to silent mode, no output
>    will be produced in this mode.
> +
> +- -b enables broadcast mode. This is only valid for _transmitter_.
>    
>  - -R switches the demo to _receiver_ mode.
>  
> -- -S switches the demo to _sender_ mode.
> +- -T switches the demo to _transmitter_ mode.
> +
> +- -S switches the demo to _server_ mode. This mode receives a packet from a client and
> +  immediately sends a response to the address / port where the package was received from.
> +
> +- -C switches the demo to _client_ mode. This mode sends a packet to a server and waits
> +  for a response. The round trip time is measured.
>  
>  You need to set up a basic out-of-band network as described by this
>  [document]({{% relref "core/net/setup#evl-net-setup-vlan" %}}). For
> @@ -69,24 +81,29 @@ peers [set up for out-of-band communications]({{% relref
>    network device with a IPv4 address set to 10.10.10.10
>  ```
>  ~# /usr/bin/oob-net-udp -a 10.10.10.10 -R
> -== sender mode (=> 127.0.0.1:42042)
> +== receiver mode (<= 10.10.10.10:42042)
> +bind--------
> +IP-Address: 10.10.10.10
> +Port:       42042
> +Family:     2
>  = 14 bytes received: Mellow sword!
>  = 14 bytes received: Mellow sword!
>  = 14 bytes received: Mellow sword!
>  ```
>  
> -## Running the UDP sender {#evl-net-udp-sender}
> +## Running the UDP transmitter (sender) {#evl-net-udp-sender}
>  
> -In its receiver form (`-S` switch is given), the UDP demo program
> +In its transmitter form (`-T` switch is given), the UDP demo program
>  emits datagrams to the specified address and port (42042 by default).
>  
>  > On the second host which has established an out-of-band port on some
>    network device with a IPv4 address set to 10.10.10.11
>  ```
> -~# /usr/bin/oob-net-udp -a 10.10.10.10 -S
> +~# /usr/bin/oob-net-udp -a 10.10.10.11 -T
> +== sender mode (=> 10.10.10.11:42042)
>  ```
>  
> -## Running the demo in loopback mode
> +## Running the transmit / receive demo in loopback mode
>  
>  As mentioned earlier, you can run this simple demo on the loopback
>  device of a single machine, as follows:
> @@ -96,7 +113,10 @@ device of a single machine, as follows:
>  ~# oob-net-udp -R -a 127.0.0.1&
>  [1] 516
>  == receiver mode (<= 127.0.0.1:42042)
> -== bound to port 42042
> +bind--------
> +IP-Address: 127.0.0.1
> +Port:       42042
> +Family:     2
>  
>  ~# oob-net-udp -S -a 127.0.0.1 
>  == sender mode (=> 127.0.0.1:42042)
> @@ -107,6 +127,91 @@ device of a single machine, as follows:
>  = 14 bytes received: Mellow sword!
>  ...
>  ```
> +
> +## Running the UDP server {#evl-net-udp-server}
> +
> +In its server form (`-S` switch is given), the UDP demo program
> +waits for datagram on the specified address / port and immediately sends
> +an answer to the the address / port where the package was received from.
> +Say we have two peers [set up for out-of-band communications]({{% relref
> +"core/net/setup" %}}):
> +
> +> On the first host which has established an out-of-band port on some
> +  network device with a IPv4 address set to 10.10.10.10
> +```
> +~# /usr/bin/oob-net-udp -a 10.10.10.10 -S
> +== server mode (<= 10.10.10.10:42042)
> +bind--------
> +IP-Address: 10.10.10.10
> +Port:       42042
> +Family:     2
> += 14 bytes received: Mellow sword!
> += 14 bytes received: Mellow sword!
> += 14 bytes received: Mellow sword!
> +```
> +
> +## Running the UDP client {#evl-net-udp-client}
> +
> +In its client form (`-C` switch is given), the UDP demo program
> +emits a datagram to the specified address and port (42042 by default).
> +After the datagram is sent, it waits for a response and prints the round trip time.
> +The call to connect automatically assigns a port where the client will receive the
> +response.
> +
> +> On the second host which has established an out-of-band port on some
> +  network device with a IPv4 address set to 10.10.10.11
> +```
> +~# /usr/bin/oob-net-udp -a 10.10.10.10 -C
> +== client mode (<= 10.10.10.10:42042)
> +send address--------
> +IP-Address: 10.10.10.10
> +Port:       42042
> +Family:     2
> +receive address--------
> +IP-Address: 10.10.10.10
> +Port:       42671
> +Family:     2
> += 15 bytes received rtt=56.6us: Mellow sword!
> += 15 bytes received rtt=57.1us: Mellow sword!
> += 15 bytes received rtt=51.7us: Mellow sword!
> +```
> +
> +## Running the server / client demo in loopback mode
> +
> +As mentioned earlier, you can run this simple demo on the loopback
> +device of a single machine, as follows:
> +
> +```
> +~# evl net -ei lo
> +~# oob-net-udp -S -a 127.0.0.1 -m "I am the server" &
> +[1] 516
> +== server mode (<= 127.0.0.1:42042)
> +bind--------
> +IP-Address: 127.0.0.1
> +Port:       42042
> +Family:     2
> +
> +~# oob-net-udp -C -a 127.0.0.1 -m "I am the client"
> +== client mode (<= 127.0.0.1:42042)
> +send address--------
> +IP-Address: 127.0.0.1
> +Port:       42042
> +Family:     2
> +receive address--------
> +IP-Address: 127.0.0.1
> +Port:       37204
> +Family:     2
> +... (the server is now displaying the incoming frames)
> +... (the client is also displaying the incoming frames and the round trip time rtt)
> +... (the messages might be displayed out of order)
> += 16 bytes received: I am the client
> += 16 bytes received rtt=51.7us: I am the server
> += 16 bytes received: I am the client
> += 16 bytes received rtt=56.6us: I am the server
> += 16 bytes received: I am the client
> += 16 bytes received rtt=57.1us: I am the server
> +...
> +```
>  ---
>  
>  {{<lastmodified>}}

Merged, thanks.

-- 
Philippe.
