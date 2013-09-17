Message-ID: <52389DD2.7030708@xenomai.org>
Date: Tue, 17 Sep 2013 20:22:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<201305232352.24308.paul_c@tuxcnc.org>
	<522F68FD.9070009@xenomai.org>
	<201309171626.08100.paul_c@tuxcnc.org>
In-Reply-To: <201309171626.08100.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Next Xenomai Release?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On 09/17/2013 05:26 PM, Paul wrote:
> On Tuesday 10 September 2013, Gilles Chanteperdrix wrote:
>> I have at last pushed the final version of the I-pipe patch for Linux
>> 3.8.13, it is available both in the xenomai git as a patch and in the
>> I-pipe git.
>>
>> Could you rebase the pre- and post- patches for Raspberry so that I
>> can put them in the Xenomai sources too?
> 
> Attached, two patches. Instructions for use:
> 
> 1) Checkout kernel sources from git://github.com/raspberrypi/linux.git 
> and use the rpi-3.8.y branch - d996a1b is the SHA-1 hash used, but 
> later revisions should work.
> 2) Apply ipipe-core-3.8.13-raspberry-pre.patch
> 3) Apply ipipe-core-3.8.13-arm patch
> 4) Apply ipipe-core-3.8.13-raspberry-post.patch
> 
> 
> Regards, Paul.
> 

Merged, thanks.


-- 
                                                                Gilles.

