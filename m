Message-ID: <4A3F85C8.3050808@domain.hid>
Date: Mon, 22 Jun 2009 15:23:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200906221245.04890.smolorz@domain.hid>	
	<4A3F73B6.1060202@domain.hid> <1245674235.4121.1.camel@domain.hid>	
	<4A3F7D57.2060704@domain.hid> <1245675698.4121.6.camel@domain.hid>
In-Reply-To: <1245675698.4121.6.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] [xenomai-head] xeno_posix.ko cannot be
	built
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Mon, 2009-06-22 at 14:47 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2009-06-22 at 14:06 +0200, Gilles Chanteperdrix wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Hi Philippe,
>>>>>
>>>>> with latest head it is not possible to build the POSIX skin as module. It 
>>>>> gives:
>>>>>
>>>>> ERROR: "xnarch_divrem_billion" [kernel/xenomai/skins/posix/xeno_posix.ko] 
>>>>> undefined!
>>>>>
>>>>> Obviously an
>>>>>
>>>>> EXPORT_SYMBOL(xnarch_divrem_billion);
>>>>>
>>>>> is missing.
>>>> Well, no. The definition of xnarh_divrem_billion is in the timeconv.h
>>>> header, which should be included in places where this function is
>>>> needed.
>>> Actually, this is no inline stuff anymore, so we do need an export just
>>> like tsc_to_ns and converse op.
>> Well, I still see its definition in timeconv.h, the only way I see to
>> get an undefined symbol would be to use the function without including
>> timeconv.h.
>>
>> And indeed, ksrc/skins/posix/internal.h, which uses
>> xnarch_divrem_billion does not include timeconv.h
>>
> 
> timeconv.h is not for direct inclusion, this is merely an instantiation
> file that works both for kernel space and userland. Callers should
> include asm/xenomai/system.h instead.

posix skin is also borken in user-space then, since it includes timeconv.h.

-- 
                                          Gilles


