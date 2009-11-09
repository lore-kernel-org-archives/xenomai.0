Message-ID: <4AF82BFA.1080903@domain.hid>
Date: Mon, 09 Nov 2009 15:49:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>	<4AF813D2.2000001@domain.hid>	<ddc6e05e0911090622m52d0297fo24061b6bea475a8e@domain.hid>
	<ddc6e05e0911090623w67986d66u19b71995d9c9e92f@domain.hid>
In-Reply-To: <ddc6e05e0911090623w67986d66u19b71995d9c9e92f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Context-sharing semaphores
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Remco den Breeje <remco@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Remco den Breeje wrote:
> Classic.

Ah. Sorry. Found the bug in the mean time. It is in the Makefile. You do
not pass the compilation flags for compilation for Xenomai posix skin.
So, your user space application uses plain linux semaphores.

See:
doc/txt/pse51-skin.txt in xenomai sources
or:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags.

-- 
                                          Gilles


