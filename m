Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel OOps large appl.
Date: Tue, 31 Oct 2006 17:32:02 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D7C8@domain.hid>
In-Reply-To: <454781B2.8070202@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

jan.kiszka@domain.hid wrote:
>>=20
>> ./cyclictest -c 1 -d 500 -i 500 -l 10000 -n
>> 0.06 0.03 0.01 1/21 354
>>=20
>> T: 0 (  354) P: 0 I:     500 C:   10000 Min:       7 Act:       7
>> Avg: 10 Max:     201 (needs a relatively short time)
=20
> False positive of the test: only the -n mode is supported over
> Xenomai, which is unfortunately not default. The default mode seems
> to cause a busy loop in cyclictest, effectively locking up the box
> (the Xenomai watchdog would have detected this).  =20
>=20
> Anyway, the test needs fixing to avoid misunderstandings.

Au ja !

So should I enable the watchdog ? What is the principle behind it ? Can
I somehow configure its behaviour ?

If I look on my reliable mechanical stopwatch and would activate the
cylictest with the above parameters: how long actually should the test
take ?


Next: the min, avg and max results mean latency in us ? Are these values
sane ? Any other test results I should give ? Other parameters ?

Regards,

Daniel.


