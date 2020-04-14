Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Tue, 14 Apr 2020 11:10:59 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>,
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>,
 <20200408114406.6119E0D9@centrum.cz>,
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>,
 <20200409170009.5B0DAA77@centrum.cz>,
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>,
 <20200409201057.74CB5ED0@centrum.cz>,
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>,
 <20200414101600.F9AA555D@centrum.cz>
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
In-Reply-To: <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20200414111059.39716137@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

> I fear there seems to be a confusion between POSIX tasks and POSIX skin.
> Is your goal programming Xenomai realtime threads using POSIX alike APIs?
> Or are you looking for a pedant of rt_task_unblock() to unblock a
> POSIX task, without Xenomai realtime threads?
 >=20
> The solution I provided is for the latter case.
=C2=A0
My original goal was to port a very complex realtime application from Xenom=
ai 2.6.5 Native skin to Xenomai 3.1 POSIX skin. So I made series of example=
s, where I tried to verify porting of several designs used in the orig. app=
lication. And rt_task_unblock() for reconfiguration of the waiting threads =
in the orig app was one of them.
Now I'm very curious, why the (my explicit) signals in Xenomai POSIX skin a=
re not working for me as I would expect.
=C2=A0
Here is my compile command:
g++ -fasynchronous-unwind-tables=C2=A0=C2=A0 -c -g -D_DEBUG -D_GNU_SOURCE -=
D_REENTRANT -D__COBALT_WRAP__ -D__COBALT__ -I/usr/xenomai/include/cobalt -I=
/usr/xenomai/include -MMD -MP -MF "build/Debug/GNU-Linux/main.o.d" -o build=
/Debug/GNU-Linux/main.o main.cpp
=C2=A0
Here is my link command:
g++ -fasynchronous-unwind-tables=C2=A0=C2=A0=C2=A0 -o dist/Debug/GNU-Linux/=
countertestapp_4 build/Debug/GNU-Linux/main.o -L/usr/xenomai/lib -Wl,-rpath=
,'/usr/xenomai/lib' -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrapper=
s -Wl,@/usr/xenomai/lib/modechk.wrappers /usr/xenomai/lib/xenomai/bootstrap=
.o -Wl,--wrap=3Dmain -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -lcob=
alt -lmodechk -lpthread -lrt
=C2=A0
I'm using Netbeans IDE for my attemps, but the I tried to integrate xeno-co=
nfig --posix --cflags or --ldflags result into the project settings as much=
 as possible.
Petr

