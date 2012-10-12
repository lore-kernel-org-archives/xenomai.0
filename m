Message-ID: <5077D1D8.1070505@xenomai.org>
Date: Fri, 12 Oct 2012 10:16:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20121011170958.40C8E372@centrum.cz> <50771645.6020705@xenomai.org>
	<20121012091140.E3CB5F90@centrum.cz>
In-Reply-To: <20121012091140.E3CB5F90@centrum.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: xenomai@xenomai.org

On 10/12/2012 09:11 AM, Petr Cervenka wrote:
>> Od: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> Komu: Petr Cervenka <grugh@centrum.cz>
>> Datum: 11.10.2012 20:56
>> Předmět: Re: [Xenomai] Shared interrupts
>>
>> CC: xenomai@xenomai.org
>> On 10/11/2012 05:09 PM, Petr Cervenka wrote:
>>> I'm using xenomai 2.5.6, adeos 2.6.38.8-x86-2.10-01
>>
>>>
>>> My primary questions: Is there a possibility to have the rtdm driver
>>> compatible with both cases?
>>
>>
>> Well, yes, enable CONFIG_XENO_OPT_SHIRQ, and pass RTDM_IRQTYPE_SHARED
>> when registering the irq handlers. And do not return XN_ISR_PROPAGATE.
> 
> Of course, I have enabled CONFIG_XENO_OPT_SHIRQ and I have passed RTDM_IRQTYPE_SHARED flag.
> But I can make running only one of those rt - nrt device combinations at a time.
> Two rt devices with shared IRQ work for me only when I do NOT return XN_ISR_PROPAGATE.

That is the way it is supposed to work.

> Combination of rt and nrt device works only when I return XN_ISR_PROPAGATE.

Yes, I was talking about the rt devices only case. For the rt/nrt mixup,
see the FAQ.

-- 
					    Gilles.

