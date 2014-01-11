Message-ID: <52D18D0A.8010905@xenomai.org>
Date: Sat, 11 Jan 2014 19:27:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
 <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
 <52D18B7D.5080705@xenomai.org>
In-Reply-To: <52D18B7D.5080705@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-pipe tracer on in production kernels? (was Re:
 Altera Cyclone V)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/11/2014 07:20 PM, Philippe Gerum wrote:
> On 01/11/2014 11:22 AM, Michael Haberler wrote:
>>
>> http://www.xenomai.org/index.php/I-pipe:Tracer describes the trace API, which could be useful to track down issues
>>
>> Q: does enabling the tracer incur significant overhead if compiled in but unused, or is it reasonable to leave it on in a production kernel?
>>
>> if the former, we might have to build/make available a second i-pipe tracer enabled kernel to track down issues 'in the field'; if the latter, it'd be less build/distribution chores
>>
> 
> The I-pipe tracer is based on the ftrace infrastructure, so tracepoints 
> are left out when the tracer is disabled. If you can live with the 
> minimal overhead ftrace adds, then leaving the I-pipe tracer code built 
> in may be an option.

That is less true without DYNAMIC_FTRACE than with DYNAMIC_FTRACE.


-- 
                                                                Gilles.

