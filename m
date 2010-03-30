From: Robert Berger <gmane@domain.hid>
Date: Tue, 30 Mar 2010 07:45:53 +0300
Message-ID: <horvm4$cil$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] find bits and pieces for Denx PPC/ipipe/xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

It looks like something changed in the way to find all the bits and
pieces to patch/build the Denx PPC/ipipe/xenomai combo.

Looking here:
http://git.xenomai.org/?p=xenomai-head.git;a=blob;f=ksrc/arch/powerpc/patches/README;h=010a86ecabce19212a8eaa1e0aaf8dc43b4805f3;hb=master

I read:

>>>

from Linux v2.6.22 to v2.6.32
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>From git://www.denx.de/git/linux-2.6-denx.git

Patch release			Commit #
----------------------------	----------------------------------------
2.6.22-DENX-*/powerpc		3e833ffb06a4ce14f2680a0afe9abd5342188e17
...
2.6.32.3-DENX-*/powerpc		224f363857f05ab44dab3441112965f0a7966788

		from Linux v2.6.20 to v2.6.21
		from Linux v2.6.33 onward
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>From ftp://ftp.free.fr/mirrors/ftp.kernel.org/linux/kernel/v2.6/

	All patches are based on mainline kernel releases.

<<<

Does this mean, that the patches are not anymore against the DENX git
repository, but against mainline?

What I would do up to now is to find in the denx git repository the
corresponding commit or similar;)

There seems to be an 2.6.33 ipipe patch:

http://git.xenomai.org/?p=xenomai-head.git;a=blob;f=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.33-powerpc-2.9-00.patch;h=7b84ba91606e7873227ef70d99aa077362248f4a;hb=master

So I would apply this on:
http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/DENX-v2.6.33-stable

Or should I use
http://git.denx.de/?p=ipipe-2.6.git;a=summary

Or something completely different?

With

http://git.xenomai.org/?p=xenomai-head.git;a=summary

I'm confused what's the recommended way to get the latest and greatest
ipipe/kernel/xenomai combination based on a DENX ppc kernel tree.

Please advise.

Regards,

Robert

-- 
Robert Berger
Embedded Software Specialist

Reliable Embedded Systems
Consulting Training Engineering
Tel.: (+30) 697 593 3428
Fax.:(+30) 210 684 7881
email: robert.berger@domain.hid
URL: http://www.reliableembeddedsystems.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
..."Pointers are like jumps, leading wildly from one part of the data
structure to another. Their introduction into high-level languages has
been a step backwards from which we may never recover." - C. A. R.
Hoare, "Hints on Programming Language Design", 1973

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



