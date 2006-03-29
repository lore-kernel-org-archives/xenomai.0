MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17450.38539.674211.828082@domain.hid>
Date: Wed, 29 Mar 2006 16:15:39 +0200
Subject: Re: [Xenomai-core] errors to console when running xeno-test (latency
	-t	1)
In-Reply-To: <442958C2.3080800@domain.hid>
References: <44280C96.1030608@domain.hid>
	<17448.18916.701490.357146@domain.hid>
	<442958C2.3080800@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
 > Gilles Chanteperdrix wrote:
 > > Jim Cromie wrote:
 > >  > hello xenophiles,
 > >  > 
 > >  > Im getting errors to the console when running latency -t 1.
 > >  > they also appear in dmesg output
 > >
 > > This should be fixed in revision 807.
 > >
 > >   
 > 807 didnt fix it here.  Its also still present in 815

Reverting 807 produces a bug on my test box identical to the one you are
reporting. Merging 807 again make the bug disappear. Could you double
check ? If the bug persists, could you send me privately your .config
file ?

-- 


					    Gilles Chanteperdrix.

