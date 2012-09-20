Message-ID: <505B3F67.3050807@xenomai.org>
Date: Thu, 20 Sep 2012 18:08:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505AED9B.1030805@sigmatek.at>
In-Reply-To: <505AED9B.1030805@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] calculate cpuload
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at
Cc: Xenomai@xenomai.org

On 09/20/2012 12:19 PM, Johann Obermayr wrote:
> Hello,
> 
> How can i calculate the cpu load for a dualcore ATOM
> Core 0 : Linux and some Xenomai Thread
> Core 1: Fixed 2 Xenomai Threads.

Enable "statistics collection", then use cat /proc/xenomai/stat or
/proc/xenomai/sched.

-- 
					    Gilles.

