Date: Thu, 28 Oct 2004 13:22:49 -0400 (EDT)
From: Currie Reid <curriereid@domain.hid>
In-Reply-To: <1098910087.669.7.camel@domain.hid>
Message-ID: <Pine.LNX.4.44L.0410281313070.7871-100000@domain.hid>
References: <20041027042517.19465.86755.Mailman@domain.hid> 
 <Pine.LNX.4.44L.0410271428370.21604-100000@domain.hid>
 <1098910087.669.7.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Question about adeos_alloc_irq
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Hi Philippe,

I am basically trying to get some latency figures using Adeos, and I've
hit a snag.  Basically, I wanted to cause an interrupt, then measure the
time it took in the root domain to respond to the interrupt.  Then, I
wanted to put the irq handler in a higher priority domain, and measure the
response this latency and compare the 2.  I thought that the second one
would be lower, as the interrupt is sure not to be masked in the higher
priority domain, while there are no such guarantees in the root domain
(linux).  But I'm finding the latencies higher; the average latency is
higher and the max is higher as well - I don't know if this is because
there is some context-switching overhead or what the problem might be.
I'm including my module on the chance that you might spot something wrong
with it immediately.

Thanks for your all of your help and patience,

Currie

#include <linux/module.h>
#include <linux/adeos.h>

#include <linux/proc_fs.h>   /* for create_proc_entry */

MODULE_LICENSE("GPL");
MODULE_AUTHOR( "Currie Reid" );
MODULE_DESCRIPTION( "Measure interrupt latency." );

/* descriptor for our domain */
adomain_t domain_desc;

int interrupt_count = 0;

/* required for taking time measurements */
struct timeval t_assert, t_deassert;

/* IRQ that we will use to trigger ISR */
unsigned MY_IRQ = 0;

/* struct required for formatting proc fs entry */
static struct proc_dir_entry *interrupt_latency_file;

/* call this to handle the interrupt in the root domain */
void root_handle_interrupt( unsigned timer_irq ){

   do_gettimeofday( &t_deassert );

   interrupt_count++;

   printk( KERN_ALERT "ERROR: this should have been handled"
                      "in the interrupt_domain\n" );
}

/* call this to handle the interrupt in the interrupt domain */
void domain_handle_interrupt( unsigned timer_irq ){

   do_gettimeofday( &t_deassert );

   interrupt_count++;
}

/* this formats the proc filesystem entry for public consumption */
static int proc_read_interrupt_latency( char* page, char** start,
      off_t off, int count, int *eof, void* data ){

   int len = 0;

   do_gettimeofday( &t_assert );

   /* if first-read, trigger the IRQ - otherwise, we are coming
    * back for more.
    */
   if( off == 0 )
      adeos_trigger_irq( MY_IRQ );

   len = sprintf( page, "latency %10i\n",
         (int)( t_deassert.tv_usec - t_assert.tv_usec ) );

   *eof = 1;

   return len;
}

/* registers our domain and associated handlers */
void domain_entry( int iflag ){

   if( iflag )
      adeos_virtualize_irq( MY_IRQ, domain_handle_interrupt,
                            0, IPIPE_HANDLE_MASK );

   for(;;)
      adeos_suspend_domain();
}


static int __init init_interrupt_latency( void ){

   /* required for registering new domain */
   adattr_t attr;
   adeos_init_attr( &attr );

   /* RESOURCE interrupt_latency_file */
   interrupt_latency_file =
      create_proc_entry( "interrupt_latency", 0444, 0 );

   if( ! interrupt_latency_file ){
      printk( KERN_ALERT "Failed to create proc entry.\n" );
      return -ENOMEM;
   }

   interrupt_latency_file->data       = 0;
   interrupt_latency_file->read_proc  = &proc_read_interrupt_latency;
   interrupt_latency_file->write_proc = 0;
   interrupt_latency_file->owner      = THIS_MODULE;

   MY_IRQ = adeos_alloc_irq();

   if( ! MY_IRQ ){

      remove_proc_entry( "interrupt_latency", 0 );
      printk( KERN_ALERT "Failed to obtain IRQ number.\n" );
      return -ENOMEM;
   }

   if( adeos_virtualize_irq( MY_IRQ, root_handle_interrupt, 0,
                             IPIPE_DEFAULT_MASK ) != 0 ){

      remove_proc_entry( "interrupt_latency", 0 );
      printk( KERN_ALERT "Failed to set IRQ handler.\n" );
      return -ENOMEM;
   }

   printk( KERN_INFO "interrupt allocated - IRQ %d.\n", MY_IRQ );

   attr.name      = "interrupt_domain";
   attr.domid     = 0x10101010;
   attr.entry     = &domain_entry;
   attr.priority  = ADEOS_ROOT_PRI + 1;

   return adeos_register_domain( &domain_desc, &attr );
}

static void __exit exit_interrupt_latency( void ){

   adeos_unregister_domain( &domain_desc );
   adeos_free_irq( MY_IRQ );
   remove_proc_entry( "interrupt_latency", 0 );
   printk( KERN_INFO "interrupt_latency unloaded.\n" );
}

module_init( init_interrupt_latency );
module_exit( exit_interrupt_latency );





