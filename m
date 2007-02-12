Message-ID: <b131c9f0702120811l64e300dbu7819f7254bdc6aa0@domain.hid>
Date: Mon, 12 Feb 2007 18:11:12 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31093_26993215.1171296672455"
Subject: [Xenomai-help] Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE
	disabled
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

------=_Part_31093_26993215.1171296672455
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there

I'm using ubuntu 6.06 LTS.
I patched a 2.6.19.1 vanilla kernel with xenomai 2.3.0 adeos
(Processor type is Pentuim III)
The realtime section has been left at the default settings.

The kernel compiles and boots ok.

Userspace Xenomai has been compiled with the --disable-x86-tsc option

When i try to run the latency test, i get the following error

Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled
(modprobe xeno_native?)

The kernel .config file shows that the native skin is supposed to be
compiled
into the kernel and CONFIG_SENO_OPT_PERVASIVE=y

Any help to solve this problem would be appreciated

Thanx
Vicki

------=_Part_31093_26993215.1171296672455
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there<br>
<br>
I&#39;m using ubuntu 6.06 LTS.<br>
I patched a <a href="http://2.6.19.1">2.6.19.1</a> vanilla kernel with xenomai 2.3.0 adeos<br>
(Processor type is Pentuim III)<br>
The realtime section has been left at the default settings.<br>
<br>
The kernel compiles and boots ok. <br>
<br>
Userspace Xenomai has been compiled with the --disable-x86-tsc option<br>
<br>
When i try to run the latency test, i get the following error<br>
<br>
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled<br>
(modprobe xeno_native?)<br>
<br>
The kernel .config file shows that the native skin is supposed to be compiled<br>
into the kernel and CONFIG_SENO_OPT_PERVASIVE=y<br>
<br>
Any help to solve this problem would be appreciated<br>
<br>
Thanx<br>
Vicki

------=_Part_31093_26993215.1171296672455--

