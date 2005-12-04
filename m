From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 4 Dec 2005 13:29:09 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VEukDw8gwqRkqM8"
Message-Id: <200512041329.09740.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Problem running xeno-test, koan on PowerBook
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_VEukDw8gwqRkqM8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Yesterday I compiled xeno trunk (revision 240) for my Powerbook.
Using the 2.6.13 kernel I only did some early boot messages the last one was 
"openpic: exit".

Using the 2.6.14 kernel I had no problem starting up and using it for a couple 
of hours. (I am writing this email with it.)

The diff in the configs concerning xenomai is the following for the 2.6.14 I 
choose the selected skins (native, uvm, rtdm, vxworks) as modules and for the 
2.6.13 everything as built in.

The I switch to root and did the following:
export  LD_LIBRARY_PATH=/usr/xenomai/lib
modprobe xeno_native
modprobe xeno_uvm
./koan
Xenomai/uvm: real-time nucleus v2.1 (Surfing With The Alien) loaded.

The latency/switch test gave the following results:
ng:/usr/xenomai/testsuite/latency# ./latency
== Sampling period: 100 us
RTT|  00:00:01
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       -7541|       -7052|        1030|       0|       -7541|        1030
<..>
RTS|       -7758|       -7052|        1139|       0|    00:00:09/00:00:09
ng:/usr/xenomai/testsuite/switch# ./switch
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|        2387|        2441|        9928|           0

Then I tried running xeno-info which did run fine (see attachment)

I got into problems running xeno-test as it managed to shutdown my system 
three times. The first time while running cat /proc/looadavg, the second time
while "running quietly for 10 seconds" and the third time very early.

What is wrong with my tests?

Any hints would be appreciated. 


-- 
Niklaus Giger

--Boundary-00=_VEukDw8gwqRkqM8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="xeno-info"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-info"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ng.ngiger.dyndns.org 2.6.14 #1 PREEMPT Sat Dec 3 13:43:10 CET 2005 ppc GNU/Linux
 
Gnu C                  4.0.3
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
xfsprogs               2.6.36
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         xeno_native nfs binfmt_misc af_packet nfsd lockd sunrpc ipv6 sungem sungem_phy ohci1394 yenta_socket rsrc_nonstatic pcmcia_core apm_emu sbp2 scsi_mod ieee1394 snd_powermac snd_pcm snd_timer snd soundcore snd_page_alloc ide_cd cdrom pl2303 usbserial autofs4 radeon drm agpgart evdev isofs nls_base ext2 ext3 jbd mbcache usbhid uhci_hcd ehci_hcd ide_disk via82cxxx trm290 sl82c105 siimage sc1200 pdc202xx_old pdc202xx_new ns87415 hpt366 hpt34x generic cmd64x aec62xx unix xfs exportfs ohci_hcd usbcore

--Boundary-00=_VEukDw8gwqRkqM8--

