Message-ID: <52F4F698.7030900@marel.com>
Date: Fri, 7 Feb 2014 15:07:04 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
 <52F4E084.3020809@marel.com> <52F4E865.5000200@xenomai.org>
 <52F4EE97.2070800@marel.com> <52F4EFE5.2040000@xenomai.org>
In-Reply-To: <52F4EFE5.2040000@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 07/02/14 14:38, Gilles Chanteperdrix wrote:
> On 02/07/2014 03:32 PM, Marcel van Mierlo wrote:
>> If I comment out q_send TRAP 8 dosent occur. If I pass NULL as data
>> words to q_send, TRAP 8 stops... and %CPU remains low....hmmm do I need
>> to ensure stack alignment somehow?
>
> The stack alignment is ensured by the compiler. Starting with ARM 
> EABI, the stack is aligned on 8 bytes, so, if you do not use special 
> tricks (like casting a char * pointer to a u_long *pointer, or using 
> __attribute__((packed))), everything should be aligned properly. Could 
> you show us the declaration of the buffer passed to q_send ? In fact, 
> posting a self-contained, minimal example allowing to reproduce the 
> problem would help.
>

I will put together a self-contained minimal example (might be next 
week), but here is a complete working task function which exhibits high 
CPU. MSW still increases if I pass NULL but no messages are received....

Marcel.


TASK cio_watchdog_kick(void)
{
     u_long cantmsg[4];
     UL ulCanTQid;

     if (q_ident("cant", 0, (INT32 *)&ulCanTQid) != 0)
     {
         t_suspend(0);
     }

     while(1)
     {
         q_send(ulCanTQid, cantmsg);
         //q_send(ulCanTQid, NULL);
         tm_wkafter(100);
     }
}

LOCAL UL start_cio_watchdog_kick(void)
{
     UL ulRetval;
     UL ulTid;


     if ((ulRetval = t_create(   "CIOW",
                                 150,
                                 512,
                                 512,
                                 T_LOCAL,
                                 (INT32 *)&ulTid)) != 0)
     {
         return ulRetval;
     }

     if ((ulRetval = t_start( ulTid,
                             T_PREEMPT,
                             (void*)cio_watchdog_kick, 0)) != 0)
     {
         return ulRetval;
     }

     return 0;
}


