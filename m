Message-ID: <4AED83C0.8050002@domain.hid>
Date: Sun, 01 Nov 2009 13:49:04 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Two real time NICs in same PC? (RTnet)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have only found documentation about the possibility to run a 
non-RT-NIC and a RT-NIC at the same time, which is possible.

But is it possible on the same PC to have:
- One NIC being master or slave in an RTnet network
- One other NIC capturing frames with RTcap
?

(The whole point is to have a network of PCs running RTnet, so that 
their clocks are synchronized. Then have these same PCs capture frames 
via RTcap. In this way the captured timestamps can be compared and  
Ethernet  frame travel times can be calculated.)

Thanks :)

Benjamin


