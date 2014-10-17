Message-ID: <544145EE.6050702@xenomai.org>
Date: Fri, 17 Oct 2014 18:38:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543E567C.4070800@xenomai.org> <543E72BB.50707@cgglobal.com>
 <20141015200320.GB30661@sisyphus.hd.free.fr> <544144F5.5000802@cgglobal.com>
In-Reply-To: <544144F5.5000802@cgglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alberto.ozalla@cgglobal.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/17/2014 06:33 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> 
> On 15/10/14 22:03, Gilles Chanteperdrix wrote:
>> On Wed, Oct 15, 2014 at 01:12:27PM +0000, ZIV-Alberto Ozalla Cantabrana wrote:
>>> On 15/10/14 13:11, Gilles Chanteperdrix wrote:
>>>> On 10/15/2014 12:59 PM, ZIV-Alberto Ozalla Cantabrana wrote:
>>>>> Dear colleagues,
>>>>>
>>>>> I face an unexpected switch to secondary mode after the very first call to rt_timer_tsc() into a real-time task created by Xenomai.
>>>>> This unexpected switch  only arises if it is the very first call to rt_timer_tsc().
>>>> Hi,
>>>>
>>>> I see two possible reasons for that:
>>>> - either on-demand mapping of library text page
>>>> - or first access to the hardware register.
>>>>
>>>> In order to find which is the reason.
>>>>
>>>> Could you replace the call to rt_timer_tsc() with a call to __xn_rdtsc()
>>>> after including asm/xenomai/tsc.h ?
>>>>
>>>>
>>> Hello,
>>>
>>> Thanks for the fast response.
>>>
>>> Unfortunately replacing the call to rt_timer_tsc() with a call to
>>> __xn_rdtsc() does not solve the problem.
>>>
>>> Another clue is that PF value increases at the same time as MSW.
>>>
>>>
>>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>     0  0      0          11594571   0     00500080   96.3 ROOT/0
>>>     0  1690   1          5339       1     00300184    1.0 Test_Task
>>>
>>> It seems to be a first access to the hardware register.
>>>
>>> Note: I use a call to mlockall(MCL_CURRENT|MCL_FUTURE) before creating
>>> the task.
>>>
>> I just tried on omap3, which is pretty close to beagle bone, and did
>> not observe the same issue. Could you try and add the following code
>> to your test:
>>
>> #include <fcntl.h>
>> #include <sys/mman.h>
>> #include <asm/xenomai/syscall.h>
>>
>> void tsc_init(void)
>> {
>> 	struct __xn_tscinfo tscinfo;
>> 	unsigned long phys_addr;
>> 	unsigned page_size;
>> 	int fd;
>>
>> 	XENOMAI_SYSCALL2(__xn_sys_arch, XENOMAI_SYSARCH_TSCINFO, &tscinfo);
>> 	fd = open("/dev/mem", O_RDONLY | O_SYNC);
>> 	page_size = sysconf(_SC_PAGESIZE);
>> 	phys_addr = (unsigned long) tscinfo.counter;
>> 	tsc_vaddr = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
>> 		    fd, phys_addr & ~(page_size - 1))
>> 		+ (phys_addr & (page_size - 1));
>> 	close(fd);
>>
>> 	rdtsc = (typeof(rdtsc))(0xffff1004 -
>> 				((*(unsigned *)(0xffff0ffc) + 3) << 5));
>> }
>>
>> static inline unsigned long long my_rdtsc(void)
>> {
>> 	return rdtsc(tsc_vaddr);
>> }
>>
>> Call tsc_init at the beginning of your program, then replace the
>> first call to rt_timer_tsc() with a call to my_rdtsc(), and see if
>> you still get the page fault?
>>
> Hi all,
> 
> It works fine.
> There are neither mode switches, nor page faults.
> 
> I will spend the weekend thinking about it.
> 
> Thanks a lot, Gilles.
> 
It is exactly the same thing as what libxenomai does, the only
difference being that libxenomai may be mapped on demand, but this is
doubtful since libxenomai initializations are done before main runs, so
it should have been mapped already. Are you sure the kernel you are
running still has the issue when using rt_timer_tsc()?

-- 
                                                                Gilles.

