Message-ID: <50968532.60603@xenomai.org>
Date: Sun, 04 Nov 2012 16:09:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1352041290.49248.YahooMailClassic@web161203.mail.bf1.yahoo.com>
In-Reply-To: <1352041290.49248.YahooMailClassic@web161203.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno_mod_isa for a 2 channel can-device with the same
 shared interrupt for both devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: thoga@yahoo.com
Cc: xenomai@xenomai.org

On 11/04/2012 04:01 PM, thoga@yahoo.com wrote:

> Hi Gilles,
> 
> thanks for your quick answer.
> 
> CONFIG_XENO_OPT_SHIRQ was not set in the kernel-config. I'll set the
> flag and recompile the kernel, but this will take 24h on that slow
> industrial pc.


There is no reason to compile the kernel on the target.

> 
> XN_ISR_SHARED flag, however, sound more interesting. How can I check,
> if the driver uses the XN_ISR_SHARED flag?


Look at the sources.

-- 
                                                                Gilles.

