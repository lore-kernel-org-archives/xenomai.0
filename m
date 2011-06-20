Message-ID: <4DFF8476.2000306@domain.hid>
Date: Mon, 20 Jun 2011 19:33:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>	<4DFBA305.9000303@domain.hid>
	<4DFC7C0E.1090700@domain.hid>	<4DFC9575.1030904@domain.hid>
	<4DFC95B7.8070703@domain.hid>	<4DFCA09B.20609@domain.hid>
	<4DFCA323.6030704@domain.hid> <4DFCA432.3070203@domain.hid>
	<4DFCAF07.8020607@domain.hid> <4DFE189D.5030908@domain.hid>
	<4DFF78AA.9050904@domain.hid>
In-Reply-To: <4DFF78AA.9050904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/20/2011 06:43 PM, Jan Kiszka wrote:
> On 2011-06-19 17:41, Gilles Chanteperdrix wrote:
>> Merged your whole branch, but took the liberty to change it a bit
>> (replacing the commit concerning unlocked context switches with comments
>> changes only, and changing the commit about xntbase_tick).
> 
> What makes splmax() redundant for the unlocked context switch case? IMO
> that bug is still present.

No, the bug is between my keyboard and chair. On architectures with
unlocked context switches, the Linux task switch still happens with irqs
off, only the mm switch happens with irqs on.

-- 
                                                                Gilles.

