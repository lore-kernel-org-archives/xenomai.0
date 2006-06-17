MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17556.16823.734335.713312@domain.hid>
Date: Sat, 17 Jun 2006 19:53:59 +0200
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
In-Reply-To: <200606151340.55710.niklaus.giger@domain.hid>
References: <200606122058.18019.niklaus.giger@domain.hid>
	<17552.3527.468486.973862@domain.hid>
	<200606151340.55710.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > Hi
 > 
 > Here the reworked patch.
 > 
 > vxWorks supports empty messages. Only one at a time can be received.

Could you explain a bit more "Only one at a time can be received" ? I do
not get it. You mean that one message get lost if posting two null
length messages while two receivers are blocked in a call to msgQReceive
?

-- 


					    Gilles Chanteperdrix.

