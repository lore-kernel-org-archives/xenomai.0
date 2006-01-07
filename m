Message-ID: <43BFA7C7.1090501@domain.hid>
Date: Sat, 07 Jan 2006 12:36:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] heres a go
	at	an	adeos-ipipe-2.6.15-i386-1.1-01.patch
References: <20060106163226.X16178@domain.hid> <43BF7337.7020506@domain.hid>
In-Reply-To: <43BF7337.7020506@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> Kent Borg wrote:
> 
>> Jim Cromie posted a patch attempt for 2.6.15 (yeah!), and the patch
>> applied, but it doesn't compile for me:
>>
>>  [...]
>>    LD      init/built-in.o
>>    LD      .tmp_vmlinux1
>>  arch/i386/kernel/built-in.o: In function `__ipipe_sync_stage':
>>  : undefined reference to `ret_from_intr'
>>  arch/i386/kernel/built-in.o: In function `__ipipe_sync_stage':
>>  : undefined reference to `ret_from_intr'
>>  make: *** [.tmp_vmlinux1] Error 1
>>  ~/linux-2.6.15$
>> For a .config I started with the stock Ubuntu 2.6.12-10-686 config
>> file and then took the defaults for all the oldconfig questions.
>>
>> Suggestions?
>>
>>  
>>
> You get to keep both pieces ? ;-)
> 
> 
> FWIW, the kernel was still running on my soekris 4801 til just now. (I 
> rebooted)
> Most of that time it was without its NFS root fs;
> my laptop was unconnected.  It was doing *no* work of any kind tho.
> Not that this helps...
> 
> 
> Im trying a kernel build on my sony laptop pentium M.
> differnt config than yours, but fuller than the soekris.
> Its running now, Im typing on it.
> wifi card works too !
> 
> Ive attached my working config - might get you going.
> pls report back what made your config not work, once you find it.
> 
> ::::::::::::::
> ipipe/Linux
> ::::::::::::::
> Priority=100, Id=0x00000000
> irq0-15: accepted
> irq32: grabbed, virtual
> ::::::::::::::
> ipipe/version
> ::::::::::::::
> 1.1-01
> 
> 
> 
> 
> FWIW, I diffed the 14 patch against mine, was puzzled at the large 
> textual diffs.
> Guessed that it was a file ordering diff in the tar, and then forgot to 
> mention this
> at send.  This seems kinda odd, since Im running linux.
> 
> Phillipe, are you running BSD  ?  </ducks>
> 

Well, sometimes this idea surfaces in the back of my head when I'm 
waiting for large disk I/O to complete over 2.6. And when it finally 
does, this operation leaves me as breathless as my hard drive...

> Are you creating patches from an fs other than ext3 ?
> That could explain the ordering.  If not, Im stumped.
> Maybe its an svn thing, they have a berkley-db-as-fs dont they ?
> 

Yes they do, but this is unrelated to the apparently funky internal 
layout of my patches. It's just that I now have all Adeos ports over 2.6 
in a single Linux tree (but the blackfin one which is uClinux-based), 
and each and every arch-specific patch is just extracted by an automated 
script from the original multi-arch patch. The way each individual 
per-arch patch is (re-)composed does not depend on the fs then.

> hth,
> jimc
> 
> 
> 
> Also, FWIW, Ive been reading LKML, and it appears that
> Ingo Molnar's  Mutex patches have turned the corner with Linux.
> Theyre not in, and Ive got no crystal ball, but I suspect they
> will get into 17 or 16
> 

The real meat we are waiting for is the priority inheritance mechanism 
so that the ownership property of mutexes is leveraged to do something 
sensible against the inversion priorities that plague the vanilla 
kernel, and this particular piece is going to be harder to push forward 
(kind of "asbestos underware everyone!"). This said, Ingo Molnar said 
that he would progressively distill the PREEMPT_RT infrastructure into 
the mainline kernel, and so far, he succeeded quite well doing so. 
Remarkable chess player ;o)
However, I must admit that from the Adeos maintenance POV, those changes 
all over the map that took place since 2.6.11 or so are making the job 
quite more complex.

> a good writeup for the regular folks (like me) on this list is here:
> http://lwn.net/Articles/164380/
> 

Nice piece, indeed.

> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

