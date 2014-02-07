Message-ID: <52F4EE97.2070800@marel.com>
Date: Fri, 7 Feb 2014 14:32:55 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
 <52F4E084.3020809@marel.com> <52F4E865.5000200@xenomai.org>
In-Reply-To: <52F4E865.5000200@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 07/02/14 14:06, Philippe Gerum wrote:
> On 02/07/2014 02:32 PM, Marcel van Mierlo wrote:
>
>>      - When I comment out q_send (so only call tm_wakeafter) MSW does
>> not increase and stays on zero.
>>      *** Why does q_send cause mode switches?
>
> Where do the data words passed to qsend() come from? Plain regular 
> memory?
>
> Also, what does /proc/xenomai/faults show after runtime?
>

The data words are created on the task stack (struct instance created as 
automatic variable on stack)

I see increasing TRAP 8 (Unaligned access exception) when application is 
running.

TRAP         CPU0
   0:          732    (Data or instruction access)
   1:            0    (Section fault)
   2:            0    (Generic data abort)
   3:            0    (Unknown exception)
   4:            0    (Instruction breakpoint)
   5:            0    (Floating point exception)
   6:            0    (VFP Floating point exception)
   7:            3    (Undefined instruction)
   8:        10067    (Unaligned access exception)

If I comment out q_send TRAP 8 dosent occur. If I pass NULL as data 
words to q_send, TRAP 8 stops... and %CPU remains low....hmmm do I need 
to ensure stack alignment somehow?

Marcel.


