Message-ID: <5474E85A.4040008@siemens.com>
Date: Tue, 25 Nov 2014 21:36:42 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5474DB89.2070401@siemens.com> <5474E8A5.4060507@xenomai.org>
In-Reply-To: <5474E8A5.4060507@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __cobalt_thread_create: cleanup after failing
	cobalt_map_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2014-11-25 21:37, Philippe Gerum wrote:
> On 11/25/2014 08:42 PM, Jan Kiszka wrote:
>> Hi,
>>
>> I ran into an oops (bt below) when (for yet unknown reasons)
>> cobalt_map_user fails. The reason is that we then call xnthread_cancel,
>> but on a thread that has no user space task assigned yet.
>>
> 
> Ack, it's terminally broken.
> 
>> Which functions rolls only pthread_create back?
>>
> 
> None, we need one which specifically applies to a dormant, unmapped thread. The existing code assumes a mapped thread.
> 
>> The issue should apply to cobalt_thread_shadow as well.
>>
> 
> Correct. In theory, this patch should fix it. In practice, it's untested code in all its glory:

Wish I could still test, but I happened to have found the trigger of
that issue - an inconsistent kernel build - and destroyed it along the way.

Will check tomorrow via an artificial failure of cobalt_map_user.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

