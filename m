Message-ID: <436A724F.8030505@domain.hid>
Date: Thu, 03 Nov 2005 21:25:51 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Dev branch 2.1
References: <4368A088.9070906@domain.hid> <43693662.3080601@domain.hid>
	<4369C3C1.2040302@domain.hid>
	<4369E251.8070802@domain.hid> <436A6493.9020107@domain.hid>
In-Reply-To: <436A6493.9020107@domain.hid>
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
> Wolfgang Grandegger wrote:
> [...]
> 
>> I have realized the same error building out of the source tree for 
>> PowerPC. The problem is, that the link is pointing to itself. Apart 
>> from that, the ksrc part works fine (at least I can boot the ipipe 
>> kernel).
> 
> 
> If I remove the sym-link and copy .svn/text-base/system.h.svn-base to
> src/include/asm-uvm/system.h it compliles:
> 
> muon:/usr/src/xenomai-2.1/src/include/asm-uvm# ll
> total 36
> -rw-r--r--  1 root root 12780 2005-11-03 01:03 Makefile
> -rw-r--r--  1 cap  cap     67 2005-11-02 21:36 Makefile.am
> -rw-r--r--  1 cap  cap  13046 2005-11-02 21:36 Makefile.in
> lrwxrwxrwx  1 root root    39 2005-11-03 01:03 system.h -> 
> ../../.././src/include/asm-uvm/system.h
> muon:/usr/src/xenomai-2.1/src/include/asm-uvm# rm system.h
> rm: remove symbolic link `system.h'? y
> muon:/usr/src/xenomai-2.1/src/include/asm-uvm# cp 
> .svn/text-base/system.h.svn-base system.h
> 
> OK, so far so good. The ipipe kernel boots, I've got a directory
> /usr/xenomai/ with all accustomed directories, but no modules...
> 
> Wolfgang, do you have the e.g. xeno_native.ko somewhere ?

The Xenomai nucleus is now intergrated into the Linux kernel and if you 
have selected static linking, no modules will be generated. Have a look 
to the Xenomai kernel options (using "make memnuconfig" and friends).

Wolfgang.

