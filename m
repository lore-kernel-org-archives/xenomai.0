Message-ID: <5549E1D9.7060607@xenomai.org>
Date: Wed, 06 May 2015 11:41:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
 <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
 <5542299B.30409@xenomai.org>
 <CAMJ=MEcC11C1Th6NjWMH6Ld3NthFvWpcSY+5tZAbk_akc6hS5g@mail.gmail.com>
 <5543AFEB.2070808@xenomai.org>
 <CAMJ=MEdXoC42PyRaKHbukCTVG9YSdqpHj=m4-Qa0jSpybiAVqA@mail.gmail.com>
 <CAMJ=MEcdpq=95YZe9cPe00kFerru+e4yukoNiji3h-HfXZaohQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEcdpq=95YZe9cPe00kFerru+e4yukoNiji3h-HfXZaohQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On 05/05/2015 08:04 AM, Ronny Meeus wrote:
> On Sat, May 2, 2015 at 8:48 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>>> This is a priority inversion issue caused by the handshake mechanism
>>> between the caller of t_delete() and the killed task finalizer. I
>>> eventually reproduced it after I figured out that pinning all tasks on
>>> the same CPU was required to trigger such bug. This patch should help:
>>>
>>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=8431d7149405235fb0aebb53ed32a537ad968c7e
>>>
>>
>> I will try the patch on Monday.
>> (I did run the example on a single core CPU).
>>
>> Thanks for the quick feedback.
> 
> Philippe,
> the patch seems to solve the issue.
> Thanks
> 
> Just for my information, is there somewhere documentation about the
> remote agent?
> 

No documentation so far. Basically it's an internal proxy thread for
carrying out remote POSIX requests that are otherwise restricted to the
local process. This only applies when --enable-pshared is in effect, and
a multi-process application does remote thread control. So far we only
need to proxy pthread_setschedparam() and pthread_cancel().

-- 
Philippe.

