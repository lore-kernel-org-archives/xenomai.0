Message-ID: <4FF369E5.5040007@xenomai.org>
Date: Tue, 03 Jul 2012 23:53:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
In-Reply-To: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@googlemail.com>
Cc: xenomai@xenomai.org

On 07/03/2012 03:30 PM, Jens K=C3=B6hler wrote:
> Hello all,
>=20
> I have a normal linux application running. Application waits in
> following loop normally about 8 ms. Delay time of 8ms is reliable.
>=20
> do
>    {
>       remain(&remainTime);
>=20
>       if ((remainTime.tv_sec !=3D 0L) || (remainTime.tv_usec !=3D 0L))
>          result =3D select(0, NULL, NULL, NULL, &remainTime);
>       else
>          break;
>    }
>    while ((result =3D=3D -1) && (errno =3D=3D EINTR));
>=20
> If there is running in parallel a Xenomai application the wait time
> could be up to 40 ms accidentally. What could be the reason?

Are you sure the "select" service guarantees delays with the version of
the linux kernel you use? Is the thread running with SCHED_FIFO policy?
If yes, what happens if you replace with nanosleep?

--=20
                                                                Gilles.


