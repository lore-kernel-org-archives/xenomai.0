MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
 <20200414101600.F9AA555D@centrum.cz>
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
 <20200414111059.39716137@centrum.cz>
In-Reply-To: <20200414111059.39716137@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 14 Apr 2020 11:46:14 +0200
Message-ID: <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
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
To: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, Apr 14, 2020 at 11:11 AM Petr =C4=8Cervenka <grugh@centrum.cz> wrot=
e:
>
> > I fear there seems to be a confusion between POSIX tasks and POSIX skin=
.
> > Is your goal programming Xenomai realtime threads using POSIX alike API=
s?
> > Or are you looking for a pedant of rt_task_unblock() to unblock a
> > POSIX task, without Xenomai realtime threads?
> >
> > The solution I provided is for the latter case.
>
>
>
> My original goal was to port a very complex realtime application from Xen=
omai 2.6.5 Native skin to Xenomai 3.1 POSIX skin. So I made series of examp=
les, where I tried to verify porting of several designs used in the orig. a=
pplication. And rt_task_unblock() for reconfiguration of the waiting thread=
s in the orig app was one of them.
>
> Now I'm very curious, why the (my explicit) signals in Xenomai POSIX skin=
 are not working for me as I would expect.
>
>
>
> Here is my compile command:
>
> g++ -fasynchronous-unwind-tables   -c -g -D_DEBUG -D_GNU_SOURCE -D_REENTR=
ANT -D__COBALT_WRAP__ -D__COBALT__ -I/usr/xenomai/include/cobalt -I/usr/xen=
omai/include -MMD -MP -MF "build/Debug/GNU-Linux/main.o.d" -o build/Debug/G=
NU-Linux/main.o main.cpp
>
>
>
> Here is my link command:
>
> g++ -fasynchronous-unwind-tables    -o dist/Debug/GNU-Linux/countertestap=
p_4 build/Debug/GNU-Linux/main.o -L/usr/xenomai/lib -Wl,-rpath,'/usr/xenoma=
i/lib' -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/x=
enomai/lib/modechk.wrappers /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=
=3Dmain -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -lcobalt -lmodechk=
 -lpthread -lrt
>
>
>
> I'm using Netbeans IDE for my attemps, but the I tried to integrate xeno-=
config --posix --cflags or --ldflags result into the project settings as mu=
ch as possible.

Okay. Now things get clearer.
pthread_kill() will be wrapped to Xenomai, but you installed a signal
handler for a Linux process.

What you basically need is a function in the Xenomai POSIX skin which
calls threadobj_unblock().

--=20
Thanks,
//richard

