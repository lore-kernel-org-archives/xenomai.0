Message-ID: <5172B0E5.7090806@xenomai.org>
Date: Sat, 20 Apr 2013 17:14:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>	<517195B6.8020209@xenomai.org>	<12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
	<51724F82.2000809@web.de>
In-Reply-To: <51724F82.2000809@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/20/2013 10:19 AM, Jan Kiszka wrote:

> On 2013-04-20 08:04, Michael Haberler wrote:
>>
>> Am 19.04.2013 um 21:06 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>
>>> On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:
>>>
>>>> [1] 
>>>> http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-April/006986.html
>>>
>>>
>>> Hi,
>>>
>>> that link does not tell us why you need this option. And that would be
>>> the most important information.
>>
>> with the linuxcnc package build I need to turn on --enable-dlopen-skins as well to get Python modules to work properly
> 
> OK, it looks like we should try harder to detect dlopen scenarios during
> runtime to avoid build-time switches. This is likely Xenomai 3 material:
> 
>  - We need to disable TLS optimizations by default (no big deal).
> 
>  - In the POSIX skin constructor, we need to read out the mlockall
>    state, lock everything if necessary, and restore the state
>    accordingly afterward. The Nucleus may help us here if there is no
>    adequate libc service (ABI change -> Xenomai 3).
> 
>  - IIRC, the problem with unconditional auto-shadowing back then were
>    the improper scheduling parameters that POSIX used to apply. That
>    was fixed a while back. So if we simple re-apply the current
>    parameters, it should cause no harm in a dlopen scenario. But I need
>    to check this again at work against our scenario.


You do not like the idea of an environment variable allowing to disable
the automatic shadowing?

-- 
                                                                Gilles.

