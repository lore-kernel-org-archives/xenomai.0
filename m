Message-ID: <4B30B3A9.4000905@domain.hid>
Date: Tue, 22 Dec 2009 12:55:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid> <4B30AF29.4050303@domain.hid>
	<4B30B154.2010203@domain.hid>
In-Reply-To: <4B30B154.2010203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> * rtcan: on blackfin we seem to have a conflict with rtcan.
>>> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
>>> define this in core headers which are included everywhere. This said,
>>> not prefixing a Xenomai symbol with something like XN seems to be asking
>>> for trouble. Wolfgang, do you think it would be possible to rename the
>>> symbols with such prefix? Or do you share some code with socket-can that
>>> you do not want to touch?
>> CAN_ERR_MASK is part of the Socket-CAN interface (include/linux/can.h),
>> it must not be called differently. Blackfin is obviously doing namespace
>> pollution which should be fixed upstream and meanwhile worked around in
>> Xenomai (e.g. via #undef CAN_ERR_MASK).
> 
> Ok. But according to the build logs, it is redefined in rtdm/rtcan.h.
> The error seems to have been fixed upstream, since we get this warning
> with 2.6.30 and not with 2.6.31.

Right, the error comes from:

http://lxr.linux.no/#linux+v2.6.32/arch/blackfin/mach-bf537/include/mach/bf537.h#L20

and is in conflict with "include/linux/can/can.h" anyhow.

Wolfgang.



