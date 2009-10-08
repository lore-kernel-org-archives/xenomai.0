From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200910080126.13483.berlemont.hauw@domain.hid>
References: <200910080126.13483.berlemont.hauw@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 19:37:04 +0200
Message-Id: <1255023424.2781.70.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Some thoughts on Analogy "kernel side" framework
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2009-10-08 at 01:26 +0200, Alexis Berlemont wrote:
> Hi,
> 
> The last week, I have been working on the global architecture of the analogy 
> project.
> 
> I tried to sum-up the main characteristics of Comedi. That was a start to 
> figure out what shape analogy will get.
> 
> Here are some notes on that subject:
> 
> 1) Comedi drivers are not common Linux drivers. In these drivers:
> 	- there is neither fops structure nor ioctl operations
> 	- there is, of course, no cdev registration
> 	- The Linux API is sometimes wrapped into Comedi-specific functions (ex. 
> irq).
> 
> 2) Comedi imposes a specific organization: devices are composed of subdevices 
> which are themselves composed of channels. Then a Comedi driver:
> 	- declares a list of subdevices
> 	- displays a list of callbacks per subdevices (command, instructions, 
> trigger, etc.).
> 
> 3) The Comedi midlayer is the link between the Linux driver programming model 
> and the Comedi drivers:
> 	- The Comedi core manages a set of pre-registered character devices
> 	- Via a specific ioctl, the core assigns a dev file to some driver and an 
> "attach" callback is called within the driver.
> 	- The comedi core is in charge of routing the ioctls to the proper subdevice 
> callbacks.
> 
> According to me, this architecture brings some troubles:
> 1) Not all the drivers perfectly fit into the midlayer:
> 	- Some components of acquisition cards do not comply with the subdevice model 
> (ex. the mite in NI card). 
> 	- We find card specific declarations in the Comedi core layer (ex.: some NI 
> specific counter modes in comedi.h);
> 2) On the user space side, it is difficult to write a card independant 
> application.
> 
> All these points make me think that the idea of midlayer itself is not 
> suitable in our case. Because of the fact that the drivers do not fit well 
> into the generic programing model, we find ourselves adapting user space 
> programs to the card they will use.
> 
> I would rather propose a framework composed of helper modules. Analogy drivers 
> would be quite similar with common RTDM drivers (they would contain fops 
> declarations, dev registrations, etc.); 
> 
> As a consequence, Analogy will be a set of tools:
> 	- ioctl routing function
> 	- acquisition device registration
> 	- asynchronous buffer management modules
> 	- etc.
> 

This sounds like a plan, but this also raises a major concern: what's
the status of your current code wrt the upcoming 2.5 now, given that you
seem to imply that the current Comedi/RTDM tree does not exhibit the
final architecture yet, and your proposal entails fundamental changes?

It was made very clear during the recent XUM that 2.5 will be out this
year, which leaves us with enough time to tackle the current issues, but
likely not to reshuffle a complete framework.

We could live with that framework only providing a single acquisition
driver in 2.5.0, but the former has to be stable, and the ABI written in
stone for the 2.5.x series. Provisions for transparent multi-ABI support
might be acceptable, but this still requires to be confident about what
would be needed in the long run, and that sudden change in your
architecture is worrisome.

In short, assuming your current work description eventually holds,
what's your timing to deliver?

> Eventually, instead of rewriting the whole Comedi drivers suite. I think we 
> can develop an analogy driver which will route the analogy ioctls to the 
> proper Comedi subdevice callbacks. I think everybody will agree to consider 
> this point critical. We must retrieve the Comedi drivers as easy as possible.
> 

Full ack.

-- 
Philippe.



