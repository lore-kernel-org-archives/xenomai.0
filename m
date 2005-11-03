Message-ID: <4369C3C1.2040302@domain.hid>
Date: Thu, 03 Nov 2005 09:01:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Dev branch 2.1
References: <4368A088.9070906@domain.hid> <43693662.3080601@domain.hid>
In-Reply-To: <43693662.3080601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer wrote:
> Ciao Philippe!
> 
> prepare-kernel.sh works well - I'd suggest to ask the user for
> the 3 needed parameters, instead of supplying them as parameters.
> e.g.
> # scripts/prepare-kernel.sh
> Linux directory: [default: /usr/src/linux] :
> Adeos-patch: [default: none] :
> Architecture: [default: i386]
> 
> ...or something like that.
>

Yep, good idea.

> ./configure also went well, but then:
> 
> # make
> Making all in src
> make[1]: Entering directory `/usr/src/xenomai-2.1/src'
> Making all in include
> make[2]: Entering directory `/usr/src/xenomai-2.1/src/include'
> make  all-recursive
> make[3]: Entering directory `/usr/src/xenomai-2.1/src/include'
> Making all in asm-uvm
> make[4]: Entering directory `/usr/src/xenomai-2.1/src/include/asm-uvm'
> make[4]: stat:system.h: Too many levels of symbolic links
> make[4]: *** No rule to make target `system.h', needed by `all-am'.  Stop.
> make[4]: Leaving directory `/usr/src/xenomai-2.1/src/include/asm-uvm'
> make[3]: *** [all-recursive] Error 1
> make[3]: Leaving directory `/usr/src/xenomai-2.1/src/include'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/usr/src/xenomai-2.1/src/include'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/xenomai-2.1/src'
> make: *** [all-recursive] Error 1
> 
> 
> /usr/src/xenomai-2.1/src/include/asm-uvm# ll
> total 36
> -rw-r--r--  1 root root 12780 2005-11-03 01:03 Makefile
> -rw-r--r--  1 cap  cap     67 2005-11-02 21:36 Makefile.am
> -rw-r--r--  1 cap  cap  13046 2005-11-02 21:36 Makefile.in
> lrwxrwxrwx  1 root root    39 2005-11-03 01:03 system.h -> 
> ../../.././src/include/asm-uvm/system.h
>

Try building out of the source tree; it's something I'm likely going to enforce 
anyway.

> Best regards,
> Hannes.
> 


-- 

Philippe.

