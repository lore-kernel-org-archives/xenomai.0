Message-ID: <4FBB9591.6090002@xenomai.org>
Date: Tue, 22 May 2012 15:33:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com>, <4FBB4951.5070803@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>,
	<4FBB5393.5040003@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE011112339161@INSITEOSBS01.insiteo.local>,
	<4FBB88A8.7030209@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE011112339162@INSITEOSBS01.insiteo.local>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE011112339162@INSITEOSBS01.insiteo.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : A possible mis-interaction between
 CONFIG_PREEMPT and GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2012 03:23 PM, Jean-Pascal JULIEN wrote:
> Gilles,
> 
> In the adeos-ipipe-2.6.38.2-arm-1.18-04.patch this piece of code is not present :

Just look at what the patch does: it replaces what the current I-pipe
patch has, with what you already have. If you want the patch I sent to
apply correctly, please use the latest I-pipe patch.

-- 
					    Gilles.

