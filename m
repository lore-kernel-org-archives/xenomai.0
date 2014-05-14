Message-ID: <53737E1A.8060209@siemens.com>
Date: Wed, 14 May 2014 16:30:50 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <531A29CC.4040201@xenomai.org> <533FF394.1020405@xenomai.org>
 <535A3B92.5070206@siemens.com> <535A4E5F.9060109@xenomai.org>
 <535FC7A8.3060508@siemens.com> <5367F922.6070808@xenomai.org>
 <53686F9C.1020207@siemens.com> <536E4FCD.2080102@xenomai.org>
In-Reply-To: <536E4FCD.2080102@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM rework (2)
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

Hi Gilles,

On 2014-05-10 18:11, Gilles Chanteperdrix wrote:
> Hi Jan,
> 
> I have pushed a new version which addresses your comments in the
> "for-forge-rtdm-rework" branch.
> 
> You can ignore the "whitespace cleanup" commit, it is just there to
> allow me to simply commit without whitespace issues, it will be removed
> later on.
> 
> Note that analogy has not been updated to the API change, I will address
> this later, if you agree with the current version.

Looks good.

Minor note on rtdm_device::open/socket doc: They are running
non-real-time context, and the documentation should mention this clearly
(compare to the regular file ops with their two variants).

I can't look at the implementation, unfortunately.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

