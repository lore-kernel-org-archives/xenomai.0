From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17592.56279.247461.702595@domain.hid>
Date: Sat, 15 Jul 2006 14:13:11 +0200
Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
In-Reply-To: <44B8D412.1080002@domain.hid>
References: <44B62AE7.8080503@domain.hid> <1152930271.5027.69.camel@domain.hid>
	<44B8A1E9.7080004@domain.hid> <44B8D412.1080002@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Index: xenomai/include/asm-blackfin/syscall.h
 > ===================================================================
 > --- xenomai.orig/include/asm-blackfin/syscall.h
 > +++ xenomai/include/asm-blackfin/syscall.h
 > @@ -26,7 +26,8 @@
 >     marker. Note: watch out for the p0 sign convention used by Linux
 >     (i.e. negative syscall number in orig_p0 meaning "non-syscall
 >     entry"). */
 > -#define __xn_mux_code(id,op)   ((id << 24)|((op << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
 > +#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mux & 0xffff))

Should not this be (op << 16) ?

 > +#define __xn_mux_shifted_id(id) (id << 24)


-- 


					    Gilles Chanteperdrix.

