Message-ID: <2ff1a98a0805130533g4133aa4fu90cd310ce807f63@domain.hid>
Date: Tue, 13 May 2008 14:33:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4829718A.6070900@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48295098.10204@domain.hid>
	<2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>
	<48295AF4.2090402@domain.hid>
	<2ff1a98a0805130216n242eddbek3f24810fc7bdd7c4@domain.hid>
	<48295F82.40404@domain.hid> <4829602A.6050603@domain.hid>
	<2ff1a98a0805130238j391b3c5dge5f79f8275b42c46@domain.hid>
	<4829718A.6070900@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Flush xnfree backlog after thread
	deletion in root context
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

On Tue, May 13, 2008 at 12:46 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
>  > No, it is supposed to work. The sched->zombie points to this zombie,
>  > which is finalized in xnpod_finish_unlocked_switch
>
>  OK. However, I would still prefer to get xnfreesync out of the critical
>  paths. Is there anything which speaks against my VIRQ idea (except that
>  it still has to be written :) )?

Ok. Even though I am not sure how it works now, getting thread
deletion to work with XNARCH_WANT_UNLOCKED_CTXSW was by far the
hardest part of the work. I am not sure you can have the same control
over what happens with a VIRQ.

-- 
 Gilles

