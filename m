From: Sebastian Smolorz <smolorz@domain.hid>
Date: Mon, 22 Jun 2009 14:35:01 +0200
References: <200906221245.04890.smolorz@domain.hid>
	<4A3F73B6.1060202@domain.hid>
In-Reply-To: <4A3F73B6.1060202@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2p3PKUJnq7NLL6Q"
Message-Id: <200906221435.02109.smolorz@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--Boundary-00=_2p3PKUJnq7NLL6Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Hi Philippe,
> >
> > with latest head it is not possible to build the POSIX skin as module.
> > It gives:
> >
> > ERROR: "xnarch_divrem_billion"
> > [kernel/xenomai/skins/posix/xeno_posix.ko] undefined!
> >
> > Obviously an
> >
> > EXPORT_SYMBOL(xnarch_divrem_billion);
> >
> > is missing.
>
> Well, no. The definition of xnarh_divrem_billion is in the timeconv.h
> header, which should be included in places where this function is
> needed. So, what is missing is probably a #include.

Hm, I don't think so. The error only appears when building the POSIX skin as 
module. The attached patch fixes the problem.

-- 
Sebastian


--Boundary-00=_2p3PKUJnq7NLL6Q
Content-Type: text/x-patch;
  charset="UTF-8";
  name="timeconv.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="timeconv.h.patch"

diff --git a/include/asm-generic/bits/timeconv.h b/include/asm-generic/bits/timeconv.h
index 7d823f7..79060b3 100644
--- a/include/asm-generic/bits/timeconv.h
+++ b/include/asm-generic/bits/timeconv.h
@@ -93,6 +93,7 @@ static inline void xnarch_init_timeconv(unsigned long long freq)
 #ifdef __KERNEL__
 EXPORT_SYMBOL(xnarch_tsc_to_ns);
 EXPORT_SYMBOL(xnarch_ns_to_tsc);
+EXPORT_SYMBOL(xnarch_divrem_billion);
 #endif /* __KERNEL__ */
 
 #endif /* !_XENO_ASM_GENERIC_BITS_TIMECONV_H */

--Boundary-00=_2p3PKUJnq7NLL6Q--

