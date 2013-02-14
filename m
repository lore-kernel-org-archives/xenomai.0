From: Martin Pongratz <pongratz@ict.tuwien.ac.at>
Date: Thu, 14 Feb 2013 11:33:50 +0000
Message-ID: <A7B6C93529C6D844895F37ADAB8DF0AC5D7097AB@ictsrv010.ICT.TUWIEN.AC.AT>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy DIO execution time and timing behavior
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I'm planning to use a NI DAQ-card (PCI-622x) with Xenomai and Analogy.

The idea is to synchronize a camera setup with a robot. The robot is contro=
lled via UDP-packets that are transmitted periodically with a cycle-time of=
 1 ms. The initiator of this communication is the robot controller (KUKA FR=
I setup with LWR 4+ robot). With every 20th datagram a camera setup shall b=
e triggered via the DAQ-card. The delay between the data-transfer and the t=
rigger-activation should be minimal or at least known with a reasonable sma=
ll jitter (magnitudes smaller than 1 ms).

But before buying the card I'd like to have some information about the timi=
ng-performance of this setup:

1)      What execution time (or magnitude of execution time) for DIO, espec=
ially output, from command execution until change of signal on the output c=
an be achieved?

2)      How much jitter in this execution time can be expected?

Thanks and BR
Martin Pongratz
--
DI Martin Pongratz
University Assistant

Robotics & Automation Group
Vienna University of Technology
Institute of Computer Technology
phn +43 1 58801 38435
fax +43 1 58801 38499
http://www.ict.tuwien.ac.at<http://www.ict.tuwien.ac.at/>

DVR:0005886

