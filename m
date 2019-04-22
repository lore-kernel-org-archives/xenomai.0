Subject: Re: irqchip tps65217 is not pipeline-safe!
References: <AM0PR07MB5572FDFC8BB9278EC530F1DCB5590@AM0PR07MB5572.eurprd07.prod.outlook.com>
 <91222f7d-c3c3-848d-f304-e97c4ff4f9d6@xenomai.org>
 <CALLqZ8RXX=zLZ5Dn2paJ4ZGgxaf+H7EYtErX3CrOZofJWQJiXg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2665f814-0cff-5162-b945-a2ef4b2cf633@xenomai.org>
Date: Mon, 22 Apr 2019 16:52:41 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RXX=zLZ5Dn2paJ4ZGgxaf+H7EYtErX3CrOZofJWQJiXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 4/22/19 4:49 PM, Greg Gallagher wrote:
> On Fri, Mar 29, 2019 at 6:37 AM Philippe Gerum via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> On 3/28/19 8:51 PM, Giulio Moro via Xenomai wrote:
>>> Hi there,
>>> booting a 4.14.94-ti kernel with Cobalt 3.0.8 from the "stable/v3.0.x" branch, on an am3358 (PocketBeagle) I get a warning during boot "irqchip tps65217 is not pipeline-safe!". The tps65217 is the power-management IC for the board. What does this message mean exactly? Is it something to be concerned about? The board has behaved fine when running Xenomai tasks, in spite of this issue.
>>
>> Nevertheless, this is unreliable. This warning is issued because the
>> irqchip code handling the tps65217 mfd which is enabled on your platform
>> was not tagged as supporting IRQ pipelining (IRQCHIP_PIPELINE_SAFE not
>> present in the flags). At the very least, this means that nobody cared
>> checking for this.
>>
>> This matter is documented in Documentation/ipipe.rst.
>>
>> --
>> Philippe.
>>
> 
> Hi,
>   I have a fix for this in my private ipipe tree, finishing testing
> tonight. Phillipe are those trees open to the public or should I send
> a patch to the list?
> 

Your tree on lab.xenomai.org is public, I'm fine with pulling patches
directly from there upon request.

-- 
Philippe.

