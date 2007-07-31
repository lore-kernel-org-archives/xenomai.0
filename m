From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18095.43878.759358.210266@domain.hid>
Date: Tue, 31 Jul 2007 23:36:38 +0200
In-Reply-To: <18095.41752.74240.393339@domain.hid>
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
	<2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
	<18095.41752.74240.393339@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>, "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
 > Yeoh Chun Yeow wrote:
 >  > Dear Gilles,
 >  > 
 >  > Thanks. After disabling the system timer interrupt at the starting of timer
 >  > init function, the problem is solved. Thanks again!
 >  > 
 >  > By the way, I would like know if you ever try the 2.6.20-at91-patch in your
 >  > testing and find out the problem. Whenever I patch my kernel with this
 >  > 2.6.20-at91-patch, the system is stalled in a very early stage, not even
 >  > reaching the request_irq in atmel serial driver.
 >  > 
 >  > Please advice. Thanks
 > 
 > I tried applying this patch, the kernel boots fine until the point where
 > it tries to configure the network interface for mounting its root
 > filesystem through nfs. The usual messages:
 > eth0: Link now 100-FullDuplex
 > Sending DHCP requests ., OK
 > IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.20
 > IP-Config: Complete:
 >       device=eth0, addr=192.168.1.20, mask=255.255.255.0, gw=192.168.1.1,
 >      host=192.168.1.20, domain=, nis-domain=(none),
 >      bootserver=192.168.1.1, rootserver=192.168.1.3, rootpath=
 > Looking up port of RPC 100003/2 on 192.168.1.3
 > Looking up port of RPC 100005/1 on 192.168.1.3
 > 
 > never gets displayed.
 > 
 > However, I observe no lockup at a very early stage, it would be
 > interesting if you could investigate this on your side.
 > 
 > Now, anybody with more knowledge on the Atmel patch for AT91, could you
 > tell me what I am doing wrong ?

It is an I-pipe patch bug, without I-pipe, the kernel finshes booting
correctly.

-- 


					    Gilles Chanteperdrix.

