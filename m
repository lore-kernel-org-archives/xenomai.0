Message-ID: <4B068939.9060405@domain.hid>
Date: Fri, 20 Nov 2009 13:19:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B068626.8060000@domain.hid>
In-Reply-To: <4B068626.8060000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] I can send -but how to receive using
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Benjamin Biegel wrote:
> Hello
> 
> I have inserted the modules rtnet, rtipv4, rtpacket, rt_eepro100, rtcfg, 
> rtmac and nomac.
> 
> But after setting up vnic0 i can only send packets (this works) but not 
> receive any.
> 
> I use
> rtifconfig rteth0 up IP MASK promisc
> nomaccfg rteth0 attach
> ifconfig vnic 0 up IP MASK
> 

Did you set up a peer box with nomac as well - or who is supposed to
send you packets? If so, does sending&receiving work for rteth0 itself
(e.g. rtping)?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

