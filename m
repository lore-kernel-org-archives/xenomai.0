MIME-Version: 1.0
References: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
 <9a2d7001-a0d7-b87c-be89-c4cad2051273@siemens.com>
 <CAEmXcAwpe3dVcriUjFYdvsQB0Kra13nY+yLtCDCyzoeCww+xCA@mail.gmail.com>
 <CAEmXcAzc2Z1J0LTEtFXZ3TrXC767Z=6DSOCpicVHPO3yFh98_Q@mail.gmail.com>
 <20190731070153.tp5c5naflbv3nmdw@jholzmayr.localdomain>
 <CAEmXcAx1ehvtUSR9fMPfV21ts3kcGPHnHYOfAZf82hJwb=wCQA@mail.gmail.com>
 <20190731082237.ccmhpfgda4fdd3nr@jholzmayr.localdomain>
 <CAEmXcAwdDAY+a+c1B8X1UZK+FRhyGt+0GcN6erp_XFfh4caNKQ@mail.gmail.com>
In-Reply-To: <CAEmXcAwdDAY+a+c1B8X1UZK+FRhyGt+0GcN6erp_XFfh4caNKQ@mail.gmail.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Thu, 1 Aug 2019 09:24:22 +0200
Message-ID: <CAEmXcAw3LO1Dma5M9TheJu4z-bTiisaPUWCPmD-HUegUkB3QZA@mail.gmail.com>
Subject: Re: Fwd: Building Xenomai 3 , Kernel 4 ... for BeagleBone Black
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, xenomai@xenomai.org

Here are the warning and error outputs of my built: Do you have any ideas I
can change this? I appreciate any suggestions.

Initialising tasks: 100% |#######################################| Time:
0:00:17

NOTE: Executing SetScene Tasks

NOTE: Executing RunQueue Tasks

WARNING: bzip2-1.0.6-r5 do_fetch: Checksum mismatch for local file
/work/build/downloads/bzip2-1.0.6.tar.gz

Cleaning and trying again.

WARNING: bzip2-1.0.6-r5 do_fetch: Renaming
/work/build/downloads/bzip2-1.0.6.tar.gz to
/work/build/downloads/bzip2-1.0.6.tar.gz_bad-checksum_527819af097ee3014e4d4=
42315b6f283

WARNING: bzip2-1.0.6-r5 do_fetch: Checksum failure encountered with
download of http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz - will attempt
other sources if available

WARNING: libpcre-native-8.39-r0 do_fetch: Checksum mismatch for local file
/work/build/downloads/pcre-8.39.tar.bz2

Cleaning and trying again.

WARNING: libpcre-native-8.39-r0 do_fetch: Renaming
/work/build/downloads/pcre-8.39.tar.bz2 to
/work/build/downloads/pcre-8.39.tar.bz2_bad-checksum_dd1af1bf51a2626b957707=
4690512335

WARNING: libpcre-native-8.39-r0 do_fetch: Checksum failure encountered with
download of
http://downloads.sourceforge.net/projects/pcre/files/prce/8.39/pcre-8.39.ta=
r.bz2
- will attempt other sources if available

WARNING: popt-native-1.16-r3 do_fetch: Failed to fetch URL
http://rpm5.org/files/popt/popt-1.16.tar.gz, attempting MIRRORS if availabl=
e

WARNING: rpm-native-5.4.16-r0 do_fetch: Failed to fetch URL
http://www.rpm5.org/files/rpm/rpm-5.4/rpm-5.4.15-0.20140824.src.rpm;name=3D=
srpm;extract=3Drpm-5.4.15.tar.gz,
attempting MIRRORS if available

WARNING: shadow-native-4.2.1-r0 do_fetch: Failed to fetch URL
http://pkg-shadow.alioth.debian.org/releases/shadow-4.2.1.tar.xz,
attempting MIRRORS if available

WARNING: xcb-proto-1.12-r0 do_fetch: Failed to fetch URL
http://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.bz2, attempting MIRRORS
if available

WARNING: libpthread-stubs-0.3-r0 do_fetch: Failed to fetch URL
http://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2, attempting
MIRRORS if available

WARNING: tcl-native-8.6.6-r0 do_fetch: Failed to fetch URL
http://downloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz, attempting
MIRRORS if available

WARNING: coreutils-8.25-r0 do_fetch: Failed to fetch URL
http://distfiles.gentoo.org/distfiles/coreutils-8.25-man.tar.xz;name=3Dmanp=
ages,
attempting MIRRORS if available

Currently  1 running tasks (1362 of 2032)  66%
|####################           |

Currently  1 running tasks (1362 of 2032)  66%
|####################           |

ERROR: xenomai-test-image-1.0-r0 do_image_wic: Function failed:
do_image_wic (log file is located at
/work/build/tmp/work/beaglebone_xenomai-poky-linux-gnueabi/xenomai-test-ima=
ge/1.0-r0/temp/log.do_image_wic.30602)

ERROR: Logfile of failure stored in:
/work/build/tmp/work/beaglebone_xenomai-poky-linux-gnueabi/xenomai-test-ima=
ge/1.0-r0/temp/log.do_image_wic.30602

Log data follows:

| DEBUG: Executing python function set_image_size

| DEBUG: Python function set_image_size finished

| DEBUG: Executing shell function do_image_wic

| Checking basic build environment...

| Done.

|

| Build artifacts not found, exiting.

|   (Please check that the build artifacts for the machine

|    selected in local.conf actually exist and that they

|    are the correct artifacts for the image (.wks file)).

|

| The artifact that couldn't be found was kernel-dir:

|   /work/build/tmp/deploy/images/beaglebone-xenomai

| WARNING: exit code 1 from a shell command.

| ERROR: Function failed: do_image_wic (log file is located at
/work/build/tmp/work/beaglebone_xenomai-poky-linux-gnueabi/xenomai-test-ima=
ge/1.0-r0/temp/log.do_image_wic.30602)

ERROR: Task (/repo/meta-core/recipes-xenomai/images/xenomai-test-image.bb:d=
o_image_wic)
failed with exit code '1'

NOTE: Tasks Summary: Attempted 2029 tasks of which 7 didn't need to be
rerun and 1 failed.



Summary: 1 task failed:

  /repo/meta-core/recipes-xenomai/images/xenomai-test-image.bb:do_image_wic

Summary: There were 14 WARNING messages shown.

Summary: There was 1 ERROR message shown, returning a non-zero exit code.

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Exception ignored when trying to write to the signal wakeup fd:

BlockingIOError: [Errno 11] Resource temporarily unavailable

Am Mi., 31. Juli 2019 um 15:04 Uhr schrieb danwe <
daniel.wenninger92@gmail.com>:

> Thanks for your answer. I can built it so far but I get many warnings tha=
t
> it cannot fetch tar-files from rpm5.org as this site is no longer
> available.
> Do you have any suggestions?
> Thanks.
>
> Daniel
>
> Am Mi., 31. Juli 2019 um 10:22 Uhr schrieb Josef Holzmayr <
> holzmayr@rsi-elektrotechnik.de>:
>
>> On Wed, Jul 31, 2019 at 09:59:41AM +0200, danwe wrote:
>> > Thanks for the setup. Sorry for asking but as I am new to that topic I
>> > don't understand how to use that site u sent me. Do I have to download
>> > Xenomai 3 first and then copy/paste the files on your site? I don't
>> really
>> > understand the readme file.
>> > For example: In the readme file I see the following:
>> >
>> >
>> >
>> > After adding meta-core and a BSP layer (right now there's only
>> meta-beaglebone
>> > available, so probably that one!), build the xenomai-test-image.
>> >
>> >
>> > So now I ask myself. Where should I add meta-core and meta-beaglebone =
to
>> > and how can I build the xenomai-test-image then?
>> > I don't understand the dependencies.
>>
>> Its a completely generic OpenEmbedded build setup. If you're not used to
>> doing so, just go to readme item IV: Using kas. Then it essentially
>> boils down to the three commands given there verbatim, just needing
>> docker to be available as well as quite some HD space and CPU cycles.
>>
>> >
>> > Thanks.
>> >
>> > Daniel
>> >
>> > Am Mi., 31. Juli 2019 um 09:01 Uhr schrieb Josef Holzmayr <
>> > holzmayr@rsi-elektrotechnik.de>:
>> >
>> > > On Wed, Jul 31, 2019 at 08:50:18AM +0200, danwe via Xenomai wrote:
>> > > > Thanks for your response. Maybe it was a bit unclear from my side:
>> > > > I need to build the Kernel and Xenomai 3. So I do neither want to
>> build
>> > > the
>> > > > kernel and userland tools on top of an existing image nor building
>> > > anything
>> > > > on top. Or what do you mean by building on top? Is there anything
>> > > "deeper"
>> > > > than a Kernel?
>> > > > And again: Does building a Kernel with Xenomai 3 depends on the
>> paltform
>> > > I
>> > > > want to use it on? I need to use it on a BeagleBone Black. Do I
>> have to
>> > > > change anything for use it on BBB?
>> > > > Thanks.
>> > >
>> > > You could use the setup I employ for doing the CIP kernel tests. All
>> > > nicely prepared for Xenomai 3 and BBB, only thing you'd have to swap
>> out
>> > > is the kernel itself which is not too complicated.
>> > >
>> > > https://github.com/LetoThe2nd/meta-xenomai
>>
>> Greetz
>>
>> --
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>> Josef Holzmayr
>> Software Developer Embedded Systems
>>
>> Tel: +49 8444 9204-48
>> Fax: +49 8444 9204-50
>>
>> R-S-I Elektrotechnik GmbH & Co. KG
>> Woelkestrasse 11
>> D-85301 Schweitenkirchen
>> www.rsi-elektrotechnik.de
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>> Amtsgericht Ingolstadt =E2=80=93 GmbH: HRB 191328 =E2=80=93 KG: HRA 1703=
93
>> Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
>> Ust-IdNr: DE 128592548
>>
>> _____________________________________________________________
>> Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
>> Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
>> USt-IdNr.: DE 128592548
>>
>>
