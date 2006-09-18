Date: Mon, 18 Sep 2006 14:13:11 +0200
Message-Id: <J5SF9Z$7F2EF49769B98E8D95E7CDDC32F233C4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re:rare brokenness in latency output - FPU bug!
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "jan.kiszka" <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

---------- Debut du message initial -----------

De     : jan.kiszka@domain.hid
A      : "xenomai-core" xenomai@xenomai.org
Chanteperdrix" gilles.chanteperdrix@xenomai.org
Copies : 
Date   : Mon, 18 Sep 2006 11:30:45 +0200
Objet  : rare brokenness in latency output - FPU bug!

> Gilles, what info do you need? It's all the latest on x86 here:
> 2.6.17.13 (.config attached), ipipe-1.4, SVN #1646, gcc4.1.0.

It would be interesting if you could:
- try reverting the last FPU changes
- try to narrow down the issue by reducing the number of
threads created
by switchtest (for example, try keeping only the threads whose
switch
fails)
- try dumping the FPU context before the first fp_regs_set,
chances are that the FPU context is already clobbered before
the first fp_regs_set; 
when the FPU context is already clobbered, running fp_regs_set
set the
value of the already set registers to qnan, and fp_regs_check
returns
INT_MAX when the register is set to qnan. I will send tomorrow
the 
header I use for converting FPU contexts into human readable form.

-- 
                 Gilles Chanteperdrix=0A=0AAcc=E9dez au courrier =E9lectr=
onique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A


