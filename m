Message-ID: <4946715C.9080709@domain.hid>
Date: Mon, 15 Dec 2008 15:01:48 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081215143435.15493.94798.stgit@domain.hid>
	<20081215143436.15493.65646.stgit@domain.hid>
	<49466DBF.9030403@domain.hid> <49466EA0.3070108@domain.hid>
In-Reply-To: <49466EA0.3070108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 3/6] POSIX: Optimize
 pthread_setschedparam fast path
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Optimize __wrap_pthread_setschedparam without HAVE___THREAD for the case
>>> that an already mapped shadow is modifying its own scheduling
>>> parameters.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>> ---
>>>
>>>  src/skins/posix/thread.c |    3 +--
>>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
>>> index 2ecb64f..d2839c6 100644
>>> --- a/src/skins/posix/thread.c
>>> +++ b/src/skins/posix/thread.c
>>> @@ -37,11 +37,10 @@ static int linuxthreads;
>>>  int __wrap_pthread_setschedparam(pthread_t thread,
>>>  				 int policy, const struct sched_param *param)
>>>  {
>>> -	pthread_t myself = pthread_self();
>>>  	unsigned long *mode_buf = NULL;
>>>  	int err, promoted;
>>>  
>>> -	if (thread == myself) {
>>> +	if (xeno_current != XN_NO_HANDLE && thread == pthread_self()) {
>> I was under the impression that xeno_current was only correct with
>> HAVE__THREAD. Otherwise, I guess we should use xeno_get_current(), no?
>>
> 
> Of course.
> 
> ------->
> 
> Optimize __wrap_pthread_setschedparam without HAVE___THREAD for the case
> that an already mapped shadow is modifying its own scheduling
> parameters.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  src/skins/posix/thread.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
> index 2ecb64f..46c49bf 100644
> --- a/src/skins/posix/thread.c
> +++ b/src/skins/posix/thread.c
> @@ -37,11 +37,10 @@ static int linuxthreads;
>  int __wrap_pthread_setschedparam(pthread_t thread,
>  				 int policy, const struct sched_param *param)
>  {
> -	pthread_t myself = pthread_self();
>  	unsigned long *mode_buf = NULL;
>  	int err, promoted;
>  
> -	if (thread == myself) {
> +	if (xeno_get_current() != XN_NO_HANDLE && thread == pthread_self()) {

Should not this be xeno_get_current() == XN_NO_HANDLE ? The thread has a
chance to be promoted only if it is not already shadowed.

-- 
                                                 Gilles.

