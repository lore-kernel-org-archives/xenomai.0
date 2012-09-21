Message-ID: <505C4388.5070100@xenomai.org>
Date: Fri, 21 Sep 2012 12:38:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50587BCE.9000402@hs-harz.de> <50587D7B.3060507@xenomai.org>
	<505882F9.90703@hs-harz.de> <5058C094.9060106@xenomai.org>
	<969688a82a4682b9.505c415d@hs-harz.de>
In-Reply-To: <969688a82a4682b9.505c415d@hs-harz.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] native skin example with rt_pipe_monitor() ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Wisse <mwisse@hs-harz.de>
Cc: xenomai@xenomai.org

On 09/21/2012 10:28 AM, Michael Wisse wrote:
> Are there plans to remove the rt_pipe API in near future ?

Kernel-space support for this API (rt_pipe_monitor belongs there) has
been dropped in the upcoming Xenomai 3.x, only userland calls will be
supported as wrappers to the RTIPC/xddp services.

The original API will fully remain in 2.6.x though.

> 
> Michael
> 
> ----- Original Message -----
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Date: Tuesday, September 18, 2012 8:42 pm
> Subject: Re: [Xenomai] native skin example with rt_pipe_monitor() ?
> To: Michael Wisse <mwisse@hs-harz.de>
> Cc: xenomai@xenomai.org
> 
> 
>> On 09/18/2012 04:19 PM, Michael Wisse wrote:
>>
>>> Thanks for the link to the API documentation, but I'm looking for an 
>>
>>
>>> example.
>>
>> The rt_pipe API is deprecated. Non deprecated APIs such as XDDP sockets
>> have examples, see:
>> examples/rtdm/profiles/ipc/xddp-*
>>
>> -- 
>>                                                                 Gilles.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

