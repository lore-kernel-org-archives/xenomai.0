From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Tue, 28 Nov 2017 16:18:56 +0000
Message-ID: <DB6PR0701MB2456EB08FE752DA5BF73FF6DB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Linking shared library which relies on bootstrap.o fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

armv7 (BeagleBone Black), Xenomai 3.0.5.

When linking a shared library with something like=20
  gcc `/usr/xenomai/bin/xeno-config --skin=3Dalchemy --ldflags` -rdynamic -=
shared -o libmylib.so=20

I get=20

/usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_ARM_THM_MOV=
W_ABS_NC against `a local symbol' can not be used when making a shared obje=
ct; recompile with -fPIC
/usr/xenomai/lib/xenomai/bootstrap.o: error adding symbols: Bad value

I understand this can be fixed by compiling the Xenomai library (or at leas=
t boostrap.o) with -fPIC.=20

Should this not be made the default setting?=

