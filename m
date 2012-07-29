Message-ID: <50151911.1070709@xenomai.org>
Date: Sun, 29 Jul 2012 13:05:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>	<201207282127.33575.paul_c@tuxcnc.org>	<50144E93.5050109@xenomai.org>	<201207291044.22418.paul_c@tuxcnc.org>
	<50151772.1000405@piments.com>
In-Reply-To: <50151772.1000405@piments.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenophile <xenophile@piments.com>
Cc: xenomai@xenomai.org

On 07/29/2012 12:58 PM, xenophile wrote:

> On 07/29/12 11:44, Paul wrote:
>>   However, "dohell 3600" does not do much.
> 
> try :
> 
> dohell -all


We follow POSIX guidelines for command line options, so that would be
dohell --all.
The reason why there is no dohell --all is that all dohell options
require arguments, such as the network address of a server, the path to
ltp, the path to hackbench, the path of a block device mount point.

-- 
                                                                Gilles.

