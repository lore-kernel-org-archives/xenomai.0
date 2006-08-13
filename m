From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17630.65180.628884.675717@domain.hid>
Date: Sun, 13 Aug 2006 12:27:40 +0200
Subject: Re: [Xenomai-core] [patches] 1-bundle-email-spelling-help
	2-rfc-add-newer-bench-tests
In-Reply-To: <44DCAE6B.4010608@domain.hid>
References: <44DBCCD3.5070505@domain.hid> <44DC2B80.1020403@domain.hid>
	<44DCAE6B.4010608@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > 1- bundle: email, Kconfig spelling, switchbench print in us, not ns.
 > issues :
 > - switchbench segfaults(iirc) for me - both before and after patch,
 > so its not tested - and printf format purposely not tweaked, so as
 > to give someone else the itch ;-)

Patch applied, thanks.

 > 
 > 
 > 2 -  add newer benchmark tests to xeno-test  RFC
 > - irqbench (all 4 ways)
 > - switchbench - segfaults
 > - switchtest
 > by the way, could we get renames ? 
 >     switch{,bench,test}/switch.c
 >     is just unnecessarily confusing !

The two switch.c are renamed, I have not applied this second patch,
since Jan seems to have an objection.

-- 


					    Gilles Chanteperdrix.

