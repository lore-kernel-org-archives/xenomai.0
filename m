Subject: Re: Accessing a mutex from different programs
References: <c1062c1f-f95e-8816-3caf-d78290f3bb63@akamina.com>
 <87lfbtjneu.fsf@xenomai.org>
From: Peter Laurich <Peter.Laurich@akamina.com>
Message-ID: <02727691-539d-d59a-faa5-e313a2c04dc7@akamina.com>
Date: Fri, 12 Feb 2021 11:22:13 -0500
MIME-Version: 1.0
In-Reply-To: <87lfbtjneu.fsf@xenomai.org>
Content-Language: en-CA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

That's it. I added the session name and my test programs now can both 
access the same mutex.

Thank you for the quick response. Now on to the next challenge :-)

Peter

On 2/12/2021 10:50 AM, Philippe Gerum wrote:
> Peter Laurich via Xenomai <xenomai@xenomai.org> writes:
>
>> Hello,
>>
>> I am in the process of migrating from Xenomai 2 to 3.1. I have
>> existing code with programs as individual c files where each file has
>> a mainline that then creates a task (rt_task_spawn()). The task spawn
>> part is working fine but I can not seem to access a mutex created in
>> one task from another task. This worked flawlessly in Xenomai 2 but I
>> have something not quite right now.
>>
>> Here are some more details:
>>
>>   - I have two test programs: mutexTest1.c and mutexTest2.c
>>
>>   - the rt_task in mutexTest1.c successfully calls rt_mutex_create()
>> followed by rt_mutex_bind(). A test by calling rt_mutex_acquire()
>> followed by rt_mutex_release() also work so the mutex can be acquired
>> and released within the same program.  This task then goes into a
>> sleep loop.
>>
>>   - I then start mutexTest2 which calls rt_mutex_bind() looking for the
>> named mutex that was created in mutexTest1; the bind has a TM_INFINITE
>> timeout. This call to bind never returns.
>>
>> I have searched extensively for configure options and other
>> postings. I thought --enable-pshared would help but it did not.
> Turning --enable-pshared on when configuring the build is definitely
> required for sharing objects. You then need to have all peer processes
> sharing a common set of objects start with the same session label passed
> to the --session argument.
>
> e.g.
>
> $ ./configure --enable-pshared ...
> $ make install
>
>
> ~# ./foo --session=<shared-session-name>
> ~# ./bar --session=<shared-session-name>
>
> This was not required with Xenomai 2.x because all the sharing was done
> in kernel space where the 'native' API implementation lived back then.
> In that place, we could share everything by design.  The 'native'
> Xenomai 2.x API (now called Alchemy there) has been rewritten as a
> user-space library in Xenomai 3.x. For this reason, objects created by
> distinct processes need to live in a common storage based on TMPFS that
> all peers can share using the shm_open() interface.
>
>> I
>> don't think that --enable-registry will do anything to make this
>> possible but it would allow me to see the mutex object and verify that
>> it was created.
>>
>> The wiki states "Mutexes can be shared by multiple processes which
>> belong to the same Xenomai session." but I can't find a definition of
>> what a Xenomai session is.
>>
>> I am running on an ARM target and the Xenomai test program latency works.
>>
>> Any suggestions would be appreciated.
> The documentation about sessions is quite terse indeed, [1] gives some
> hints when describing the '--session' argument:
>
> "Name of the session the new process will be part of (or create if not
> present). If --enable-pshared was given when configuring the Xenomai
> libraries, this label allows multiple processes giving the same label at
> startup to share objects created by members of the same session."
>
> [1] https://gitlab.denx.de/Xenomai/xenomai/-/wikis/App_Setup_And_Init
>
