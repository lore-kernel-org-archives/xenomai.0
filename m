From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.13486.254768.91245@domain.hid>
Date: Fri, 2 Jun 2006 14:53:02 +0200
Subject: Re: [Xenomai-help] xnpod help
In-Reply-To: <47190.155.98.4.39.1149199741.squirrel@domain.hid>
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
	<17535.18007.179715.207040@domain.hid>
	<447F49C8.4090609@domain.hid>
	<39455.155.98.4.39.1149195102.squirrel@domain.hid>
	<447F5935.4090105@domain.hid>
	<47190.155.98.4.39.1149199741.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Brandt Erickson wrote:
 > > Ok, things get clearer. But why a kernel module? Are you *that* short on
 > > CPU cycles?
 > 
 > The reason why I'm trying to develop a kernel-space application is not for
 > latency issues but because I need to be in kernel-space to read/write
 > to/from my DAC.

There are several way you can write an application with Xenomai:
- first, the canonical way, split your application between driver code
  and application code, implement the driver in kernel-space and the
  application in user-space. Xenomai ease your work by providing the
  RTDM skin for writing drivers in kernel-space, and user-space skins
  (posix, native, vxworks, etc...) for writing applications in
  user-space. For a good portability, I would suggest to use the posix
  skin in user-space.

- second, the rapid way, good for prototyping, do it all in
  user-space. You may use iopl or ioperm to allow your application to
  access I/O regions, and libpci and mmaping /dev/mem to access PCI
  devices from user-space. Xenomai will ease your work here by allowing
  you to run your whole application in gdb, and skins generally provide
  functions to implement IRQ servers in user-space. See for example
  pthread_intr_wait_np.

- a third way, maybe useful as an intermediate between the first
  two. Split your code between kernel-space and user-space, but use
  the same skin in user-space and kernel-space. Xenomai ease your
  work here because skin interfaces are written to be very similar in
  kernel-space and user-space, and IPCs may generally be used to
  communicate between the two address spaces.

 >  Is the IPC between kernel-space realtime and user-space
 > non-realtime that much more difficult the user-space realtime to
 > user-space non-realtime?  I've familiar with regular user-space IPC using
 > condition variables, semaphores, and shared memory, so if it's fairly
 > similar, I'm hoping that won't be a problem.
 > -Brandt

The only IPC existing to communicate between real-time (whether
user-space or kernel-space) and non-realtime user-space threads is the
native skin message pipes: 
http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html

By contrast all other IPC implemented by all skins are accessible to
real-time threads running in secondary mode: they will simply switch to
primary mode the time they use blocking services. So, it is probably a
better idea to create your non-realtime threads as real-time threads and
let them switch to secondary mode when they use non-realtime services.

-- 


					    Gilles Chanteperdrix.

