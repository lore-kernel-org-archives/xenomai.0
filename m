Message-ID: <52A8AEA5.7000409@xenomai.org>
Date: Wed, 11 Dec 2013 19:27:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52A88B17.8050707@steinkuehler.net>
In-Reply-To: <52A88B17.8050707@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM 3.12 Kernel Support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 12/11/2013 04:56 PM, Charles Steinkuehler wrote:
> I am successfully using Xenomai with a 3.8.13 kernel on the BeagleBone,
> but there are no drivers for the on-chip GPU available.  TI is
> apparently skipping the 3.8 kernel series, and now has drivers available
> for 3.12.
>
> So, if I want Xenomai and GPU acceleration on the BeagleBone, I either
> need to back-port the TI GPU drivers from 3.12 to 3.8, or get Xenomai
> working on a 3.12 ARM kernel.
>
> I figure eventually the Xenomai patches will be updated for 3.12, but I
> might be able to help move things along.  Is anyone actively working on
> 3.12 support, or is development still centered around 3.10?  Is the
> master branch from http://git.xenomai.org/ipipe.git/ the most
> appropriate branch to try and forward-port?  It looks like the 3.10
> branches have more recent commits...

3.10.18 is validated on ARM, and works correctly as far as I can tell. 
So, I could switch to 3.12. I would prefer to complete a few things on 
xenomai-forge in the next weeks before I can switch though.

-- 
					    Gilles.

