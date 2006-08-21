From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.47839.774296.547723@domain.hid>
Date: Mon, 21 Aug 2006 15:53:35 +0200
Subject: Re: [Xenomai-help] Oops on PPC405EP
In-Reply-To: <44E9B5A1.3010102@domain.hid>
References: <44E9B5A1.3010102@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

Dirk Eibach wrote:
 > NIP [c016892c] rthal_restore_fpu+0x10/0xe4
 > LR [c003d8cc] xnpod_switch_fpu+0x94/0x12c

Could you run "switchtest" ? If there is a FPU context switch error, you
should get an (hopefully more clear) error message.

-- 


					    Gilles Chanteperdrix.

