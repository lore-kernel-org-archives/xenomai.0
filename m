From: Dirk Roloff <roloff@domain.hid>
Date: Thu, 18 Mar 2004 14:37:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181437.13187.roloff@domain.hid>
Subject: [Adeos-main] Adding void * to interrupt isr
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hi All,

after implementing my device driver in a adeos domain, i am missing a pointer to my device struct in the isr.
Under Linux the prototype of request_irq is:

int request_irq(unsigned int irq, void (*gest)(int, void *, struct pt_regs *), unsigned long drap_interrupt, const char *devname, void *dev_id); 

as you see / know the last parameter is a void * dev_id. This dev_id is not handled by the kernel and just past as 
second parm to the isr.
This makes it easy to handle more the one device withe the same driver, or pass some infos to the isr.

ToDo:

* adding a void * to adomain_t.irq
 
* change adeos_virtualize_irq() and  adeos_alloc_irq() save the dev_id in  
adomain_t.

* change the call to irq handler passing dev_id;

* Change all calls to adeos_virtualize_irq to pass a NULL dev_id  while init pipeline for linux.

* Change dokumentation


What do you think about this ? I would do and test this an supply a patch. Who would add this to the current cvs.

To make the prototypes equal we maybe add also struct pt_regs * but i do not know which regs should be
the isr.

Regards 
Dirk




