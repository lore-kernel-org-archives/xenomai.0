From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] 2.6.17 hang on "will halt now" (possibly SMI
	related) [SOLVED]
Date: Mon, 3 Jul 2006 14:37:09 -0300
References: <200606301654.45844.lbocseg@domain.hid> <44A7CA35.5060009@domain.hid>
In-Reply-To: <44A7CA35.5060009@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607031437.09370.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Thank you Jan. I tested and it is working pretty fine again.

My only problem is that I couldn't compile the new IRQ testsuite. I needed to 
disable it in order to compile the kernel. That happened both at home as at 
college.

Thank you, once more.

Best Regards,
Rodrigo.

____________________________________________________________
Em Domingo 02 Julho 2006 10:29, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> I began to experience a problem since 2.6.17 when shutting down my PC.
>>
>> I noticed the problem just after I recompiled my kernel to enable the SMI
>> workaround. I, then rebooted the new kernel and when I tried to shutdown 
>> the system, it stopped on "will halt now" message or something like.
>>
>> The same behavior is occurring both in home (Pentium-3 550 MHz) and  at
>> college (P4-1.7GHz). In both systems, Xenomai advised me to enable SMI
>> workaround. Actually, at home, the worst latency with the latency test was
>> about 20us independently from enabling or not the SMI workaround.
>>
>> Do someone else experienced a similar problem when upgrading to 2.6.17?
>
>Yep. Should be fixed now, see latest trunk.
>
>It was a deadlock due to clumsy unregistration of the reboot notifier
>from its own handler. I think the locking of the kernel changed in
>2.6.17 (RCU) and made this fatal.
>
>Jan
>
>
>PS: 20us on a P-III 550 is a bit too good. I guess some serious load is
>missing (cache load, IRQs, ...).

		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



