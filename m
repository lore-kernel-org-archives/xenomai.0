Message-ID: <4E2EAB0F.6050109@domain.hid>
Date: Tue, 26 Jul 2011 13:54:55 +0200
From: zenati <omar.zenati@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Debugging Xenomai kernel
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Dear,

I'm trying to debug Xenomai kernel with GDB and Qemu. So, I launch 
Xenomai in Qemu and make it waiting for GDB. Then I start GDB and 
connect them to Qemu, make breakpoint at the desired function to debug 
and start Xenomai. If the function belongs to the linux kernel, the 
execution stop at the breakpoint. But, if the function belongs to the 
Xenomai nucleus, GDB recognize the breakpoint at the execution but don't 
stop.

Is it possible to debug Xenomai with GDB and Qemu?
Is it the good way to debug?

Thank you for your attention and your help.
Sincerely,

Omar ZENATI


