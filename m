Date: Tue, 4 Nov 2014 20:43:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141104194359.GB21384@sisyphus.hd.free.fr>
References: <CADLCHM+eyrDUh4fBdTEk4TrDzsPmnGghaH-07XT=zFLxojtS4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADLCHM+eyrDUh4fBdTEk4TrDzsPmnGghaH-07XT=zFLxojtS4g@mail.gmail.com>
Subject: Re: [Xenomai] Communicate to a device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Seda Seda <seda9seda9@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Nov 04, 2014 at 11:57:58AM +0200, Seda Seda wrote:
> I have a non real time device. I communicated it using syscall
> functions.Now, I am writing a kernel module and an user space
> application. When I attach device to pc, ttyACM0 file creates under /dev.
> 
> When I install my module as device name is "ttyACM0", I see a driver
> in proc/rtdm/named_devices file. But when I write "/dev/ttyACM0" and
> install module, I get an error. It says that "Cannot allocate memory".

The sentence 'I write /dev/ttyACM0 and install module' does not make
any sense:
- you can not write to a device before you load its module (assuming
you mean 'I write to /dev/ttyACM0';
- installing the module does not mean anything, what is important is
loading it.

Anyway, from the little and bogus information you give us, little
can be said, except that your driver is probably buggy, and that you
need to debug it.

-- 
					    Gilles.

