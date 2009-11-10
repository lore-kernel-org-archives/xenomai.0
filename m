Message-ID: <4AF964C2.3060206@domain.hid>
Date: Tue, 10 Nov 2009 14:04:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AF87D53.9090102@domain.hid> <4AF947FA.4030908@domain.hid>
	<4AF9571F.7090500@domain.hid>
In-Reply-To: <4AF9571F.7090500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] heap reference and trivial build
 fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> The following changes since commit 6d7d6bc436ef3d1fb51fa8de06d4ecf004e3b6a5:
>>>   Gilles Chanteperdrix (1):
>>>         nucleus: defer selector block deletion to an APC.
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>>
>>> Jan Kiszka (2):
>>>       nucleus: Track heap mapping on to mm-clone
>>>       nucleus: Fix trivial build warning
>>>
>>>  ksrc/nucleus/heap.c   |   12 +++++++++++-
>>>  ksrc/nucleus/module.c |    2 +-
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> Hi Jan,
>>
>> do you agree if I add the notification to the xenomai-git mailing list
>> for your tree? It makes it possible to review your patches without any
>> action on your side. Note that a recent modification to the notification
>> mechanism only shows the relevant patches.
>>
> 
> No problem. Ah, the new filter looks nice!
> 
> And how would my new workflow look like? Just silently push into
> 'for-upstream'?

Well, it does not work for me, because I always realize that I screwed
up AFTER I push the changes. Besides, we may push things only for
review, so, I would keep the pull requests and the discussions on the
list, only avoid publishing the patches manually on the list. But this
is open for discussion of course.

-- 
                                          Gilles


