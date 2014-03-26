MIME-Version: 1.0
In-Reply-To: <53316C4C.6000708@sigmatek.at>
References: <53316C4C.6000708@sigmatek.at>
Date: Wed, 26 Mar 2014 17:49:41 +0100
Message-ID: <CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: erwin.pranz@sigmatek.at
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Mar 25, 2014 at 12:45 PM, Erwin Pranz <erwin.pranz@sigmatek.at>wrot=
e:

> Hello,
>
> I am using rtdm_mutex_lock/rtdm_mutex_unlock in a rtdm driver and I get a
> signal SIGDEBUG_MIGRATE_PRIOINV when I call the driver from a priority-0
> thread.The signal is sent in xnsynch_release_thread when rescnt is 0 on a
> XNOTHER thread, which means that rescnt is not balanced.
>
> I think the reason why rescnt is not balanced is in rtdm_mutex_timedlock:
> when the owner of the mutex is NULL, the owner is changed to the calling
> thread, but rescnt is not increased.
>
> I suggest the following fix in rtdm_mutex_timedlock:
> -       else if (likely(xnsynch_owner(&mutex->synch_base) =3D=3D NULL))
> +       else if (likely(xnsynch_owner(&mutex->synch_base) =3D=3D NULL)) {
>                 xnsynch_set_owner(&mutex->synch_base, curr_thread);
> +               if (xnthread_test_state(curr_thread, XNOTHER))
> +                       xnthread_inc_rescnt(curr_thread);
> +       }
>
>
Hi Gilles,

Could you maybe elaborate on this? It seems the resource counting is not in
balance. It would be great to know if this the correct way to fix it.

The problem should be easily reproducible by having just one shadowed
priority 0 thread that somehow calls rtdm_mutex_lock directly followed by
rtdm_mutex_unlock. This will trigger the code in ksrc/nucleus/synch.c that
was added by commit-486afd15, which sends SIGDEBUG_MIGRATE_PRIOINV on
Xenomai v2.6.2.1. It shouldn't send any signal in that case, as nothing is
wrong.

Note we are on Xenomai v2.6.2.1. Xenomai v2.6.3 sends (the better name for
it) SIGDEBUG_RESCNT_IMBALANCE.

Thanks for your help,
Henri


> Best regards,
>
> --
> Erwin Pranz
> Software
> ________________________________
>
> SIGMATEK GmbH & Co KG
> Sigmatekstra=DFe 1
> 5112 Lamprechtshausen =D6sterreich / Austria
>
> Tel.:  +43/6274/4321-0
> Fax:  +43/6274/4321-18
> E-Mail: erwin.pranz@sigmatek.at
> http://www.sigmatek-automation.com
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
