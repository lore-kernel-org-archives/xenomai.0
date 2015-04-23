From: Henry Bausley <hbausley@deltatau.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Apr 2015 07:18:29 -0700
Message-ID: <1429798709.21270.3.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] segfaults when using xenomai shared library
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I am seeing a intermittent segfaults when linking to a shared library
that links with xenomai.

I sometimes get
[30354.351344] projpp[25002]: segfault at c ip b751bcfa sp b770c238
error 4 in libpthread-2.19.so[b7511000+18000]

My shared library libppmac.so contains a single function and absolutely
nothing else

int Test(void)
{
  return 1 + 1;
}

ldd returns

root@10.34.9.73:/opt/ppmac/libppmac# ldd libppmac.so 
	linux-gate.so.1 =>  (0xb7779000)
	libpthread_rt.so.1 => /usr/lib/libpthread_rt.so.1 (0xb774e000)
	libxenomai.so.0 => /usr/lib/libxenomai.so.0 (0xb7746000)
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xb7596000)
	libpthread.so.0 => /lib/i386-linux-gnu/libpthread.so.0 (0xb757a000)
	librt.so.1 => /lib/i386-linux-gnu/librt.so.1 (0xb7571000)
	/lib/ld-linux.so.2 (0xb777a000)

My application does not even call the function in the shared library.
Its code is as follows

#include <pthread.h>
#include <dlfcn.h>

int Test(void);

int main(int argc, char *argv[])
{
  printf("pthread_setschedparam(pthread_self(),SCHED_OTHER,&param);\n");
}

int CallLibraryToBreak(void)
{
  Test();
}

The application does not segfault if I do not link the xenomai libraries
ie. 

root@10.34.9.73:/opt/ppmac/libppmac# ldd libppmac.so
	linux-gate.so.1 =>  (0xb77ac000)
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xb75de000)
	/lib/ld-linux.so.2 (0xb77ad000)

I am using i686 ubuntu 14.04 with 3.14.28-xenomai-2.6.4  any suggestions
would be greatly appreciated.

I use the script below to check if the program faults
#!/bin/bash
test=`./projpp | grep SCHED_OTHER`

while [ $test ]
do
test=`./projpp | grep SCHED_OTHER`
done
echo 'Crashed'




Outbound scan for Spam or Virus by Barracuda at Delta Tau


