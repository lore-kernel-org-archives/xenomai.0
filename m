References: <07fe7fa20faed6e818d33b54db9001b6@stupar.com>
 <adbf2787-6a0e-588e-272e-be15686fc2b7@xenomai.org>
 <ee4b936505fe83420d3e95303ebe6058@stupar.com>
From: Andrija Stupar <andrija@stupar.com>
Message-ID: <ddc23472-e188-5482-be39-dc8f8917eed6@stupar.com>
Date: Sat, 18 Mar 2017 12:28:24 -0400
MIME-Version: 1.0
In-Reply-To: <ee4b936505fe83420d3e95303ebe6058@stupar.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Andrija Stupar <andrija@stupar.com>
Subject: Re: [Xenomai] RTDM driver init: interrupts and context objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Well, I can answer my own question from a couple of weeks ago. Nothing 
was wrong with the way the RTDM interrupts were coded - the port from 
Linux to RTDM was done properly. The problem was a mode switch, falling 
into secondary (non-RT) mode. As I gather from the Xenomai RTDM API 
documentation, rtdm_event_wait(...) can only be called in RT mode. That 
is, if you call it non-RT mode it does nothing. When this call is made 
in non-RT mode, it just falls through (i.e. it does nothing). The actual 
interrupt occurs later and it has nothing to wake up since nothing went 
to sleep.

Once I found the sources of the mode switch in the code calling the 
driver, and fixed them so that I was always running in RT mode, the 
interrupts worked perfectly.


On 03/02/2017 11:10 PM, andrija@stupar.com wrote:
> Hi Philippe,
>
> Thank you very much for your earlier response. I have figured that 
> part of the driver out and opening and requesting an interrupt line 
> works well. Also, upon an interrupt, an interrupt service routine is 
> executed as expected. However I have one remaining problem I hope you 
> could help me out with. For interrupt-driven A/D conversion, the 
> hardware I am using works like this: 1) I write to a register to 
> initiate interrupt-driven A/D conversion 2) the write call then goes 
> to sleep until data is ready 3) an interrupt handler awakens the write 
> call 4) the write call returns and 5) the code which made the write 
> call now knows that it should read data from an input register.
>
> In the original driver, the code doing steps 1), 2) and 4) looks like 
> this:
>
> wqc = 0;       /* indicate waiting */
> writew( (int)ldata, (void *)(*adata) );
> wait_event_interruptible(ain_queue, wqc);
> wqc = 2;       /* indicate complete */
> .... return (...) ;
>
> Since interrupts in RTDM work slightly differently and there is no 
> wait queue in the RTDM/Xenomai version I am using, I ported the above 
> code to RTDM like this:
>
> writew( (int)ldata, (void *)(*adata) );
> if (!my_context->data_flag) {
>      my_context->wait_flag = TRUE; /* indicate waiting */
>          if (rtdm_event_wait(&my_context->apc8620_wait)) { /* wait */
>                        my_context->wait_flag = FALSE;
>                        return ( -ERESTARTSYS );
>          }
> }
> /* indicate complete */
> my_context->data_flag = FALSE;
> my_context->wait_flag = FALSE;
> .... return (...) ;
>
> In the original driver, step 3) is the in the interrupt handler 
> function and looks like this:
>
> if( wqc == 0)        /* waiting for a blocked start convert AND an 
> interrupt from the input board */
> {
>      wqc = 1;               /* when received, change the condition to 
> true... */
>       wake_up_interruptible(&ain_queue);     /* ... and wake the 
> blocked write */
> }
>
> My port of the above to RTDM is:
>
> if (my_context->wait_flag && !(my_context->data_flag)) {
>            my_context->data_flag = TRUE;
>          my_context->wait_flag = FALSE;
>             rtdm_event_signal(&my_context->apc8620_wait);
> }
> return( RTDM_IRQ_HANDLED);
>
> My understanding is that the above two pairs of code snippets (vanilla 
> Linux and RTDM) do the same thing, functionally. However they do not. 
> The interrupt driven A/D conversion is defined by a timer which can be 
> set to some range of values (e.g. 1 second). However it seems that the 
> board generates interrupts for other reasons as well.
>
> When I run this using the Linux driver, my write call that initiates 
> sleeps for about a second (i.e. the timer period) and then returns, 
> and then there is data to read. When I run this running my RTDM 
> driver, my write call sleeps much less, it returns almost immediately, 
> and there is no data to read.
>
> My question is therefore - have I made some obvious mistake in porting 
> the regular interrupts to RTDM interrupts in the code above? Am I 
> using RTDM interrupts correctly here? Or is the code I've written 
> expectedly behaving differently from the original code?
>
> Thanks for any help.
>
> Best regards,
>
> Andrija Stupar
>


