Message-ID: <4E440FC2.4070807@domain.hid>
Date: Thu, 11 Aug 2011 19:22:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>
	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>
	<4E43EBC6.10808@domain.hid>
In-Reply-To: <4E43EBC6.10808@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 08/11/2011 04:48 PM, Daniele Nicolodi wrote:
> On 11/08/11 13:43, Daniele Nicolodi wrote:
>> I submitted the debian bug, beside what is the cause of the problem,
>> binaries compiled with gcc-4.6 are not usable, but binaries compiled
>> with gcc-4.4 are. I'm compiling xenomai-head right now (this requires
>> compiling both user space and kernel space, so testing requires some
>> more time). I'll let you know ASAP.
> 
> Hello,
> 
> I compiled linux 2.6.38.8 and xenomai-head with gcc-4.6. The obtained
> kernel boots fine but xenomai services do not: latency hangs right after
> the sched_setscheduler system call. With the same kernel I compiled user
> space with gcc-4.4 and xenomia services work just fine.

Please try and find the point in the latency test where the hang happens
(it probably happens when calling a xenomai service, so, not
sched_setscheduler), and then post the two disassemblies of this service
implementation in libnative.so, the one compiled with 4.4, the other
with 4.6.

> 
> Cheers,


-- 
                                                                Gilles.

