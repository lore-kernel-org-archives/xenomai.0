MIME-Version: 1.0
In-Reply-To: <CAMwkeZxf8xizLZ5Pyg+L8CwHxnY7oYXDxiCBYDGR93NWZ2vWAw@domain.hid>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
	<4E8B0DEA.8030102@domain.hid>
	<CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
	<4E8B3744.2030407@domain.hid>
	<CAGc_wL2RgNKfMUyQURJ8G2ceaJtvnJL6LpFue3ekuwJ99vwPww@domain.hid>
	<4E8C3AF9.7070604@domain.hid>
	<CAMwkeZyDjpqb11NoxUCTxwpmY5RV0bjRzAHG6HeeyW5RvXejDQ@mail.gmail.com>
	<CAMesUR7Kn66LETRjRatAPJ5SFM+3EkkbSYwtPo8h1jP96crqYQ@mail.gmail.com>
	<CAMwkeZxf8xizLZ5Pyg+L8CwHxnY7oYXDxiCBYDGR93NWZ2vWAw@domain.hid>
Date: Thu, 6 Oct 2011 03:25:29 -0400
Message-ID: <CAGc_wL2-16bthSzVLvBJfJg3tab7ZQyB33XkG_4fF1eBi9CC5Q@mail.gmail.com>
From: Julien Delange <julien.delange@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

2011/10/5 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> Oh, I see, thanks for pointing this out. On the code I had working with
> comedi I used 1 for subdevices providing "sampl_t" samples (2 bytes) and =
2
> for subdevices providing "lsampl_t" samples (4 bytes) (timer/counter
> subdevices, for instance). I really think that rationale is misleading, a=
nd
> find working in terms of bytes much saner! In any case, using 8 as Julien
> does seems to not be correct.

Yes, indeed, the size could be changed, what is funny is that this
piece of code works correctly, meaning the value is correct. Anyway,
correcting the size may be better.

