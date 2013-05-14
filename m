Message-ID: <5191EE9E.5030100@xenomai.org>
Date: Tue, 14 May 2013 09:58:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1Etoj5_mKnmQGvSXtdrasx7Fz8niYQCYhPAbaxiKSUg0GgcA@mail.gmail.com>	<5191360D.6070801@xenomai.org>
	<5191EA44.5080307@control.lth.se> <5191ED35.8010904@xenomai.org>
In-Reply-To: <5191ED35.8010904@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timeline for 2.6.2.2?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>, xenomai@xenomai.org

On 05/14/2013 09:52 AM, Gilles Chanteperdrix wrote:

> On 05/14/2013 09:39 AM, Anders Blomdell wrote:
> 
>> On 2013-05-13 20:50, Gilles Chanteperdrix wrote:
>>> On 05/13/2013 05:18 PM, Daniel M. Drucker, Ph.D. wrote:
>>>
>>>> Is there a planned 2.6.2.2? Could there be?
>>>>
>>>> There are a few fixes since 2.6.2.1 we want, and it would ease our release
>>>> process a huge amount if we could use a released version instead of git
>>>> head.
>>>
>>>
>>> 2.6.3 is the next release. A todo list has been published here:
>>> http://www.xenomai.org/pipermail/xenomai/2013-April/028147.html
>> Says:
>>    - x86: 3.5.7 with intel graphic card, try and find the source of high
>>      latencies
>>
>> does this say that 2.6.3 ipipe will be based on 3.5.7? Then I'll have 
>> better to try track down the issue in:
>>
>> http://www.xenomai.org/pipermail/xenomai/2013-March/027963.html
> 
> 
> It will have a patch for 3.8, but the issue has been reported on 3.5.7,
> but can be reproduced on 3.8.
> I thought the issue you quote was solved?


And a Xenomai release is not tied with any particular release of the
I-pipe patch and supposed to support all the past I-pipe releases. There
just so happens that it is better tested with the latests I-pipe patch
it ships with.

-- 
                                                                Gilles.

