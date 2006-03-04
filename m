Message-ID: <440A2403.6090700@domain.hid>
Date: Sun, 05 Mar 2006 00:34:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4409B56B.4000501@domain.hid> <4409E28D.90800@domain.hid>
In-Reply-To: <4409E28D.90800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Xenomai v2.1-rc4
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Hannes Mayer wrote:
> Philippe Gerum wrote:
> 
>>
>> This time, the merge window is closed for good; no kidding. This said, 
>> too many changes since -rc3 have taken place for releasing v2.1 
>> without one more -rc iteration, so here is -rc4. Major updates are as 
>> follows:
>>
>> - scalable timer management using non-linear access (Gilles)
>> - shared real-time interrupt support (Dmitry)
>> - POSIX updates (Gilles)
>> - UVM fixes (me)
>> - registry support abstraction (me)
>> - RTDM updates (Jan)
>> - building blocks for Debian packaging (Romain Lenglet)
>>
>> http://download.gna.org/xenomai/testing/xenomai-2.1-rc4.tar.bz2
> 
> 
> Ciao Philippe!
> 
> During prepare-kernel.sh I noticed that
> 
> Adeos/i386 1.XXXX (newgen) installed.
> Links installed.
> Build system ready.
> 
> is not printed anymore. Bug or feature ?
> 

Feature. --verbose brings this message back, IIRC. I guess that's needed for 
automated Debian packaging stuff Romain is working on.

-- 

Philippe.

