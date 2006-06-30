From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Fri, 30 Jun 2006 16:54:45 -0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301654.45844.lbocseg@domain.hid>
Subject: [Xenomai-core] 2.6.17 hang on "will halt now" (possibly SMI related)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

I began to experience a problem since 2.6.17 when shutting down my PC.

I noticed the problem just after I recompiled my kernel to enable the SMI 
workaround. I, then rebooted the new kernel and when I tried to shutdown  the 
system, it stopped on "will halt now" message or something like.

The same behavior is occurring both in home (Pentium-3 550 MHz) and  at 
college (P4-1.7GHz). In both systems, Xenomai advised me to enable SMI 
workaround. Actually, at home, the worst latency with the latency test was 
about 20us independently from enabling or not the SMI workaround.

Do someone else experienced a similar problem when upgrading to 2.6.17?

I'm currently using 2.6.17.2 and SVN version of Xenomai.

Thanks in advance,

Rodrigo.

P.S: All remaining system is working fine as much as I could note.

		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



