Message-ID: <49F6F4DD.6000902@domain.hid>
Date: Tue, 28 Apr 2009 14:21:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49F69924.8070001@domain.hid> <1240913240.6990.347.camel@domain.hid>
In-Reply-To: <1240913240.6990.347.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai 2.5 rc1 timing computations.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Philippe Gerum wrote:
> On Tue, 2009-04-28 at 07:50 +0200, Gilles Chanteperdrix wrote:
>> Hi,
>>
>> currently, the situation is this:
>> - the timing core uses an approximate value of the cpu frequency (using
>> xnarch_llmulshft) to do conversions between tsc and ns;
>> - the APIC timer reprogrammation still uses imuldiv, that is a more
>> exact cpu frequency, coupled with an approximate APIC frequency
>> (obtained from ipipe_request_tickdev), to do the conversion between tsc
>> delays and APIC delays;
>> - the posix skin uses llimd to do conversions between timespec and
>> timeval structures and tsc values
>> - the posix and native skins in user-space still use llimd to do
>> conversions between ns and tsc (only if using tsc in user-space).
>>
>> These are causes of unprecisions, I think we should fix this, though it
>> is unlikely to be the cause of the high jitters observed by Vikesh with
>> 2.5-rc1.
>>
> 
> Ack, we definitely should. Working on allowing userland to use
> llmulshift for timing computations for the native skin here, as a first
> step. For that purpose, xnsysinfo_t has just been extended to carry the
> pre-scaled values needed for llmulshft. I just don't want to have to
> issue a syscall for those conversions to take place.

Actually, the pre-scaled values could be re-computed in user-space
without changing the ABI. BTW, I wonder why this computations starts
with a shift value of 31 and not 32. Using 32 when possible would
improve the precision.

-- 
                                                 Gilles.

