MIME-Version: 1.0
From: Hans Petersen <hpetersenlg@googlemail.com>
Date: Thu, 19 Aug 2021 14:16:42 +0200
Message-ID: <CAHk=vNFHsSE5iaJd30tSxEDiNBD+w2hmuhnY7CD7Rz6EyjqtJg@mail.gmail.com>
Subject: xenomai-4 on raspberry-pi-4
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, everyone,

I'm trying to get XENOMAI-4 to run on the Raspberry-PI-4.

For this I downloaded the source files '*v5.10.y-evl-rebase*' and compiled
them with 'bcm2711_defconfig'.

Unfortunately, the image does not work because many specific files, such as
the device tree and the broadcom drivers and serveral config-flags, are
missing in the source tree.
However, these are also missing in the mainline kernel.

I can load a kernel version *'5.10.52*' from the *Raspbian repository*.

*Now my question*:

Is there a possibility to patch XENOMAI4 into the Raspbian sources, or any
other way to install a Xenomai-4 on the Raspberry-PI-4?

Thanks
