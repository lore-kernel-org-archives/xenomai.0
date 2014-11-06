Date: Thu, 6 Nov 2014 16:55:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106155503.GD30908@sisyphus.hd.free.fr>
References: <545B9297.2090003@cgglobal.com>
 <20141106153738.GC30908@sisyphus.hd.free.fr>
 <545B994D.1080008@cgglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545B994D.1080008@cgglobal.com>
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Nov 06, 2014 at 03:52:45PM +0000, ZIV-Alberto Ozalla Cantabrana wrote:
> Hi all,
> 
> Sorry about missing references to function cu_log().
> You can omit cu_log calls (It is like printf).

The problem is that printf will cause a switch to secondary mode,
which you do not want to happen. So, please rewrite your example
using functions from xenomai libraries, test it again, and see if
printf is not the problem.

-- 
					    Gilles.

