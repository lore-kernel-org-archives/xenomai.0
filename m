Message-ID: <525A86D2.8090007@xenomai.org>
Date: Sun, 13 Oct 2013 13:41:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5257A979.7080208@siemens.com> <525A7127.3050101@xenomai.org>
	<525A8012.8020703@web.de>
In-Reply-To: <525A8012.8020703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] forge: Cleanup COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 10/13/2013 01:12 PM, Jan Kiszka wrote:
> On 2013-10-13 12:08, Philippe Gerum wrote:
>> On 10/11/2013 09:32 AM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> The following changes since commit
>>> 926e0441446aae116bf5b0701753e4b87a5386a2:
>>>
>>>    doc: update installation guidelines (2013-10-04 15:46:23 +0200)
>>>
>>> are available in the git repository at:
>>>
>>>    git://git.xenomai.org/xenomai-jki.git for-forge
>>>
>>> for you to fetch changes up to f1559e40a39b1a54e0348732402a68eb0dfef0a4:
>>>
>>>    Rename include and lib copying files (2013-10-10 15:15:56 +0200)
>>>
>>> If you do not like COPYING.* renaming, just skip the second patch. The
>>> first on is important as we currently have code that is formally under
>>> no COPYING file.
>>>
>>
>> Thanks for the heads up. However, I disagree with both patches. GPL has
>> never been our default license.
> 
> Where did we ever intentionally diverge from the pattern that everything
> is GPL except those bits that need to be linked to or #included by
> third-party programs? I strongly believe that this is a very reasonable
> pattern, so I don't understand your disagreement here. And see below
> what damage a missing default license can cause.

I am sorry to feed the troll. But what is the point of making test code
GPL? Who cares what the users do with it? Not me anyway. I'd rather be
happy to have users cut and paste test code in their application code.

-- 
                                                                Gilles.

