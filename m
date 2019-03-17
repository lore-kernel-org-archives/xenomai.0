From: =?gb2312?B?wO6x+Q==?= <bingli@mail.sdu.edu.cn>
Subject: Application compile problem when use RTnet
Date: Sun, 17 Mar 2019 15:35:39 +0800
Message-ID: <000e01d4dc94$05438a90$0fca9fb0$@mail.sdu.edu.cn>
MIME-Version: 1.0
Content-Language: zh-cn
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone:

   I am new to RTnet. I am using xenomai + RTnet in Ubuntu=A3=ACXenomai =
version
3.0.5,  Linux kernal version 4.9.38. And the ethernet card is Intel =
e1000.

  I am going to program use RTnet to communicate with another device =
called
RTDS. And I can=A1=AFt find any example in except demo in Xenomai 2. So =
I try to
compile the demo code in Xenomai 2.But I got an error when I compile the
demo code. The code in demo is as below:

=20

#include <alchemy/task.h>

#include <rtdm/rtdm.h> =20

#include <trank/rtdm/rtdm.h>

// #include <rtdm/uapi/rtdm.h>   The original code in the example, but =
there
is no rtdm.h file in uapi folder.

#include <linux/net.h>   /* required for rt_task_wait_period() changes =
*/

=20

When I compile the code, It throw an error :

```

In file included from frag-ip.c:37:0:

/usr/xenomai/include/trank/rtdm/rtdm.h:21:28: fatal error: rtdm/rtdm.h: =
No
such file or directory

compilation terminated.

```

The error is from =A1=B0/usr/xenomai/include/trank/rtdm/rtdm.h=A1=B1 , =
and I put the
code below in rtdm.h

=20

#ifndef _XENOMAI_TRANK_RTDM_RTDM_H  =20

#define _XENOMAI_TRANK_RTDM_RTDM_H
#include_next <rtdm/rtdm.h>              //Error is form this statement
#ifdef __cplusplus


extern "C" {


#endif  =20

=20

I use the makefile as below:

=20

XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config

CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --cflags)

LDFLAGS :=3D $(shell $(XENO_CONFIG) --posix --alchemy --ldflags)

CC :=3D gcc

EXECUTABLE :=3D frag-ip

all: $(EXECUTABLE)

%: %.c

        $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

=20

I am so confused, and I can=A1=AFt sovle the problem , so if there some =
one
understand where this problem is?

Thanks for everyone who spend time to give me some help!

