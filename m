MIME-Version: 1.0
References: <004201d4dd27$c0ae2bd0$420a8370$@mail.sdu.edu.cn>
In-Reply-To: <004201d4dd27$c0ae2bd0$420a8370$@mail.sdu.edu.cn>
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Mon, 18 Mar 2019 14:18:15 +0800
Message-ID: <CAKbLDQPakavk72qZG_c_OMxiA6P8+Gf+YNrpTT8sW5z2Tr36qw@mail.gmail.com>
Subject: Re: Application compile problem when use RTnet
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
To: =?UTF-8?B?5p2O5Yaw?= <bingli@mail.sdu.edu.cn>
Cc: xenomai@xenomai.org

On Mon, Mar 18, 2019 at 9:13 AM =E6=9D=8E=E5=86=B0 via Xenomai <xenomai@xen=
omai.org> wrote:

> Hi everyone:
>
>   I am new to RTnet. I am using xenomai + RTnet in Ubuntu=EF=BC=8CXenomai=
 version
> 3.0.5,  Linux kernal version 4.9.38. And the ethernet card is Intel e1000=
.
>
>   I am going to program use RTnet to communicate with another device call=
ed
> RTDS. And I can=E2=80=99t find any example in except demo in Xenomai 2. S=
o I try to
> compile the demo code in Xenomai 2.But I got an error when I compile the
> demo code. The code in demo is as below:
>
>
>
> #include <alchemy/task.h>
>
> #include <rtdm/rtdm.h>
>
> #include <trank/rtdm/rtdm.h>
>
> // #include <rtdm/uapi/rtdm.h>   The original code in the example, but
> there
> is no rtdm.h file in uapi folder.
>
> #include <linux/net.h>   /* required for rt_task_wait_period() changes */
>
>
>
> When I compile the code, It throw an error :
>
> ```
>
> In file included from frag-ip.c:37:0:
>
> /usr/xenomai/include/trank/rtdm/rtdm.h:21:28: fatal error: rtdm/rtdm.h: N=
o
> such file or directory
>
> compilation terminated.
>
> ```
>
> The error is from =E2=80=9C/usr/xenomai/include/trank/rtdm/rtdm.h=E2=80=
=9D , and I put the
> code below in rtdm.h
>
>
>
> #ifndef _XENOMAI_TRANK_RTDM_RTDM_H
>
> #define _XENOMAI_TRANK_RTDM_RTDM_H
>
> #include_next <rtdm/rtdm.h>              //Error is form this statement
>
>  #ifdef __cplusplus
>
> extern "C" {
>
> #endif
>
>
>
> I use the makefile as below:
>
>
>
> XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
>
> CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --cflags)
>
> LDFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --ldflags)
>
> CC :=3D gcc
>
> EXECUTABLE :=3D frag-ip
>
> all: $(EXECUTABLE)
>
> %: %.c
>
>         $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>
>
>
> I am so confused, and I can=E2=80=99t sovle the problem , so if there som=
e one
> understand where this problem is?
>
> Thanks for everyone who spend time to give me some help!
>
>
> Hi,

I think that you might have to include the "--rtdm" in xeno-config. I've
had some issues with compiling code when I don't put in that flag. However,
I am using the alchemy api so things may be different. But you can try and
see anyway.

Best,
-Ashwin
