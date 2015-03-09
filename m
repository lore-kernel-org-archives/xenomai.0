Message-ID: <54FD3DB7.7080301@jonasplatte.de>
Date: Mon, 09 Mar 2015 07:29:11 +0100
From: Jonas Platte <mail@jonasplatte.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtnet in Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

as the title suggests, I am trying to set up rtnet with Xenomai 3.0.

I already partly got rtnet to work with Xenomai 2.6 on a debian
machine with linux 3.4; I will try to get a linux 3.14.x or 3.16
kernel running there tomorrow [when I am at work again], because
cobalt requires at least 3.10 and the rtnet stuff wasn't installed
when I built Xenomai 3.0 for the 3.4 kernel with the mercury core so I
assumed for the moment that mercury core + rtnet isn't supported.

On my arch linux system at home I already tried the same thing though,
where installing a new kernel was simpler, but I wasn't successful.
Apparently, the rtnet tools (the programs rtnet, rtcfg, rtping and so
on) were installed but the kernel modules didn't even get built.

So I have two main questions:

* Is it true that rtnet is only available for the cobalt core?
  [I like to think that it isn't, and if I'm right about that
  I'd be happy to help fixing it. I have a fair amount of experience
  with the GNU build system / autotools.]
* How to build the rtnet kernel module and the rt_* ethernet drivers?
  I feel like I am missing a "make modules" (and "make modules_install")
  somewhere, but I only found automake-generated Makefiles that didn't
  have these targets and the Makefiles in kernel/, which look like they
  should be part of a recursive make call, but I didn't find that
  directory referenced anywhere but in EXTRA_DIST.

Also, a small thing that I might write dedicated email for if whoever
reads until here tells me that would be a good idea to make the right
people notice it:

I'm writing a C++11 (downwards compatibility currently not planned)
wrapper for the Xenomai / rtnet RTDM API. It will be released under
LGPL v3, unless xeno-- project is not as dead as it seems or someone
is willing to revive it (in which case I would love to integrate this
functionality there instead of making it a seperate library); or
someone gives me a good reason to release it under a different license.

Thanks to everyone who worked on porting rtnet to Xenomai 3.0 and
integrating it into the repository!

P.S.: The next email(s) from me will probably not come from this email
address, but from jonas.platte@iwes.fraunhofer.de. In case you want to
contact me directly, please use that address.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/T23AAoJEChniccSSv3r3akH/0IM+MxE5YKOk3SR1SWYVaD6
nwA+VsVGtOOGiP7QdvRaYiBnLw/7FcYX7mBO8/7ATe9Ke+0Z4evCu+EKv5guIQKy
jkAFZABNwO55lihPXhAgFRHK+KwfSMkKGSNAPbKsx8rwDDG2wkWdsamBCWOpmMQC
CM0Uq2ldchp66y58Wu5+Y9D37WsB8xopnX7AytrsKw/5lNcG3yvziRtRy5n3ox1d
If9fFUoIpfY+X5tAOkRk2fu9SZgvS/Yq6vRVgoy83cE3hoaQQsZAMvvZUH0mYu6z
DcPC0ZPafrYg5+ZyuNowM3kp7qpmGRnCaIHMSMP7zj74Z0oHh/MJSdxuEwToZvM=
=Y6kO
-----END PGP SIGNATURE-----

