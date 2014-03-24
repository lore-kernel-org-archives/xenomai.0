MIME-Version: 1.0
Date: Mon, 24 Mar 2014 13:48:56 +0000
Message-ID: <CAKJ14NcHyt724RqMxa_Wa2kQBtc=j1Z6VpJK-2M6Z4ieNjqzsQ@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
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
To: xenomai@xenomai.org

>
> Message: 2
> Date: Fri, 21 Mar 2014 10:47:20 -0400
> From: Adam Vaughan <vaughana@umich.edu>
> To: Paul <paul_c@tuxcnc.org>, "xenomai@xenomai.org"
>         <xenomai@xenomai.org>
> Subject: Re: [Xenomai] Raspberry Pi SD Card Issue
> Message-ID:
>         <CAK4EZFQecV3B0uq+d3KKWX7HJB0=
> Ume48fqcfaqH492rMpXmWg@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> After a fair amount of detective work with kernel code, searching
> through forums / commit logs, trying different kernel versions /
> configs, etc. I finally found the cause for this problem.  It was the
> cross-compile toolchain I built with crosstool-ng.  I was using the
> stock crosstool-ng armv6-rpi-linux-gnueabi configuration and I believe
> (but I am not 100% sure) commit 86a8d1d467c8.
>

Thanks for investigating this. I think that might be a good starting point
for me [1] since it my problem persists even after trying the same tests
with two brand new sd cards on several occasions (I am using 'crosstool-NG
linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04').

However, the cited commit (
http://crosstool-ng.org/hg/crosstool-ng/rev/86a8d1d467c8 ) looks
unsuspicious to me. Could you elaborate how this might influence the
generated kernel binaries?


>
> The fix is to use the toolchain provided by the Raspberry Pi
> foundation at git://github.com/raspberrypi/tools.git .  I don't really
> have time to dig into why the other toolchain produced an occasional
> kernel glitch, but I thought I'd let everyone know it's something to
> be aware of.
>
>
[1] https://www.mail-archive.com/xenomai@xenomai.org/msg04453.html
