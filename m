MIME-Version: 1.0
Date: Wed, 29 Feb 2012 18:16:23 +0200
Message-ID: <CAH=ipMDXKUmjn87Tw-bwUShQQv5SLgi1sohYKrwDkAQW9wJSLQ@mail.gmail.com>
From: teoman cengiz <teoman.ondin@domain.hid>
Content-Type: multipart/alternative; boundary=f46d041704eb2d7a8d04ba1caa41
Subject: [Xenomai-help] xenomai 2.6.0:Linkage Error.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--f46d041704eb2d7a8d04ba1caa41
Content-Type: text/plain; charset=ISO-8859-1

Hello;

   I was using Xenomai 2.4.8 .  My applications were running and I had no
linkage or run time errors.

   Due to some necessities ,xenomai 2.6.0. But I can even not  run
xenomai-2.6.0 default examples such as latency:

robotlab@domain.hid$ sudo
./latency
/usr/src/xenomai-2.6.0/src/testsuite/latency/.libs/lt-latency: symbol
lookup error: /usr/src/xenomai-2.6.0/src/skins/native/.libs/libnative.so.3:
undefined symbol: xeno_current


Also I get errors in rtdm in xenomai-head examples  :

robotlab@domain.hid$
./tut01-skeleton-app
./tut01-skeleton-app: symbol lookup error: /usr/xenomai/lib/librtdm.so.1:
undefined symbol: xeno_bind_skin_opt

I get same error from my own application too,

*I am sure, my flags are correct !

The makefiles finds all rtdm and native *libraries or what else required..

So it is not a xeno-config fault. I also tried by hand and edited makefiles
properly.


My last option is recompilation of xenomai-2.6.0 and the kernel, then
reinstallation...


Can anybody help, what else can I try to solve the problem, my platform is
2.6.38.8-xenomai-2.6 ?


Regards..



Teoman.

--f46d041704eb2d7a8d04ba1caa41
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello;<br><br>=A0=A0 I was using Xenomai 2.4.8 .=A0 My applications were ru=
nning and I had no linkage or run time errors. <br><br>=A0=A0 Due to some n=
ecessities ,xenomai 2.6.0. But I can even not=A0 run xenomai-2.6.0 default =
examples such as latency:<br>
<br>robotlab@domain.hid$ =
sudo ./latency <br>/usr/src/xenomai-2.6.0/src/testsuite/latency/.libs/lt-la=
tency: symbol lookup error: /usr/src/xenomai-2.6.0/src/skins/native/.libs/l=
ibnative.so.3: undefined symbol: xeno_current<br>
<br><br>Also I get errors in rtdm in xenomai-head examples=A0 :<br><br>robo=
tlab@domain.hid$ ./tut0=
1-skeleton-app <br>./tut01-skeleton-app: symbol lookup error: /usr/xenomai/=
lib/librtdm.so.1: undefined symbol: xeno_bind_skin_opt<br>
<br>I get same error from my own application too, <br><br><b>I am sure, my =
flags are correct ! <br><br>The makefiles finds all rtdm and native </b>lib=
raries or what else required..<br><br>So it is not a xeno-config fault. I a=
lso tried by hand and edited makefiles properly.<br>
<br><br>My last option is recompilation of xenomai-2.6.0 and the kernel, th=
en reinstallation...<br><br><br>Can anybody help, what else can I try to so=
lve the problem, my platform is 2.6.38.8-xenomai-2.6 ?<br><br><br>Regards..=
<br>
<br><br><br>Teoman.<br><br><br><br><br><br><br><br><br><br>=A0<br><br><br>=
=A0 =A0 <br>

--f46d041704eb2d7a8d04ba1caa41--

