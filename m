From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17444.19510.452560.852068@domain.hid>
Date: Fri, 24 Mar 2006 20:44:54 +0100
Subject: Re: [Xenomai-help] Crashing at boot with 2.6.15.4
In-Reply-To: <4424264F.7090401@domain.hid>
References: <440DA975.50002@domain.hid> <440DAC21.9030801@domain.hid>
	<44241F36.40201@domain.hid> <4424264F.7090401@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > > divide error: 0000 [#1]
 > > Modules linked in:
 > > CPU:    0
 > > EIP:    0060:[<c014243a>]    Not tainted VLI
 > > EFLAGS: 00010246   (2.6.15.6-ipipe)
 > > EIP is at xntimer_get_jiffies_aperiodic+0x5a/0xf0
 > 
 > This is not ok, but should be easy to fix.

Fixed by revision 786 in trunk and revision 787 in branch 2.1.

-- 


					    Gilles Chanteperdrix.

