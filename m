From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Wed, 18 Nov 2009 09:49:03 -0500
Message-ID: <245373446233674495BCA5CA2FC1EB173017033106@domain.hid>
References: <245373446233674495BCA5CA2FC1EB173017033105@domain.hid>
In-Reply-To: <245373446233674495BCA5CA2FC1EB173017033105@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Patch to prevent loss of initial thread priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

> We had the problem that one of our threads, which we initially assigned p=
riority 29, ended up having priority 89.
> I know that PI is the reason why the priority of the thread was first bum=
ped up to 89 and then to 90 because
> two higher priority threads started blocking on two different mutexes own=
ed by the thread (initial priority 29).

Ok. I forgot to tell u that the thread went to sleep because it started wai=
ting for a message from a message=20
queue right in between the two PI events.=20

Andreas

