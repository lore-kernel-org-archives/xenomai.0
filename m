MIME-Version: 1.0
References: <CAAvDm6YS03s6A76n_As4Bo4BkpcdYXOzmSkC3LGCseTJv_fTfA@mail.gmail.com>
 <BN6PR11MB16203EC08765DE4712447835EEA00@BN6PR11MB1620.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB16203EC08765DE4712447835EEA00@BN6PR11MB1620.namprd11.prod.outlook.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 11 May 2020 13:10:27 +0800
Message-ID: <CAAvDm6ZxYUq10Bm=stKRNboob9sm5NZOsF5KroKu9x-QcjMj9A@mail.gmail.com>
Subject: Re: Q: about mutex lock bettween rt thread and nrt thread.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,
    Thank you for your response.

    >>If Head domain's interrupts & threads occupied CPU, the system may
deadlock there since nothing can kill them.
    What do you mean? I could not get the idea.When this happen? And
how?Does it have relation to XDDP?

    Thank you for your attention.
    Look forward to hearing from you.

Meng, Fino <fino.meng@intel.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8810=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:17=E5=86=99=E9=81=93=EF=BC=9A

>
> >Sent: Sunday, May 10, 2020 1:12 PM
> >
> >Hi,
> >I think mutex lock should not be shared bettween rt thread and nrt
> thread, because if i use the posix mutex api
> >implemented by linux,it causes the rt thread switch to the secondary mod=
e.
> >
> >    As per the documentation(https://xenomai.org/documentation/
> >xenomai-3/html/xeno3prm/group__alchemy__mutex.html
> >#ga8f7db304bb5a839d81614f00c4cde145),
> >the mutex api implemented by xenomai could not be used in normal linux
> thread.
> >
> >So,how to share the same mutex bettween rt thread and nrt thread?Could
> you offer some guidance on that?
> >
> >Thank you for your attention.
> >Looking forward to hearing from you.
>
> I would like to say, if subconsciously want to use mutex or some other
> lock between Cobalt thread
> and Linux kernel thread, it's better find another pattern to exchange dat=
a
> other than a mutex/lock. For example,
> Cobalt thread continuous write data to a piece of memory, Linux kernel
> thread continuous read.
> This may lose some samples although, but can let Cobalt thread return
> immediately without blocking.
> If lose sample is not acceptable, try XDDP,  Cobalt thread can also
> write&return without blocking.
> If Head domain's interrupts & threads occupied CPU, the system may
> deadlock there since nothing can kill them.
>
>
> BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> Intel =E2=80=93 IOTG Developer Enabling
>
