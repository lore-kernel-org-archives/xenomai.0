Subject: Re: Is anybody can show me a simple rtdm driver to read/write virtual
 memory device?
References: <CAAvDm6Zsm-gF+HwBLx1jo4-WHHu37_YoPGOTvgey3FVeWVCMWA@mail.gmail.com>
 <03215306-db00-75ce-e473-3de10cb233e7@siemens.com>
 <CAAvDm6aatWP2G6h3YavWE2KYk6++omNgkJ2ntjQaXk-jYtEbbQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45d9dab9-69bc-2f71-0ff8-4d229981b0fc@siemens.com>
Date: Mon, 6 Apr 2020 10:53:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6aatWP2G6h3YavWE2KYk6++omNgkJ2ntjQaXk-jYtEbbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, Xenomai <xenomai@xenomai.org>

[re-adding the mailing list]

On 06.04.20 10:20, 孙世龙 wrote:
> Thanks a lot for your replay.
> 
> My english is poor.I am sorry to confuse you.
> 

No problem! We are both not native speakers.

> I wrote in last letter  " a simple rtdm driver to read/write virtual 
> memory device ".
> I mean a simple device driver to read\write some bytes from memory 
> ,which is not a driver  for a practical hardware .The simple device 
> driver works like the /dev/null or /dev/zero in linux.
> To make it more clearly, i hope to port this simple linux driver listed 
> below to rtdm driver.

Did you study the RTDM API already [1]? As a rule of thumb, if there are 
corresponding functions, use them in favor of the Linux API. If you have 
any question on a particular one, drop it here on the list.

Jan

[1] 
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm.html

> 
> #include<linux/init.h >
> #include<linux/module.h >
> #include<linux/kernel.h >	/* printk() */
> #include<linux/slab.h >		/* kmalloc() */
> #include<linux/fs.h >		/* everything... */
> #include<linux/errno.h >	/* error codes */
> #include<linux/types.h >	/* size_t */
> #include<linux/fcntl.h >	/* O_ACCMODE */
> #include<linux/cdev.h >
> #include<asm/uaccess.h >	/* copy_*_user */
> 
> 
> MODULE_LICENSE("Dual BSD/GPL");
> MODULE_AUTHOR("Hcamael");
> 
> int scull_major=    0;
> int scull_minor=    0;
> int scull_nr_devs=  4;
> int scull_quantum=  4000;
> int scull_qset=  1000;
> 
> struct scull_qset{
> 	void  **data;
> 	struct scull_qset*next;
> };
> 
> struct scull_dev{
> 	struct scull_qset*data;   /* Pointer to first quantum set. */
> 	int quantum;               /* The current quantum size. */
> 	int qset;                  /* The current array size. */
> 	unsigned long size;        /* Amount of data stored here. */
> 	unsigned int access_key;   /* Used by sculluid and scullpriv. */
> 	struct mutex mutex;        /* Mutual exclusion semaphore. */
> 	struct cdev cdev;	/* Char device structure. */
> };
> 
> struct scull_dev*scull_devices;	/* allocated in scull_init_module */
> 
> /* * Follow the list. */
> struct scull_qset*scull_follow(struct scull_dev*dev,  int n)
> {
> 	struct scull_qset*qs=  dev->data;
> 
>          /* Allocate the first qset explicitly if need be. */
> 	if  (!  qs)  {
> 		qs=  dev->data=  kmalloc(sizeof(struct scull_qset),  GFP_KERNEL);
> 		if  (qs==  NULL)
> 			return  NULL;
> 		memset(qs,  0,  sizeof(struct scull_qset));
> 	}
> 
> 	/* Then follow the list. */
> 	while  (n--)  {
> 		if  (!qs->next)  {
> 			qs->next=  kmalloc(sizeof(struct scull_qset),  GFP_KERNEL);
> 			if  (qs->next==  NULL)
> 				return  NULL;
> 			memset(qs->next,  0,  sizeof(struct scull_qset));
> 		}
> 		qs=  qs->next;
> 		continue;
> 	}
> 	return  qs;
> }
> 
> /* * Data management: read and write. */
> 
> ssize_tscull_read(struct file*filp,  char __user*buf,  size_t count,
>                  loff_t*f_pos)
> {
> 	struct scull_dev*dev=  filp->private_data;
> 	struct scull_qset*dptr;  /* the first listitem */
> 	int quantum=  dev->quantum,  qset=  dev->qset;
> 	int itemsize=  quantum*  qset;  /* how many bytes in the listitem */
> 	int item,  s_pos,  q_pos,  rest;
> 	ssize_t retval=  0;
> 
> 	if  (mutex_lock_interruptible(&dev->mutex))
> 		return  -ERESTARTSYS;
> 	if  (*f_pos >=  dev->size)
> 		goto out;
> 	if  (*f_pos+  count >  dev->size)
> 		count=  dev->size-  *f_pos;
> 
> 	/* Find listitem, qset index, and offset in the quantum */
> 	item=  (long)*f_pos/  itemsize;
> 	rest=  (long)*f_pos%  itemsize;
> 	s_pos=  rest/  quantum;  q_pos=  rest%  quantum;
> 
> 	/* follow the list up to the right position (defined elsewhere) */
> 	dptr=  scull_follow(dev,  item);
> 
> 	if  (dptr==  NULL||  !dptr->data||  !  dptr->data[s_pos])
> 		goto out;  /* don't fill holes */
> 
> 	/* read only up to the end of this quantum */
> 	if  (count >  quantum-  q_pos)
> 		count=  quantum-  q_pos;
> 
> 	if  (raw_copy_to_user(buf,  dptr->data[s_pos]  +  q_pos,  count))  {
> 		retval=  -EFAULT;
> 		goto out;
> 	}
> 	*f_pos+=  count;
> 	retval=  count;
> 
>    out:
> 	mutex_unlock(&dev->mutex);
> 	return  retval;
> }
> 
> ssize_tscull_write(struct file*filp,  const  char __user*buf,  size_t count,
>                  loff_t*f_pos)
> {
> 	struct scull_dev*dev=  filp->private_data;
> 	struct scull_qset*dptr;
> 	int quantum=  dev->quantum,  qset=  dev->qset;
> 	int itemsize=  quantum*  qset;
> 	int item,  s_pos,  q_pos,  rest;
> 	ssize_t retval=  -ENOMEM;  /* Value used in "goto out" statements. */
> 
> 	if  (mutex_lock_interruptible(&dev->mutex))
> 		return  -ERESTARTSYS;
> 
> 	/* Find the list item, qset index, and offset in the quantum. */
> 	item=  (long)*f_pos/  itemsize;
> 	rest=  (long)*f_pos%  itemsize;
> 	s_pos=  rest/  quantum;
> 	q_pos=  rest%  quantum;
> 
> 	/* Follow the list up to the right position. */
> 	dptr=  scull_follow(dev,  item);
> 	if  (dptr==  NULL)
> 		goto out;
> 	if  (!dptr->data)  {
> 		dptr->data=  kmalloc(qset*  sizeof(char*),  GFP_KERNEL);
> 		if  (!dptr->data)
> 			goto out;
> 		memset(dptr->data,  0,  qset*  sizeof(char*));
> 	}
> 	if  (!dptr->data[s_pos])  {
> 		dptr->data[s_pos]  =  kmalloc(quantum,  GFP_KERNEL);
> 		if  (!dptr->data[s_pos])
> 			goto out;
> 	}
> 	/* Write only up to the end of this quantum. */
> 	if  (count >  quantum-  q_pos)
> 		count=  quantum-  q_pos;
> 
> 	if  (raw_copy_from_user(dptr->data[s_pos]+q_pos,  buf,  count))  {
> 		retval=  -EFAULT;
> 		goto out;
> 	}
> 	*f_pos+=  count;
> 	retval=  count;
> 
>          /* Update the size. */
> 	if  (dev->size<  *f_pos)
> 		dev->size=  *f_pos;
> 
>    out:
> 	mutex_unlock(&dev->mutex);
> 	return  retval;
> }
> 
> /* Beginning of the scull device implementation. */
> 
> /* * Empty out the scull device; must be called with the device * mutex 
> held. */
> intscull_trim(struct scull_dev*dev)
> {
> 	struct scull_qset*next,  *dptr;
> 	int qset=  dev->qset;    /* "dev" is not-null */
> 	int i;
> 
> 	for  (dptr=  dev->data;  dptr;  dptr=  next)  {  /* all the list items */
> 		if  (dptr->data)  {
> 			for  (i=  0;  i<  qset;  i++)
> 				kfree(dptr->data[i]);
> 			kfree(dptr->data);
> 			dptr->data=  NULL;
> 		}
> 		next=  dptr->next;
> 		kfree(dptr);
> 	}
> 	dev->size=  0;
> 	dev->quantum=  scull_quantum;
> 	dev->qset=  scull_qset;
> 	dev->data=  NULL;
> 	return  0;
> }
> 
> intscull_release(struct inode*inode,  struct file*filp)
> {
>      printk(KERN_DEBUG"process %i (%s) success release minor(%u) file\n",  current->pid,  current->comm,  iminor(inode));
> 	return  0;
> }
> 
> /* * Open and close */
> 
> intscull_open(struct inode*inode,  struct file*filp)
> {
> 	struct scull_dev*dev;  /* device information */
> 
> 	dev=  container_of(inode->i_cdev,  struct scull_dev,  cdev);
> 	filp->private_data=  dev;  /* for other methods */
> 
> 	/* If the device was opened write-only, trim it to a length of 0. */
> 	if  (  (filp->f_flags&  O_ACCMODE)  ==  O_WRONLY)  {
> 		if  (mutex_lock_interruptible(&dev->mutex))
> 			return  -ERESTARTSYS;
> 		scull_trim(dev);  /* Ignore errors. */
> 		mutex_unlock(&dev->mutex);
> 	}
>      printk(KERN_DEBUG"process %i (%s) success open minor(%u) file\n",  current->pid,  current->comm,  iminor(inode));
> 	return  0;
> }
> 
> /* * The "extended" operations -- only seek. */
> 
> loff_tscull_llseek(struct file*filp,  loff_t off,  int whence)
> {
> 	struct scull_dev*dev=  filp->private_data;
> 	loff_t newpos;
> 
> 	switch(whence)  {
> 	case  0:  /* SEEK_SET */
> 		newpos=  off;
> 		break;
> 
> 	case  1:  /* SEEK_CUR */
> 		newpos=  filp->f_pos+  off;
> 		break;
> 
> 	case  2:  /* SEEK_END */
> 		newpos=  dev->size+  off;
> 		break;
> 
> 	default:  /* can't happen */
> 		return  -EINVAL;
> 	}
> 	if  (newpos<  0)
> 		return  -EINVAL;
> 	filp->f_pos=  newpos;
> 	return  newpos;
> }
> 
> struct file_operations scull_fops=  {
> 	.owner=     THIS_MODULE,
> 	.llseek=    scull_llseek,
> 	.read=      scull_read,
> 	.write=     scull_write,
> 	// .unlocked_ioctl = scull_ioctl,
> 	.open=      scull_open,
> 	.release=   scull_release,
> };
> 
> /* * Set up the char_dev structure for this device. */
> static  void  scull_setup_cdev(struct scull_dev*dev,  int index)
> {
> 	int err,  devno=  MKDEV(scull_major,  scull_minor+  index);
> 
> 	cdev_init(&dev->cdev,  &scull_fops);
> 	dev->cdev.owner=  THIS_MODULE;
> 	dev->cdev.ops=  &scull_fops;
> 	err=  cdev_add  (&dev->cdev,  devno,  1);
> 	/* Fail gracefully if need be. */
> 	if  (err)
> 		printk(KERN_NOTICE"Error %d adding scull%d",  err,  index);
>      else
>          printk(KERN_INFO"scull: %d add success\n",  index);
> }
> 
> 
> void  scull_cleanup_module(void)
> {
> 	int i;
> 	dev_t devno=  MKDEV(scull_major,  scull_minor);
> 
> 	/* Get rid of our char dev entries. */
> 	if  (scull_devices)  {
> 		for  (i=  0;  i<  scull_nr_devs;  i++)  {
> 			scull_trim(scull_devices+  i);
> 			cdev_del(&scull_devices[i].cdev);
> 		}
> 		kfree(scull_devices);
> 	}
> 
> 	/* cleanup_module is never called if registering failed. */
> 	unregister_chrdev_region(devno,  scull_nr_devs);
>      printk(KERN_INFO"scull: cleanup success\n");
> }
> 
> 
> intscull_init_module(void)
> {
> 	int result,  i;
> 	dev_t dev=  0;
> 
> 	/* * Get a range of minor numbers to work with, asking for a dynamic 
> major * unless directed otherwise at load time. */
> 	if  (scull_major)  {
> 		dev=  MKDEV(scull_major,  scull_minor);
> 		result=  register_chrdev_region(dev,  scull_nr_devs,  "scull");
> 	}  else  {
> 		result=  alloc_chrdev_region(&dev,  scull_minor,  scull_nr_devs,  "scull");
> 		scull_major=  MAJOR(dev);
> 	}
> 	if  (result<  0)  {
> 		printk(KERN_WARNING"scull: can't get major %d\n",  scull_major);
> 		return  result;
> 	}  else  {
>          printk(KERN_INFO"scull: get major %d success\n",  scull_major);
>      }
> 
>          /* * Allocate the devices. This must be dynamic as the device number can 
> * be specified at load time. */
> 	scull_devices=  kmalloc(scull_nr_devs*  sizeof(struct scull_dev),  GFP_KERNEL);
> 	if  (!scull_devices)  {
> 		result=  -ENOMEM;
> 		goto fail;
> 	}
> 	memset(scull_devices,  0,  scull_nr_devs*  sizeof(struct scull_dev));
> 
>          /* Initialize each device. */
> 	for  (i=  0;  i<  scull_nr_devs;  i++)  {
> 		scull_devices[i].quantum=  scull_quantum;
> 		scull_devices[i].qset=  scull_qset;
> 		mutex_init(&scull_devices[i].mutex);
> 		scull_setup_cdev(&scull_devices[i],  i);
> 	}
> 
> 	return  0;  /* succeed */
> 
>    fail:
> 	scull_cleanup_module();
> 	return  result;
> }
> 
> module_init(scull_init_module);
> module_exit(scull_cleanup_module);
> 
> 
> 
> 
> 
> 
> Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> 于 
> 2020年4月6日周一 下午3:45写道：
> 
>     On 06.04.20 09:22, 孙世龙 via Xenomai wrote:
>      > Is anybody could show me a simple xenomai3 rtdm driver to read/write
>      > virtual memory device?
>      > A virtual memory device to:
>      >      write "hello world" to memory device in real real time(It's
>     appricate
>      > if the write operation could wake up the read task which allready
>     waited to
>      > read)
>      > read  the memory device in real time(It's appricate if the read
>     operation
>      > could wake up the write task which allready waited to write)
>      >
> 
>     What do you mean with "virtual memory"?
> 
>     If you are looking for a pattern how a driver implements read/write
>     callbacks, maybe study the serial drivers. They come closest to
>     "simple".
> 
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

