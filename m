MIME-Version: 1.0
In-Reply-To: <CAKJ14NcMmp5ikYEmot_sOmLChz7Amgi=5ZR4BX+NM23BB8yk8g@mail.gmail.com>
References: <CAKJ14NcMmp5ikYEmot_sOmLChz7Amgi=5ZR4BX+NM23BB8yk8g@mail.gmail.com>
Date: Tue, 25 Mar 2014 20:01:16 -0400
Message-ID: <CAK4EZFQ1+NBcwf9-V4dtD1E-F7QGKaymV7Ck9ZWD_6ULHdjm3A@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Raspberry Pi SD Card Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Don't get me wrong. I definitely know that different toolchains produce
> different binaries and I certainly can believe that issues like this can
> arise due to some toolchain "optimizations" or toolchain bugs. Those are
> usually the most tricky bugs to find as I still can remember and every
> little clue can be help in tracking them down that's why I was asking.

There's this saying that "a bad workman blames his tools."  So out of
concern that I might have made some kind of user error configuring
crosstool, I just tried both the old 86a8d1d467c8 I was using and the
most recent e11a8a2e225d with the crosstool provided stock
armv6-rpi-linux-gnueabi config:

hg clone http://crosstool-ng.org/hg/crosstool-ng
cd crosstool-ng
# FOR CURRENT VERSION:  hg update e11a8a2e225d
# FOR OLD VERSION:  hg update 86a8d1d467c8
autoconf
./configure --prefix="$PWD/toolchain-builder"
make
make install
cd toolchain-builder
PATH="$PATH:$PWD/bin"
ct-ng armv6-rpi-linux-gnueabi
ct-ng build  # Grab about 15 minutes worth of popcorn...

The current crosstool version e11a8a2e225d works, but the old
86a8d1d467c8 version throws the same SD card / ext4 error I was
seeing.  So it would appear that the problem is fixed in the most
recent crosstool, which is good news.

> Thanks again for looking into this. Good luck w your thesis.

Thank you.

