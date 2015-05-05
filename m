MIME-Version: 1.0
In-Reply-To: <CAMJ=MEdXoC42PyRaKHbukCTVG9YSdqpHj=m4-Qa0jSpybiAVqA@mail.gmail.com>
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
 <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
 <5542299B.30409@xenomai.org>
 <CAMJ=MEcC11C1Th6NjWMH6Ld3NthFvWpcSY+5tZAbk_akc6hS5g@mail.gmail.com>
 <5543AFEB.2070808@xenomai.org>
 <CAMJ=MEdXoC42PyRaKHbukCTVG9YSdqpHj=m4-Qa0jSpybiAVqA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 5 May 2015 08:04:20 +0200
Message-ID: <CAMJ=MEcdpq=95YZe9cPe00kFerru+e4yukoNiji3h-HfXZaohQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On Sat, May 2, 2015 at 8:48 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>> This is a priority inversion issue caused by the handshake mechanism
>> between the caller of t_delete() and the killed task finalizer. I
>> eventually reproduced it after I figured out that pinning all tasks on
>> the same CPU was required to trigger such bug. This patch should help:
>>
>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=8431d7149405235fb0aebb53ed32a537ad968c7e
>>
>
> I will try the patch on Monday.
> (I did run the example on a single core CPU).
>
> Thanks for the quick feedback.

Philippe,
the patch seems to solve the issue.
Thanks

Just for my information, is there somewhere documentation about the
remote agent?

Ronny

