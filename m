Message-ID: <50958E65.9090106@xenomai.org>
Date: Sat, 03 Nov 2012 22:36:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <k73ua9$nf5$1@ger.gmane.org>
In-Reply-To: <k73ua9$nf5$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beagle-XM - ipipe-core-3.2.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <gmane@reliableembeddedsystems.com>
Cc: xenomai@xenomai.org

On 11/03/2012 09:20 PM, Robert Berger wrote:

> more detailed info about Linux booting is here: http://pastebin.com/54bBuXQi


Please disable CONFIG_SMP. The I-pipe for 3.2.21 does not support
SMP_ON_UP yet, it has only be added to 3.4.


-- 
                                                                Gilles.

