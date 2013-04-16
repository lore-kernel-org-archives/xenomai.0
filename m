Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51670ED3.2070009@xenomai.org>
Date: Tue, 16 Apr 2013 14:59:24 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <08EA9EC3-6EBE-4527-AE0C-D44F9FB8A9E1@mah.priv.at>
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
	<5165E85B.2040609@xenomai.org>
	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
	<6C6B8C75-5498-4645-AA10-5651431A1E90@mah.priv.at>
	<516660A2.3020307@xenomai.org>
	<913FB5D5-4051-40BC-A81D-5832DDD4D69D@mah.priv.at>
	<51670ED3.2070009@xenomai.org>
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


I've gotten the char shm driver to work flawlessly as suggested, and am =
now looking into dumping the rest of the SysV IPC legacy code in the =
linuxcnc code base and replace it by shm_open/mmap

reading up on the Xenomai Posix skin a bit late (ahem) it occurs to me =
the best solution would have been to use the Xenomai Posix skin =
throughout, kernel and userland, dump my little driver, and be done with =
it

the catch, of course, is that the Xenomai Posix skin is available on, =
well, Xenomai only, which leaves out the RTAI and vanilla kernels cases, =
and any other flavor downstream

reading up on ksrc/skins/posix/shm.c it occurs to me it isnt exactly a =
copy & paste job getting that to run without the Xenomai environment

so I'm really just asking so I dont write off an option prematurely... =
this is whacky, right?

- Michael


Am 11.04.2013 um 21:28 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> Of course, this is where the down-side is, you will have to maintain
> your little kernel module with kernel version changes.
..
>=20
>=20
> --=20
>                                                                Gilles.


