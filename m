Message-ID: <4CAE0D90.1070208@domain.hid>
Date: Thu, 07 Oct 2010 20:12:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid> <4CAB24D9.5000308@domain.hid>	
	<4CAB2994.40505@domain.hid> <4CAB2B37.7010104@domain.hid>	
	<4CAB2C4B.6090005@domain.hid> <4CAB2D1C.70907@domain.hid>	
	<4CAB305B.60406@domain.hid> <4CAB3450.5090105@domain.hid>	
	<4CAC3F55.4050007@domain.hid>
	<1286471281.13186.79.camel@domain.hid>
	<4CAE04B1.9070503@domain.hid>
In-Reply-To: <4CAE04B1.9070503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Overcoming the "foreign" stack
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
>> I'm on a wait and see stance about generalizing the use of the ftrace
>> framework for our needs; like Gilles saw with ARM, I must admit that I
>> did notice a massive overhead on low-end ppc as well when we moved the
>> pipeline tracer over it. I'm aware of the mcount optimizations that
>> should be there when cycles really matter, and that ftrace does branch
>> directly to the trace function when only a single one exists, but this
>> may not be easy to keep after the generalization has taken place.
>> Anyway, I'll wait for more data to make my opinion.
> 
> As I said, ftrace is more the a simple mcount-tracer. And it's standard,
> distros start to enable it in their production kernels these days
> (except for the function tracer).
> 
> If the overhead of the ftrace's mcount is too high on low-end platforms
> (I personally haven't tried it there yet), it would probably be a good
> idea to develop some optimizations or allow some variant that does not
> suffer that much - but upstream then.

I can talk about ARM on that subject: the "fix" is to use dynamic ftrace
(I did not get it working, so I am not sure it still has not one too
many indirection layers, but it looks like it does not). But the patches
to get dynamic ftrace working on ARM, though known since march, have not
been merged yet, so will not be here in the upcoming 2.6.36. I suspect
other architectures such as blackfin also lag behind x86. So, in the
mean-time, if we want to get the I-pipe tracer working with a reasonable
overhead, we have to make our own version, and from that perspective,
the version where mcount calls directly the ipipe tracer, is much
simpler than importing the whole dynamic ftrace stuff. So, I vote for
keeping some #ifdefs or Kconfig stuff in the ipipe tracer code to be
able to use a standalone tracer, as it will also simplify getting it to
work with architectures which lag even more behind x86 than ARM or
Blackfin. Say for instance, microblaze, nios, or sparc.

-- 
					    Gilles.

