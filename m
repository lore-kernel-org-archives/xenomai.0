MIME-Version: 1.0
In-Reply-To: <823c2008-4b4b-9b0a-a84c-ee60b4304506@xenomai.org>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
 <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
 <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
 <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
 <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
 <CAOuPNLgpwc4+nk=5V_3E0k6V_oYVs1q_gfLpwiN_8jfbsYNq9g@mail.gmail.com>
 <1dd59300-7763-e9f3-cda8-2f2548e9e96c@xenomai.org>
 <CAOuPNLiwFdBO1A34A8CU6iVTPQ0VRBq6g7NR=Z3hDvke0+nbdQ@mail.gmail.com>
 <823c2008-4b4b-9b0a-a84c-ee60b4304506@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 2 Apr 2018 19:18:36 +0530
Message-ID: <CAOuPNLjLT==YZU3EEDWvfoJBhR4bsYtKyMCTfz6SNt+YSxYzSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I tried changing "native" skin to "alchemy" skin and replaced header
from native/timer.h to alchemy/timer.h
But when I build my rtdm application, I get below error:

app_test.c: In function =E2=80=98main=E2=80=99:
app_test.c:41:7: warning: implicit declaration of function
=E2=80=98rt_dev_open=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D rt_dev_open(DEVICE_NAME, O_RDWR);
       ^
app_test.c:50:8: warning: implicit declaration of function
=E2=80=98rt_dev_write=E2=80=99 [-Wimplicit-function-declaration]
  ret =3D rt_dev_write(fd, msg, len);
        ^
app_test.c:65:8: warning: implicit declaration of function
=E2=80=98rt_dev_read=E2=80=99 [-Wimplicit-function-declaration]
  ret =3D rt_dev_read(fd, buff, len);
        ^
app_test.c:76:2: warning: implicit declaration of function
=E2=80=98rt_dev_close=E2=80=99 [-Wimplicit-function-declaration]
  rt_dev_close(fd);
  ^
/tmp/ccTcHyFz.o: In function `main':
app_test.c:(.text.startup+0x45): undefined reference to `rt_dev_open'
app_test.c:(.text.startup+0x85): undefined reference to `rt_dev_write'
app_test.c:(.text.startup+0xf2): undefined reference to `rt_dev_read'
app_test.c:(.text.startup+0x15e): undefined reference to `rt_dev_close'
collect2: error: ld returned 1 exit status
Makefile:11: recipe for target 'app_test' failed
make: *** [app_test] Error 1

---------------------------------------
I even tried adding "-lrtdm" to the cflags but it did not work.
skin =3D alchemy
CC :=3D $(shell $(INSTALL_PATH)/xeno-config --cc)
CFLAGS :=3D $(shell $(INSTALL_PATH)/xeno-config --skin=3D$(skin) --cflags)
-O2 -lrtdm

I am using Xenomai-3.0.

Is there any specific library I need to include for alchemy with RTDM API?



Thanks,
Pintu




On Tue, Mar 27, 2018 at 6:35 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/27/2018 02:09 PM, Pintu Kumar wrote:
>> Hi,
>>
>> Thank you so much for all your explanation.
>> But, before I dig deeper, I have some simple questions which is troublin=
g me.
>>
>> 1) In Idle case, we see latency improvement (~2-3 micro-seconds on
>> average) using Xenomai native task application, compared to normal
>> posix thread application (with 100 us sleep).
>>     Then why not it is seen with RTDM driver and its application ?
>>
>> 2) In the idle case itself, we have seen read/write latency
>> improvement using RTNET (loopback) and simple UDP client/server
>> application using Xenomai posix skin
>>     Then why not same is visible with RTDM driver?
>>
>
> All answers have already been given, or can be inferred fairly easy from
> what was said earlier.
>
> On a general note, it is safer not to compare apples and oranges when it
> comes to benchmarking: two different codes usually do things
> differently, so you may simply not be measuring the same work load. If
> you really want to figure out what happens, you may need to dive into
> the implementation.
>
>> 3) How to choose, when to develop a Xenomai native application, and
>> when to simply convert using posix skin ?
>>
>
> Choose portability with POSIX. The so-called "native" - now Alchemy API
> - was defined 14 years ago for a single purpose: make greybards coming
> from the traditional RTOS world comfortable with API semantics close to
> what they were used to with VxWorks, VRTX, pSOS and friends.
>
> Alchemy exists in Xenomai 3 only for the purpose of making the life of
> people migrating from 2.x easier.
>
> --
> Philippe.

