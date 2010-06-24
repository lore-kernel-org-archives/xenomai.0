Date: Fri, 25 Jun 2010 01:04:11 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100624230411.GB9802@domain.hid>
References: <4BA259D1.4020704@domain.hid> <4BA2BFCF.8010000@domain.hid>
	<4BB0F428.5050905@domain.hid> <20100405215416.GA2522@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100405215416.GA2522@domain.hid>
Subject: Re: [Xenomai-core] Analogy: cancel ongoing commands when a device
 is closed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

Hi,

Alexis Berlemont wrote:
> Hi,
> 
> Daniele Nicolodi wrote:
> > Alexis Berlemont wrote:
> > > Daniele Nicolodi wrote:
> > >> After fixing analogy to permit continuous acquisition, I discovered that
> > >> ongoing commands are not canceled when a device is closed (I obtain a
> > >> DMA buffer owerwrite warning in the kernel log when I abruptly terminate
> > >>  my acquisition program).
> > >>
> > >> I think this is quite a surprising behavior. I would expect that the
> > >> commands are canceled when there isn't a data consumer any more. Would
> > >> it be possible to cancel any ongoing command on device close? If there
> > >> is agreement on this, I can look into providing a patch.
> > >>
> > > The close should indeed stop any occurring acquisition. I implemented
> > > this behaviour. It is in my git repository.
> > 
> > Hi Alexis. I have been working with analogy from your git three and I
> > should say that the new behavior, in my use case, is worst than the
> > previous.
> > 
> > Now, when a device is closed, all accurring acquisition are terminated,
> > also the ones that haven't been started by the current process. While it
> > is possible to use at the same time two different subdevices, from two
> > different processes, now it is not possible to terminate one process and
> > leave the other one running. I think that the correct behavior would be
> > to terminate just the acquisitions started by the current process.
> > However, I have no idea on how difficult this would be.
> > 
> 

I just pushed into the branch analogy of my git repository what you
asked. Starting from now, the only asynchronous acquisition to be
cancelled will be the one which is related with the file descriptor to
be closed.

I reviewed the Analogy core to do so. You should not notice any API /
ABI breakage.

> We had two alternatives: either stopping nothing or cancelling "any
> ongoing command" related with the device. Cancelling only acquisitions
> initiated by a specific process implies the implementation of some
> tricky mechanism above the file approach (open, ioctl, close). I am
> afraid that we will create some complex code for an issue which should
> be solved by a suitable device file organization (maybe many dev files
> instead of a single one). 
> 
> I will have a look at what you asked but I cannot ensure anything, I
> have no clear solution in mind.
> 
> > This bring me also to the fact that there isn't currently a way to
> > prevent two concurrent processes to access the same subdevice,
> > interfering each other. Would it possible to have a lock() method, as
> > comedi has?
> 
> There is a lock mechanism but it is not exposed as it is in
> comedi. The lock system is at the subdevice level: you cannot initiate
> an instruction if a command is occuring (the reverse is true of
> course). This is handled with a subdevice status bitfield atomically
> accessed. Have a look at a4l_reserve_transfer() and tell me if I miss
> something. 
> 
> > 
> > Thanks. Cheers,
> > -- 
> > Daniele
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 
> -- 
> Alexis.

-- 
Alexis.

