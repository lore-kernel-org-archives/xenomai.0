Date: Mon, 4 May 2015 11:47:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150504094745.GL1993@hermes.click-hack.org>
References: <1740903282.3953811.1430731145805.JavaMail.root@openwide.fr>
 <727852337.3956926.1430732646012.JavaMail.root@openwide.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727852337.3956926.1430732646012.JavaMail.root@openwide.fr>
Subject: Re: [Xenomai] Problem with the promiscuous mode of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Damien Lagneux <damien.lagneux@openwide.fr>
Cc: xenomai@xenomai.org

On Mon, May 04, 2015 at 11:44:06AM +0200, Damien Lagneux wrote:
> Hi all,
> 
> I'm trying to adapt openPOWERLINK to RTnet. I'm using Xenomai 3.0-rc4,
> linux kernel 3.16.7, and the board I'm working with is an Armadeus apf6.
> 
> I have a problem with the promiscuous mode of the fec driver. It seems I 
> can only receive packets which are addressed to the board.
> 
> I'm using the raw-ethernet and eth_p_all programs to test the promiscuous
> mode. If the destination MAC address used in the raw-ethernet program 
> is the the broadcast address or the board's address, the eth_p_all program
> prints the messages. Otherwise, it doesn't print them.
> 
> I did set the interface rteth0 in promiscuous mode.
> 
> Does anyone have an idea what could the problem?

How did you set the promiscuous mode ?

-- 
					    Gilles.

