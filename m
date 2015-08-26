MIME-Version: 1.0
In-Reply-To: <55DDCFEE.5070400@xenomai.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DDCFEE.5070400@xenomai.org>
Date: Wed, 26 Aug 2015 09:30:42 -0700
Message-ID: <CAJqUr7ynkteBkrURB0+r0esOKAF-SfPYjKPpfvkSm3OVjO9K_g@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: xenomai@xenomai.org

dpkg -l gcc-aarch64-linux-gnu

gcc-aarch64-linux-gnu             4:4.9.1-1             amd64
  The GNU C compiler for arm64 architecture

On Wed, Aug 26, 2015 at 7:40 AM, Jorge Ramirez Ortiz <jro@xenomai.org>
wrote:

> On 08/24/2015 08:13 PM, Don Mahurin wrote:
> > The system is built with the following commands.
> > git clone https://gitlab.mperpetuo.com/it/build-scripts.git
> > mkdir -p build
> > cd build
> > ../build-scripts/build_linux_emulator-arm64.sh
> > or
> > ../build-scripts/build_linux_emulator-arm64.sh --314-rc6
> > or
> > ../build-scripts/build_linux_emulator-arm64.sh --314-rc7
>
>
> what compiler version are you using?
>
>
> --
> jro
>
