Message-ID: <522F68FD.9070009@xenomai.org>
Date: Tue, 10 Sep 2013 20:46:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<519E677F.9050001@xenomai.org>
	<201305232352.24308.paul_c@tuxcnc.org>
In-Reply-To: <201305232352.24308.paul_c@tuxcnc.org>
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

On 05/24/2013 12:52 AM, Paul wrote:
> On Thursday 23 May 2013, Gilles Chanteperdrix wrote:
>> On 05/23/2013 05:57 PM, Poole Jr, Donald R. wrote:
>>> I guess I overlooked that post and response. Any clarifying
>>> words/steps on what needs to be done to get the 3.8.x kernel
>>> patched with Xenomai for running on the Beaglebone/Raspberry Pi in
>>> the meantime?
>>
>> For beaglebone, it is integrated in the I-pipe tree for the ARM
>> architecture (git://git.xenomai.org/ipipe-gch.git, branch
>> for-core-3.8), which is currently based on 3.8.0 but will probably be
>> rebased on a more recent version for the I-pipe 3.8 release, for the
>> raspberry pi, you can try the patch which has been posted by Paul,
>> but probably needs rebasing once the I-pipe for 3.8 is released.
> 
> 
> I have a set of patches ready for 3.8.8 based on the "official" 
> Raspberry Pi sources [1] - Need to reduce the current set of nine down 
> to a pre and post pair which I'll try to do over the weekend. In the 
> meantime, if anyone wants to take the set for a spin, drop me a note 
> and I'll send them over.

Hi Paul,

I have at last pushed the final version of the I-pipe patch for Linux
3.8.13, it is available both in the xenomai git as a patch and in the
I-pipe git.

Could you rebase the pre- and post- patches for Raspberry so that I can
put them in the Xenomai sources too?

Also note that the I-pipe patch for 3.10.0 is available, but it is
probably not yet the final version.

Thanks in advance.
Regards.

-- 
                                                                Gilles.

