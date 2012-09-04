Message-ID: <50462AB8.1090606@xenomai.org>
Date: Tue, 04 Sep 2012 18:22:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50461A66.6070805@ruggedcom.com>
In-Reply-To: <50461A66.6070805@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Powepc 8360 interrupt timing question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: xenomai@xenomai.org

On 09/04/2012 05:12 PM, Makarand Pradhan wrote:
> :|  # func                 -90    0.727  xnsched_rt_enqueue+0x8 
> (xnpod_resume_thread+0xa8)
> :|  # func                 -89+   3.439  addmlq+0x8 
> (xnsched_rt_enqueue+0x44)

You are using the O(1) scheduler, it is asymptotically fast, but
probably not so fast as the default linked list based scheduler if there
are not too many threads.

-- 
					    Gilles.

