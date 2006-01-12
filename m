MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17350.20759.34780.813349@domain.hid>
Date: Thu, 12 Jan 2006 13:52:39 +0100
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
In-Reply-To: <43C58820.5010006@domain.hid>
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid>
	<1136754149.17443.21.camel@domain.hid>
	<43C18CE1.5040509@domain.hid> <43C1CFC2.8040104@domain.hid>
	<43C21BA7.4050806@domain.hid> <43C220FE.4010100@domain.hid>
	<17346.57955.432284.905332@domain.hid>
	<43C37926.5060007@domain.hid>
	<17349.33404.156585.857948@domain.hid>
	<43C58820.5010006@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > But it does not seem to be due to the bug I was suspecting in context
 > > switch code.
 > > 
 > 
 > What about the PPC world? I saw some SVN commits claiming to fix this
 > (also for blackfin) - but there was no "Hey, it's fixed now!" on the
 > mailing list.

Actually, the bug I suspected was the real cause of trouble on
ia64. But, if you look at Philippe's commit, you will see that there
were a couple of other bugs (probably all my work) on this architecture,
hence my previous, wrong, claim.

-- 


					    Gilles Chanteperdrix.

