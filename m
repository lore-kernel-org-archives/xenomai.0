From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 22 Mar 2006 02:24:48 +0100
References: <200603201434.15258@domain.hid>
	<200603210148.11118.berlemont.hauw@domain.hid> <441F5F31.70206@domain.hid>
In-Reply-To: <441F5F31.70206@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220224.48468.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] Re: COMEDI over RTDM (was: rtdm_event_timedwait
	hang-up)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi,

> > But there are plenty of things I am not happy with :
> > -> the original comedilib version is not really well suited for rtdm. In
> > this library for many reasons; for example, you can find calls to
> > malloc/free
>
> Oops, not so nice.
>
> > functions. If I stick to the original implementation, I have to either to
> > ask for adding alloc stuff in user mode in rtdm skin or use another skin
> > to manage allocations. None of these solutions seems interesting for me
> > for many reasons. A lot of people  must be thinking I am overkill, it is
> > true that the comedilib allocations should be done at init time
> > (comedi_open, comedi_close) then no need to fulfull real-time constraints
> > but I think comedi should be fully rtdm compliant; this would avoid
> > tricky corner cases for
> > developpers/users. The best and simplest solution for me would be some
> > slight modifications in the comedilib API but I doubt everyone is OK with
> > that.
>
> Could you give some concrete use cases of the comedilib where dynamic
> allocation is involved? I don't know that library actually. What does it
> manage beyond calling the driver core?

In the function comedi_open() : 

  if(!(it=malloc(sizeof(comedi_t))))
    goto cleanup;
  memset(it,0,sizeof(comedi_t));

  if((it->fd=rt_dev_open(fn,0))<0)
  {
    fprintf(stderr, "comedi_open: rt_dev_open failed (ret=%d)\n",
	    it->fd);
    goto cleanup;
  }

  if(comedi_ioctl(it->fd, COMEDI_DEVINFO, 
		  (unsigned long)&it->devinfo)<0)
    goto cleanup;

  it->n_subdevices=it->devinfo.n_subdevs;

  get_subdevices(it);

...

We can see an allocation for a structure which will contain the result ("fd") 
of rt_dev_open(). And this is not over, the function "get_subdevices()" will 
make another allocation to keep info about the driver (subdevice, number of 
channels, etc.). And this function "get_subdevices()" will trigger more 
allocations by calling "get_rangeinfo()". In fact, "malloc()" is called eight 
times.

All disallocations are done in "comedi_close()".

Starting from here, we have two alternatives:
-> preallocate enough structs the first time "comedi_open()" is called. mmh...
-> modify the comedilib API to let the developper handle the allocations.

> > -> I think the comedi structures organization (comedi_device, subdevice,
> > async, etc.) should be reviewed considering the rtdm architecture. Of
> > course, these modifications should not induce big changes in the comedi
> > drivers source.
>
> Please also give concrete examples here. RTDM devices should be
> manageable by the user via file descriptors, just like normal devices.

There is a little difference with normal devices and classical drivers. The 
link between a device and a driver is not direct. The comedi layer affects a 
comedi device (/dev/comedi0..9 or comedi0..9) to a specific driver at runtime 
thanks to a specific ioctl (cf. comedi_config in comedilib). This is the 
comedi attach stuff.

At this level, I may think it would be interesting to consider quite precisely 
the layer organization. I have not well understood the architectural border 
between what must be done by the driver and what must be done by the abstract 
layer.

For example, here is a description of the attaching procedure: 
1) the devconfig ioctl is received by the abstract comedi layer;
2) the abstract layer (in comedi/drivers.c) calls do_devconfig_ioctl() which 
makes some allocations and a few setups in the structure comedi_device, the 
the function comedi_device_attach() is called;
3)In comedi_device_attach(), we check if the proper driver whether available 
(insmoded), if so a driver specific function is called;
4) in this driver function, we have access to the structures of the abstract 
layer and we modify them (comedi_subdevice);
5) back in the abstract layer, the function "postconfig() is called to setup 
the struct "comedi_async" (this struct belongs to a comedi_subdevice).

To sum up: 
-> comedi_device { (managed by the abstract layer)
	-> comedi_subdevice { (managed by the driver)
		-> comedi_async (managed by the abstract layer)
	}
}

I am not sure I am clear (it is quite hard to explain without source code), 
but I think the drivers should not get direct access to the structures of the 
abstract layer. 

You may find this points useless, all this stuff is not directly related with 
rtdm functionnalities, I just thought the rtdm port would be a good 
opportunity to think about that. 

> What is different, what extra information is needed?

. I just think some fields could be removed or grouped in comedi_subdevice 
(lock, busy, etc.) and we could integrate in comedi_async the nonblocking 
info. This is minor.

I may have some more points to share with you but I have to keep them for 
tomorrow night.

> Release early, release often ;). I would offer to have a look, maybe it
> will clarify where the RTDM-specific problems are.

OK sorry for tonight, hard day...

Alexis.


