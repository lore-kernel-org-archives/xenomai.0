Subject: Re: A potential Xenomai Mutex issue
References: <DM6PR07MB596162CF3DD4EB4071336D26E7A50@DM6PR07MB5961.namprd07.prod.outlook.com>
 <43f9470f-ed47-0a2a-71f5-ca9bca08879a@siemens.com>
 <DM6PR07MB59614BFAE90AE8DA6B49769EE7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <2f51ad42-4be3-606d-dbdf-ee036bd562de@siemens.com>
 <DM6PR07MB59610EC30F9B7433FBD53E35E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d3ed1327-3026-6489-a66b-56f9680f08d2@siemens.com>
Date: Fri, 23 Aug 2019 17:23:20 +0200
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB59610EC30F9B7433FBD53E35E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "DIAO, Hanson (DI PA CI RC R&D SW2)" <hanson.diao@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.08.19 16:29, DIAO, Hanson (DI PA CI RC R&D SW2) wrote:
> Hi Jan,
> 
> I attached my code here. This is only Lock function. Unlock function is similar.
> 
> 
>          printf("Before Mutex Lock Mutext addr = %p,count = %d, owner = %x\n",
>                  mpMutex,
>                  mpMutex->lockcnt,
>                  xnarch_atomic_get(mpMutex->fastlock));
>          int err = rt_mutex_acquire( mpMutex, (RTIME)TM_INFINITE );
>          if ( err &&
>                   // During boot-up and shutdown we run single-threaded
>                   // so there is no need to lock an semaphore.
>                   !(rc_system_state() != SYSTEM_RUNNING && err == -EPERM) )
>          {
>                  rc_xeno_log( LOG_ERROR , "rt_mutex_acquire" , err);
>          }
>          printf("After Mutex Lock Mutext addr = %p,count = %d, owner = %x\n",
>                  mpMutex,
>                  mpMutex->lockcnt,
>                  xnarch_atomic_get(mpMutex->fastlock));

OK, now I understand the relation between "count" and "lockcnt". Thanks.

Again, for the deadlock case, can you reproduce it with synthetic patterns and 
share them?

> 
> 
> For the issue 2 the test case is very simple. The lock sequence is as below. After ReadReg function I checked the lockcnt. The lockcnt is 1.
> Int writeReg()
> {
>       SMILock();
>       ReadReg();

So you are reading lockcnt here? Then 1 is obviously the expected value. Is 
owner (fastlock) 0 here?

>       ......
>       SMIUnlock();
> }
> 
> Int ReadReg()
> {
>       SMILock();

If you read it here, it should be 2 in a recursive case.

Jan

>       ........
>       ......
>       SMIUnlock();
> }
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

