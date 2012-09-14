Message-ID: <5053404B.9000006@iit.it>
Date: Fri, 14 Sep 2012 16:33:47 +0200
From: "Alessio Margan @ IIT" <alessio.margan@iit.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] segfault using rt_printf service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,

I'm switching from xenomai 2.5.6 to 2.6.1 using=20
adeos-ipipe-2.6.38.8-x86-2.11-01.patch
In this test I have 2 threads :
- rx_udp receive udp packets from dsp boards at 1kHz
- boards_test send udp packets at 1kHz

I got segfault in printer_loop thread, the point is that if I change env=20
var RT_PRINT_PERIOD to about 10 or 1000 (default is 100 ms) I do not=20
have segfault.

Any suggestion ?

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xb7d1ab70 (LWP 5998)]
0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
(gdb) bt
#0  0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
#1  0xb7fccbf9 in print_buffers () from /usr/xenomai/lib/libxenomai.so.0
#2  0xb7fcd867 in printer_loop () from /usr/xenomai/lib/libxenomai.so.0
#3  0xb7fb5955 in start_thread () from /lib/i686/cmov/libpthread.so.0
#4  0xb7dec5ee in clone () from /lib/i686/cmov/libc.so.6

 >> /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          2584201    0     00500080   94.1  ROOT/0
   1  0      0          130190     0     00500080   99.8  ROOT/1
   0  0      0          2571624    0     00000082    0.5  rtnet-stack
   0  0      0          109        0     00000082    0.0  rtnet-rtpc
   1  0      0          21680      0     00000084    0.0  rttcp timerwheel
   0  6069   1          1          0     00b00380    0.0  test_main
   0  6071   3          29998      0     00340184    0.7  boards_test
   0  6072   3          60007      0     00340182    2.8  rx_udp
   1  0      0          0          0     00000000    0.0  IRQ19: rteth0
   1  0      0          25100574   0     00000000    0.2  IRQ521: [timer]

CPU  PID    PRI      PERIOD     NAME
   0  0          98      -          rtnet-stack
   0  0            0      -          rtnet-rtpc
   1  0            1      -          rttcp timerwheel
   0  6069      0      -          test_main
   0  6071    99      1ms     boards_test
   0  6072    99      -          rx_udp


TIA

Alessio

--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
/Advanced Robotics/

Via Morego, 30 16163 Genova=20
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>
alessio.margan[at]iit <mailto:alessio.margan@iit.it>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The=20
information is intended for the use of the addressee only. If you are=20
not the addressee we would appreciate your notification in this respect.=20
Please note that any disclosure, copy, distribution or use of the=20
contents of this message is prohibited and may be unlawful. We have=20
taken every reasonable precaution to ensure that any kind of attachment=20
to this e-mail has been swept for viruses. However, we cannot accept=20
liability for any damage sustained as a result of software viruses and=20
would advise you to carry out your own virus checks before opening any=20
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai=20
soli destinatari. Qualora  veniate in possesso di tali informazioni=20
senza essere definito come destinatario vi reghiamo di leggere le=20
seguenti note. Ogni apertura, copia, distribuzione del contenuto del=20
messaggio e dei suoi allegati =E8 proibito e potrebbe violare le presenti=20
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per=20
assicurare che gli allegati non contengano virus. Comunque non=20
assumeremo alcuna responsabilit=E0 per ogni eventuale danno causato da=20
virus software e simili in quanto =E8 onere del destinatario verificarne=20
l'assenza in ogni allegato attuando propri indipendenti controlli.

