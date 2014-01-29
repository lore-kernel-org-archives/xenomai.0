From: Paul <paul_c@tuxcnc.org>
Date: Wed, 29 Jan 2014 13:46:48 +0000
References: <1390987721.64002.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <52E8CF13.4070904@xenomai.org>
In-Reply-To: <52E8CF13.4070904@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201401291346.49045.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Cross-compile vanilla kernel to armhf fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wednesday 29 January 2014, Gilles Chanteperdrix wrote:
> On 01/29/2014 10:28 AM, Huub Van Niekerk wrote:
> > Hi,
> >
> > I'm trying to cross-compile xenomai-2.6.3 patched vanilla linux
> > kernel 3.5.7 to armhf using this command:
> >
> > /Downloads/linux-3.5.7$ CONCURRENCY_LEVEL=2 CLEAN_SOURCE=no
> > DEB_HOST_ARCH=armhf fakeroot make-kpkg --arch arm --cross-compile
> > /usr/bin/arm-linux-gnueabihf- --initrd --append-to-version
> > -xenomai-2.6.3 --revision 1.0 kernel_image kernel_headers
> >
> >
> > and get this error:
> >
> >    CC      drivers/xenomai/testing/timerbench.o
> >    LD      drivers/xenomai/testing/xeno_timerbench.o
> >    LD      drivers/xenomai/testing/xeno_switchtest.o
> >    LD      drivers/xenomai/testing/built-in.o
> >    LD      drivers/xenomai/built-in.o
> >    LD      drivers/built-in.o
> > make[1]: Leaving directory `/home/huub/Downloads/linux-3.5.7'
> > make: *** [debian/stamp/build/kernel] Error 2
> >
> >
> > I've tried to find a possible cause but found nothing. Can anyone
> > please direct me into a possible solution ?
>
> You are lacking the line with the actual error. The full log should
> contain it. Otherwise you can try without CONCURRENCY_LEVEL, in which
> case make should stop immediately after the error.

You may also need:
	--subarch armhf
as an option passed to make-kpkg...

But the first question should be, can you cross compile a kernel for the 
target using the standard kernel make ?

If you can't, then using make-kpkg will fail also.

