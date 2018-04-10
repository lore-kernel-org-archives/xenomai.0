From: "Pham, Phong" <phamp@ddc-web.com>
Date: Tue, 10 Apr 2018 19:03:08 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44E8488E31A@DDCEXCH.ddc-ny.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] mmap when using in conjunction with mapper to retrieve
 memory mapped IO space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>


Hi,

According to page 651
https://xenomai.org/documentation/xenomai-3/pdf/xeno3prm.pdf


This will make such region accessible via the mapper device using the follo=
wing sequence of code, via
the default ->mmap() handler from the UDD core:
int fd, fdm;
void *p;
fd =3D open("/dev/foocard", O_RDWR);
fdm =3D open("/dev/foocard,mapper@2", O_RDWR);
p =3D mmap(NULL, 4096, PROT_READ|PROT_WRITE, 0, fdm, 0);


I have several questions:

1)      It looks like the 4th argument of mmap (the one to the left of "fdm=
") needs to be either MAP_SHARED or MAP_PRIVATE

2)      The "@" character right after "mapper" is not valid (ie. there shou=
ld be no "@" character at all)

3)      /dev/foocard should be /dev/rtdm/foocard

here's my real question:

Assuming all 3 of the above is valid from user space, and on the kernel spa=
ce, I followed the ex. to create memory region, etc. such that I do see my =
device

# ls -l dev/rtdm
crw-------    1 root     root      252,   0 Jan  1 00:00 autotune
crw-------    1 root     root      247,   0 Jan  1 00:00 eeprom
crw-------    1 root     root      246,   0 Jan  1 00:00 eeprom,mapper0
crw-------    1 root     root      254,   0 Jan  1 00:00 memdev-private
crw-------    1 root     root      254,   1 Jan  1 00:00 memdev-shared
crw-------    1 root     root      253,   0 Jan  1 00:00 memdev-sys
crw-------    1 root     root      249,   0 Jan  1 00:00 mmio
crw-------    1 root     root      248,   0 Jan  1 00:00 mmio,mapper0
crw-------    1 root     root      248,   1 Jan  1 00:00 mmio,mapper1
crw-------    1 root     root      248,   2 Jan  1 00:00 mmio,mapper2
crw-------    1 root     root      248,   3 Jan  1 00:00 mmio,mapper3
crw-------    1 root     root      248,   4 Jan  1 00:00 mmio,mapper4
crw-------    1 root     root      250,   0 Jan  1 00:00 switchtest
crw-------    1 root     root      251,   0 Jan  1 00:00 timerbench


like /dev/rtdm/eeprom and /dev/rtdm/eeprom,mapper0  etc. I don't see my ker=
nel hook ever gets called


static struct udd_device eeprom =3D {
              .device_flags =3D RTDM_NAMED_DEVICE,
              .device_name =3D "eeprom",
              .ops =3D {
                             .close =3D phong_scs750_close,
                             .open =3D phong_scs750_open,
                             .mmap =3D phong_scs750_mmap,
              }

By that, I mean phong_scs750_open, phong_scs750_mmap never gets invoked.  m=
map() from user space returns -1 with errno value of 19 (ENODEV).  Any advi=
se?

Phong.
Notice: This e-mail and any files transmitted with it may contain Data Devi=
ce Corporation's privileged and proprietary information. It is intended sol=
ely for the use of the individual or entity to whom it is addressed. If you=
 are not the named recipient of this transmission, any disclosure, copying,=
 distribution or reliance on the contents of this message is prohibited. If=
 you received this e-mail in error, please destroy it and any attached file=
s and notify me immediately.
