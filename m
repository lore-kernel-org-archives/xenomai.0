MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 19 Oct 2021 22:49:14 -0700
Message-ID: <CA+K1mPHJGftXH0ujmAyUryBpR3iC7kAeLU0oi3cHBfhF4Gn9iQ@mail.gmail.com>
Subject: which mmap API
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I recently got a Xenomai 3.1 shared memory .mmap op to work but I don't see
any mmap examples in the Xemomai documentation (please publish one). I have
a question as to why I had to do it a certain way. Here is the
(abbreviated) code I used:

typedef struct {         // shared struct
   int data[PAGE_SIZE*4];
} shm_test_t;

shm_test_t *shm_test_p = 0;    // create a driver struct to share
shm_test_p = kmalloc(sizeof(shm_test_t) + RTDM_MAX_DEVNAME_LEN,
GFP_KERNEL);

static struct rtdm_driver device_tmpl = {
   .profile_info        =
RTDM_PROFILE_INFO(mydev_,RTDM_CLASS_EXPERIMENTAL,0,999),
   .device_flags = RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
   .device_count        = MAX_DEVICES,
   .context_size = sizeof(struct mydev_context),
   .ops = {
      .open = mydev_open,
      .close        = mydev_close,
      .read_nrt         = mydev_read,
      .ioctl_rt   = mydev_ioctl,
      .ioctl_nrt = mydev_ioctl,
      .mmap             = mydev_mmap,
   },
};

// device initialization
dev = kmalloc(sizeof(struct rtdm_device) + RTDM_MAX_DEVNAME_LEN,
GFP_KERNEL);
dev->driver = &device_tmpl;
dev->label = "mydev%d";
name = (char *)(dev + 1);
ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
err = rtdm_dev_register(dev);

// .mmap op handler
int mydev_mmap(struct rtdm_fd *fd, struct vm_area_struct *vma)
{
    rtdm_mmap_kmem(vma, shm_test_p);   // do the address conversion
}

That works.  I can share the shm_test_t struct between my rtdm driver and
userspace.
In userspace I do:
mydev_fd = open("/dev/rtdm/mydev0", O_RDWR);  // linked against Xeno3.1
posix wrappers
shmem_data_p = (shm_test_t *)
mmap(0,sizeof(shm_test_t),PROT_READ|PROT_WRITE,MAP_SHARED,mydev_fd,0);

That works, but why don't I need rtdm_mmap_to_user() in the .mmap op
handler? If rtdm_mmap_kmem() does the job then why does rtdm_mmap_to_user()
exist?

thanks, -C Smith
