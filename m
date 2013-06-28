Message-ID: <51CDD88C.5000004@xenomai.org>
Date: Fri, 28 Jun 2013 20:40:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>	<51CB231E.8030600@xenomai.org>	<201306271109.22749.leo@alaxarxa.net>
	<51CC031A.9030905@xenomai.org>
	<CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
In-Reply-To: <CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: peter@thesourceworks.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2013 05:35 PM, Peter Soetens wrote:

> On Thu, Jun 27, 2013 at 11:17 AM, Philippe Gerum<rpm@xenomai.org>  wrote:
>> On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:
>>
>>>
>>> AAnd I don't know how to silent (or if is possible) this messages.
>>
>>
>> Try disabling CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX if currently set in your
>> kernel config. If that is still not enough, then you will have to switch off
>> PTHREAD_WARNSW manually, using pthread_set_mode_np(), for each thread which
>> triggers this signal.
>
> Quoting Gilles:
> "The point is that these messages are telling you that there is a bug,
> either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
> could explain such a behaviour), or in orocos code. When the bug is
> fixed the signal will disappear."
>
> We're having one thread ( main() ) which is modeswitching all the time
> since it's doing user IO using the console, filesystem etc.
>
> I didn't consider this as a bug, and we only enable PTHREAD_WARNSW for
> specific threads, where it does matter.


What would be a problem would be to change scheduling policy from 
SCHED_FIFO to SCHED_OTHER in a section protected by a mutex, you would 
then get the signal when releasing the mutex. In this case, when using 
xenomai 2.6.2.1, you would get a SIGDEBUG with reason 
SIGDEBUG_MIGRATE_PRIOINV reason, after 2.6.2.1 you would get a SIGDEBUG 
with reason SIGDEBUG_RESCNT_IMBALANCE.

This is considered as a bug, because if the mutex is shared with other 
threads using SCHED_FIFO policy, switching from SCHED_FIFO to 
SCHED_OTHER would cause the thread holding the mutex to switch to 
secondary mode, and so potentially cause a priority inversion.

But I think we already discussed this a long time ago on this list.

Anyway, a way to know what happens is to print the reason in the signal 
handler.

-- 
                                                                 Gilles.

