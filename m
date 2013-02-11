Message-ID: <51189FC7.4070807@xenomai.org>
Date: Mon, 11 Feb 2013 08:37:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <718DFA7882181D45B8BD18F31C46D55427A67586@MBX204.domain.local>
	<718DFA7882181D45B8BD18F31C46D55427A675C0@MBX204.domain.local>
In-Reply-To: <718DFA7882181D45B8BD18F31C46D55427A675C0@MBX204.domain.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Perry <Gregory.Perry@govirtual.tv>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/11/2013 06:23 AM, Gregory Perry wrote:

> How do I go about finding out what the most recent kernel for ARM
> that is supported by 2.6.2.1?  Is it still 3.2.21?  Can someone point
> me to the file in the Xenomai distro which describes the most recent
> kernel released with each Xenomai?
> 
> I am going to take the plunge and patch each release up to 3.2.21 on
> the BeagleBone with the TI support patches, and then attempt a
> Xenomai integration on that optimized TI kernel.


Simply have a look at the ksrc/arch/arm/patches directory.

-- 
                                                                Gilles.

