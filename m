Message-ID: <423441.69204.qm@domain.hid>
Date: Tue, 5 May 2009 23:23:04 -0700 (PDT)
From: luan dinh <dinhluanbmt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1138471030-1241590984=:69204"
Subject: [Xenomai-help] EtherCAT- help with xenomai configuration
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org


--0-1138471030-1241590984=:69204
Content-Type: text/plain; charset=us-ascii

hi.
I'm also work with EtherCAT master, Xenomai, Rtnet
can you explain more detail about your timer measuring ?
+ the time between send and receive EtherCAT packet about 19us ( it depend on Slaves processtime ), i use Wireshark wit RTnet plugin to capture packets

Luan Dinh

--- On Tue, 5/5/09, henning.richter@domain.hid <henning.richter@domain.hid> wrote:

From: henning.richter@domain.hid <henning.richter@domain.hid>
Subject: [Xenomai-help] help with xenomai configuration
To: xenomai@xenomai.org
Date: Tuesday, May 5, 2009, 2:21 PM


Hi,



I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai 2.4.6.1 and the latest rtnet version.

I set up the EthercatMasterLibrary and send some Frames (size of ~1200 byte) cylical to my Beckhoff devices.

Measuring the time (via rt_read_timer-function of timer.h) handing the frames over to the NIC last between 5 and 10 us. (its the low_level_send)

Measuring the time at the application layer is takes ~250 - 350 us. So I am loosing quite a lot time in between.



Maybe there is sth. wrong with my xenomai configuration.

I run the 'xeno-test' (results below) but the test stop at generation load.



Henning





      
--0-1138471030-1241590984=:69204
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">hi.<br>I'm also work with EtherCAT master, Xenomai, Rtnet<br>can you explain more detail about your timer measuring ?<br>+ the time between send and receive EtherCAT packet about 19us ( it depend on Slaves processtime ), i use Wireshark wit RTnet plugin to capture packets<br><br>Luan Dinh<br><br>--- On <b>Tue, 5/5/09, henning.richter@domain.hid <i>&lt;henning.richter@domain.hid&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: henning.richter@domain.hid &lt;henning.richter@domain.hid&gt;<br>Subject: [Xenomai-help] help with xenomai configuration<br>To: xenomai@xenomai.org<br>Date: Tuesday, May 5, 2009, 2:21 PM<br><br><div id="yiv1827528761">
<p><font face="Arial">Hi,</font><br>
<br>
<font face="Arial">I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai 2.4.6.1 and the latest rtnet version.</font><br>
<font face="Arial">I set up the EthercatMasterLibrary and send some Frames (size of ~1200 byte) cylical to my Beckhoff devices.</font><br>
<font face="Arial">Measuring the time (via rt_read_timer-function of timer.h) handing the frames over to the NIC last between 5 and 10 us. (its the low_level_send)</font><br>
<font face="Arial">Measuring the time at the application layer is takes ~250 - 350 us. So I am loosing quite a lot time in between.</font><br>
<br>
<font face="Arial">Maybe there is sth. wrong with my xenomai configuration.</font><br>
<font face="Arial">I run the 'xeno-test' (results below) but the test stop at generation load.</font><br>
<br>
<font face="Arial">Henning</font><br>
</p></div><br></blockquote></td></tr></table><br>

      
--0-1138471030-1241590984=:69204--

