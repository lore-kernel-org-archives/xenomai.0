Message-ID: <5457E311.6000706@xenomai.org>
Date: Mon, 03 Nov 2014 21:18:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann> <20141031200007.GC378@sumost.ca>
 <5454ADDF.4040604@xenomai.org> <6071747.2uXMl1ZSO0@riemann>
 <54573A6D.1030201@xenomai.org> <20141103155947.GA15262@sumost.ca>
 <5457AD81.7090200@xenomai.org> <20141103183747.GB15262@sumost.ca>
 <5457DF1C.4060209@xenomai.org> <20141103200314.GE18422@sisyphus.hd.free.fr>
In-Reply-To: <20141103200314.GE18422@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

On 11/03/2014 09:03 PM, Gilles Chanteperdrix wrote:
> On Mon, Nov 03, 2014 at 09:01:32PM +0100, Philippe Gerum wrote:
>> On 11/03/2014 07:37 PM, Steve M. Robbins wrote:
>>> On Mon, Nov 03, 2014 at 05:29:53PM +0100, Philippe Gerum wrote:
>>>
>>>> Just to make sure we are on the same page, as Dietmar mentioned in an
>>>> earlier mail, read() as implemented by the rt-pipe driver only returns
>>>> _one_ message at a time, although > 1 could be pending. One has to
>>>> iterate over a read() loop using a non-blocking fd on the /dev/rtp
>>>> device to get them all.
>>>
>>> Aha!  Thanks (and to Dietmar).  I completely missed this fact.  I'll
>>> go re-write the read as a loop and see if it works better.  I should read
>>> until the read() returns 0 (bytes read)?
>>>
>>
>> Until you get -1 with errno == EWOULDBLOCK. Zero would rather mean that
>> the other end of pipe has been disconnected, just like with a regular FIFO.
>>
> 
> Just a stupid question: should not calling select then read make as
> long as there are some messages to read?
> 

That would be the normal option, but Steve observes issues with this
pattern, we are trying to find out whether a loss of event notification
might be at work in the poll() handler basically. I still can't see it
reading the code though, but we cannot rule out any option at this stage.

-- 
Philippe.

