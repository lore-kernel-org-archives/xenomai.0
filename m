Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <516D93AC.1040703@xenomai.org>
Date: Tue, 16 Apr 2013 21:53:57 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD1F7BB4-BFF5-4196-92D7-B80C3B584BF7@mah.priv.at>
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
	<5165E85B.2040609@xenomai.org>
	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
	<6C6B8C75-5498-4645-AA10-5651431A1E90@mah.priv.at>
	<516660A2.3020307@xenomai.org>
	<913FB5D5-4051-40BC-A81D-5832DDD4D69D@mah.priv.at>
	<51670ED3.2070009@xenomai.org>
	<08EA9EC3-6EBE-4527-AE0C-D44F9FB8A9E1@mah.priv.at>
	<516D93AC.1040703@xenomai.org>
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

Am 16.04.2013 um 20:08 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 04/16/2013 02:59 PM, Michael Haberler wrote:
...
>> reading up on ksrc/skins/posix/shm.c it occurs to me it isnt exactly
>> a copy & paste job getting that to run without the Xenomai
>> environment
>=20
>=20
> The reason is that the posix shm interface is not exactly simple. By
> defining your own API, you can do something much simpler. You them
> implement the API directly in kernel-space with return memory, and in
> user-space by using the ioctls provided by the driver.

I felt so.. writing off a wild phantasy.

The current approach works perfectly fine and already supports clean =
regression test runs on RTAI kernel threads, as well as Xenomai kernel =
and userland RT threads. The rest is harmless.

Thanks a lot for the excellent advice!

- Michael


>=20
>=20
> --=20
>                                                                Gilles.


