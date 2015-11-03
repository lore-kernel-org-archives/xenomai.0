From: Umair Ali <ali.umair@tut.fi>
Date: Tue, 3 Nov 2015 10:49:14 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am working on the project of playing back the pcap files in real time usi=
ng xenomai patch on vanilla kernel. The main idea is to open the pcap file,=
 read the file packet by packet and then send on the network as raw Etherne=
t packet. I have read one thread http://sourceforge.net/p/rtnet/mailman/mes=
sage/24032962/ but it did not help me a lot. I am also new to real time lin=
ux kernel. Moreover I tried to install the RTnet over the xenoami but most =
of the time my pc hangs up and I need to do the brutal restart. Therefore I=
 am not much inclined towards the RTnet. Anyone have any example code or an=
y thing which can help me or atleast provide me the guidance that how I can=
 achieve my goal.
My NIC is realtek 8139too.

Thanks & Regards
Ali=20

