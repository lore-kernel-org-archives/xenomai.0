Message-ID: <52DFC80D.6050101@xenomai.org>
Date: Wed, 22 Jan 2014 14:30:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com>
In-Reply-To: <52DFC734.2090906@geral.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexandre COFFIGNAL <acoffignal@geral.com>
Cc: xenomai@xenomai.org

On 01/22/2014 02:27 PM, Alexandre COFFIGNAL wrote:
>
> Le 22/01/2014 13:00, Gilles Chanteperdrix a écrit :
>> On 01/22/2014 12:36 PM, Alexandre COFFIGNAL wrote:
>>>>> +        cf->data[3]=((data0 >> 0)  & 0xFF) ;
>>>>> +        cf->data[2]=((data0 >> 8)  & 0xFF) ;
>>>>> +        cf->data[1]=((data0 >> 16)  & 0xFF) ;
>>>>> +        cf->data[0]=((data0 >> 24)  & 0xFF) ;
>>>>> +        cf->data[7]=((data1 >> 0)  & 0xFF) ;
>>>>> +        cf->data[6]=((data1 >> 8)  & 0xFF) ;
>>>>> +        cf->data[5]=((data1 >> 16)  & 0xFF) ;
>>>>> +        cf->data[4]=((data1 >> 24)  & 0xFF) ;
>>>>>
>>>>> rtcan flexcan works perfectly.
>>>>> is  anyone know what is the problem with first instructions ?
>>>> Probably mb->data does not have the right alignment. Could you not
>>>> arrange to get it properly aligned? Failing that, you should use
>>>> put_unaligned instead of open coding it.
>>>>
>>>>
>>> here structures used in flexcan driver, it seem to be aligned
>>
>> I am talking about the alignment of cf->data, since obviously, that is
>> the one which is causing problems.
>>
>>
> Thank a lot, put_unaligned fix this issue if you want, i can send a path
>

The other solution (getting cf->data to be properly aligned) would be 
more efficient, why is not it possible to get cf->data properly aligned?

-- 
					    Gilles.

