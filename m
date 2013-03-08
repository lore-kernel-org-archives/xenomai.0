MIME-Version: 1.0
In-Reply-To: <5139FE6C.7030407@xenomai.org>
References: <CAMJ=MEdBofo5+uaFiTLpEE6mHaFhEit=Ae=i=05wu0+fydo2=g@mail.gmail.com>
	<5139FDB3.5010207@xenomai.org> <5139FE6C.7030407@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 8 Mar 2013 17:00:50 +0100
Message-ID: <CAMJ=MEf7YFOA=WdxQGBVasJFuJajOYHN3zeSboZLx71Xc=sPpw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai-forge: Interface change of copperplate_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Mar 8, 2013 at 4:06 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/08/2013 04:03 PM, Philippe Gerum wrote:
>>
>> On 03/08/2013 03:16 PM, Ronny Meeus wrote:
>>>
>>> Hello
>>>
>>> I see that the interface of copperplate_init has been changed from:
>>>
>>> void copperplate_init(int argc, char *const argv[]);
>>> to
>>> void copperplate_init(int *argcp, char *const **argvp);
>>>
>>> This is disturbing if I have an application that needs to be run on
>>> the 2 versions of xenomai.
>>> Is there any construction (for example a define) I can use in my code
>>> to call this function in a correct way?
>>>
>>
>> Nope, and don't expect any. The -forge interface is still in a state of
>> flux, albeit dust has settled a lot since it was all started. There
>> won't be any effort toward backward compat until 3.x is officially out.
>> No ETA.
>>
>>
>
> If you happen to use autoconf, then you could run AC_TRY_COMPILE to figure
> out which syntax is the right one, and define a config symbol you could test
> in your code accordingly.
>
> --
> Philippe.

OK, thanks.

Ronny

