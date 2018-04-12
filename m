References: <C2EC5BA46D13CD44B5915A8FEEB4C44E8488E31A@DDCEXCH.ddc-ny.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2fa46484-f8e1-ffbd-5e67-79d6345d08d2@xenomai.org>
Date: Thu, 12 Apr 2018 10:58:20 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E8488E31A@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mmap when using in conjunction with mapper to
 retrieve memory mapped IO space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 04/10/2018 09:03 PM, Pham, Phong wrote:
> 
> Hi,
> 
> According to page 651
> https://xenomai.org/documentation/xenomai-3/pdf/xeno3prm.pdf
> 
> 
> This will make such region accessible via the mapper device using the following sequence of code, via
> the default ->mmap() handler from the UDD core:
> int fd, fdm;
> void *p;
> fd = open("/dev/foocard", O_RDWR);
> fdm = open("/dev/foocard,mapper@2", O_RDWR);
> p = mmap(NULL, 4096, PROT_READ|PROT_WRITE, 0, fdm, 0);
> 
> 
> I have several questions:
> 
> 1)      It looks like the 4th argument of mmap (the one to the left of "fdm") needs to be either MAP_SHARED or MAP_PRIVATE
> 
> 2)      The "@" character right after "mapper" is not valid (ie. there should be no "@" character at all)
> 
> 3)      /dev/foocard should be /dev/rtdm/foocard


Fixed, thanks.

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/structudd__memregion.html#udd_memory_region

> 
> here's my real question:
> 
> Assuming all 3 of the above is valid from user space, and on the kernel space, I followed the ex. to create memory region, etc. such that I do see my device
> 
> # ls -l dev/rtdm
> crw-------    1 root     root      252,   0 Jan  1 00:00 autotune
> crw-------    1 root     root      247,   0 Jan  1 00:00 eeprom
> crw-------    1 root     root      246,   0 Jan  1 00:00 eeprom,mapper0
> crw-------    1 root     root      254,   0 Jan  1 00:00 memdev-private
> crw-------    1 root     root      254,   1 Jan  1 00:00 memdev-shared
> crw-------    1 root     root      253,   0 Jan  1 00:00 memdev-sys
> crw-------    1 root     root      249,   0 Jan  1 00:00 mmio
> crw-------    1 root     root      248,   0 Jan  1 00:00 mmio,mapper0
> crw-------    1 root     root      248,   1 Jan  1 00:00 mmio,mapper1
> crw-------    1 root     root      248,   2 Jan  1 00:00 mmio,mapper2
> crw-------    1 root     root      248,   3 Jan  1 00:00 mmio,mapper3
> crw-------    1 root     root      248,   4 Jan  1 00:00 mmio,mapper4
> crw-------    1 root     root      250,   0 Jan  1 00:00 switchtest
> crw-------    1 root     root      251,   0 Jan  1 00:00 timerbench
> 
> 
> like /dev/rtdm/eeprom and /dev/rtdm/eeprom,mapper0  etc. I don't see my kernel hook ever gets called
> 
> 
> static struct udd_device eeprom = {
>               .device_flags = RTDM_NAMED_DEVICE,
>               .device_name = "eeprom",
>               .ops = {
>                              .close = phong_scs750_close,
>                              .open = phong_scs750_open,
>                              .mmap = phong_scs750_mmap,
>               }
> 
> By that, I mean phong_scs750_open, phong_scs750_mmap never gets invoked.  mmap() from user space returns -1 with errno value of 19 (ENODEV).  Any advise?

Your app may be missing symbol wrapping. Please check out this doc:

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api.html

-- 
Philippe.

