Message-ID: <48F465DD.6020505@domain.hid>
Date: Tue, 14 Oct 2008 11:26:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid> <48F45847.3030704@domain.hid>
	<48F461A6.6010600@domain.hid> <48F4634B.3030002@domain.hid>
In-Reply-To: <48F4634B.3030002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> looking into the "xeno_in_primary_mode" thing I wondered how to make the
>>>> thread state quickly retrievable. Going via pthread_getspecific as we do
>>>> for xeno_get_current appears logical - but not optimal. Though
>>>> getspecific is optimized for speed, it remains a function call, a few
>>>> sanity checks, and only finally a TLS variable access. That could be
>>>> achieved in a much lighter way by using a __thread variable.
>>>>
>>>> But can we assume that all target we support also support the __thread
>>>> storage class? TLS is surely mandatory now: I assume pthread_getspecific
>>>> would become non-RT safe without it, right? Is there anything we
>>>> can/must check for during configure to verify __thread support?
>>> I really think that this optimization is not worth the trouble. Anyway,
>> As long as we cannot specify the amount of "trouble", it's hard to
>> decide. Me current feeling is that it should rather simplify the
>> implementation + save us quite a few ops in the fast path (even more
>> with upcoming thread-mode check).
> 
> The trouble is to make some reliable detections in the configure script,
> so that the user will know early that Xenomai can not work with its
> current toolchain. And to make this detection work with uclibc as well
> as with glibc, gcc 4 versus gcc 3, etc...

Will work out a test program for configure.

> 
> Besides, pthread_getspecific can be implemented pretty efficiently in
> user-space without __thread support: using a hash table would be enough.
>  So, if we rely on pthread_getspecific, we do not have to know if ptd
> are implemented with some hardware trick.

It will always remain orders of magnitude heavier than __thread
variables which are a) inlined and b) should only need two memory
accesses at worst. Moreover, it is clearly the future, while the
importance of pthread_getspecific will decrease over the time. The
__thread storage class is C99 standard (though its implementation
remains a separate topic).

> 
>>> I have one question: is an implementation guaranteed to support more
>>> than one __thread variable? Because from ARM implementation I would say
>>> that ARM has only one __thread variable.
>> That would be weird - there is no such limitation known to me. Anyway,
>> you could easily verify this with a simple test program I guess. /me
>> also wonders how the glibc/NPTL is maintaining certain per-thread
>> variables (and there are surely > 1) internally.
> 
> I would say the __thread variable is used to store an array, which is,
> according to what Philippe said yesterday, turned into a multilevel
> structure when creating more than 32 keys.
> 
> At the hardware level, I am pretty sure ARM has only one per thread
> token. However I do not know how it is used to implement __thread
> variable (or variables).

Will look into some ELF definitions on this, but that there is a single
hw token (CPU register) for accessing the TLS root is surely not
uncommon. The rest is linker magic, specifically when it comes to
dealing with offsets of cross-lib TLS variables.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

