Message-ID: <51646CBA.40407@xenomai.org>
Date: Tue, 09 Apr 2013 21:32:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <oqr4jdyggv.fsf@merlin.sez.to>
In-Reply-To: <oqr4jdyggv.fsf@merlin.sez.to>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] rtcan_module: Fix tx_timeout buffer size
 inconsistency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>, Wolfgang Grandegger <wg@denx.de>
Cc: xenomai@xenomai.org

On 03/17/2013 07:56 PM, Paul Janzen wrote:

> When formatting /proc/rtcan/sockets, tx_timeout is defined as
> char[16], but a length of 20 is passed to rtcan_get_timeout_name. If
> tx_timeout for any socket is infinite, this causes snprintf to zero
> outside the buffer, leading to stack overflow and a kernel panic.
> Make the tx_timeout buffer 20 bytes long instead.
> 
> Signed-off-by: Paul Janzen <pcj@xenomai.sez.to>


Wolfgang, ping?

-- 
                                                                Gilles.

