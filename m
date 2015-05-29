Message-ID: <55680E2D.20501@free.fr>
Date: Fri, 29 May 2015 08:58:53 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <554B0C27.5010802@free.fr>
 <20150507090719.GC2099@hermes.click-hack.org> <554B651A.9000209@nta-inc.net>
 <55618C06.2040608@xenomai.org>
In-Reply-To: <55618C06.2040608@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] v3 heap mem-pool-size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jeff Webb <jeff.webb@nta-inc.net>, xenomai@xenomai.org

Hi,

I tried git version.

I am able to create heaps in one program. No problem.
but altough, I enabled pshared, I can not bind on these heaps from 
another program.

rt_heap_bind fails with "Resource temporary unavailable."

Regards,
S.Ancelot


On 24/05/2015 10:29, Philippe Gerum wrote:
> On 05/07/2015 03:14 PM, Jeff Webb wrote:
>> On 05/07/2015 04:07 AM, Gilles Chanteperdrix wrote:
>>> On Thu, May 07, 2015 at 08:54:31AM +0200, Stéphane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> Is there a better way to raise mem-pool-size other than specifying in
>>>> cmdline ?
>>>>
>>>>      0"007.389| WARNING: [main] heapobj_init() failed for 470 bytes,
>>>> raise
>>>> --mem-pool-size?
>>> A command line option is nice, it allows you to do basically
>>> anything you want by calling your program from a script. What is it
>>> you want to do that can not be achieved this way?
>>>
>> If we don't want to call our application from a script to set
>> appropriate Xenomai parameters, will supplying the --no-auto-init option
>> to xeno-config allow us to set Xenomai run-time options to the desired
>> values by manually calling copperplate_init() from our application?  Are
>> the options that can be passed to copperplate_init() the ones described
>> here [1]?  Do these options apply to applications based on the POSIX
>> skin as well?  If so, I am slightly confused because the documentation
>> (e.g. [2], [3]) that states that all APIs except POSIX are based on the
>> Copperplate library, so it would seem that Copperplate related stuff
>> would not apply to POSIX applications.  I apologize if this is a silly
>> question, but I am still coming up to speed on the new Xenomai 3
>> architecture.
>>
> There used to be an inconsistency regarding this, because POSIX apps did
> not share the same init sequence internally than non-POSIX ones. This
> has been fixed by recent changes, available from the master branch.
> The new (common) init sequence of all Xenomai applications is described
> in this document: http://xenomai.org/2015/05/application-setup-and-init/
>
> You may be interested in using the tunables:
> http://xenomai.org/2015/05/application-setup-and-init/#Configuration_and_runtime_tunables
>
> I have checked this approach with a large, real world application, which
> looks good so far. Please let me know if that addresses your
> requirements as well. Thanks,
>


