Date: Wed, 21 Feb 2007 10:33:28 +0100 (CET)
From: Nicholas Mc Guire <der.herr@domain.hid>
Subject: Re: [Adeos-main] latency results for ppc and x86
In-Reply-To: <725115.56324.qm@domain.hid>
Message-ID: <Pine.LNX.4.60.0702211019590.2291@domain.hid>
References: <725115.56324.qm@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: adeos-main@gna.org, Wolfgang Grandegger <wg@domain.hid>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>
> Latencies are mainly due to cache refills on the P4. Have you already
> put load onto your system? If not, worst case latencies will be even longer.
>

one posibility we found in RTLinux/GPL to reduce latency is to free up
TLBs by flushing a few of the TLB hot spots, basically these flushpoints
are something like:

__asm__ __volatile__("invlpg %0": :"m" (*(char*)__builtin_return_address(0)));

put at places where we know we don't need thos lines any more (i.e. after 
switching tasks or the like). By inserting only a few such flushpoints in
hot code on the kernel side we found a clear reduction of the worst case
jitter and interrupt response times.

Aside from caches, BTB exhaustion in high load situations is also a 
problem that has not been addressed much in the realtime variants - with 
the P6 families having a botched BTB prediction unit, one can use some 
"strange" constructions to reduce branch penalties - i.e.:

   if(!condition){slow_path();}
   else{fast_path();}

if more predictalbe than

   if(codition){fast_path();}
   else{slow_path();}

as in the first case the branch prediction is static, thus the worst case
is that you are jumping over a few bytes of object code when the condition
is not met. in the second case the default if the BTB does not yet know
this branch is to guess not-taken and thus load the jump target of the 
slow patch with the overhead of TLB/Cache penalties.

Regarding the PPC numbers, the surprising thing for me is that the same
archs are doing MUCH better with old RTAI/RTLinux versions, i.e. 2.4.4
kernel on a 50MHz MPC860 shows a worst case of 57us - so I do question
what is going wrong here in the 2.6.X branches of hard-realtime Linux -
my suspicion is that there is too much work being done on fast-hot CPUs
and the low-end is being neglected - which is bad as the numbers you
post here for ADEOS are numbers reachable with mainstream preemptive
kernel by now as well (off course not on the low end systems though).

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF3BHqnU7rXZKfY2oRAoUIAJ9F+Y/uwanXyUPJlTJYyOQm2H0efgCeOcTM
Hh1/eLtu+SHeZpjlIVQMLgM=
=0PD6
-----END PGP SIGNATURE-----

