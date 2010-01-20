Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Jan 2010 17:57:18 -0600
Message-ID: <181804936ABC2349BE503168465576460D7138C6@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] POSIX skin default stacksize
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm trying to determine the source of a bogus initial stack size after=
 I
initialize a pthread_attr_t with pthread_attr_init.  I'm using the POSIX
skin (obviously), but I'm not quite sure if it is getting this parameter
from Xenomai or libc.

I'm running on a custom PowerPC board with a version 2.6.24.6 kernel.=
  I
get the same result using both Xenomai 2.4.10, and 2.5.0.  I noticed the
issue after having a small program with a few number of threads that was
crashing the system with an out of memory exception.

I have a very basic program ...

----------------------main.c--------------------------
#include <stdio.h>
#include <pthread.h>
#include <limits.h>

int main(int argc, char **argv)
{
   size_t s;
   pthread_attr_t a;

   pthread_attr_init(&a);
   pthread_attr_getstacksize(&a, &s);

   printf("PTHREAD_STACK_MIN is %d\n", PTHREAD_STACK_MIN);
   printf("Default stack size is %d\n", s);

   return 0;
}
-----------------------------------------------------

For which the output is

>PTHREAD_STACK_MIN is 16384
>Default stack size is 8388608

As you can see, the stack size after I call pthread_attr_init is a
whopping 8 MB.

>From what I can tell, it is linking against the correct library.  I can
see the Xenomai options to the linker, with the -lpthread_rt and all
that.

Any idea why this would occur?

Thanks


