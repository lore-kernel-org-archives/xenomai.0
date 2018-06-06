References: <035ed079-cdbb-c39f-d3c6-2a0f46f59361@xenomai.org>
 <8802987.z5JkY3iLTf@wirbelwind>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1ca187a6-d96b-5a66-2237-5c9fcb5dbe4d@xenomai.org>
Date: Wed, 6 Jun 2018 17:41:33 +0200
MIME-Version: 1.0
In-Reply-To: <8802987.z5JkY3iLTf@wirbelwind>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Introducing Dovetail
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steven.seeger@nasa.gov
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Hi Steven,

On 06/05/2018 03:33 PM, Steven Seeger wrote:
> On Tuesday, June 5, 2018 6:48:23 AM EDT Philippe Gerum wrote:
>> This is a heads-up about an ongoing work I hinted at last year [1]
>> codenamed "Dovetail", which has just reached a significant milestone. In
>>  short, an overhauled implementation of the interrupt pipeline is now
>> capable of delivering short response times reliably on the ARM SoCs I'm
>> working on (mainly i.MX(6q|7d) so far), running the recent 4.17 kernel
>> release.
> 
> <snip>
> 
> Hi Philippe.
> 
> Looks like there is just one branch here. Assuming this is the future, is the 
> goal here to have a generic branch and arch-specific branches again?
> 

I don't know yet. So far, dovetail has been remarkably easy to forward
port to newer kernel releases here (4.8 was the first target release),
which used to be hardly the case for the I-pipe. So maybe that split
won't make much sense in the future hopefully, assuming that anyone
porting the architecture bits would likely be able to quickly port the
generic portion in the same move.

If so, there might be a master tree again, with people downstream
rebasing over it for their own business, sending patches upstream as
they see fit to reduce the size of their custom commit stack.

-- 
Philippe.

