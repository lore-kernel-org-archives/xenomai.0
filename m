Date: Tue, 4 Nov 2014 14:30:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141104133014.GA16558@sisyphus.hd.free.fr>
References: <297545433.13742.1415102393951.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297545433.13742.1415102393951.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Serial realtime communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Nov 04, 2014 at 12:59:53PM +0100, Huy Cong Vu wrote:
> Hello everyone, 
> I have a Linux thread which read/write to a device connected by
> usb port & I would like to bring it to Xenomai realtime by using
> rtdm library.

There is no support for this in Xenomai sources, you will have to
use external libraries, but please do not ask support for these
libraries on this mailing list: since it is code we do not maintain,
it will be hard for us to support it.

> What I wonder is the difference between the functions of rtdm & those of POSIX Xenomai skins, if the goal is only to bring the realtime properties to the process. 
> For example, rt_dev_open() (of rtdm) & open() (of POSIX Xenomai). When I use open() of POSIX Xenomai, it works fine, but with rt_dev_open(), it returns -19 as output, with the same port address: 
> #define ENODEV 19 /* No such device */ 

That is simple: the posix skin open calls rt_dev_open, and if that
fails with -ENODEV (or -ENOSYS), calls the plain Linux open, as can
be seen here: 

http://git.xenomai.org/xenomai-2.6.git/tree/src/skins/posix/rtdm.c#n63

The difference is that the POSIX skin is supposed to allow you
to work both with Xenomai services and with Linux services. When
your program wants to open a non real-time device, it can still use
open instead of having to use __real_open. This allows compiling the
same program for xenomai or not with minimal changes.

> And then, I don't really understand the purpose of making a serial communication become "realtime", which means that making the read() procedure more deterministically? 

Well, to make a serial communication become "realtime", you first
need an RTDM based driver. And yes, once you have an RTDM driver,
when a task is suspended by "read", it is handled by Xenomai
real-time scheduler. This way, it can not experience unbounded waits
dues to the fact that Linux scheduler does not guarantee bounded
latencies.

-- 
					    Gilles.

