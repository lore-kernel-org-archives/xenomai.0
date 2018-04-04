From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Wed, 4 Apr 2018 19:58:14 +0000
Message-ID: <DB6PR0701MB2456EF1925C87F170E90540EB5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xeno-config --no-mode-check still has -lmodechk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

 /usr/xenomai/bin/xeno-config --skin cobalt --ldflags --no-mode-check

returns
-Wl,--no-as-needed   /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain=
 -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcoba=
lt -lmodechk -lpthread -lrt

which removes the modechk wrappers, but leaves -lmodechk in. Is this expect=
ed?

As I understand it, libmodechk provides implementations for __wrap_malloc, =
__wrap_free and __real_malloc, __real_free() are these needed even when the=
 wrappers are disabled, or should -lmodechk not be included?


