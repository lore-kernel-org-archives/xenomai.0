Message-ID: <5131DC27.80909@xenomai.org>
Date: Sat, 02 Mar 2013 12:01:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>	<5130E0C7.80709@siemens.com>
	<5130E6FE.2070905@siemens.com>	<1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
	<5131B5A2.6000501@web.de>
In-Reply-To: <5131B5A2.6000501@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
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

On 03/02/2013 09:17 AM, Jan Kiszka wrote:

> On 2013-03-02 01:47, Gabriele Moabiti wrote:
>>
>>
>> ----- Messaggio originale -----
>>
>> Da: Jan Kiszka <jan.kiszka@siemens.com>
>> On 2013-03-01 18:09, Jan Kiszka wrote:
>>> There is more broken, even in latest stable 3.5.7. See the patches at
>>> [1] for a tested version. Unfortunately, I cannot update my tree for 3.8
>>> ATM as git services seem to be down on xenomai.org.
>>
>> Does this and other important patches will be backported to 3.2?
> 
> I'm planning to get them merged into 3.8 first of all, maybe also into
> 3.5 (as this is our current production baseline). No plans exist beyond
> that. I'd rather like to leave older kernels alone to reduce maintenance
> efforts (porting is simple, proper testing takes time).
> 
> Also note that 3.2 is lacking much more critical fixes than those few
> around KVM. IOW: Don't use it for anything serious with x86.


Maybe reverting the mprotect/ipipe_pin_vma patches in the 3.2 branch, so
as to avoid the zero page corruption, but take some faults sometimes
would be a simple, feasible solution? 3.2 seems to have been chosen as a
long term stable branch.

-- 
                                                                Gilles.

