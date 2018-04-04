From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Wed, 4 Apr 2018 20:15:09 +0000
Message-ID: <DB6PR0701MB2456FE5A9F080B3BE39375E0B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] doc for xeno-config skins
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

What is the difference between the Posix and Cobalt skin, as far as xeno-co=
nfig is concerned??

Difference between
  xeno-config --skin posix --cflags
  xeno-config --skin cobalt --cflags
is that the former declares -D__COBALT_WRAP__ (which in turn adds fwd decla=
rations for clock_nanosleep() and pthread_setname_np() in boilerplate/libc.=
h).

difference between=20
  xeno-config --skin posix --ldflags
  xeno-config --skin cobalt --ldflags
is that the former adds `-Wl,@/usr/xenomai/lib/cobalt.wrappers`

So it seems to me that `--skin posix` expects you to call, e.g.: pthread_cr=
eate(), while `--skin cobalt` expects you to call, e.g.: __wrap_pthread_cre=
ate()

Is this correct?
Is that it?
What are the intended uses?
I don't think this is documented anywhere? Where would be the best place to=
 have this written down? Perhaps the --help of xeno-config? Also, while we =
are at it, --skin alchemy vs --skin native and the effect of --compat could=
 use some description.

Best,
Giulio

