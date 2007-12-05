From: Dennis Nguyen <dennisnguy@domain.hid>
In-Reply-To: <2ff1a98a0712050209o2737f0a9oa9da90859fe5a827@domain.hid>
References: <47563A68.8060404@domain.hid>
	<2ff1a98a0712050209o2737f0a9oa9da90859fe5a827@domain.hid>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 09:44:10 -0800
Message-Id: <1196876650.22401.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] undefined reference to `rt_printf(char const*,
	...)'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2007-12-05 at 11:09 +0100, Gilles Chanteperdrix wrote:
> On Dec 5, 2007 6:43 AM, Dennis Nguyen <dennisnguy@domain.hid> wrote:
> > Hello all,
> >
> > I got the "undefined reference to rt_printf" function when I called
> > rt_printf in my application.  I included the header #include <rtdk.h> in
> > the source file and -L /usr/xenomai/lib -lrtdk -lpthread-rt in the
> > makefile.  I'm using kernel i386 2.6.23.9 and xenomai 2-4rc7. I have the
> > rtdk.h include file in /usr/xenomai/include and librtdk.so in the
> > /usr/xenomai/lib.
> > What am I missing?
> 
> Does the attached patch help ?
> 
Thanks Gilles,
Yes, the patch helped. My application is a cpp file.
Dennis


