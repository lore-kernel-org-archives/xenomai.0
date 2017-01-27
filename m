References: <b9af993a-5dcd-396f-e6c0-31a13efeb909@numalliance.com>
 <dc106047074e4f73b89c1b3a7a3b7069@EDB3.wapice.localdomain>
 <85f10308-7c52-d242-5704-0a374ff57007@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <acc00b7d-2b15-dcdf-ff39-0f492f41a62e@xenomai.org>
Date: Fri, 27 Jan 2017 09:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <85f10308-7c52-d242-5704-0a374ff57007@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] shared heap access mixing 32 and 64 bits applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, =?UTF-8?Q?Lassi_Niemist=c3=b6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/27/2017 08:54 AM, Stéphane Ancelot wrote:
> 
> 
> Le 26/01/2017 à 11:12, Lassi Niemistö a écrit :
>>> Is it possible to access same shared memory heaps , between 32 and 64
>>> bits processes ?
>> In regular linux I faced the wall when trying to protect the usage of
>> the shared memory area by (pthread iirc) mutex/semaphore - those
>> structures had differences between 32/64bit platforms. I don't know if
>> situation is same in Xenomai but pay attention also to what you are
>> going to put in the shared memory.
>>
>> -Lassi
> 
> I have now the answer regarding xenomai shared heaps between 32 and 64 
> bits processes , here is the status, if you use the latest next xenomai
> branch.
> within a system running 64 bits xenomai kernel, you can :
> * use shared heap areas with 32 bits xenomai processes
> * use shared heap areas with 64 bits xenomai processes
> * you can not use shared heap areas between 32 and 64 bits xenomai
> processes.
> Each area (32/64) are insulated, this incompatibility issue comes mainly
> from usage of size_t type in the xenomai  heap library which are
> different between 32 and 64 bits systems.
> and maybe more other reasons ...
> 
> So, this is good to know that incompatibility , you can not mix both
> kind of processes in xenomai.


There is absolutely no provision for sharing Xenomai sessions in general
between 32/64 bit applications, and there won't be any, ever. Mixed ABI
support relates to invoking 64bit kernel services from a 32bit
application, nothing beyond that.

-- 
Philippe.

