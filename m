Message-ID: <1215602455.48749f17654c0@domain.hid>
Date: Wed, 09 Jul 2008 13:20:55 +0200
From: nourry@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] USB device with Hard Real Time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

> Of course. I had a quick glance at the web page describing the acquisit=
ion
> device, but too quick to find any source.

> Best regards.

> Alexis.


Here is it, for USB :

#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/smp_lock.h>
#include <linux/completion.h>
#include <asm/uaccess.h>
#include <linux/usb.h>
#include <linux/version.h>

#ifdef CONFIG_USB_DEBUG
	static int debug =3D 1;
#else
	static int debug =3D 0;
#endif

/* Use our own dbg macro */
#undef dbg
#define dbg(format, arg...) do { if (debug) printk(KERN_DEBUG __FILE__ ":=
 "
format "\n" , ## arg); } while (0)

/* Version Information */
#define DRIVER_VERSION "v0.31"
#define DRIVER_AUTHOR "LabJack, support@domain.hid"
#define DRIVER_DESC "USB LabJack UE9 Driver"

/* Timeout for reads (in ms) */
#define READ_TIMEOUT 5*HZ

/* Module parameters */
module_param(debug, int, S_IRUGO | S_IWUSR);
MODULE_PARM_DESC(debug, "Debug enabled or not");

#define USB_LABJACKUE9_VENDOR_ID	0x0cd5
#define USB_LABJACKUE9_PRODUCT_ID	0x0009

/* IO controls */
#define IOCTL_LJ_SET_READ_TIMEOUT	0x1

/* table of devices that work with this driver */
static struct usb_device_id labjackue9_table [] =3D {
	{ USB_DEVICE(USB_LABJACKUE9_VENDOR_ID, USB_LABJACKUE9_PRODUCT_ID) },
	{ }					/* Terminating entry */
};

MODULE_DEVICE_TABLE (usb, labjackue9_table);

/* Get a minor range for your devices from the usb maintainer */
#define USB_LABJACKUE9_MINOR_BASE	224

/* Structure to hold all of our device specific stuff */
struct usb_labjackue9 {
	struct usb_device*	udev;				/* save off the usb device pointer */
	struct usb_interface*	interface;			/* the interface for this device */
	unsigned char 		minor;				/* the starting minor number for this device *=
/
	unsigned char 		num_ports;			/* the number of ports this device has */
	char 			num_interrupt_in;		/* number of interrupt in endpoints we have *=
/
	char 			num_bulk_in;			/* number of bulk in endpoints we have */
	char 			num_bulk_out;			/* number of bulk out endpoints we have */
	unsigned char*		bulk_in_buffer[2];		/* the buffer to receive data */
	size_t 			bulk_in_size[2];		/* the size of the receive buffer */
	__u8 			bulk_in_endpointAddr[2];	/* the address of the bulk in endpoint =
*/
	unsigned char*		bulk_out_buffer[2];		/* the buffer to send data */
	size_t 			bulk_out_size[2];		/* the size of the send buffer */
	struct urb*		write_urb[2];			/* the urb used to send data */
	__u8 			bulk_out_endpointAddr[2];	/* the address of the bulk out endpoin=
t */
	atomic_t 		write_busy;			/* true iff write urb is busy */
	struct 			completion write_finished;	/* wait for the write to finish */
	int 			open;				/* if the port is open or not */
	int			present;			/* if the device is not disconnected */
	struct 			semaphore sem;			/* locks this structure */
	int			read_timeout;			/* timeout for reads, in ms */
};


/* prevent races between open() and disconnect() */
static DECLARE_MUTEX (disconnect_sem);

/* local function prototypes */
static ssize_t labjackue9_read	(struct file *file, char *buffer, size_t c=
ount,
loff_t *ppos);
static ssize_t labjackue9_write	(struct file *file, const char *buffer, s=
ize_t
count, loff_t *ppos);
static int labjackue9_ioctl	(struct inode *inode, struct file *file, unsi=
gned
int cmd, unsigned long arg);
static int labjackue9_open	(struct inode *inode, struct file *file);
static int labjackue9_release	(struct inode *inode, struct file *file);

static int labjackue9_probe	(struct usb_interface *interface, const struc=
t
usb_device_id *id);
static void labjackue9_disconnect	(struct usb_interface *interface);

static void labjackue9_write_bulk_callback	(struct urb *urb, struct pt_re=
gs
*regs);

static struct file_operations labjackue9_fops =3D {
	.owner =3D	THIS_MODULE,
	.read =3D		labjackue9_read,
	.write =3D	labjackue9_write,
	.ioctl =3D	labjackue9_ioctl,
	.open =3D		labjackue9_open,
	.release =3D	labjackue9_release,
};

/*
 * usb class driver info in order to get a minor number from the usb core=
,
 * and to have the device registered with devfs and the driver core
 */
static struct usb_class_driver labjackue9_class =3D {
	.name =3D		"usb/labjackue9_%d",
	.fops =3D		&labjackue9_fops,
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,14)
	.mode =3D		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
#endif
	.minor_base =3D	USB_LABJACKUE9_MINOR_BASE,
};

/* usb specific object needed to register this driver with the usb subsys=
tem */
static struct usb_driver labjackue9_driver =3D {
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,16)
	.owner =3D	THIS_MODULE,
#endif
	.name =3D		"labjackue9",
	.probe =3D	labjackue9_probe,
	.disconnect =3D	labjackue9_disconnect,
	.id_table =3D	labjackue9_table,
};


/**
 *	usb_labjackue9_debug_data
 */
static inline void usb_labjackue9_debug_data (const char *function, int s=
ize,
const unsigned char *data)
{
	int i;

	if (!debug)
		return;

	printk (KERN_DEBUG __FILE__": %s - length =3D %d, data =3D ",
		function, size);
	for (i =3D 0; i < size; ++i)
		printk ("%.2x ", data[i]);

	printk ("\n");
}


/**
 *	labjackue9_delete
 */
static inline void labjackue9_delete (struct usb_labjackue9 *dev)
{
	int i;

	for(i =3D 0; i < 2; i++)
	{
		kfree (dev->bulk_in_buffer[i]);
		usb_buffer_free (dev->udev, dev->bulk_out_size[i],
				dev->bulk_out_buffer[i],
				dev->write_urb[i]->transfer_dma);
		usb_free_urb (dev->write_urb[i]);
	}

	kfree (dev);
}


/**
 *	labjackue9_open
 */
static int labjackue9_open (struct inode *inode, struct file *file)
{
	struct usb_labjackue9 *dev =3D NULL;
	struct usb_interface *interface;
	int subminor;
	int retval =3D 0;

	dbg("%s", __FUNCTION__);

	subminor =3D iminor(inode);

	/* prevent disconnects */
	down (&disconnect_sem);

	interface =3D usb_find_interface (&labjackue9_driver, subminor);
	if (!interface) {
		err ("%s - error, can't find device for minor %d",
		     __FUNCTION__, subminor);
		retval =3D -ENODEV;
		goto exit_no_device;
	}

	dev =3D usb_get_intfdata(interface);
	if (!dev) {
		retval =3D -ENODEV;
		goto exit_no_device;
	}

	/* lock this device */
	down (&dev->sem);

	/* increment our usage count for the driver */
	++dev->open;

	/* save our object in the file's private structure */
	file->private_data =3D dev;

	/* unlock this device */
	up (&dev->sem);

exit_no_device:
	up (&disconnect_sem);
	return retval;
}


/**
 *	labjackue9_release
 */
static int labjackue9_release (struct inode *inode, struct file *file)
{
	struct usb_labjackue9 *dev;
	int retval =3D 0;

	dev =3D (struct usb_labjackue9 *)file->private_data;
	if (dev =3D=3D NULL) {
		dbg ("%s - object is NULL", __FUNCTION__);
		return -ENODEV;
	}

	dbg("%s - minor %d", __FUNCTION__, dev->minor);

	/* lock our device */
	down (&dev->sem);

	if (dev->open <=3D 0) {
		dbg ("%s - device not opened", __FUNCTION__);
		retval =3D -ENODEV;
		goto exit_not_opened;
	}

	/* wait for any bulk writes that might be going on to finish up */
	if (atomic_read (&dev->write_busy))
		wait_for_completion (&dev->write_finished);

	--dev->open;

	if (!dev->present && !dev->open) {
		/* the device was unplugged before the file was released */
		up (&dev->sem);
		labjackue9_delete (dev);
		return 0;
	}

exit_not_opened:
	up (&dev->sem);

	return retval;
}


/**
 *	labjackue9_read
 *
 *	By default, endpoint 1 is used to read from the device.	To use the end=
point
2,
 *	set bit 16 of count, or add 32768 to count.
 *
 */
static ssize_t labjackue9_read (struct file *file, char *buffer, size_t c=
ount,
loff_t *ppos)
{
	struct usb_labjackue9 *dev;
	int retval =3D 0;
	unsigned int bytes_read;
	int bytes_read_count =3D 0;
	int ep =3D 0;

	dev =3D (struct usb_labjackue9 *)file->private_data;

	dbg("%s - minor %d, count =3D %ld", __FUNCTION__, dev->minor, count);

	/* lock this object */
	down (&dev->sem);

	/* verify that the device wasn't unplugged */
	if (!dev->present) {
		up (&dev->sem);
		return -ENODEV;
	}

	if(count < 32768) {
		ep =3D 0;
	}
	else {
		ep =3D 1;
		count -=3D 32768;
	}

	while(count > 0) {
		/* do a blocking bulk read to get data from the device */
		retval =3D usb_bulk_msg (dev->udev,
				       usb_rcvbulkpipe (dev->udev,
						dev->bulk_in_endpointAddr[ep]),
				       dev->bulk_in_buffer[ep],
				       min (dev->bulk_in_size[ep], count),
				       &bytes_read, dev->read_timeout);

		dbg("%s - ep =3D %d, count =3D %ld, bytes_read =3D %d", __FUNCTION__, e=
p + 1, count,
bytes_read);
		/* if the read was successful, copy the data to userspace */
		if (!retval  || retval =3D=3D -ETIMEDOUT) {
			if (copy_to_user (buffer + bytes_read_count, dev->bulk_in_buffer[ep],
min((size_t)bytes_read, count))) {
				retval =3D -EFAULT;
				goto exit;
			}
			else
				bytes_read_count +=3D bytes_read;
		}
		else
			goto exit;

		if(count > bytes_read) {
			if(bytes_read <=3D 0)
				goto set_retval;

			count -=3D bytes_read;
		}
		else
			count =3D 0;

		if(dev->bulk_in_size[ep] > bytes_read)
			goto set_retval;
	}

set_retval:
	retval =3D bytes_read_count;

exit:
	/* unlock the device */
	up (&dev->sem);
	dbg("     %s - retval %d", __FUNCTION__, retval);
	return retval;
}


/**
 *	labjackue9_write
 *
 *	By default, endpoint 1 is used to write to the device.	To use the endp=
oint 2,
 * 	set bit 16 of count, or add 32768 to count
 *
 */
static ssize_t labjackue9_write (struct file *file, const char *buffer, s=
ize_t
count, loff_t *ppos)
{
	struct usb_labjackue9 *dev;
	int retval =3D 0;
	int ep =3D 0;

	dev =3D (struct usb_labjackue9 *)file->private_data;

 	dbg("%s - minor %d, count =3D %ld", __FUNCTION__, dev->minor, count);

	/* lock this object */
	down (&dev->sem);

	/* verify that the device wasn't unplugged */
	if (!dev->present) {
		retval =3D -ENODEV;
		goto exit;
	}

	/* verify that we actually have some data to write */
	if (count =3D=3D 0) {
		dbg("%s - write request of 0 bytes", __FUNCTION__);
		goto exit;
	}

	if(count < 32768) {
		ep =3D 0;
	}
	else {
		ep =3D 1;
		count -=3D 32768;
	}
	//{
	if (copy_from_user(dev->write_urb[ep]->transfer_buffer, buffer,
			   count)) {
		retval =3D -EFAULT;
		goto exit;
	}

	/* wait for a previous write to finish up; we don't use a timeout
	* and so a nonresponsive device can delay us indefinitely.
	*/
	if (atomic_read (&dev->write_busy))
		wait_for_completion (&dev->write_finished);

	usb_labjackue9_debug_data (__FUNCTION__, count,
			     dev->write_urb[ep]->transfer_buffer);

	dbg("%s - ep =3D %d, count =3D %ld", __FUNCTION__, ep + 1, count);

	/* this urb was already set up, except for this write size */
	dev->write_urb[ep]->transfer_buffer_length =3D count;

	/* send the data out the bulk port */
	/* a character device write uses GFP_KERNEL,
	 unless a spinlock is held */
	init_completion (&dev->write_finished);
	atomic_set (&dev->write_busy, 1);
	retval =3D usb_submit_urb(dev->write_urb[ep], GFP_KERNEL);
	if (retval) {
		atomic_set (&dev->write_busy, 0);
		err("%s - failed submitting write urb, error %d",
	    		__FUNCTION__, retval);
	}
	else {
		retval =3D count;
	}

exit:
	/* unlock the device */
	up (&dev->sem);

	return retval;
}


/**
 *	labjackue9_ioctl
 */
static int labjackue9_ioctl (struct inode *inode, struct file *file, unsi=
gned
int cmd, unsigned long arg)
{
	struct usb_labjackue9 *dev;
	void __user *data;
	int retval =3D 0;
	int timeout =3D 0;

	dev =3D (struct usb_labjackue9 *)file->private_data;

	/* lock this object */
	down (&dev->sem);

	/* verify that the device wasn't unplugged */
	if (!dev->present) {
		up (&dev->sem);
		return -ENODEV;
	}

	dbg("%s - minor %d, cmd 0x%.4x, arg %ld", __FUNCTION__,
	    dev->minor, cmd, arg);

	/* driver specific commands */
	switch (cmd) {
		/* Sets the timeout for bulk read transfers in ms from an integer argum=
ent */
		/* If the timeout is set to zero, reads will wait forever */
		case IOCTL_LJ_SET_READ_TIMEOUT:
			data =3D (void __user *) arg;
			if (data =3D=3D NULL)
				break;
			if (copy_from_user(&timeout, data, sizeof(int))) {
				retval =3D -EFAULT;
				break;
			}

			dbg("%s - current timeout of %d changed to %d", __FUNCTION__,
dev->read_timeout, timeout);
			dev->read_timeout =3D timeout;
			break;
		default:
			retval =3D -ENOTTY;
			break;
	}

	/* unlock the device */
	up (&dev->sem);

	return retval;
}


/**
 *	labjackue9_write_bulk_callback
 */
static void labjackue9_write_bulk_callback (struct urb *urb, struct pt_re=
gs
*regs)
{
	struct usb_labjackue9 *dev =3D (struct usb_labjackue9 *)urb->context;

	dbg("%s - minor %d", __FUNCTION__, dev->minor);

	/* sync/async unlink faults aren't errors */
	if (urb->status && !(urb->status =3D=3D -ENOENT ||
				urb->status =3D=3D -ECONNRESET)) {
		dbg("%s - nonzero write bulk status received: %d",
		    __FUNCTION__, urb->status);
	}

	/* notify anyone waiting that the write has finished */
	atomic_set (&dev->write_busy, 0);
	complete (&dev->write_finished);
}


/**
 *	labjackue9_probe
 *
 *	Called by the usb core when a new device is connected that it thinks
 *	this driver might be interested in.
 */
static int labjackue9_probe(struct usb_interface *interface, const struct
usb_device_id *id)
{
	struct usb_device *udev =3D interface_to_usbdev(interface);
	struct usb_labjackue9 *dev =3D NULL;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;
	size_t buffer_size;
	int i;
	int retval =3D -ENOMEM;
	int ep =3D 0;

	/* See if the device offered us matches what we can accept */
	if ((udev->descriptor.idVendor !=3D USB_LABJACKUE9_VENDOR_ID) ||
	    (udev->descriptor.idProduct !=3D USB_LABJACKUE9_PRODUCT_ID)) {
		return -ENODEV;
	}

	/* allocate memory for our device state and initialize it */
	dev =3D kmalloc (sizeof(struct usb_labjackue9), GFP_KERNEL);
	if (dev =3D=3D NULL) {
		err ("Out of memory");
		return -ENOMEM;
	}
	memset (dev, 0x00, sizeof (*dev));

	init_MUTEX (&dev->sem);
	dev->udev =3D udev;
	dev->interface =3D interface;

	/* set up the endpoint information */
	/* check out the endpoints */
	/* use only the first bulk-in and bulk-out endpoints */
	iface_desc =3D &interface->altsetting[0];
	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
		endpoint =3D &iface_desc->endpoint[i].desc;

		if(i < 2)
			ep =3D 0;
		else
			ep =3D 1;

		//{
		if (!dev->bulk_in_endpointAddr[ep] &&
		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
					=3D=3D USB_ENDPOINT_XFER_BULK)) {
			/* we found a bulk in endpoint */
			buffer_size =3D endpoint->wMaxPacketSize;
			dev->bulk_in_size[ep] =3D buffer_size;
			dev->bulk_in_endpointAddr[ep] =3D endpoint->bEndpointAddress;
			dev->bulk_in_buffer[ep] =3D kmalloc (buffer_size, GFP_KERNEL);
			if (!dev->bulk_in_buffer[ep]) {
				err("Couldn't allocate bulk_in_buffer %d", ep + 1);
				goto error;
			}
		}

		if (!dev->bulk_out_endpointAddr[ep] &&
		    !(endpoint->bEndpointAddress & USB_DIR_IN) &&
		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
				=3D=3D USB_ENDPOINT_XFER_BULK)) {
			/* we found a bulk out endpoint */
			/* a probe() may sleep and has no restrictions on memory allocations *=
/
			dev->write_urb[ep] =3D usb_alloc_urb(0, GFP_KERNEL);
			if (!dev->write_urb[ep]) {
				err("No free urbs available");
				goto error;
			}
			dev->bulk_out_endpointAddr[ep] =3D endpoint->bEndpointAddress;

			/* on some platforms using this kind of buffer alloc
			 * call eliminates a dma "bounce buffer".
			 *
			 * NOTE: you'd normally want i/o buffers that hold
			 * more than one packet, so that i/o delays between
			 * packets don't hurt throughput.
			 */
			buffer_size =3D endpoint->wMaxPacketSize;
			dev->bulk_out_size[ep] =3D buffer_size;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,14)
			dev->write_urb[ep]->transfer_flags =3D (URB_NO_TRANSFER_DMA_MAP |
					URB_ASYNC_UNLINK);
#else
			dev->write_urb[ep]->transfer_flags =3D (URB_NO_TRANSFER_DMA_MAP);
#endif
			dev->bulk_out_buffer[ep] =3D usb_buffer_alloc (udev,
					buffer_size, GFP_KERNEL,
					&dev->write_urb[ep]->transfer_dma);
			if (!dev->bulk_out_buffer[ep]) {
				err("Couldn't allocate bulk_out_buffer %d", ep);
				goto error;
			}
			usb_fill_bulk_urb(dev->write_urb[ep], udev,
				      usb_sndbulkpipe(udev,
						      endpoint->bEndpointAddress),
				      dev->bulk_out_buffer[ep], buffer_size,
				      labjackue9_write_bulk_callback, dev);
		}
	}

	for(i =3D 0; i < 2; i++) {
		if (!(dev->bulk_in_endpointAddr[i] && dev->bulk_out_endpointAddr[i])) {
			err("Could not find both bulk-in and bulk-out endpoint %d", i + 1);
			goto error;
		}
	}

	/* allow device read, write and ioctl */
	dev->present =3D 1;

	/* we can register the device now, as it is ready */
	usb_set_intfdata (interface, dev);
	retval =3D usb_register_dev (interface, &labjackue9_class);
	if (retval) {
		/* something prevented us from registering this driver */
		err ("Not able to get a minor for this device.");
		usb_set_intfdata (interface, NULL);
		goto error;
	}

	dev->minor =3D interface->minor;

	dev->read_timeout =3D READ_TIMEOUT;

	/* let the user know what node this device is now attached to */
	info ("USB LabJack device now attached to labjackue9-%d", dev->minor);
	return 0;

error:
	labjackue9_delete (dev);
	return retval;
}


/**
 *	labjackue9_disconnect
 *
 *	Called by the usb core when the device is removed from the system.
 *
 *	This routine guarantees that the driver will not submit any more urbs
 *	by clearing dev->udev.  It is also supposed to terminate any currently
 *	active urbs.  Unfortunately, usb_bulk_msg(), used in labjackue9_read()=
, does
 *	not provide any way to do this.  But at least we can cancel an active
 *	write.
 */
static void labjackue9_disconnect(struct usb_interface *interface)
{
	struct usb_labjackue9 *dev;
	int minor;

	/* prevent races with open() */
	down (&disconnect_sem);

	dev =3D usb_get_intfdata (interface);
	usb_set_intfdata (interface, NULL);

	down (&dev->sem);

	minor =3D dev->minor;

	/* give back our minor */
	usb_deregister_dev (interface, &labjackue9_class);

	/* terminate an ongoing write */
	if (atomic_read (&dev->write_busy)) {
		usb_unlink_urb (dev->write_urb[0]);
		usb_unlink_urb (dev->write_urb[1]);
		wait_for_completion (&dev->write_finished);
	}

	/* prevent device read, write and ioctl */
	dev->present =3D 0;

	up (&dev->sem);

	/* if the device is opened, labjackue9_release will clean this up */
	if (!dev->open)
		labjackue9_delete (dev);

	up (&disconnect_sem);

	info("USB LabJack #%d now disconnected", minor);
}


/**
 *	usb_labjackue9_init
 */
static int __init usb_labjackue9_init(void)
{
	int result;

	/* register this driver with the USB subsystem */
	result =3D usb_register(&labjackue9_driver);
	if (result) {
		err("usb_register failed. Error number %d",
		    result);
		return result;
	}

	info(DRIVER_DESC " " DRIVER_VERSION);
	return 0;
}


/**
 *	usb_labjackue9_exit
 */
static void __exit usb_labjackue9_exit(void)
{
	/* deregister this driver with the USB subsystem */
	usb_deregister(&labjackue9_driver);
}


module_init (usb_labjackue9_init);
module_exit (usb_labjackue9_exit);

MODULE_AUTHOR(DRIVER_AUTHOR);
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_LICENSE("GPL");


Hope it's not too long, if you can read it, it may not !
See you,
Antoine

