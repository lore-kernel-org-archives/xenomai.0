References: <CAESnvfOhCNj85NoKkJ2-3wNJPLqdUJTGxCaypG=WPZML=S5EHg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: evl core build on x86 machine
In-reply-to: <CAESnvfOhCNj85NoKkJ2-3wNJPLqdUJTGxCaypG=WPZML=S5EHg@mail.gmail.com>
Date: Wed, 31 Mar 2021 11:47:36 +0200
Message-ID: <87tuorr6x3.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashwik John <johnashwik994@gmail.com>
Cc: xenomai@xenomai.org, evl@evlproject.org


Ashwik John via Evl <evl@evlproject.org> writes:

> Hi All,
>
> I am trying to build evl core on x86 pc but it is not successful.
>
> x86 pc works with Ubuntu 18.04.
>
> evl project branch used is *evl/v5.10 : *git clone --depth 1 --branch
> evl/v5.10 git://git.evlproject.org/linux-evl.git
>
> for libevl, master branch was used: git clone --depth 1 --branch master
> git://git.evlproject.org/libevl.git
>
> when installing the modules with modules_install. Just the following
> modules are installed.
>   INSTALL drivers/thermal/intel/x86_pkg_temp_thermal.ko
>   INSTALL fs/efivarfs/efivarfs.ko
>   INSTALL net/ipv4/netfilter/iptable_nat.ko
>   INSTALL net/ipv4/netfilter/nf_log_arp.ko
>   INSTALL net/ipv4/netfilter/nf_log_ipv4.ko
>   INSTALL net/ipv6/netfilter/nf_log_ipv6.ko
>   INSTALL net/netfilter/nf_log_common.ko
>   INSTALL net/netfilter/xt_LOG.ko
>   INSTALL net/netfilter/xt_MASQUERADE.ko
>   INSTALL net/netfilter/xt_addrtype.ko
>   INSTALL net/netfilter/xt_mark.ko
>   INSTALL net/netfilter/xt_nat.ko
>   DEPMOD  5.10.25evl+
>
> When trying to boot with the evl kernel the boot fails since there are no
> modules.
>
> It will be of great help with your solutions to solve this issue.

According to your description, this is not an EVL-specific issue, but a
generic kernel build/install problem. You may want to refer to any of
the many tutorials available on the net for this.

-- 
Philippe.

