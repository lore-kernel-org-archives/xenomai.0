MIME-Version: 1.0
In-Reply-To: <20150225093213.GM14148@hermes.click-hack.org>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
 <54ED94CE.3040409@xenomai.org> <20150225093213.GM14148@hermes.click-hack.org>
From: Michael Smith <2michael.smith@gmail.com>
Date: Thu, 26 Feb 2015 08:05:06 +0200
Message-ID: <CANWkrROKH_8hReyDYMgBqRF3tM5mrCRM7Dk=MsSdaYJvQzcy9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Feb 25, 2015 at 11:32 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, Feb 25, 2015 at 10:24:30AM +0100, Philippe Gerum wrote:
>> On 02/25/2015 09:33 AM, Bart Vissers wrote:
>> > Hi Philippe,
>> >
>> > Before making any changes, I ran xeno-config --info:
>> > Xenomai version: Xenomai/cobalt v3.0-rc3 --
>> > Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 2015
>> > i686 GNU/Linux
>> > Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
>> > root=UUID=0925426e-e058-4093-963c-8b7de072e229 ro quiet
>> > I-pipe release #2 detected
>> > Cobalt core 3.0-rc3 detected
>> > Build args: --prefix=/usr --includedir=/usr/include/xenomai
>> > --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite
>> > --build i486-linux-gnu build_alias=i486-linux-gnu
>> >
>> > namelist did not work, as latency does not contain any symbols. How
>> > can I include these when building debian packages?
>>
>> I don't have much knowledge of the Debian pkg system, but the way I used
>> to do this was:
>>
>> export DEB_BUILD_OPTIONS="debug nostrip"
>>
>> before building the package, maybe adding "noopt" if you also want to
>> disable the optimizer, although this is not required for keeping the
>> namelist. Gilles certainly has more on this.
>
> We separate packages on 2.6 with only the debug symbols, named
> xenomai-runtime-debg and libxenomai1-dbg, you need to install them
> to have the debug symbols. But I do not think you need the debug
> symbols to list the dynamic symbols of a binary, the dynamic symbol
> tables is not remove by the stripping process. Simply run:
>
> nm -D /path/to/latency
>
>
> --
>                                             Gilles.


I just want to confirm my system is also built with Debian packaging
method. I am running Ubuntu 14.04.

Here are the outputs on my system, with:  xeno-config --info

Xenomai version: Xenomai/cobalt v3.0-rc3 --
Linux acs1-marlin 3.14.28-xenomai-3.0-rc3-52fb91e #1 SMP Mon Feb 23
09:56:59 SAST 2015 i686 i686 i686 GNU/Linux
Kernel parameters: BOOT_IMAGE=/vmlinuz-3.14.28-xenomai-3.0-rc3-52fb91e
root=/dev/mapper/ubuntu--vg-root ro quiet splash vt.handoff=7
I-pipe release #7 detected
Cobalt core 3.0-rc3 detected
Build args: --prefix=/usr --includedir=/usr/include/xenomai
--mandir=/usr/share/man
--with-testdir=/usr/lib/xenomai/testsuite --build i686-linux-gnu
build_alias=i686-linux-gnu

Then I ran:

sudo nm -D ./latency  | grep __wrap

And got:

         U __wrap_clock_gettime
         U __wrap_close
         U __wrap_fclose
         U __wrap___fprintf_chk
         U __wrap_free
         U __wrap_fwrite
         U __wrap_ioctl
         U __wrap_kill
         U __wrap_open
         U __wrap___printf_chk
         U __wrap_pthread_create
         U __wrap_pthread_join
         U __wrap_pthread_setname_np
         U __wrap_puts
         U __wrap_read
         U __wrap_sem_close
         U __wrap_sem_open
         U __wrap_sem_post
         U __wrap_sem_unlink
         U __wrap_sem_wait
         U __wrap_time
         U __wrap_timerfd_create
         U __wrap_timerfd_settime
         U __wrap_write

Regards
Michael

