Message-ID: <4E75ED9E.9000708@domain.hid>
Date: Sun, 18 Sep 2011 15:09:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABm7fFPcAjLu3_xVi+t8fCYy_VYKR6A7pgTF-WeHv4ifw9V5qA@mail.gmail.com>
In-Reply-To: <CABm7fFPcAjLu3_xVi+t8fCYy_VYKR6A7pgTF-WeHv4ifw9V5qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Port to stmp3xxx (arm based)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bertold Van den Bergh <vandenbergh@domain.hid>
Cc: xenomai@xenomai.org

On 09/17/2011 05:15 PM, Bertold Van den Bergh wrote:
> Hello,
> 
> I am trying to port Xenomai to the freescale stmp3xxx cpu (I.MX233).
> 
> I added TSC code from plat-s3c24xx as this processor also uses a 16
> bit downcounter based timer. I run the system tick counter and the TSC
> freerunning counter at 32KHz (I plan to speed it up to increase
> precision but I have a question about that). I have monitored the TSC
> output and it is a monotonic count without jumps forward or backward.
> Xenomai and linux boots fine. I can also start xenomai tasks, and they
> even appear to work to some extent.

The mask member filled by __ipipe_mach_get_tscinfo is wrong, the right
mask for a 16 bits counter is 0x0000ffff

-- 
                                                                Gilles.

