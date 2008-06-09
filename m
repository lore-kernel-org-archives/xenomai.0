MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18509.34281.184033.126406@domain.hid>
Date: Mon, 9 Jun 2008 21:35:05 +0200
In-Reply-To: <484D2F1E.8060109@domain.hid>
References: <484C17E1.20808@domain.hid>
	<18508.6580.612681.20967@domain.hid>
	<484D2EA3.5040505@domain.hid> <484D2F1E.8060109@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Xenomai v2.4.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Roland Stigge wrote:
 > Roland Stigge wrote:
 > > By the way: lintian(1) detects several empty *.map files which weren't
 > > empty in 2.4.3.
 > 
 > i.e.
 > 
 > arm_2hal_8c__incl.map
 > blackfin_2hal_8c__incl.map
 > blackfin_2nmi_8c__incl.map
 > generic_2hal_8c__incl.map
 > generic_2nmi_8c__incl.map
 > hal__32_8c__incl.map
 > hal__64_8c__incl.map
 > hal-common_8c__incl.map
 > ia64_2hal_8c__incl.map
 > nmi__32_8c__incl.map
 > powerpc_2hal_8c__incl.map
 > rtdm_8h__incl.map
 > smi_8c__incl.map
 > 
 > in doc/generated/html/api/

It looks like these map files contain no href in the 2.4.3 release, so,
there is nothing "clickable" and I think we do not loose anything. I
wonder why Doxygen needs these empty files though.


-- 


					    Gilles.

