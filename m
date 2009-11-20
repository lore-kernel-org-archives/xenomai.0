Message-ID: <4B068626.8060000@domain.hid>
Date: Fri, 20 Nov 2009 13:05:58 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] I can send -but how to receive using
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

I have inserted the modules rtnet, rtipv4, rtpacket, rt_eepro100, rtcfg, 
rtmac and nomac.

But after setting up vnic0 i can only send packets (this works) but not 
receive any.

I use
rtifconfig rteth0 up IP MASK promisc
nomaccfg rteth0 attach
ifconfig vnic 0 up IP MASK


Thanks :)

Benjamin


