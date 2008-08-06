Message-ID: <2b490f270808061420l5da130b1sb8a2ccd9c34d46f5@domain.hid>
Date: Wed, 6 Aug 2008 23:20:52 +0200
From: "Dehann Fourie" <dehann.fourie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9680_27572457.1218057652583"
Subject: [Xenomai-help] SATA problem
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

------=_Part_9680_27572457.1218057652583
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have changed to a SATA hard drive on my Xeno machine, but now have kernel
panic - not sync: unable to kill init! I have done some reading on the sda?
destination for a SATA device. It seems to me that the PC doesn't find the
SATA hard drive and I suspect the problem is at root="\dev\sda1" in the
grub. Part I don't get is that it is the same as my original kernel? My
config is:

AMD Geode 500MHz
single partition SATA hard drive
Debian 4.03
Xenomai 2.4.4
vanilla kernel 2.6.25

Thanks in advance!

Dehann

------=_Part_9680_27572457.1218057652583
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>I have changed to a SATA hard drive on my Xeno machine, but now have kernel panic - not sync: unable to kill init! I have done some reading on the sda? destination for a SATA device. It seems to me that the PC doesn&#39;t find the SATA hard drive and I suspect the problem is at root=&quot;\dev\sda1&quot; in the grub. Part I don&#39;t get is that it is the same as my original kernel? My config is:<br>
<br>AMD Geode 500MHz<br>single partition SATA hard drive<br>Debian 4.03<br>Xenomai 2.4.4<br>vanilla kernel 2.6.25<br><br>Thanks in advance!<br><br>Dehann<br></div>

------=_Part_9680_27572457.1218057652583--

