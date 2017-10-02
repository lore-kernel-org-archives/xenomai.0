From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 2 Oct 2017 10:39:01 +0000
Message-ID: <DB6PR0701MB245612C4904BA6543FFE09F0B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] PTHREAD_COND_INITIALIZER
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

The Xenomai documentation for pthread_cond_variable says=20
"Note that only pthread_cond_init() may be used to initialize a condition v=
ariable, using the static initializer PTHREAD_COND_INITIALIZER is not suppo=
rted."

However, demo/posix/cyclictest/cyclictest.c has the following line:
    static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
which seems to contradict the above prescription.

