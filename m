Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel OOps large appl.
Date: Tue, 31 Oct 2006 16:37:02 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D777@domain.hid>
In-Reply-To: <1162308339.4996.107.camel@domain.hid>
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

Philippe Gerum wrote:
=20
=20
> IOW, something seems out of sync in your configuration. Does the
> testsuite work on your board, and specifically the "cyclic" test?=20


The cyclic test does the following output:

./cyclictest -c 1 -d 500 -i 500 -l 10000 -n
0.06 0.03 0.01 1/21 354

T: 0 (  354) P: 0 I:     500 C:   10000 Min:       7 Act:       7 Avg:
10 Max:     201
(needs a relatively short time)

./cyclictest -c 0 -d 500 -i 500 -l 10000 -n
0.00 0.01 0.00 1/21 357

T: 0 (  357) P: 0 I:     500 C:   10000 Min:       6 Act:       6 Avg:
12 Max:     403
(needs a relatively short time)

./cyclictest -c 1 -d 500 -i 500 -l 10000 -n -r
0.00 0.00 0.00 1/21 367

T: 0 (  367) P: 0 I:     500 C:   10000 Min:      10 Act:      11 Avg:
19 Max:     491
(needs a relatively short time)

./cyclictest -c 1 -d 500 -i 500 -l 10000 -s
T: 0 (  360) P: 0 I:     500 C:   10000 Min:   -6174 Act:94983888
Avg:47488852 Max:94983888
(needs much longer)

./cyclictest -c 1 -d 500 -i 500 -l 10000
0.16 0.03 0.01 1/22 379

T: 0 (  379) P: 0 I:     500 C:   10000 Min:-5964339 Act:-5964339
Avg:-3481100 Max: -997872

(returns immediately without doing anything)

./cyclictest

(locks up system immediately)



Probably not good....


Regards,

Daniel.

=20

