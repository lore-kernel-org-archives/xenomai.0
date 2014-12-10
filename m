Message-ID: <5488D4D8.7010604@nta-inc.net>
Date: Wed, 10 Dec 2014 17:18:48 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca> <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca> <5488A985.2070006@xenomai.org>
 <20141210201140.GL24110@csclub.uwaterloo.ca>
 <20141210212342.GO24110@csclub.uwaterloo.ca> <5488C149.8020901@nta-inc.net>
 <20141210220129.GP24110@csclub.uwaterloo.ca>
In-Reply-To: <20141210220129.GP24110@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/10/2014 04:01 PM, Lennart Sorensen wrote:
> On Wed, Dec 10, 2014 at 03:55:21PM -0600, Jeff Webb wrote:
>> I can confirm that this is around the time I started having trouble with the proprietary nvidia module.  In the linux 2.6.?? days, I didn't experience that issue.  It is obviously up to the authors to decide whether or not it is desirable to allow proprietary modules to continue to operate on an I-pipe patched kernel as they do an un-patched kernel.  Since the issue was raised, I thought I would report my experience in case there is a desire to get this configuration working again.
>
> Well certainly I do agree with Gilles that if there is a binary blob,
> you can not know if it is going to mess directly with interrupts and
> break ipipe, so the nvidia driver could be a problem (hard to know).

Yes, this is true.  Just to be clear, though, I have used Xenomai with the nvidia module loaded, and it does work well enough to be useful for some applications on some hardware.  I would not recommend this configuration for a critical application, but it may be useful to some people for development and testing.  The open-source nouveau driver is much better behaved, but some video cards don't work well with nouveau.

-Jeff


