Message-ID: <4F130ED3.3030902@domain.hid>
Date: Sun, 15 Jan 2012 18:37:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W49F600F976B754BCA60E03C4820@domain.hid>
In-Reply-To: <BLU166-W49F600F976B754BCA60E03C4820@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] realtime pipes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 01/15/2012 01:36 PM, Jan-Erik Lange wrote:
> 
> Hello,
> 
> it is possible to access a real-time pipe /dev/rtpx within the kernel
> space of Linux? Since there is no open function?

Real-time pipes are deprecated.

> 
> Is it therefore possible to communicate between the Xenomai Kernel
> space and the Linux Kernel space?

As mentioned several time, using anything else in kernel-space than the
RTDM API is deprecated. If you are interested in the services the RTDM
api offers, see:

http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__driverapi.html

For instance, you can see a section named "non-real-time signalling
services", which probably answers your question.

-- 
                                                                Gilles.

