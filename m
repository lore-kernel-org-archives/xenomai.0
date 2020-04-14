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
 <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
 <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
In-Reply-To: <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 14 Apr 2020 12:23:42 +0200
Message-ID: <CAFLxGvzkubcKhrzWvHQqQ6Stv4xD=LU2k6Uvhymk=YKHpKt91w@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On Tue, Apr 14, 2020 at 12:07 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 14.04.20 11:46, Richard Weinberger wrote:
> > On Tue, Apr 14, 2020 at 11:11 AM Petr =C4=8Cervenka <grugh@centrum.cz> =
wrote:
> >>
> >>> I fear there seems to be a confusion between POSIX tasks and POSIX sk=
in.
> >>> Is your goal programming Xenomai realtime threads using POSIX alike A=
PIs?
> >>> Or are you looking for a pedant of rt_task_unblock() to unblock a
> >>> POSIX task, without Xenomai realtime threads?
> >>>
> >>> The solution I provided is for the latter case.
> >>
> >>
> >>
> >> My original goal was to port a very complex realtime application from =
Xenomai 2.6.5 Native skin to Xenomai 3.1 POSIX skin. So I made series of ex=
amples, where I tried to verify porting of several designs used in the orig=
. application. And rt_task_unblock() for reconfiguration of the waiting thr=
eads in the orig app was one of them.
> >>
> >> Now I'm very curious, why the (my explicit) signals in Xenomai POSIX s=
kin are not working for me as I would expect.
> >>
> >>
> >>
> >> Here is my compile command:
> >>
> >> g++ -fasynchronous-unwind-tables   -c -g -D_DEBUG -D_GNU_SOURCE -D_REE=
NTRANT -D__COBALT_WRAP__ -D__COBALT__ -I/usr/xenomai/include/cobalt -I/usr/=
xenomai/include -MMD -MP -MF "build/Debug/GNU-Linux/main.o.d" -o build/Debu=
g/GNU-Linux/main.o main.cpp
> >>
> >>
> >>
> >> Here is my link command:
> >>
> >> g++ -fasynchronous-unwind-tables    -o dist/Debug/GNU-Linux/countertes=
tapp_4 build/Debug/GNU-Linux/main.o -L/usr/xenomai/lib -Wl,-rpath,'/usr/xen=
omai/lib' -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/us=
r/xenomai/lib/modechk.wrappers /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--w=
rap=3Dmain -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -lcobalt -lmode=
chk -lpthread -lrt
> >>
> >>
> >>
> >> I'm using Netbeans IDE for my attemps, but the I tried to integrate xe=
no-config --posix --cflags or --ldflags result into the project settings as=
 much as possible.
> >
> > Okay. Now things get clearer.
> > pthread_kill() will be wrapped to Xenomai, but you installed a signal
> > handler for a Linux process.
> >
> > What you basically need is a function in the Xenomai POSIX skin which
> > calls threadobj_unblock().
> >
>
> Below the working version for unblocking the RT task with non-RT signal.

This interrupts the Linux syscall, yes. Does this also work when the
thread blocks on the Xenomai/Cobalt side?

--=20
Thanks,
//richard

