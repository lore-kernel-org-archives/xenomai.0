Message-ID: <5234791E.6090708@xenomai.org>
Date: Sat, 14 Sep 2013 16:56:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEk6gTAZDO7=gKRtBCaSRDMoEAD5ad6_Q7XFx3XoFY0q2OvFhg@mail.gmail.com>
	<52347663.90705@xenomai.org>
	<CAEk6gTAKZBaueJfNL5ikkjJbQDRXifUHfi8tSNKDMQxwMxWq_A@mail.gmail.com>
	<5234786C.3070301@xenomai.org>
In-Reply-To: <5234786C.3070301@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM patch for 3.10 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: xenomai@xenomai.org

On 09/14/2013 04:53 PM, Gilles Chanteperdrix wrote:
> On 09/14/2013 04:50 PM, Drasko DRASKOVIC wrote:
>> On Sat, Sep 14, 2013 at 4:44 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> The I-pipe patch for Linux 3.10 for the ARM and x86 architectures is
>>> already running but not finalized. However, Xenomai 2.6.3 will be
>>> released without this patch, but is "3.10 ready" so that we will not
>>> need another Xenomai release when the patch for 3.10 is finalized.
>>
>> This is great news!
>>
>> I saw that 2.6.2 was not even "3.8 ready", as I had trouble compiling
>> kerenl with adeos patch, so it is advised to switch to xenomai-head.
>>
>> Great to know that stable Xenomai can be used with 3.10LTSI kernel version.
>>
>> Where can this 3.10 patch be found? I'd like to start testing already
>> on my set-up with 3.10 kernel and xenomai-head.
> 
> git://git.xenomai.org/ipipe-gch.git branch for-ipipe-3.10
> 
> This git is not the official repository, but my working space, so
> branches may be rebased from time to time without no warning,
> ultimately, the official repository is always
> 
> git://git.xenomai.org/ipipe.git
> 

You can use ipipe.git branch "ipipe-next" as well, it is even more up to
date than my repository.

-- 
                                                                Gilles.

