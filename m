From: Henry Bausley <hbausley@deltatau.com>
In-Reply-To: <20150423143407.GI7109@hermes.click-hack.org>
References: <1429798709.21270.3.camel@lx-henry>
 <20150423143407.GI7109@hermes.click-hack.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Apr 2015 07:47:46 -0700
Message-ID: <1429800466.21270.7.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segfaults when using xenomai shared library
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2015-04-23 at 16:34 +0200, Gilles Chanteperdrix wrote:
> On Thu, Apr 23, 2015 at 07:18:29AM -0700, Henry Bausley wrote:
> > I am seeing a intermittent segfaults when linking to a shared library
> > that links with xenomai.
> > 
> > I sometimes get
> > [30354.351344] projpp[25002]: segfault at c ip b751bcfa sp b770c238
> > error 4 in libpthread-2.19.so[b7511000+18000]
> > 
> > My shared library libppmac.so contains a single function and absolutely
> > nothing else
> > 
> > int Test(void)
> > {
> >   return 1 + 1;
> > }
> > 
> > ldd returns
> > 
> > root@10.34.9.73:/opt/ppmac/libppmac# ldd libppmac.so 
> > 	linux-gate.so.1 =>  (0xb7779000)
> > 	libpthread_rt.so.1 => /usr/lib/libpthread_rt.so.1 (0xb774e000)
> > 	libxenomai.so.0 => /usr/lib/libxenomai.so.0 (0xb7746000)
> > 	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xb7596000)
> > 	libpthread.so.0 => /lib/i386-linux-gnu/libpthread.so.0 (0xb757a000)
> > 	librt.so.1 => /lib/i386-linux-gnu/librt.so.1 (0xb7571000)
> > 	/lib/ld-linux.so.2 (0xb777a000)
> > 
> > My application does not even call the function in the shared library.
> > Its code is as follows
> > 
> > #include <pthread.h>
> > #include <dlfcn.h>
> > 
> > int Test(void);
> > 
> > int main(int argc, char *argv[])
> > {
> >   printf("pthread_setschedparam(pthread_self(),SCHED_OTHER,&param);\n");
> > }
> > 
> > int CallLibraryToBreak(void)
> > {
> >   Test();
> > }
> > 
> > The application does not segfault if I do not link the xenomai libraries
> > ie. 
> 
> There is a case you seem to not have tested. What about linking with
> xenomai libraries without linking to libppmac.so ?
> 
Linking w/o libppmac.so does not segfault. 

root@10.34.9.73:/opt/ppmac/projpp# ldd projpp
	linux-gate.so.1 =>  (0xb7741000)
	libpthread_rt.so.1 => /usr/lib/libpthread_rt.so.1 (0xb7719000)
	libxenomai.so.0 => /usr/lib/libxenomai.so.0 (0xb7711000)
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xb7561000)
	libpthread.so.0 => /lib/i386-linux-gnu/libpthread.so.0 (0xb7545000)
	librt.so.1 => /lib/i386-linux-gnu/librt.so.1 (0xb753c000)
	/lib/ld-linux.so.2 (0xb7742000)
root@10.34.9.73:/opt/ppmac/projpp# ./test.sh





Outbound scan for Spam or Virus by Barracuda at Delta Tau


