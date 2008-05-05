Message-ID: <481F6C7D.1050908@domain.hid>
Date: Mon, 05 May 2008 16:22:21 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040601070208000005030007"
Subject: [Xenomai-help] Loosing serial interrupt
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

This is a multi-part message in MIME format.
--------------040601070208000005030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am having problems with lost serial interrupts. Could you please 
explain to me why this happens ? I am probably missing something 
regarding scheduling in Xenomai...
I prepared a program that triggers the problem, at least on my system.

Thanks,

Tomas

The program works on my system as follows:

1. I run the program, it prints

In interrupt, LStatus: 96
In interrupt, read char, LStatus: 96

[which means that it received a serial interrupt, because the 
transmitter receiver is empty]

2. I send a single character to the program over serial line

3. the program wakes up (10 seconds after (1))

4. the program prints

I-NFO irq=4 hits=1
PIC-ISR:0 PIC-IRR:0 PIC-IMR:128 UART-IIR:4 UART-LSR:97 UART-MSR:176

[which means the interrupt at Xenomai level hit only once, although it 
should have twice, second time because of the received character
  these too lines that repeat indefinitely, the interrupt not coming. 
although interrupts are enabled at PIC level]

I use the "XT-PIC-XT" (8259A) interrupt controller. As far as I know, 
Linux sets up the controller to "edge triggering", but uses 
"handle_level_irq" for it. When received by Xenomai, the interrupt is 
masked and acked at PIC level ( "ack" means EOI at 8259A). When the 
interrupt handling in the program finishes, it unmasks the interrupt. I 
verified  that my 8259A has a latch that can detect the UART interrupt 
even if masked, so that when unmasked again, it can be delivered.





--------------040601070208000005030007
Content-Type: text/plain;
 name="xloopback.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xloopback.c"

#include <stdio.h>
#include <sys/io.h>
#include <unistd.h>

#include <native/task.h>
#include <native/intr.h>
#include <sys/mman.h>

#define BASEPORT 0x3f8
#define IRQ_NUMBER 0x4

RT_INTR intr_desc;
RT_TASK sender_desc, task_main;

inline void nfo() {

  int isr, irr, imr;
  int iir, lsr, msr;
  
  outb(0x0b, 0x20);
  isr = inb(0x20);
  outb(0x0a, 0x20);
  irr = inb(0x20);
  imr = inb(0x21);
  
  iir = inb(BASEPORT +2);
  lsr = inb(BASEPORT +5);
  msr = inb(BASEPORT +6);
  
  fprintf(stderr, "PIC-ISR:%d PIC-IRR:%d PIC-IMR:%d UART-IIR:%d UART-LSR:%d UART-MSR:%d\n",
    isr, irr, imr, iir, lsr, msr);

}

void sender_task (void *cookie) {

  int res;
  
  for(;;) {


    res = rt_intr_wait(&intr_desc, TM_INFINITE);
    
    if (res<=0) {
      perror("rt_intr_wait: ");
      continue;
    }

    fprintf(stderr,"In interrupt, LStatus: %d \n", inb(BASEPORT +5));

    inb(BASEPORT);
    fprintf(stderr,"In interrupt, read char, LStatus: %d \n",
        inb(BASEPORT +5));

    rt_intr_enable( &intr_desc ); 
  }
}

RT_INTR_INFO intr_nfo;

int main(int argc, char **argv) {

  int res,i;
  
  if (iopl(3)) { 
    perror("iopl:");
    return 1;
  }

  mlockall(MCL_CURRENT|MCL_FUTURE);
  
  res = rt_intr_create(&intr_desc, NULL, IRQ_NUMBER, I_NOAUTOENA); 
//  res = rt_intr_create(&intr_desc, NULL, IRQ_NUMBER, 0); 

  if (res) {
    perror("rt_intr_create:");
    return 1;
  }
  
  res = rt_task_create(&sender_desc, NULL, 0, 99, 0);
  if (res) {
    perror("rt_task_create:");
    return 1;
  }
  
  rt_task_start(&sender_desc, &sender_task, NULL);


  outb( 0x00, BASEPORT + 1);
  outb( 0x80, BASEPORT + 3 );
  outb( 0x01, BASEPORT + 0 );
  outb( 0x00, BASEPORT + 1 );
  outb( 0x03, BASEPORT + 3 );

// FIFO on, interrupt after one byte
  outb( 0x7, BASEPORT + 2); 
  
// FIFO off 
  outb( 0x0, BASEPORT + 2); 
  
  outb( 0xb, BASEPORT + 4 ); // force rts on
//  outb( 0x9, BASEPORT + 4 ); // do not force rts

  
  rt_intr_enable( &intr_desc );    
  
  outb( 15, BASEPORT + 1 ); 

  rt_task_shadow( &task_main, NULL, 1, 0);

  while (1) {

      rt_task_sleep(10000000000ULL);
      
      rt_intr_inquire(&intr_desc, &intr_nfo);
      fprintf(stderr,"I-NFO irq=%d hits=%d\n", intr_nfo.irq, intr_nfo.hits);

      nfo();
  }

  fprintf(stderr,"Main: no more characters to send...\n");  

}


--------------040601070208000005030007--

