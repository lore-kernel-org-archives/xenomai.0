MIME-Version: 1.0
References: <CA+K1mPFj0B28UNzcM-uF1Z6BPHVXO5sdceuyHhQEijU=qEwNNw@mail.gmail.com>
 <ac42ca13-53da-c5e6-47aa-5ad796a6e38a@siemens.com>
In-Reply-To: <ac42ca13-53da-c5e6-47aa-5ad796a6e38a@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 11 Nov 2021 00:52:46 -0800
Message-ID: <CA+K1mPGza+MLZUbtQKJJ7Zsq+5d1Rt5OhQaBFq+uxkrBbWge2A@mail.gmail.com>
Subject: Re: access errno in Xeno 3.1
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
Cc: Xenomai List <xenomai@xenomai.org>

OK that makes sense.
thanks,  -C Smith

On Thu, Nov 11, 2021 at 12:27 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 11.11.21 08:33, C Smith via Xenomai wrote:
> > I can compile a rtdm kernel module OK with Xenomai 3.1 but I can't
> > seem to get my module to see errno.
> >
> > In several Xenomai example sources I see :
> > #include <errno.h>
> > but when I put that in my rtdm code I must also add to my Makefile:
> > -I/usr/src/linux/. Is that the right include path?
> >
> > Even once I do all that, when I compile I get:
> > error: =E2=80=98errno=E2=80=99 undeclared (first use in this function)
> >           rtdm_printk("warning, munmap returned errno: %d\n", errno);
> >
>
> The kernel has no errno variable. That is a user space concept. In the
> kernel, you usually get errors via the return code of the function you
> invoked.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

