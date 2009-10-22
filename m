Message-ID: <4AE05271.6060909@domain.hid>
Date: Thu, 22 Oct 2009 14:39:13 +0200
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai and Libpcap
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

Hej

I have a question regarding the use of Libpcap together with Xenomai. 
The Libpcap library provides the ability to capture Ethernet frames with 
my NIC in promiscuous mode + time stamp the received frames on Ethernet 
level (through the clock of the NIC).

My question is this: How do i set up an Xenomai real-time environment 
that makes the time-stamping very accurate. How do I have influence on 
when pcap is scheduled? How do I make sure pcap is not preempted by the OS?

Thanks for any guidance on this point :)

Benjamin

