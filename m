From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17364.46664.389729.166491@domain.hid>
Date: Mon, 23 Jan 2006 11:56:08 +0100
Subject: Re: [Adeos-main] wake_up_interruptible ?
In-Reply-To: <200601230144.31936.berlemont.hauw@domain.hid>
References: <43D2B94C.3000202@domain.hid>
	<200601230144.31936.berlemont.hauw@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Alexis Berlemont wrote:
 > Hi,
 > 
 > 
 > > I've got a kernel module which creates a chrdev.
 > > In the read file operation I have a interruptible_sleep_on.
 > > Now I want to wake it up from an IPIPE interrupt handler
 > > (i.e. unblock the read operation from user-space on the
 > > chrdev), but I bet wake_up_interruptible is forbidden
 > > in HRT context, isn't it ?
 > 
 > Why not using a semaphore : 
 > 
 > in your read fops function :
 > 
 > down_interruptible(pointer_read_sem);
 > 
 > in your IPIPE interrupt handler:
 > 
 > up(pointer_read_sem);
 > 
 > In an interrupt handler, I think you can use a Linux semaphore. I am quite 
 > sure semaphores are used in the Xenomai pipe implementation.

For the "up" function to work properly, Linux scheduler data have to be
in a consistent state. But with the IPIPE patch, Linux may be preempted
by a higher priority domain at any point where hardware interrupts are
not disabled, and where scheduler data are not necessarily in a
consistent state.

One way to wake up a regular Linux thread from a higher priority domain
interrupt handler is to propagate this interrupt after HRT processing in
higher priority domains and run wake_up_interruptible from Linux domain
interrupt handler.

-- 


					    Gilles Chanteperdrix.

