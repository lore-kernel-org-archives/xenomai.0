References: <1BF62296-6E7D-4758-9084-62F575A58151@mah.priv.at>
 <535D3E4B.7060506@xenomai.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <535D3E4B.7060506@xenomai.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <F858FC36-FAA3-4EE2-8C34-41A0C5911B0F@mah.priv.at>
From: Michael Haberler <mail17@mah.priv.at>
Date: Mon, 28 Apr 2014 17:10:35 +0200
Subject: Re: [Xenomai] q: userland timestamps  which match rt_timer_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



> Am 27.04.2014 um 19:28 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@=
xenomai.org>:
>=20
>> On 04/27/2014 05:29 PM, Michael Haberler wrote:
>> I need to create ns-resolution timestamps from RT (using
>> rt_timer_read() - no surprises) and from normal userland programs
>>=20
>> the latter binaries should be Xenomai-unaware if possible - is there
>> a normal Linux API which reads the same timestamp source as
>> rt_timer_read()?
>>=20
>> eg: clock_gettime(CLOCK_xxxx)?
>=20
> No, xenomai clock and linux clock generally are not synchronized. If you
> need only timestamps though, you can access linux realtime clock from
> xenomai program (wihout a switch to secondary mode) by using xenomai
> posix skin clock_gettime(CLOCK_HOST_REALTIME). This clock can not be
> used for timers (or timeouts) though.

great - thanks, exactly what I was looking for!

- Michael

>=20
> --=20
>                                                                Gilles.

