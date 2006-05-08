Message-ID: <b647ffbd0605080318q390fea8dm9ab67da488d6488b@domain.hid>
Date: Mon, 8 May 2006 12:18:42 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <17502.32006.418774.459215@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <17502.13773.674199.219762@domain.hid>
	<445E637A.5080706@domain.hid>
	<17502.32006.418774.459215@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On 08/05/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Jan Kiszka wrote:
>  > Likely I did not yet get the full picture: What prevents using another
>  > adeos per-task key for this?
>
> We would need a per-task key for every skin that needs a per-process
> data, but more importantly, we would need to track the clone syscalls
> (that would be another adeos event) in order to propagate the per-task
> data to each thread of the process. Or maybe ptds are inherited upon
> clone ?

All of them are cleared in kernel/fork.c :: copy_process(). At least,
the one pointed by "nkgkptd" (keeps shadow's xnthread_t *) must be
cleared. Another logic could be applied for the rest, I guess.

p.s. I haven't read you patch yet so all said above is out of current conte=
xt :)

--
Best regards,
Dmitry Adamushko

