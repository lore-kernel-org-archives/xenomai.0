Message-ID: <47740B5A.7070601@domain.hid>
Date: Thu, 27 Dec 2007 21:30:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>	<2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>	<8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>	<18291.60209.715762.159719@domain.hid>	<8b3b30860712271028p12db5801mb156e6d58a01008f@domain.hid>
	<8b3b30860712271035s24933c63wf981b32dcf5b4a7b@domain.hid>
In-Reply-To: <8b3b30860712271035s24933c63wf981b32dcf5b4a7b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai@xenomai.org

Racconico Lambrati wrote:
> 
> How can I run it in kernel space?
> The application is designed to be little and stable, and with fusion
> 0.9.1 run without problem
>

If your application based on 0.9.1 used to run in user-space, then it
must have been based on the UVM support. This support has been dismissed
since Xenomai v2.3-rc1, because it was a temporary hack allowing
user-space development until all skins have a real user-space interface,
which is now the case.

The services you mention are now only available from the kernel-based
interface, provided by the xeno_vxworks.ko module, because they do not
make sense from a userland perspective.

Userland applications based on the VxWorks API
(/usr/xenomai/lib/libvxworks.so) should not need them at all. If for
some reason they do, then you should consider splitting the application
in two parts, one kernel-based, the other one running in userland. The
point is that dealing with interrupts should most often remain a kernel
business, and this obviously also applies to interposing on the tick timer.

If your application was not based on the UVM, then it must have been
running embodied into a kernel module, in which case the issue is
already solved.

Rehashing what Gilles already told you: until you actually explain _why_
you need such services, nobody will be able to suggest any solution to
your problem, I'm afraid.

-- 
Philippe.

