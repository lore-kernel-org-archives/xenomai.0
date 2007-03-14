From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17912.26777.313494.393466@domain.hid>
Date: Wed, 14 Mar 2007 22:26:49 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F86426.9000309@domain.hid>
References: <45F86426.9000309@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid

Maksym Veremeyenko wrote:
 > Hello!
 > 
 > I have a question about coexisting another applications on host that is 
 > under xenomai.
 > 
 > First my problem: running some applications cause not swap usage, memory 
 > statistics is:
 > 
 > Mem:    385000k total,    91908k used,   293092k free,    21180k buffers
 > Swap:  2000368k total,        0k used,  2000368k free,    42684k cached
 > 
 > and swap is constantly 0k used. Is it normal?

If the system does not need swap, it does not use swap, I think it is
normal.


 > 
 > 
 > Second problem:  other applications sometimes (50% attemps) fail to 
 > start (especially perl scripts and Eclipse) then at least one Xenomai 
 > application running.
 > 
 > I use linux 2.6.17.14, Adeos 1.5-02, Xenomai trunk 2170

Could you try running "switchtest" while your Xenomai application is
running ?

-- 


					    Gilles Chanteperdrix.

