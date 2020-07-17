MIME-Version: 1.0
References: <CAAvDm6bKV3jueSVTj9c5yfrxTKVd-oMj1ETX4Z2xtiV+-nGKxQ@mail.gmail.com>
 <BYAPR11MB37657E4273FDDA050513C12CEE7C0@BYAPR11MB3765.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB37657E4273FDDA050513C12CEE7C0@BYAPR11MB3765.namprd11.prod.outlook.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Fri, 17 Jul 2020 18:18:21 +0800
Message-ID: <CAAvDm6btHLntQSPLktP_ffRepTE=_Dm8=H8EgbSpe1CnV1qt1Q@mail.gmail.com>
Subject: Re: Are there some methods that could limit how much CPU resources
 could be a single Xenomai process or thread?
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
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi, =E5=AD=9F=E7=A5=A5=E5=A4=AB
Thank you for taking the time to respond to my question.

>In my understanding cgroup's design is exclusionary with real-time/determi=
nistic/time coordinate design.
>The latency/jitter is already down to 20us level,  how it can endure cgrou=
p's volatility.
I don't hold much hope, either. But I am not sure whether it's
impossible to achieve this goal or not.

>Do u really have strong requirement for this scenario?
It's a strong requirement, but not necessary.

>Maybe it will work on a highly fine-tuned environment.
Any advice on how to proceed?

Best Regards.
sunshilong(=E5=AD=99=E4=B8=96=E9=BE=99)

On Fri, Jul 17, 2020 at 8:55 AM Meng, Fino <fino.meng@intel.com> wrote:
>
> In my understanding cgroup's design is exclusionary with real-time/determ=
inistic/time coordinate design,
> The latency/jitter is already down to 20us level,  how it can endure cgro=
up's volatility,
> Do u really have strong requirement for this scenario? maybe it will work=
 on a highly fine-tuned environment.
>
> BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> Intel =E2=80=93 IOTG Developer Enabling
>
> >Sent: Thursday, July 16, 2020 8:01 PM
> >
> >Hi, list
> >
> >Are there some methods that could limit how much CPU resources could be =
maximally used by a single Xenomai process or
> >thread?
> >Does the Linux kernel's cgroup interface work for the Xenomai?
> >
> >The description about cgroup quoted from the Linux program manual:
> >The kernel's cgroup interface is provided through a pseudo-filesystem ca=
lled cgroupfs.
> >Grouping is implemented in the core cgroup kernel code, while resource t=
racking and limits are implemented in a set of per-
> >resource-type subsystems (memory, CPU, and so on).
> >
> >Thank you for your attention to this matter.
> >Looking forward to hearing from you.
> >Best Regards.
>

