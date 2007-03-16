From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17914.63535.18893.207257@domain.hid>
Date: Fri, 16 Mar 2007 21:03:59 +0100
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
In-Reply-To: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Muruganandam Ganapathy <muruganandam.ganapathy@domain.hid>
Cc: xenomai@xenomai.org

Muruganandam Ganapathy wrote:
 > Hello,
 > 
 > I am new to Xenomai and trying to understand whether it is suitable for our
 > need.
 > We have a board based on ARM926EJ. I would like to know
 > 
 > 
 > 1. is there Xenomai support for ARM926

Xenomai supports most ARM processor cores. For example, the ARM926 is
supported with the ARM integrator board. The real question is: does it
support the particular board you use ? If not, then all you have to do
is to adapt the I-pipe patch to the board you use.


 >    I did google through and found that Xenomai is for the user application
 >    In our case, we have a kernel mode driver/application which is very time
 >    critical and we were unable to meet the timing requirement using the
 > regular kernel.

No, Xenomai APIs exist both in kernel and user space and are symetrical
as much as possible. So, it is up to you to choose if you want to
program your application in kernel or user-space. Note however that for
future-proof designs, it is recommended to only write driver code in
kernel-space, using the RTDM API, and to write the rest of your
application in user-space.


 > 
 > 2. If support is available, what is the version to use. I am running 2.6.19
 >    on the board.

2.6.19 is only supported by the latest v2.3.x branch; since it has not
yet been released you will have to download the sources via svn, by
typing something like:

svn co http://svn.gna.org/svn/xenomai/branches/v2.3.x xenomai

Note that if the board you use is not supported, you will get undefined
symbols building the kernel, and this is where your work will start:
implementing the missing functions for the board you use. The missing
functions concern hardware timer management, tsc emulation using the
hardware timer, and interrupts demultiplexing. We can help you doing
this work if you tell us which board you use.

-- 


					    Gilles Chanteperdrix.

