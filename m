Message-ID: <48BBF299.7060205@domain.hid>
Date: Mon, 01 Sep 2008 15:48:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAB67.90707@domain.hid>
	<48BBD8E4.6010702@domain.hid>
In-Reply-To: <48BBD8E4.6010702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/9] Switch to handle-based fast mutex
 owners
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
>> To improve robustness of the fast mutex implementation in POSIX (and
>> later on in native), it is better to track the mutex owner by handle
>> instead of kernel object pointer. Therefore, this patch changes
>> __xn_sys_current (xeno_set_current) so that it returns
>> xnthread_handle(current_thread). It furthermore converts the POSIX mutex
>> implementation to pick up and store the lock owner as handle in the
>> kernel/user-shared mutex. Finally it ensures that all skins (except for
>> RTDM which must not mess around with foreign skins anyway) add their
>> threads to the registry so that at least anonymous handles are
>> available.
>>
>> As the value stored in the mutex variable is now an integer, we can
>> switch over to xnarch_atomic_t, removing all atomic_intptr users.
> 
> The current implementation allows RTDM threads to use POSIX skin
> mutexes. I do not see why this should change.

Such mixup might technically be possible now. But there is neither a
need nor does it make the resulting driver more portable. I don't want
to introduce needless thread registration to RTDM just to cover
theoretical use cases that should not exist in the first place.

Nevertheless, some sanity check will have to be added to the
to-be-written generic xnsynch support to catch missing thread handles.
That make sense for checking future skin implementation as well.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

