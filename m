Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 May 2011 10:36:46 +0200
Message-ID: <2A5271086BF5EA4A891F3804135DEA82069C8430@domain.hid>
References: <2A5271086BF5EA4A891F3804135DEA82069C8336@domain.hid>
	<4DC43293.8000907@domain.hid>
From: "BONOS Antonis" <antonis.bonos@domain.hid>
Subject: Re: [Xenomai-help] Installation problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


 Thanks for your help

>> Hello,
>>=20
>> I'm compiling a 2.6.35.9 kernel patched with xenomai 2.5.6, on a Core

>> I7 PC, and experiencing problems running xeno-test, and my own real=20
>> time programs.
>>=20
>> I attached the .config file I used for the kernel, the dmesg log, and

>> xeno-test result ( redacted because /proc/ipipe/Linux was quite=20
>> uninterresting).
>> I have a problem with theses errors, for instance with xeno-test:=20
>>=20
>> ...
>> running: ./run -- -sh -T 120 -t0 # latency ....
>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_native?)
>> ERROR: Module xeno_timerbench does not exist in /proc/modules
>> ERROR: Module xeno_rtdm does not exist in /proc/modules
>> ERROR: Module xeno_native does not exist in /proc/modules
>> ERROR: Module xeno_nucleus does not exist in /proc/modules

>> I'm quite stuck with this issue, I've tried searching on the net, but

>> I'm unable to find a pr <<.config>> o <<dmesg.log>> b=20
>> <<xeno-test.log>> lem similar to this one

>Could you try configuring xenomai user-space support with
--enable-x86-sep if you have not done it yet? Or on the=20
> contrary disable it if it is enabled?

I understand you're refering to the way to configure the xenomai
compilation.
I tried with /.configure --enable-x86-sep  and without, and I still have
the same behaviour.

I'm currently trying to compile using the configuration recommanded in
this white paper from intel=20
http://embedded.communities.intel.com/servlet/JiveServlet/download/4435-
1248/xeno_intel.pdf


Regards

