Message-ID: <4CAB0519.1000004@domain.hid>
Date: Tue, 05 Oct 2010 12:59:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid>
In-Reply-To: <4CAAF0CA.7060603@domain.hid>
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
> My key question is currently if and how much of this could be realized
> in 2.6. Could we drop in-kernel skins in that version? If not, what
> about disabling them by default, converting RTDM tasks to a
> kthread-based approach, and enabling tracing etc. only in that case?
> However, this might be a bit fragile unless we can establish
> compile-time or run-time requirements negotiation between Adeos and its
> users (Xenomai) about the stack model.

Just to clarify about 2.6. 2.6 is supposed to have a short-lived
"unstable" state, where we implement fixes for the few problems on the
2.5 branch which require breaking the ABI. So, removing kernel-space
threads for other skins than RTDM is not the plan. However, does it
really matter whether other skins than RTDM use kernel-space threads for
changing the way kernel-space threads stacks are allocated?

-- 
					    Gilles.

