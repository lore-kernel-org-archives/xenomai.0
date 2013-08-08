From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 8 Aug 2013 09:58:39 -0400
Message-ID: <20130808135839.GB22673@csclub.uwaterloo.ca>
References: <52039EC3.4050908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52039EC3.4050908@gmail.com>
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagar Behere <sagar.behere@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Aug 08, 2013 at 03:36:03PM +0200, Sagar Behere wrote:
> I wish to generate PWM signals from Xenomai, using the beaglebone
> black, kernel 3.8.13 patched with xenomai.
> 
> There already exist linux kernel modules for the hardware PWM
> generator (eHRPWM) on the am335x chip in the beaglebone. The PWM
> generator can be configured and controlled via the /sysfs interface
> and the whole thing works very well.
> 
> I understand that the /sysfs interface cannot be used by xenomai
> tasks without triggering a transition away from the primary xenomai
> (hard realtime) domain. So my question is: What is the least effort
> way to change the duty cycle of the hardware PWM generator, from a
> xenomai task?
> 
> Does the following approach sound feasible?
> 
> 1. Configure the PWM generator (freq, polarity etc.) from the /sysfs
> interface at application startup. This need not be realtime
> 2. Assuming that the duty-cycle is controlled by the value of some
> memory-mapped register, use mmap()/ioremap() to map that register's
> address into the xenomai task's address space.
> 3. Write the duty-cycle values to the mapped memory, from within the
> xenomai task
> 
> So this is like a hybrid approach that uses the existing linux
> kernel module for initializing/configuring the hardware PWM and the
> xenomai task only changes the value of one register that affects the
> duty cycle of the output waveform.

I know it isn't what you asked for, but would using one of the PRUs
be simpler?  Maybe that wouldn't work.

-- 
Len Sorensen

