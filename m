MIME-Version: 1.0
From: ilyasse toumi <toumi.ily@gmail.com>
Date: Tue, 15 Dec 2015 13:19:29 +0100
Message-ID: <CAG6c7CZLmLg-Ko_tFqWGoVXXuKBUyx339VwD5LdzicJwQ_M1SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Subscribe request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi there,

I'm using kernel rpi-3.18.y as mentioned in an email sent by Joe Lee about
RPI2, I used the patch ipipe-core-3.18.20-arm-6.patch and also the patch
for RPI2 version5, the problem is that when i try to compile the kernel
after patching it it gives some errors.
It's about some implicit declarations of functions that are present in the
patch like

__ipipe_mach_update_tsc
smp_mb__before_atomic_dec
smp_mb__before_atomic_dec
....

Could someone please help me solve these errors.

Or if someone succeeded in patching the Kernel for RPI2, please provide a
tutorial o some help with details

=E2=80=8Bthanks in advance
--=20
--
