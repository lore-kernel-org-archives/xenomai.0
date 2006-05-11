Message-ID: <446303BF.40906@domain.hid>
Date: Thu, 11 May 2006 11:28:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kernel panic on rmmod xeno_vxworks
References: <200605102227.09892.niklaus.giger@domain.hid>
In-Reply-To: <200605102227.09892.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
> I compiled and started my test with a recent xenomai/trunk (revision 1068).
> I booted into single user mode, did a "modprobe xeno_vxworks" (no problem) and 
> then a "rmmod xeno_vxworks" and got as response on my PowerBook only
> "Kernel panic: -not syncing: Aiee, killing interrupt handler".
> 

Confirmed, and it seems configuration-dependent, but not arch-dependent. 
I'm on it, more later.

-- 

Philippe.

