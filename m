Message-ID: <54D4DF0C.2080007@control.lth.se>
Date: Fri, 06 Feb 2015 16:34:36 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <54D4D409.2020708@control.lth.se> <54D4D9B2.8090805@xenomai.org>
In-Reply-To: <54D4D9B2.8090805@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mixing linux and alchemy (cobalt) calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2015-02-06 16:11, Philippe Gerum wrote:
> On 02/06/2015 03:47 PM, Anders Blomdell wrote:
>> I have an application that need both realtime and linux sockets, am I correct in assuming that
>> withe the alchemy skin I could access them like
>>
>>   socket(...           // Linux version
>>   __real_socket(...    // Linux version
>>   __cobalt_socket(...  // Alchemy/cobalt version
>>
>> while under the cobalt skin, it would be:
>>
>>   socket(...           // Alchemy/cobalt version
>>   __real_socket(...    // Linux version
>>   __cobalt_socket(...  // Alchemy/cobalt version
>>
> 
> This depends on the LDFLAGS retrieved from xeno-config:
> 
> 1. with --posix mentioned in the xeno-config --ldflags request
> 
> 	socket(...), __cobalt_socket(...) or __RT(socket(...))  => Cobalt
> implementation
> 	__real_socket(...) or __STD(socket(...)) => glibc service
> 
> 2. without --posix mentioned in the xeno-config --ldflags request
> 
> 	__cobalt_socket(...) or __RT(socket(...))  => Cobalt implementation
> 	socket(...) or __STD(socket(...)) => glibc service
> 
> e.g.
> 
> - the application only wants to access the POSIX services implemented by
> Cobalt using the regular POSIX names: LDFLAGS should contain the output of:
> $ xeno-config --posix --ldflags, or --cobalt --ldflags.
> 
> - the application wants to access the POSIX services implemented by
> Cobalt using the regular POSIX names, and the alchemy API: LDFLAGS
> should contain the output of:
> $ xeno-config --posix --alchemy --ldflags, or --cobalt --alchemy --ldflags.
> 
> - the application wants to access the POSIX services implemented by
> Cobalt solely via the explicit POSIX wrappers, and the alchemy API:
> LDFLAGS should contain the output of (i.e. omitting --posix):
> $ xeno-config --alchemy --ldflags, or --alchemy --ldflags.
> 
> NOTE: using __RT() is preferred to calling __cobalt(), in case an API
> stacked over the Cobalt POSIX API redefines its own implementation of
> POSIX services over the dual kernel. __RT() would call the stacked
> implementation, __cobalt() would force a call to the Cobalt
> implementation of the service.
> 
Thanks for the clarification, will sprinkle the code with __STD(...) 
and __RT(...), from here on :-).

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


