From: Marco Tessore <marco.tessore@axelsw.it>
Subject: About RTNet setup
Date: Fri, 15 May 2020 13:15:32 +0000
Message-ID: <97020454f0464394b9128a7620d8d631@axelsw.it>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Good morning,
I'm working in a project where I need send and receive RAW ethernet packet =
in realtime.
I'm using a Xenomai 3.1 porting on an Ubuntu machine.
RTNet is enabled in the kernel as modules.

The problem is that I don't really know how to setup the network in userspa=
ce.

If this mailing list is not appropriate for the issue please tell me where =
I can write.

The results of  rtifconfig is:
rteth0    Medium: Ethernet  Hardware address: 6C:B3:11:52:4C:E9
          IP address: 192.168.178.142  Broadcast address: 192.168.178.255
          UP BROADCAST RUNNING  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1
          UP LOOPBACK RUNNING  MTU: 1500

So I tried rtping to ping another machine, in my network: that machine is n=
ot a realtime one, and rtping response is that there's no route to host.
The first question is: does the other machine need to run rtnet as well to =
respond to the rtping protocol, or it's simply a realtime implementation of=
 the standard ping?

The second question is: to send and receive custom ethernet frames from a u=
serspace process,
What is the best configuration of rtnet.conf ? I don't really need rt-tcpip=
 and I don't know how TDMA works.

Third question is about the API to use: I'm trying to see the examples, but=
 I'have some troubles to actually implement this.

I'll appreciate any help
Kind Regards
Marco Tessore



Marco Tessore

AXEL S.r.l.
Via del Cannino, 3
21020 Crosio della Valle (VA) - ITALY
Tel: +39 0332 949600
Fax: +39 0332 969315
E-mail: marco.tessore@axelsw.it<mailto:marco.tessore@axelsw.it>
Web site: www.axelsoftware.it<http://www.axelsoftware.it>

Le informazioni contenute in questo messaggio e negli eventuali allegati so=
no riservate e ad uso esclusivo del destinatario. Qualora abbiate ricevuto =
questo messaggio per errore, siete cortesemente pregati di darne immediata =
comunicazione al mittente e di provvedere alla sua distruzione. Grazie.
(Regolamento Europeo Protezione dei Dati n. 2016/679 ("GDPR")/D. Lgs 30.6.2=
003 n. 196)

The information contained in this e-mail and any attachments are confidenti=
al and are intended for the use of the individual or entity to which they a=
re addressed. If you are not among the named recipients, please notify the =
sender immediately by reply e-mail and then delete this message from your s=
ystem. Thank you.
(Decree 196/2003 and Regulation (EU) 2016/679)


