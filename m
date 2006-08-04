MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17619.19247.585900.147875@domain.hid>
Date: Fri, 4 Aug 2006 15:27:11 +0200
Subject: Re: [Xenomai-help] Time between ISR and RT Task
In-Reply-To: <20060804070841.313620@domain.hid>
References: <20060804070841.313620@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GSM909@domain.hid
Cc: xenomai@xenomai.org

GSM909@domain.hid wrote:
 > GSM909@domain.hid wrote:
 >  > Hello
 >  >
 >  > I have run a few programs with Xenomai tasks and have no problems. But I notice that the time between ISR and RT task ( RT task is suspended and resumed by the ISR) is shorter when Linux have a lot of work ( average load around 10 ) as when Linux has nothing to do( al : 0.05 ). 
 > 
 > Do you observe this for worst case, or for average case latencies? Do you observe this when you boot with the idle=poll parameter ?
 > 
 > When idle, Linux uses the 'hlt' instruction, that stops the CPU until an interrupt happen, maybe waking up from this state take a little bit more time than when an interrupt is received directly?
 > 
 > How can I set idel = poll ?

That's idle, not idel. The way to pass this option to the kernel depend
on the bootloader you are using. If using lilo on x86, add a line:

append="idle=poll"

to the /etc/lilo.conf section for the image you are booting (if there is
already an "append" line, then add "idle=poll" to this line)

If using grub on x86, add idle=poll to the /boot/grub/menu.lst line
beginning with "kernel" for the xenomai kernel.

Anyway, you should let the latency test run a few hours for a given
configuration before concluding anything, the worst case latency does
not show up so easily.

-- 


					    Gilles Chanteperdrix.

