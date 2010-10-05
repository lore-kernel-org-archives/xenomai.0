Message-ID: <4CAB06C6.1090303@domain.hid>
Date: Tue, 05 Oct 2010 13:06:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid> <4CAB0519.1000004@domain.hid>
In-Reply-To: <4CAB0519.1000004@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Am 05.10.2010 12:59, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> My key question is currently if and how much of this could be realized
>> in 2.6. Could we drop in-kernel skins in that version? If not, what
>> about disabling them by default, converting RTDM tasks to a
>> kthread-based approach, and enabling tracing etc. only in that case?
>> However, this might be a bit fragile unless we can establish
>> compile-time or run-time requirements negotiation between Adeos and its
>> users (Xenomai) about the stack model.
> 
> Just to clarify about 2.6. 2.6 is supposed to have a short-lived
> "unstable" state, where we implement fixes for the few problems on the
> 2.5 branch which require breaking the ABI. So, removing kernel-space
> threads for other skins than RTDM is not the plan. However, does it
> really matter whether other skins than RTDM use kernel-space threads for
> changing the way kernel-space threads stacks are allocated?

Not if we break the API for all in-kernel skins (not only RTDM) by
freezing the stack size (that will be the side effect of moving over
kthreads). I've no problem to do this for RTDM, but in-kernel
applications may have different stack footprints than ordinary RTDM
drivers, thus could break subtly. Therefore the consideration to do a
hard cut then, forcing remaining users to port now (instead of fixing
once again and port later on).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

