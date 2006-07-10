Content-Type: text/plain; charset="utf-8"
Date: Mon, 10 Jul 2006 13:40:00 +0200
From: "Keinen Namen" <GSM909@domain.hid>
In-Reply-To: <44B2169F.7070205@domain.hid>
Message-ID: <20060710114000.145290@domain.hid>
MIME-Version: 1.0
References: <20060710080757.4430@domain.hid> <44B21018.4060702@domain.hid>
	<20060710084549.4390@domain.hid> <44B2169F.7070205@domain.hid>
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] ISR Again
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

hi Again

witch from have a RT_ISR?

I simply want a Programm that run helloworld_isr when Interrupt 13 is fired.

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>

#include <native/intr.h>

MODULE_DESCRIPTION("My kernel module");
MODULE_AUTHOR("Nobody");
MODULE_DESCRIPTION("Dei Mudda");
MODULE_LICENSE("my own");


RT_INTR my_rt_intr;

static int helloworld_isr(rt_intr_t *intr){
	printk( KERN_ALERT "IRQ\n");
	return IRQ_HANDLED;
}

static int helloworld_init_module(void) {
	int x;
	printk( KERN_ALERT "Module helloworld init startet Version 0.1\n" );
	
	x = rt_intr_create(&my_rt_intr,"einName",13,helloworld_isr,NULL,0);
	if(!x){
		printk( KERN_ALERT "Interrupt erfolgreich erstellt\n");
	
		if(!(rt_intr_enable(&my_rt_intr))){
			printk( KERN_ALERT "Interrupt erfolgreich aktiviert\n");
		}
	}else{
		printk( KERN_ALERT "Interrupt Erstellung fehlgeschlagen %i\n",x);
	}
}

static void helloworld_exit_module(void) {

	if(!(rt_intr_disable(&my_rt_intr))){
		printk( KERN_ALERT "Interrupt Cleared !\n" );
		if(!(rt_intr_delete(&my_rt_intr))){
	 		printk(KERN_ALERT "Interrupt deleted\n" );
		}
	}

	printk( KERN_ALERT "Module helloworld exit\n" );
}

module_init(helloworld_init_module);
module_exit(helloworld_exit_module);
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

