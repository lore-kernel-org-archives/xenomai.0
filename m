From: Lin Zhang <Lin.Zhang@domain.hid>
Date: Tue, 8 Mar 2011 18:22:18 +0100
Message-ID: <FA526D37A62FA141B5D2D8700F5167C83D79AE3E0C@ICTS-S-EXC4-CA.luna.kuleuven.be>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] libnative.so.3: cannot handle TLS data
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear all,=20

I am building my own embedded system with xenomai-2.5.5.2 and virtex ii xup=
 board with powerpc.=20

The linux kernel is 2.6.33, with xenomai and powerpc patched. I use busybox=
 1.6.1 stable version.

I tried the following line on my powerpc system:=20

/usr/xenomai/bin # ./latency

Then I received an error:
./latency: error while loading shared libraries: libnative.so.3: cannot han=
dle TLS data

My xenomai related software does not run, it reports a similar error:
error while loading shared libraries: libxenomai.so.0: cannot handle TLS da=
ta

Have anyone seen this kind of problem? Could you please give me some hints?

Thanks in advance.

Best regards,
Lin =

