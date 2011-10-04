MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
Date: Tue, 4 Oct 2011 09:40:56 +0200
Message-ID: <CAAXf6LXRVpaU6abddH5h9Kq4Z0fF5m5Ms3RpjiNVOOR8bLW9rQ@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] xenomai-forge: ELF symbol interposition problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

We're experiencing problems with ELF symbol interposition with xenomai forge.
The symbol mem_alloc, declared in include/copperplate/heapobj.h and
defined in lib/copperplate/heapobj-malloc.c, is also present in our
own executable. When linking our objects with the xenomai-forge
libraries, the symbols from our objects take precedence.

As a result, when heapobj_alloc() calls mem_alloc(), it calls the
mem_alloc from our application code, which of course is totally
incompatible.

There isn't really a good solution to this problem. I think it will be
necessary to make sure that all exported functions from the
xenomai-forge libraries have a unique name. The name 'mem_alloc' (and
many of the functions in lib/copperplate/heapobj-malloc.c) is too
common.

Another solution may be to mark certain symbols as hidden, provided
they do not need to be exported to applications. Some references to it
appear here:
http://www.airs.com/blog/archives/307

What is your view on this?

Thanks,
Thomas

