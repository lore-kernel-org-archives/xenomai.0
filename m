Message-ID: <5343AF72.8060107@xenomai.org>
Date: Tue, 08 Apr 2014 10:12:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain> <534275AD.50005@xenomai.org>
 <1396924672.16375.8.camel@localhost.localdomain>
In-Reply-To: <1396924672.16375.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <pjh@northern-ridge.com.au>
Cc: xenomai@xenomai.org

On 04/08/2014 04:37 AM, Peter Howard wrote:
> On Mon, 2014-04-07 at 11:53 +0200, Gilles Chanteperdrix wrote:
>> On 04/07/2014 07:34 AM, Peter Howard wrote:
>>>
>>> On Wed, 2014-04-02 at 09:24 +0200, Gilles Chanteperdrix wrote:
>>>> On 04/02/2014 04:59 AM, Peter Howard wrote:
>>>>> Hi,
>>>>>
>>>>> I'm interested in running xenomai on a TI-OMAP L138 board.  I found the
>>>>> following thread in the archives:
>>>>>
>>>>> http://www.xenomai.org/pipermail/xenomai/2010-January/018898.html
>>>>>
>>>>> where someone was working on porting ipipe and xenomai to that board.
>>>>> However, the thread ended with problems still unresolved, and the patch
>>>>> in the thread (just the changes for ipipe) isn't in the ipipe
>>>>> repository.
>>>>>
>>>>> Does anyone know if this work was completed or just faded into the
>>>>> ether?
>>>>
>>>> We never merged a patch for this processor. And a lot of things changed
>>>> since that time. If you are interested in porting the I-pipe patch to
>>>> this processor, see:
>>>>
>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>>
>>>
>>> Contrary to what I said last week, I'm working on a patch off the head
>>> of the ipipe repo.  I have built a kernel with an ipipe port and with
>>> xenomai patched in.  However the latency results are bad right now:
>>
>> Well, in that case enable the I-pipe tracer, and run latency with the -f
>> option to know why.
>>
> 
> I turned the tracing on and . . . start getting kernel panics from a
> NULL pointer dereference.  If I have tracing on from boot it dies
> shortly after getting to the login prompt.  If I disable it at boot, I
> start getting ext-3 errors as soon as I enable it (losing the ability to
> read the filesystem at all), then get the panic a few seconds later.  I
> get an I-pipe tracer log along with the panic, but aren't really sure
> how to interpret it in this context.   In all cases the failure appears
> to be in the context of __ipipe_trace():

Do you have CONFIG_IPIPE_TRACE_VMALLOC turned on? If not, you should. If
the backtraces are not meaningful, you can try disabling stack unwinding.

> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004    
> pgd = c73e8000, hw pgd = c73e8000                                               
> [00000004] *pgd=c72a3831, *pte=00000000, *ppte=00000000                         
> Internal error: Oops: 817 [#1] PREEMPT ARM                                      
> Modules linked in:                                                              
> CPU: 0 PID: 2307 Comm: run-parts Not tainted 3.10.0-ipipe-00165-g9a2c8c8-dirty 5
> task: c70ef800 ti: c737a000 task.ti: c737a000                                   
> PC is at get_page_from_freelist+0x164/0x750                                     
> LR is at __ipipe_trace+0xa8/0x5b8                                           
> 
> 
> I'm going to keep digging to see if I can work out what the actual
> failure is, but any suggestions would be appreciated.  (I can provide
> full dump and following trace log if it would be useful)

Disable stack unwinding, and show us the backtrace you get, and the full
trace if you get it.

-- 
                                                                Gilles.

