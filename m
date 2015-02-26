MIME-Version: 1.0
In-Reply-To: <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
From: Michael Smith <2michael.smith@gmail.com>
Date: Thu, 26 Feb 2015 08:07:43 +0200
Message-ID: <CANWkrROU7su-1ZEFJiUfV-8KB-swyDq9q551irut18RBxyxdHA@mail.gmail.com>
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
To: Bart Vissers <bvissers@e2mtechnologies.eu>
Cc: xenomai@xenomai.org

On Wed, Feb 25, 2015 at 10:33 AM, Bart Vissers
<bvissers@e2mtechnologies.eu> wrote:
> Hi Philippe,
>
> Before making any changes, I ran xeno-config --info:
> Xenomai version: Xenomai/cobalt v3.0-rc3 --
> Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 2015
> i686 GNU/Linux
> Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
> root=3DUUID=3D0925426e-e058-4093-963c-8b7de072e229 ro quiet
> I-pipe release #2 detected
> Cobalt core 3.0-rc3 detected
> Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai
> --mandir=3D/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuite
> --build i486-linux-gnu build_alias=3Di486-linux-gnu
>
> namelist did not work, as latency does not contain any symbols. How
> can I include these when building debian packages?
>
> Unfortunately, I got compilation errors after applying the patch to
> xenomai-3.0-rc3: error: =E2=80=98XENO_WARNING=E2=80=99 undeclared (first =
use in this
> function)
> So I decided to repeat my steps with the git next branch, 52fb91e...
> So, same linux kernel, i-pipe patch and kernel config. Also included
> the printk patch. Output:
>
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> latency: failed to set periodic, code 9
> ^C---|-----------|-----------|-----------|--------|------|---------------=
----------
> RTS|  10000.000|      0.000| -10000.000|       0|     0|    00:03:26/00:0=
3:26
>
> Notice the ^C. I killed it because it was running indefinitely. This
> was also the case in my previous attempts.
>
>
> Best regards,
> Bart

Just to confirm my output screen pretty much looks identical, after I hit
Ctrl-C.

Michael

