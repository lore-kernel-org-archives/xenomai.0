Message-ID: <55DCB521.20204@xenomai.org>
Date: Tue, 25 Aug 2015 14:34:09 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org>
 <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
In-Reply-To: <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/25/2015 02:05 PM, Don Mahurin wrote:
>>> > >
>>> > > The system is built with the following commands.
>>> > > git clone https://gitlab.mperpetuo.com/it/build-scripts.git
>>> > > mkdir -p build
>>> > > cd build
>>> > > ../build-scripts/build_linux_emulator-arm64.sh
>>> > >
>> >
>> > This went almost fine except the rsync step which assumes a native arm64
>> > host for populating the rootfs, I have no such beast. But that's not a
>> > major issue, I can take another path for building it.
> 
> Yes, to build the system, we copy the arm64 shared libraries from the host
> system (used by cross compiler).  Using Ubuntu 14.10. May need some
> adjustment for other Linux host systems.
> 
> 

if you need some aarch64 libraries, you can use a one of the rootfs below to
pull them

https://builds.96boards.org/releases/hikey/linaro/debian/15.06/

Download one of the images (hikey-jessie_alip_20150701-323.emmc.img.gz for instance)

$ simg2img hikey-jessie_alip_20150701-323.emmc.img raw.img
$ sudo mount raw.img <mnt_point>



-- 
jro

