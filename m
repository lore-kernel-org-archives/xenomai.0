MIME-Version: 1.0
In-Reply-To: <54ED94CE.3040409@xenomai.org>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
 <54ED94CE.3040409@xenomai.org>
From: Michael Smith <2michael.smith@gmail.com>
Date: Thu, 26 Feb 2015 08:20:17 +0200
Message-ID: <CANWkrROaEV=DdTLcfKB+8RWpucpwypUXXxi_H7bdErWajTruAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Feb 25, 2015 at 11:24 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 02/25/2015 09:33 AM, Bart Vissers wrote:
>> Hi Philippe,
>>
>> Before making any changes, I ran xeno-config --info:
>> Xenomai version: Xenomai/cobalt v3.0-rc3 --
>> Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 2015
>> i686 GNU/Linux
>> Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
>> root=3DUUID=3D0925426e-e058-4093-963c-8b7de072e229 ro quiet
>> I-pipe release #2 detected
>> Cobalt core 3.0-rc3 detected
>> Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai
>> --mandir=3D/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuite
>> --build i486-linux-gnu build_alias=3Di486-linux-gnu
>>
>> namelist did not work, as latency does not contain any symbols. How
>> can I include these when building debian packages?
>
> I don't have much knowledge of the Debian pkg system, but the way I used
> to do this was:
>
> export DEB_BUILD_OPTIONS=3D"debug nostrip"
>
> before building the package, maybe adding "noopt" if you also want to
> disable the optimizer, although this is not required for keeping the
> namelist. Gilles certainly has more on this.
>
> This said, at this stage you may want to build the user-space code
> manually, leaving aside the debian pkg builder. It would be much easier
> to control the build configuration process, at least for me:
>
> http://xenomai.org/installing-xenomai-3-x/#Building_the_x86_libraries_326=
4bit
>
>> Unfortunately, I got compilation errors after applying the patch to
>> xenomai-3.0-rc3: error: =E2=80=98XENO_WARNING=E2=80=99 undeclared (first=
 use in this
>> function)
>
> Yes, I'm always referring to the current development tip in this discussi=
on.
>
>> So I decided to repeat my steps with the git next branch, 52fb91e...
>> So, same linux kernel, i-pipe patch and kernel config. Also included
>> the printk patch. Output:
>>
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: periodic user-mode task
>> =3D=3D All results in microseconds
>> warming up...
>> latency: failed to set periodic, code 9
>> ^C---|-----------|-----------|-----------|--------|------|--------------=
-----------
>> RTS|  10000.000|      0.000| -10000.000|       0|     0|    00:03:26/00:=
03:26
>>
>> Notice the ^C. I killed it because it was running indefinitely. This
>
> That is expected, the main thread just hangs paused in this case. If you
> don't hit ^C, the real-time core should report two cobalt threads as
> follows:

On my side, when running without hitting ^C, the console output:

=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
latency: failed to set periodic, code 9

>
> ~ # cat /proc/xenomai/sched/threads
> CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
>   0  0      idle   core       -1   -             R          [ROOT]
>   0  1206   rt     cobalt      0   -             X          latency
>   0  1208   rt     cobalt      0   -             W          display-1206
>

Console output for this:

CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
  2  541    rt     core       98   -             W          [rtnet-stack]
  3  542    rt     core        0   -             W          [rtnet-rtpc]
  0  2959   rt     cobalt      0   -             X          latency
  0  2961   rt     cobalt      0   -             W          display-2959


> Do you confirm this on your end? If so, then can you look a bit further,
> listing the file descriptors currently open for the main thread, e.g. in
> my case:
>
> ~ # ls -l /proc/1206/fd
> total 0
> lrwx------    1 root     root            64 Feb 25 09:21 0 -> /dev/pts/0
> lrwx------    1 root     root            64 Feb 25 09:21 1 -> /dev/pts/0
> lrwx------    1 root     root            64 Feb 25 09:21 2 -> /dev/pts/0
> lrwx------    1 root     root            64 Feb 25 09:21 3 ->
> anon_inode:[cobalt-timerfd]
>

And for this:
# ls -l /proc/2959/fd

total 0
lrwx------ 1 root root 64 Feb 26 08:13 0 -> /dev/pts/1
lrwx------ 1 root root 64 Feb 26 08:13 1 -> /dev/pts/1
lrwx------ 1 root root 64 Feb 26 08:13 2 -> /dev/pts/1
lrwx------ 1 root root 64 Feb 26 08:13 3 -> anon_inode:[cobalt-timerfd]


> I'm interested to know whether you can see the last one.
>
>> was also the case in my previous attempts.
>>
>
> So you received no message visible from dmesg?
>

Also checked dmesg, no extra outputs relating to the latency program.
Michael

> --
> Philippe.

