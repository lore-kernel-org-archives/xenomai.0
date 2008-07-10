Message-ID: <4875D791.9040902@domain.hid>
Date: Thu, 10 Jul 2008 11:34:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <81ac35bcbdd12c31081c6c5852abd705@domain.hid>
In-Reply-To: <81ac35bcbdd12c31081c6c5852abd705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] vxworks task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> Hi
> 
> How to tell a vxworks task to execute on a specific CPU like T_CPU(cpuid)
> parameter for native rt_task ?
> 
> Thank you in advance

use pthread_set_affinity_np

-- 
                                                  Gilles.

