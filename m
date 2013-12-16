Message-ID: <52AF1730.6010200@siemens.com>
Date: Mon, 16 Dec 2013 16:07:28 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52AE0F6D.10007@xenomai.org> <52AE17FC.4070200@xenomai.org>
In-Reply-To: <52AE17FC.4070200@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reworking file descriptors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-12-15 21:58, Gilles Chanteperdrix wrote:
> On 12/15/2013 09:22 PM, Gilles Chanteperdrix wrote:
>>
>> Hi Jan,
>>
>> I have starting reworking the posix skin on forge to use the cobalt
>> registry instead of the ad-hoc registry it currently uses. The next step
>> for that work is to convert the file descriptors, offering a unified
>> access with select to posix skin message queues and rtdm drivers, and
>> working correctly with fork().
>>
>> I have a clear idea on how I would do it for the posix message queues
>> only. Just as I did for the semaphores, I would implement a hash table,
>> where the file descriptor structures are indexed by the user-space file
>> descriptor (obtained with open(/dev/null) for instance, so that xenomai
>> file descriptors follow the posix specification, and use the smallest
>> available descriptor), and the mm structure.
>>
>> However, RTDM allows opening file descriptors in kernel-space, so it
>> would break my implementation, because we can use NULL or &init_mm as
>> the mm key, but what would we use as the file descriptor index?
> 
> Crazy ideas include calling xnregistry_enter and using the returned
> handler as file descriptor in kernel-space, but that would give a
> different way to get the file descriptor structure for kernel-space and
> user-space.

I'm not sure if I got the idea yet: User space would obtain the file
descriptor index itself, via opening /dev/null, and provide this index
together with the open or socket request to the kernel, right? So far we
did the index management inside the RTDM layer, reusing Linux for it
would be the major change.

Then the only difference for kernel originated open is that there is no
Linux-provided source of file descriptor indexes. We will need a
separate one in RTDM, just like so far. The difference will be that this
one, likely again a simple bitmap, will serve in-kernel users only.

Reading your proposal again, I see you mentioning user space file
descriptor structures. Where do they come from? What are their purpose?
We didn't have a need for them so far, why now?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

