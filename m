Message-ID: <505F23DB.8070109@xenomai.org>
Date: Sun, 23 Sep 2012 16:59:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr> <505EBD61.1050009@wanadoo.fr>
	<505F0D40.9030105@xenomai.org> <505F234B.6070208@wanadoo.fr>
In-Reply-To: <505F234B.6070208@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 09/23/2012 04:57 PM, Thierry Bultel wrote:

> Gilles,
> 
> thanks for your advice.
> 
> I do not mind using the versatile express especially for emulation, I
> only want a board with a cortex A9 that boots in qemu, with a linux
> kernel >= 3.2, and an available ipipe patch.
> 
> Unfortunately qemu does not support the IMX6 yet, which is the board
> I aim, so I have to cope with another one.
> 
> If you have a board name that is already fully supported and that
> fits my needs, please tell me and I will use it with pleasure.


OMAP4 and IMX6 are the only SMP SOCs I could test. That said, normally
the I-pipe core 3.4 should run on any cortex A9 base processor. For the
I-pipe core 3.2, you need to a few things to get it working, which I
tried and describe in the wiki page.

-- 
                                                                Gilles.

