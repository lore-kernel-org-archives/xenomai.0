From: Henry Bausley <hbausley@domain.hid>
In-Reply-To: <4926859D.4090208@domain.hid>
References: <1227226604.13217.13.camel@domain.hid>
	<4926859D.4090208@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 10:25:06 -0800
Message-Id: <1228242306.29066.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shared memory mlockall error w/ mono	interpreter?
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

The mono application doesn't need realtime services.  But it does need
access to DPRAM.

It crashes with the message:
Xenomai: process memory not locked (missing mlockall?)

On Fri, 2008-11-21 at 10:55 +0100, Gilles Chanteperdrix wrote:
> Henry Bausley wrote:
> > We have an application that uses shared memory to communicate from our
> > kernel driver to user space.  In our own standard C applications we can
> > issue an mlockall and we can use multiple threads without a problem.
> > 
> > However, we are also using the mono .NET interpreter which links to a
> > shared library that links to the xenomai shared memory and issues a
> > mlockall.  Whenever we run programs using the mono interpreter we get
> > the error message Xenomai: process memory not locked (mlockall).  mono
> > is a .NET virtual machine w/ garbage collection like java.
> 
> Does the mono application need real-time services ?
> 
> > 
> > We tried --enable-posix-auto-mlockall but the third party apps running
> > under mono still crashes with the mlockall
> 
> How does it crash ? Not enough memory ?
> 



