MIME-Version: 1.0
In-Reply-To: <CAKJ14NcHyt724RqMxa_Wa2kQBtc=j1Z6VpJK-2M6Z4ieNjqzsQ@mail.gmail.com>
References: <CAKJ14NcHyt724RqMxa_Wa2kQBtc=j1Z6VpJK-2M6Z4ieNjqzsQ@mail.gmail.com>
Date: Mon, 24 Mar 2014 11:01:58 -0400
Message-ID: <CAK4EZFRdaFwbsZ0FOPZmQiddc2jzWNN-9sCbX9k8L8wtb-R11Q@mail.gmail.com>
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

> However, the cited commit (
> http://crosstool-ng.org/hg/crosstool-ng/rev/86a8d1d467c8 ) looks
> unsuspicious to me. Could you elaborate how this might influence the
> generated kernel binaries?

I don't think that particular commit caused it.  I just mentioned the
commit so people would know around when the issue was happening if
they're looking to reproduce the problem.

Also, I'm not completely sure I was using 86a8d1d467c8 or something
more recent.  I deleted the toolchain after I identified it as the
cause, but my notes say it was 86a8d1d467c8.  My notes are fairly
thorough, but I don't always update them and I vaguely remember
rebuilding the toolchain at a later date.  It could just be a figment
of my imagination.

Anyway, I mentioned the toolchain issue because I would have never
guessed a toolchain could produce a kernel that booted and seemed fine
except for what appeared to be some kind of race condition within the
SD card driver when it was under heavy load.  As you may know, the
Raspberry Pi 3.8.13 kernel branch isn't being maintained and the
kernel drivers (especially USB) have been patched up quite a bit since
the device's introduction, so I think it's entirely reasonable to
suspect the code is broken, not the toolchain.

As for the actual cause within the toolchain, I really have no idea.
I have to finish my thesis research, so I have almost no free time to
investigate the cause beyond just noting a different toolchain made
all my problems go away.

On Mon, Mar 24, 2014 at 9:48 AM, Andreas Glatz <andi.glatz@gmail.com> wrote:
>>
>> Message: 2
>> Date: Fri, 21 Mar 2014 10:47:20 -0400
>> From: Adam Vaughan <vaughana@umich.edu>
>> To: Paul <paul_c@tuxcnc.org>, "xenomai@xenomai.org"
>>         <xenomai@xenomai.org>
>> Subject: Re: [Xenomai] Raspberry Pi SD Card Issue
>> Message-ID:
>>         <CAK4EZFQecV3B0uq+d3KKWX7HJB0=
>> Ume48fqcfaqH492rMpXmWg@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> After a fair amount of detective work with kernel code, searching
>> through forums / commit logs, trying different kernel versions /
>> configs, etc. I finally found the cause for this problem.  It was the
>> cross-compile toolchain I built with crosstool-ng.  I was using the
>> stock crosstool-ng armv6-rpi-linux-gnueabi configuration and I believe
>> (but I am not 100% sure) commit 86a8d1d467c8.
>>
>
> Thanks for investigating this. I think that might be a good starting point
> for me [1] since it my problem persists even after trying the same tests
> with two brand new sd cards on several occasions (I am using 'crosstool-NG
> linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04').
>
> However, the cited commit (
> http://crosstool-ng.org/hg/crosstool-ng/rev/86a8d1d467c8 ) looks
> unsuspicious to me. Could you elaborate how this might influence the
> generated kernel binaries?
>
>
>>
>> The fix is to use the toolchain provided by the Raspberry Pi
>> foundation at git://github.com/raspberrypi/tools.git .  I don't really
>> have time to dig into why the other toolchain produced an occasional
>> kernel glitch, but I thought I'd let everyone know it's something to
>> be aware of.
>>
>>
> [1] https://www.mail-archive.com/xenomai@xenomai.org/msg04453.html
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

