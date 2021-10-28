Subject: Re: which mmap API
References: <CA+K1mPHJGftXH0ujmAyUryBpR3iC7kAeLU0oi3cHBfhF4Gn9iQ@mail.gmail.com>
 <f8927397-95d4-3866-9327-84b29fe237c2@siemens.com>
 <CA+K1mPH3UE1y0r3u6sE7HuB5wtUWMg6rFZqZ5_ehyAQmGpdTHg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <798bf1ee-ceb0-fd16-3dbb-96640e1293e5@siemens.com>
Date: Thu, 28 Oct 2021 09:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPH3UE1y0r3u6sE7HuB5wtUWMg6rFZqZ5_ehyAQmGpdTHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On 28.10.21 09:30, C Smith wrote:
> OK thanks. I am attaching a proposed patch for the docs. I've tried to
> use the syntax of the Linux Device Drivers book.

Thanks, looks good, but we need that as proper patch (subject, brief
body and at least a signed-of-by). See CONTRIBUTING.md.

> I will soon submit a more complete pair of test apps for using mmap(),
> which I assume would end up in xenomai-3.x/demo/cobalt/.

demo/posix/cobalt, yes, probably.

Jan

> 
> thanks,
> -C Smith
> 
> On Thu, Oct 21, 2021 at 8:23 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 20.10.21 07:49, C Smith via Xenomai wrote:
>     > I recently got a Xenomai 3.1 shared memory .mmap op to work but I
>     don't see
>     > any mmap examples in the Xemomai documentation (please publish
>     one). I have
>     > a question as to why I had to do it a certain way. Here is the
>     > (abbreviated) code I used:
>     >
>     > typedef struct {         // shared struct
>     >    int data[PAGE_SIZE*4];
>     > } shm_test_t;
>     >
>     > shm_test_t *shm_test_p = 0;    // create a driver struct to share
>     > shm_test_p = kmalloc(sizeof(shm_test_t) + RTDM_MAX_DEVNAME_LEN,
>     > GFP_KERNEL);
>     >
>     > static struct rtdm_driver device_tmpl = {
>     >    .profile_info        =
>     > RTDM_PROFILE_INFO(mydev_,RTDM_CLASS_EXPERIMENTAL,0,999),
>     >    .device_flags = RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
>     >    .device_count        = MAX_DEVICES,
>     >    .context_size = sizeof(struct mydev_context),
>     >    .ops = {
>     >       .open = mydev_open,
>     >       .close        = mydev_close,
>     >       .read_nrt         = mydev_read,
>     >       .ioctl_rt   = mydev_ioctl,
>     >       .ioctl_nrt = mydev_ioctl,
>     >       .mmap             = mydev_mmap,
>     >    },
>     > };
>     >
>     > // device initialization
>     > dev = kmalloc(sizeof(struct rtdm_device) + RTDM_MAX_DEVNAME_LEN,
>     > GFP_KERNEL);
>     > dev->driver = &device_tmpl;
>     > dev->label = "mydev%d";
>     > name = (char *)(dev + 1);
>     > ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
>     > err = rtdm_dev_register(dev);
>     >
>     > // .mmap op handler
>     > int mydev_mmap(struct rtdm_fd *fd, struct vm_area_struct *vma)
>     > {
>     >     rtdm_mmap_kmem(vma, shm_test_p);   // do the address conversion
>     > }
>     >
>     > That works.  I can share the shm_test_t struct between my rtdm
>     driver and
>     > userspace.
>     > In userspace I do:
>     > mydev_fd = open("/dev/rtdm/mydev0", O_RDWR);  // linked against
>     Xeno3.1
>     > posix wrappers
>     > shmem_data_p = (shm_test_t *)
>     > mmap(0,sizeof(shm_test_t),PROT_READ|PROT_WRITE,MAP_SHARED,mydev_fd,0);
>     >
>     > That works, but why don't I need rtdm_mmap_to_user() in the .mmap op
>     > handler? If rtdm_mmap_kmem() does the job then why does
>     rtdm_mmap_to_user()
>     > exist?
> 
>     rtdm_mmap_to_user is only foreseen for cases outside of an mmap handler,
>     typically in some specific ioctl (see e.g.
>     kernel/drivers/analogy/buffer.c). Most cases a better and more
>     consistently handled via mmap handler and, thus, mmap() syscalls. We can
>     improve the documentation on this cases. For rtdm_mmap_{k,v,io}mem, the
>     situation should be better already.
> 
>     In any case, patches welcome.
> 
>     Jan
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

