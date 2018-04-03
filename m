MIME-Version: 1.0
In-Reply-To: <CAOuPNLjLT==YZU3EEDWvfoJBhR4bsYtKyMCTfz6SNt+YSxYzSQ@mail.gmail.com>
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
 <CAOuPNLjLT==YZU3EEDWvfoJBhR4bsYtKyMCTfz6SNt+YSxYzSQ@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 3 Apr 2018 16:14:19 +0530
Message-ID: <CAOuPNLjwJj1iw6wkhceaOs4S=KL=v01nrQ6B3edbOweBRasE+w@mail.gmail.com>
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

Any clue on this?

I guess native and alchemy skin is internally same.
Then why rt_dev_xxx does not work with alchemy skin.
Please let me know the alternate API to invoke rtdm driver with alchemy ski=
n.

Thanks,
Pintu


On Mon, Apr 2, 2018 at 7:18 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Hi,
>
> I tried changing "native" skin to "alchemy" skin and replaced header
> from native/timer.h to alchemy/timer.h
> But when I build my rtdm application, I get below error:
>
> app_test.c: In function =E2=80=98main=E2=80=99:
> app_test.c:41:7: warning: implicit declaration of function
> =E2=80=98rt_dev_open=E2=80=99 [-Wimplicit-function-declaration]
>   fd =3D rt_dev_open(DEVICE_NAME, O_RDWR);
>        ^
> app_test.c:50:8: warning: implicit declaration of function
> =E2=80=98rt_dev_write=E2=80=99 [-Wimplicit-function-declaration]
>   ret =3D rt_dev_write(fd, msg, len);
>         ^
> app_test.c:65:8: warning: implicit declaration of function
> =E2=80=98rt_dev_read=E2=80=99 [-Wimplicit-function-declaration]
>   ret =3D rt_dev_read(fd, buff, len);
>         ^
> app_test.c:76:2: warning: implicit declaration of function
> =E2=80=98rt_dev_close=E2=80=99 [-Wimplicit-function-declaration]
>   rt_dev_close(fd);
>   ^
> /tmp/ccTcHyFz.o: In function `main':
> app_test.c:(.text.startup+0x45): undefined reference to `rt_dev_open'
> app_test.c:(.text.startup+0x85): undefined reference to `rt_dev_write'
> app_test.c:(.text.startup+0xf2): undefined reference to `rt_dev_read'
> app_test.c:(.text.startup+0x15e): undefined reference to `rt_dev_close'
> collect2: error: ld returned 1 exit status
> Makefile:11: recipe for target 'app_test' failed
> make: *** [app_test] Error 1
>
> ---------------------------------------
> I even tried adding "-lrtdm" to the cflags but it did not work.
> skin =3D alchemy
> CC :=3D $(shell $(INSTALL_PATH)/xeno-config --cc)
> CFLAGS :=3D $(shell $(INSTALL_PATH)/xeno-config --skin=3D$(skin) --cflags=
)
> -O2 -lrtdm
>
> I am using Xenomai-3.0.
>
> Is there any specific library I need to include for alchemy with RTDM API=
?
>
>
>
> Thanks,
> Pintu
>
>

