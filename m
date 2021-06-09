Subject: Re: [PATCH] cobalt/thread: get rid of dynamic allocation for
 xnthread_signal
References: <20210608070436.1198-1-hongzhan.chen@intel.com>
 <768ca079-fefa-e11c-2271-7c5340be69c1@siemens.com>
 <BN9PR11MB522722EBB828C6991F269E9FF2369@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e5a87b95-3279-9bef-3051-460c4fbf8174@siemens.com>
Date: Wed, 9 Jun 2021 07:36:49 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB522722EBB828C6991F269E9FF2369@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09.06.21 07:10, Chen, Hongzhan wrote:
> 
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Tuesday, June 8, 2021 4:28 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH] cobalt/thread: get rid of dynamic allocation for xnthread_signal
>>
>> On 08.06.21 09:04, Hongzhan Chen via Xenomai wrote:
>>> Add one or more "signal slots" per possible cause of in-band signal
>>> into struct xnthread to get rid of dynamic allocation.
>>>
>>> For SIGDEBUG, except SIGDEBUG_WATCHDOG all other SIGDEBUG_* cause
>>> including SIGDEBUG_MIGRATE_SIGNAL, SIGDEBUG_MIGRATE_SYSCALL,
>>> SIGDEBUG_MIGRATE_FAULT, SIGDEBUG_MIGRATE_PRIOINV, SIGDEBUG_NOMLOCK,
>>> SIGDEBUG_RESCNT_IMBALANCE, SIGDEBUG_LOCK_BREAK, SIGDEBUG_MUTEX_SLEEP
>>> are synchronous and mutually exclusive due to the oob->in-band transition.
>>> But SIGDEBUG_WATCHDOG is triggered asynchronously by the oob timer.
>>>
>>> All SIGSHADOW_* events need their own slot: SIGSHADOW_ACTION_HARDEN and
>>> SIGSHADOW_ACTION_HOME can be raised by remote threads asynchronously to
>>> the target thread. SIGSHADOW_ACTION_BACKTRACE comes in addition to
>>> SIGDEBUG_MIGRATE_*. For the latter reason, SIGSHADOW_ACTION_BACKTRACE
>>> cannot pile up though.
>>>
>>> Including SIGTERM, we have totally 6 slots.
>>>
>>
>> Please rebase on top of next, rather than wip/dovetail. It will replace
>> the related patch in wip/dovetail.
> 
> Actually , the patch is based on https://lab.xenomai.org/xenomai-rpm.git/log/?h=for-upstream/dovetail.
> There is still several patches that current patch is depending on have not been merged into next.
> Do we need to merge into for-upstream/dovetail at first or I should create new patch for next that I should work on?
> Please suggest.

Base on next. This patch has no dependencies on wip/dovetail. It
replaces a patch from the bottom of that branch. And it can be tested
over, eg., 5.4.y-ipipe as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

