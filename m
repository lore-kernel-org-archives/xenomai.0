From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Thu, 15 Oct 2009 15:21:51 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB172FEEF2DCD7@domain.hid>
References: <1254853590.3718.28.camel@domain.hid>,
	<1254859856.2784.251.camel@domain.hid>
In-Reply-To: <1254859856.2784.251.camel@domain.hid>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_245373446233674495BCA5CA2FC1EB172FEEF2DCD7RCexchangeSVR_"
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

--_002_245373446233674495BCA5CA2FC1EB172FEEF2DCD7RCexchangeSVR_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Back at work. See inline replies below.


> > > > > - powerpc32 updates for 2.6.30. Mainly to merge the once experime=
ntal
> > > > > bits that prevent most alignment faults from triggering a seconda=
ry mode
> > > > > switch. Andreas told me this works like a charm on 83xx, and I di=
d not
> > > > > see any issue on 52xx, 85xx or 86xx either.
> > > > >
> > > >
> > > > Can I get a version of that patch for testing? Is it in your git
> > > > repository?
> > >
> > > I just pushed this commit to my remote tree (ipipe-2.6.30-powerpc
> > > branch); it should appear in a few hours once mirrored (cron job).
> > >
> >
> > I finally had a chance to test the ipipe-2.6.30-powerpc version
> > from the git repository. Unfortunately, I noticed that our application
> > dies after some time and that this behaviour is related to that
> > alignment patch (if I take it out everything runs fine for > 2 days).
> >
> > Currently I'm investigating the reasons for that crash. It has
> > something to do with floating point registers not being restored
> > properly. Our alignment exceptions are mainly triggered by accesses
> > to unaligned floating point data.
>=20
> Does it work any better with this patch in?

I applied that patch but unfortunately our application still dies. I includ=
ed
an application with with you (hopefully) can reproduce the problem=20
which we are seeing. Our system is a MPC8360 with 2.6.30, ipipe 2.7,
xenomai 2.4.9.1.

Here are the steps:

1) apply ipipe with alignment patch, recompile kernel
2) comile test1.c (attached) with:=20
        gcc -Wall -O2 `xeno-config --xeno-cflags` \
                                `xeno-config --xeno-ldflags` \
                                 -l native -l rtdk  -o test1 test1.c
3) Start test1 in one shell
4) Open a second shell and start 'switchbench'

Just when 'switchbench' is running, I get the following
output from my test application:
...
Missmatch: 0xfff8000082064000
Missmatch: 0xfff8000082064000
Missmatch: 0xfff8000082064000
Missmatch: 0xfff8000082064000=20
...

It seems that test1 is interrupted right between
the lfd and stfd and the floating point regs aren't
restored properly.

Just a side note: I had to add assembly code to my
C program to force an alignment exception. gcc seems
to be smart enough to avoid unaligned access. g++
on the other hand (especially g++ 3.3.6 which we are=20
using) seems to generate assembly code which causes
alignment exceptions. So it seems that it's really g++'s=20
fault. We also discovered that our g++ generates buggy=20
floating point assembly code when compiling with the=20
-O2 or -Os option. Currently, we compile our application
with -msoft-float to avoid those issues which has the
nice side effect that we also don't get alignment exceptions
anymore.

Many thanks,
Andreas


> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 32cc3df..a04a5e3 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -80,7 +80,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
>                  * FPU, and then when we get scheduled again we would sto=
re
>                  * bogus values for the remaining FP registers.
>                  */
> -               ipipe_preempt_disable(flags);
> +               if (ipipe_root_domain_p)
> +                       preempt_disable();
> +               local_irq_save_hw_cond(flags);
>                 if (tsk->thread.regs->msr & MSR_FP) {
>  #ifdef CONFIG_SMP
>                         /*
> @@ -94,7 +96,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
>  #endif
>                         giveup_fpu(tsk);
>                 }
> -               ipipe_preempt_enable(flags);
> +               local_irq_restore_hw_cond(flags);
> +               if (ipipe_root_domain_p)
> +                       preempt_enable();
>         }
>  }

--_002_245373446233674495BCA5CA2FC1EB172FEEF2DCD7RCexchangeSVR_
Content-Type: text/x-csrc; name="test1.c"
Content-Description: test1.c
Content-Disposition: attachment; filename="test1.c"; size=1227;
	creation-date="Thu, 15 Oct 2009 15:06:45 GMT";
	modification-date="Thu, 15 Oct 2009 15:06:45 GMT"
Content-Transfer-Encoding: base64

LyogdmltOiBzZXQgdHMgPSA0OiAqLwojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHVu
aXN0ZC5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUg
PHN0ZGFyZy5oPgojaW5jbHVkZSA8cnRkay5oPgojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4KCnR5
cGVkZWYgc3RydWN0IG1zZyB7Cgl1bnNpZ25lZCBjaGFyIGlkOwoJdW5pb24gewoJCXVuc2lnbmVk
IGxvbmcgbG9uZyByYXc7CgkJc3RydWN0IHsKCQkJdW5zaWduZWQgc2hvcnQgdmFsMTsKCQkJdW5z
aWduZWQgbG9uZyB2YWwyOwoJCQl1bnNpZ25lZCBzaG9ydCB2YWwzOwoJCX0gX19hdHRyaWJ1dGVf
XygocGFja2VkKSk7Cgl9Owp9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpIG1zZ190OwoKc3RhdGlj
IFJUX1RBU0sgdGFzazsKc3RhdGljIG1zZ190IG1zZzsKCmludCBtYWluKHZvaWQpCnsKCWludCBl
cnI7CgoJbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNMX0ZVVFVSRSk7CglydF9wcmludF9hdXRvX2lu
aXQoMSk7CgoJZXJyID0gcnRfdGFza19zaGFkb3coJnRhc2ssICJtYWluIiwgMywgMCk7CglpZigh
ZXJyKSB7CgkJLyogRmlsbCB0aGUgbWVzc2FnZSAqLwoJCW1zZy5pZCA9IDB4RkY7CgkJbXNnLnZh
bDEgPSAweDEyMzQ7CgkJbXNnLnZhbDIgPSAweDU2Nzg5QUJDOwoJCW1zZy52YWwzID0gMHhERUYw
OwoKCQl3aGlsZSgxKSB7CgkJCWRvdWJsZSBzYXZlOwoJCQl1bnNpZ25lZCBsb25nIGxvbmcgb3V0
ID0gMDsKCgkJCS8qIEZvcmNlIGFuIGFsaWdubWVudCBleGNlcHRpb24KCQkJICAgYnkgYWNjZXNz
aW5nIHVuYWxpZ25lZCBmbG9hdGluZwoJCQkgICBwb2ludCBkYXRhIChsZmQgMCwxKCUyKSkuICov
CgkJCV9fYXNtX18gX192b2xhdGlsZV9fKAoJCQkic3RmZCAwLCUwICAgIyBzYXZlIGNvbnRlbnRz
IG9mIGYwIFxuXHQiCgkJCSJsZmQgMCwxKCUyKSAjIHVuYWxpZ25lZCBhY2Nlc3MgXG5cdCIKCQkJ
InN0ZmQgMCwlMSAgICMgc3RvcmUgZGF0YSBpbiAnb3V0JyBcblx0IgoJCQkibGZkIDAsJTAgICAg
IyByZXN0b3JlIGNvbnRlbnRzIG9mIGYwIFxuXHQiIAoJCQk6ICI9bSIoc2F2ZSksICI9bSIob3V0
KQoJCQk6ICJyIigmbXNnKQoJCQkpOwoKCQkJaWYoIG91dCAhPSBtc2cucmF3ICkKCQkJCXJ0X3By
aW50ZigiTWlzc21hdGNoOiAweCVsbHhcbiIsIG91dCk7CgoJCQlydF90YXNrX3NsZWVwKDEwMDAw
MFVMTCk7CgkJfQoJfQoJcmV0dXJuIGVycjsKfQoK

--_002_245373446233674495BCA5CA2FC1EB172FEEF2DCD7RCexchangeSVR_--

