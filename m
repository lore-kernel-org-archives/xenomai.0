From: Dirk Roloff <roloff@domain.hid>
Date: Mon, 23 Feb 2004 00:35:16 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402230035.16494.roloff@domain.hid>
Subject: [Adeos-main] interrupt latency
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi List,

I ve got the following problem:

I have to write a driver for linux for a receiver-board. 
On this board is an AMCC S5933 pci-controler. Ok on this chip is a fifo (256 
bit).
it has 2 regsiters MWAR (adress for DMA) and MWTC ( byte count for DMA)
i will set both to a buffer - the count will be decemented and if it reaches 
zero i will get an interrupt (IRQ 5). in the drivers handler function i will 
just set MWAR to the next buffer and MWTC to the size of the buffer.
So the board can start new DMA.

Thats the background now the problem:
the fifo, again its 256 bit will be filled by a satalite link with 1Mbit
1024000 bits per second. So i have a maximum of 0.25 milliseconds.
and i have no idea how long it takes to get the pci for the next dma.
But it woks most time, but ca. 10 times in an hour my pc is too slow.
( i think - i am not sure )
So i loose some data. Its a receive only application so i have no handshake 
back in the air.

if you google for interrupt latency - you will find "Linux is no RTOS" - so i 
find rtai and the adeos-patches. Great that sounds like it could work.
untar kernel - patch - compile - crash - compile - read ... read ... 
understand ... ahhhh .... ok i changed the driver.

Create a domain with prio 200 
adeos_virtualize_irq( IRQ 5 )
compile - test .... the same problem .... i lose data ....

My next try to understand whats going on .... create a new module to simulate 
what i think is going on.
i put some soure at the end of this mail.

I registered a linux handler vor irq 4 (serial device)
this is just looping in a long loop doing nothing but using cpu power.
( a cat on ttyS0 will trigger one irq )

i register a handler for all (0-15) irqs on the realtimeside.
while the linux handler is running i am counting the irqs that will be entered 
in there.

at the end of the linux_handler i printk what is captured by the realtime:
IRQ 0 ( timer i think ) 300 times and more ...

and then i see only one other IRQ happening once !!
IRQ 9 ( scsii ) or IRQ 1 (keyboard) or IRQ 12 (mouse)

realy - when i trigger IRQ 4 ( by cat /dev/ttyS0 ) the pc is hanging for about 
a sekond. i am spinning around the mouse and pressing the keyboard.
i will only catch one IRQ.

At the end of the linux handler i read out the pic. the catched irq for 
example 12 is marked out. And i couldn't find why. If i understand the code. 
an incomming IRQ will be acked and put in the ipipe. So new IRQs can happen.
While walking down the ipipe.

Back to my real problem - if there is a driver on the linux side - the ide or 
whatever using long time ( simulated by IRQ 4 ) i will not get in the 
realtime handler for my receiver card.

My goal is: if IRQ 5 is raised - stop doing what ever you are doing - serve 
the board, and after that you have all time you need.

i am working a week on my own, its sunday night and the weekend is also gone.
i real need someone to help me.

thanks

Dirk

ah ... here is now the code pices ( I cut out some stuff )


init_module()
 - request_irq( 4 , linux_handler ) /* my simulation of a long running device 
handler here ist ttyS0 */
 - adeos_register_domain( myRealtime )

in the DomainEntry()
{
 int i;
  for(i=0;i<16;++i) adeos_virtualize_irq( i realtime_handler )

  for(;;) /* dont realy understand - copyed from rtai */
    adeos_suspend_domain();
}

static volatile int linux_irq = 0;
static volatile int irq_count[256];

static void linux_handler()
{
  linux_irq = 1;	/* we are running */
 /* just eating some cpu time - this will hang the linux for 1-2 sekonds */
  for(x=0;x<1000;++x) 
    for(i=0;i<1000000;++i)
      if( x==0)++i;

  linux_irq = 0; /* we are finish */
  /* Ok lets have a look what happend in realtime */
  for( i=0;i<255;++i)
  {
    if( irq_count[i] != 0)
      printk ("linux_irq_handler: irq %d catched %d times\n",i ,irq_count[i]);
  }
}

static void 
realtime_handler ( unsigned int irq )
{
  if(linux_irq != 0)
  {
    ++irq_count[irq]; /* add counter while linux_handler is running */
  }
}






