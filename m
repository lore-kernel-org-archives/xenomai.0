MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18327.41159.877097.684423@domain.hid>
Date: Wed, 23 Jan 2008 21:17:11 +0100
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A014A26202B@FND-MAILB03.VIA.DK>
References: <2220D86D21B55040AB683933DBD97B5A014A26202B@FND-MAILB03.VIA.DK>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Calling rt_task_start with cookie not NULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hans S=F8ndergaard (HSO) wrote:
 > The rt_task_start has the following signature:
 >=20
 > int rt_task_start (RT_TASK * task, void(*)(void *cookie) entry, void * c=
ookie);
 >=20
 > but I have not been able to find any example where the cookie parameter =
is not NULL.
 >=20
 > I am programming an example, where the entry function need some paramete=
rs (five).
 >=20
 > Can someone tell me how to do that?

you could pass a pointer to a structure containing the five parameters
as a cookie. If you want to allocate the structure on stack, you should
take care of synchronizing the starting thread with the thread which
calls rt_task_start, using, for instance, a semaphore. For instance:

struct five_parms {
        unsigned parm1;
        int parm2;
        void *parm3;
        long long parm4;
        int parm5;
};

RT_SEM five_parms_done;

void task_entry(void *cookie)
{
        struct five_parms *parms =3D (struct five_parms *) cookie;
        unsigned parm1;
        int parm2;
        void *parm3;
        long long parm4;
        int parm5;

        parm1 =3D parms->parm1;
        parm2 =3D parms->parm2;
        parm3 =3D parms->parm3;
        parm4 =3D parms->parm4;
        parm5 =3D parms->parm5;

        rt_sem_v(&five_parms_done);

        /* Your code here. */
}

void some_other_function(void)
{
        struct five_parms parms;
        RT_TASK task;
        /* Your code here. */
        parms.parm1 =3D 12;
        parms.parm2 =3D -42;
        parms.parm3 =3D NULL;
        parms.parm4 =3D 20000000000LL;
        parms.parm5 =3D 1;

        rt_task_start(&task, task_entry, &parms);
        rt_sem_p(&five_parms_done, TM_INFINITE);
}

If you plan to routinely pass 5 arguments to all the tasks you
create, you can go one step further by defining your own wrapper of
rt_task_start. For instance:

typedef void entry_5parms(unsigned, int, void *, long long, int);

struct five_parms {
        unsigned parm1;
        int parm2;
        void *parm3;
        long long parm4;
        int parm5;
        entry_5parms *entry;
};

RT_SEM five_parms_done;

void task_trampoline(void *cookie)
{
        struct five_parms *parms =3D (struct five_parms *) cookie;
        entry_5parms *entry;
        unsigned parm1;
        int parm2;
        void *parm3;
        long long parm4;
        int parm5;

        parm1 =3D parms->parm1;
        parm2 =3D parms->parm2;
        parm3 =3D parms->parm3;
        parm4 =3D parms->parm4;
        parm5 =3D parms->parm5;
        entry =3D parms->entry;

        rt_sem_v(&five_parms_done);

        entry(parm1, parm2, parm3, parm4, parm5);
}

rt_task_start(RT_TASK *task, entry_5parms *entry, unsigned parm1,=20
              int parm2, void *parm3, long long parm4, int parm5)
{
        struct five_parms parms;
        RT_TASK task;
        int err;

        /* Your code here. */
        parms.parm1 =3D parm1;
        parms.parm2 =3D parm2;
        parms.parm3 =3D parm3;
        parms.parm4 =3D parm4;
        parms.parm5 =3D parm5;
        parms.entry =3D entry;

        err =3D rt_task_start(task, task_trampoline, &parms);

        if (!err)
                rt_sem_p(&five_parms_done, TM_INFINITE);

        return err;
}
           =20
I have been lazy, and not checked all the return values of all xenomai
services, which real code should do. Also note that I did not show the
initialization of the semaphore, but real code needs that too.

--=20


					    Gilles Chanteperdrix.

