From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y5lEcKOfUK"
Content-Transfer-Encoding: 7bit
Message-ID: <17611.37633.881446.443324@domain.hid>
Date: Sat, 29 Jul 2006 18:55:29 +0200
Subject: Re: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
In-Reply-To: <17611.36969.814874.846387@domain.hid>
References: <44CB2884.80801@domain.hid>
	<17611.36969.814874.846387@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--y5lEcKOfUK
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > How about solving this in Kconfig ?
 > Index: scripts/Kconfig.frag
 > ===================================================================
 > --- scripts/Kconfig.frag	(revision 1388)
 > +++ scripts/Kconfig.frag	(working copy)
 > @@ -2,6 +2,7 @@
 >  menu "Real-time sub-system"
 >  
 >  config XENOMAI
 > +	depends on CONFIG_X86_TSC || !X86 || !CONFIG_INPUT_PCSPKR
 >  	bool "Xenomai"
 >  	default y
 >          select IPIPE

Sorry, I meant:

-- 


					    Gilles Chanteperdrix.

--y5lEcKOfUK
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-forbid-pcspkr-in-kconfig.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/Kconfig.frag
===================================================================
--- scripts/Kconfig.frag	(revision 1388)
+++ scripts/Kconfig.frag	(working copy)
@@ -2,6 +2,7 @@
 menu "Real-time sub-system"
 
 config XENOMAI
+	depends on X86_TSC || !X86 || !INPUT_PCSPKR
 	bool "Xenomai"
 	default y
         select IPIPE

--y5lEcKOfUK--

