From: Alexis Berlemont <berlemont.hauw@domain.hid>
Subject: Re: [Adeos-main] wake_up_interruptible ?
Date: Mon, 23 Jan 2006 01:44:31 +0100
References: <43D2B94C.3000202@domain.hid>
In-Reply-To: <43D2B94C.3000202@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230144.31936.berlemont.hauw@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,


> I've got a kernel module which creates a chrdev.
> In the read file operation I have a interruptible_sleep_on.
> Now I want to wake it up from an IPIPE interrupt handler
> (i.e. unblock the read operation from user-space on the
> chrdev), but I bet wake_up_interruptible is forbidden
> in HRT context, isn't it ?

Why not using a semaphore : 

in your read fops function :

down_interruptible(pointer_read_sem);

in your IPIPE interrupt handler:

up(pointer_read_sem);

In an interrupt handler, I think you can use a Linux semaphore. I am quite 
sure semaphores are used in the Xenomai pipe implementation.

Best regards.

Alexis.


