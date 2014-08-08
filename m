Message-ID: <53E4BD17.7080707@xenomai.org>
Date: Fri, 08 Aug 2014 14:05:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org> <53E3D084.2000506@tuebingen.mpg.de>
 <53E3D2FF.5000407@xenomai.org> <53E3D50D.7060701@tuebingen.mpg.de>
 <53E3D712.3070801@xenomai.org> <53E3D9F0.5070906@xenomai.org>
 <53E47549.4010904@xenomai.org>
In-Reply-To: <53E47549.4010904@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Ludovic Righetti <ludovic.righetti@tuebingen.mpg.de>, Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org

On 08/08/2014 08:59 AM, Philippe Gerum wrote:
> On 08/07/2014 09:56 PM, Gilles Chanteperdrix wrote:
>> On 08/07/2014 09:44 PM, Philippe Gerum wrote:
>>> On 08/07/2014 09:35 PM, Ludovic Righetti wrote:
>>>>
>>>>> I suspect you could run any loop, like cat /proc/interrupts, and see the
>>>>> same issue. Are you running with a frame buffer in the no-x mode?
>>>>>
>>>> that's what I thought too, but /proc/interrupts or /proc/xenomai/sched
>>>> (or others) do not seem to create any issue (below the output for
>>>> interrupts, watching other /proc/ files give similar results).
>>>>
>>>> Let me check about the fb.
>>>>
>>>
>>> Just for kicks, could you try this patch ? it does NOT fix anything,
>>> only maybe papering over an issue we don't know about yet:
>>
>> Note that there has already been a thread about this issue in april.
>>
> 
> So it looks like nobody cared.
> 
I tried and help Jeroen, but since I could not reproduce the issue,
could not investigate it much further.

-- 
                                                                Gilles.

