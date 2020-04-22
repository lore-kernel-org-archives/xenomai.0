From: Jona Ostermann <Jona.Ostermann@janztec.com>
Subject: Error on running xeno-test
Date: Wed, 22 Apr 2020 09:26:57 +0000
Message-ID: <LEXPR01MB1215811EAA36B9C17EFE718C8FD20@LEXPR01MB1215.DEUPRD01.PROD.OUTLOOK.DE>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am currenty testing my Xenomai Cobalt v3.1 installation on Debian 9 with =
kernel version 4.9.146.

When running xeno-test, I get the following output:

++ echo 0
++ testdir=3D/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run random_alloc_rounds=3D64 pattern_check_rou=
nds=3D64
arith OK
bufp OK
cpu_affinity skipped (no kernel support)
fpu_stress OK
FAILURE handle_sigchld:78: gdb execution returned 3 instead of 0 - No such =
proce=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ss
child 880 returned: exited with status 1


what could cause this error?


Best regards
Jona



