Message-ID: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
Date: Fri, 18 Apr 2008 16:33:42 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Handling interrupt - jitter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

I'm having (from my perspective) too big jitter on handling
interrupts. System is: ARM9, AT91SAM9260, Kernel 2.6.20.21, Adeos
1.8-03, Xenomai-2.4.2, interrupt is generated every 1ms, externally.
Interrupt source (ET1200) is connected to IRQ1 pin (PC15). I'm using
native skin from user space. Usually, handler 'reacts' after ~110us,
but, worst case delay is around 250us! Is this performance
normal/expected on my platform? Why the difference is so huge?

Is there anything I can do to get better results (with this hw:)?

Code looks like the example provided with Xenomai:

void tmng ()
{
   for (;;) {
      err = rt_intr_wait(&intr_desc,TM_INFINITE);
      if (err > 0) {
         [..]
      } else {
         [..]
      }
      rt_intr_enable (&intr_desc);
   }
}
main ()
{

  err = rt_intr_create(&intr_desc, "ET1200_sync", IRQ_NUMBER, 0);
  err = rt_task_create(&task_desc, "tmng", 0, 99, T_JOINABLE);

  rt_intr_enable (&intr_desc);

  rt_task_start(&task_desc,&tmng,NULL);
}

Thanks

