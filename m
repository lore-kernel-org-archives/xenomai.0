MIME-Version: 1.0
References: <20211220071310.116526-1-ksmola51@gmail.com>
 <42e197d4b23feae90c591217e4dc0e1dca731dd9.camel@siemens.com>
In-Reply-To: <42e197d4b23feae90c591217e4dc0e1dca731dd9.camel@siemens.com>
From: k smo <ksmola51@gmail.com>
Date: Tue, 21 Dec 2021 00:43:38 -0800
Message-ID: <CAC2JQegXmrgGm5eZwktV5-fp9+xwF=2ZfCGTbbXOT+NwLeqVMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Examples demonstrating .mmap() in RTDM driver
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Actually I'll avoid the PAGE_SIZE issue since there isn't a need for the
userspace app to know anything about kernel pages in order to use mmap.
Since this is a demo, we'll put various types of data in the shared struct.
Here are highlights from the revised code:

typedef struct {        /* memory to share */
       char name[32];
       int data[4096];
       double dval;
} shm_test_layout_t;

The kernel module does:

shm_size = (sizeof(shm_test_layout_t) / PAGE_SIZE);
rem = (sizeof(shm_test_layout_t) % PAGE_SIZE);
if (rem)
      shm_size += 1;
if (shm_size < 2)       // xenomai has a minimum requirement of 2 pages for
mappable heaps...
      shm_size = 2;
shm_size *= PAGE_SIZE;
rtdm_printk("xmmap module: shared memory size will be: %d\n", shm_size);

shm_test_layout_t *xmmap_shared_area_p = NULL;
xmmap_shared_area_p = (shm_test_layout_t *) vmalloc(shm_size +
RTDM_MAX_DEVNAME_LEN);

The module initilizes the string, integers and the double.
Then once module it is loaded we see this in dmesg:

[454162.232511] xmmap module: Initializing xmmap module
[454162.232515] xmmap module: raw shared struct size: 16424
[454162.232517] xmmap module: shared memory size will be: 20480
[454162.232531] xmmap module: shared memory address: 00000000ca8d562b
[454162.232588] xmmap module: device0 registration OK, returned: 0

The userspace app does:

_shmem_size = sizeof(shm_test_layout_t);
xmmap_fd = open("/dev/rtdm/xeno_mmap0", O_RDWR);
if (xmmap_fd > 0) {
               xmmap_shmem_data_p =
                   (shm_test_layout_t *) mmap(0, _shmem_size, PROT_READ |
PROT_WRITE, MAP_SHARED, xmmap_fd, 0);

Running the userspace app:
 ./xmmap_user
Original raw size of shmem segment is: 16424
Opened device OK. file descriptor is: 3
Attempting to mmap() the fd...
Shared memory address is : 0xf7f67000
Shared string: xeno
Shared integers: 100,101,102,103
Shared float: 123.456000

Above in the prints you see that the userspace app gets the exact same
sizeof() struct, but the
userspace app does not care that the module has rounded up the size of the
allocated memory.

-Konstantin

On Mon, Dec 20, 2021 at 3:34 AM Bezdeka, Florian <
florian.bezdeka@siemens.com> wrote:

> Hi Konstantin,
>
> On Sun, 2021-12-19 at 23:13 -0800, Konstantin Smola via Xenomai wrote:
> > +#ifndef PAGE_SIZE
> > +#define PAGE_SIZE 4096
> > +#endif
> > +
> > +typedef struct {             /* memory to share */
> > +     int data[PAGE_SIZE * 100];
> > +     double dval;
> > +} shm_test_layout_t;
>
> Hm...
>
> First of all, there is no guarantee for 4k pages. I would prefer using
> sysconf(_SC_PAGESIZE) for fetching the page size.
>
> Second, PAGE_SIZE * 100 makes 100 pages, but as array size of int it
> will be sizeof(int)*PAGE_SIZE*100, not sure if that is what you want
> for an example.
>
> At first glance it looks like data should be void* and pre-fixed with a
> new member named "size" of type size_t. I did not review the remaining
> parts in detail, so I might miss something.
>
