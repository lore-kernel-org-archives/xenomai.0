MIME-Version: 1.0
Date: Fri, 21 Oct 2011 16:23:22 +0900
Message-ID: <CAAtf-FfFezJdSr6w0YbStuVp8MdUxP+xLjw0LuvTAcdVuc8oXw@domain.hid>
From: Donggu Kang <cdslashboot@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Interruption of sata hard driver's during real-time
	task running
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear all


I tried to test of latnecy with a etherlab on the xenomai framework.
The etherlab is ethercat master implimentation in the Linux Evironment
and It's using normal ethernet interface card.

In my test, I have found huge latency under hard disk stress situation.
For making hard disk stress, I ran nomal linux process that is "while:
do ls -lR / > /tmp/list; done & > /dev/ null".
After than I also run xenomai task with etherlab master api.

The latest latency is above a 500us. It is unacepptable on my system.
When I run latency test tool of xenomai, the latency is under a 5us

I think the real-time task and communication of NIC is intercepted by
hard disk IRQ.

Is there any idea to prevent interruption of sata hard driver's during
real-time task run.
Thanks for any comment or suggestion regarding that problem.

Hardware
CPU : Core 2 Duo L7400 1.5ghz
ICH : ICH7
NIC : realteck 8139c ( 8139too )
HDD : SATA 2 250 Mb 5000rpm

Real Time Environment
Debian sqeeze,
kernel 2.6.37.6,
Xenomai-2.5.6,
adeos-ipipe-2.6.37.6-x86-2.9-02.patch
EtherLab-1.5 stable
Cycle time 1ms


Best regard,

Donggu Kang.

