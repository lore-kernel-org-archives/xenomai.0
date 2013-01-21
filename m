Message-ID: <50FD2FFA.9010002@xenomai.org>
Date: Mon, 21 Jan 2013 13:09:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>	<4FF369E5.5040007@xenomai.org>	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>	<4FF402AD.3020601@xenomai.org>	<4FF415AB.2030503@xenomai.org>	<CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>	<CAL7_A_XMD_KY9nryEyb3xzHpCb1PFYTG6qJupLWqRZhJXjkYRw@mail.gmail.com>	<4FF44389.3030209@xenomai.org>	<CAL7_A_WTJUeWNTTra2t9veiyWMxC5VtpotocMHGPdU1v7QAxKA@mail.gmail.com>	<4FF44C52.6050809@xenomai.org>	<CAL7_A_VUC8JD9yeMnLt2iJQ0ex_at3QMhiL3cQ5CHPFh0rcJRA@mail.gmail.com>	<4FF585C4.1000708@xenomai.org>	<CAL7_A_WZ=mQ9F_Od92qQKFS85QcOtOwqyXu+omrhOBgnZpJFNQ@mail.gmail.com>	<50AA3732.5000701@xenomai.org>	<CAL7_A_VBCVX9o4_m4DEH7iDAf423UiowDGy+FhD_VZLcfonq9g@mail.gmail.com>	<50BC705D.2040407@xenomai.org>
	<CAL7_A_XHtj19V3gnog7_Hoer6UGxRJfoFwT0sgzQvhtARB3b9A@mail.gmail.com>
In-Reply-To: <CAL7_A_XHtj19V3gnog7_Hoer6UGxRJfoFwT0sgzQvhtARB3b9A@mail.gmail.com>
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
Cc: Xenomai <xenomai@xenomai.org>

On 01/21/2013 01:06 PM, Jens K=C3=B6hler wrote:

> Hello Gilles,
>=20
> I did not understand your latests statement. What do you mean with "If
> you expect a task using a Linux semaphore to have bounded latencies,
> you misunderstood the way Xenomai works."
>=20
> Do you think it should work without problems, without delays, latencies=
?
> Do you know if someone has already used linux semaphores in a xenomai t=
hread?
> What do you recommend to find reason and a solution?


Using a Linux semaphore causes a switch to secondary mode, which means
potentially unbounded latencies.

Please keep the list in CC.

--=20
                                                                Gilles.


