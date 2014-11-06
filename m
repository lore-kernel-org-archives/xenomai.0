Date: Thu, 6 Nov 2014 13:48:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106124850.GB29228@sisyphus.hd.free.fr>
References: <20141105205917.GA28595@sisyphus.hd.free.fr>
 <637400768.107888843.1415271440604.JavaMail.root@zimbra90-e16.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637400768.107888843.1415271440604.JavaMail.root@zimbra90-e16.priv.proxad.net>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: tbultel@free.fr
Cc: xenomai@xenomai.org

On Thu, Nov 06, 2014 at 11:57:20AM +0100, tbultel@free.fr wrote:
> nor why it is part of the ipipe patch.

So, the reason it is part of the ipipe patch is that without it, we
get high latencies on imx6.

http://git.xenomai.org/ipipe-gch.git/commit/?h=ipipe-3.0-imx6q&id=46342aa94d2635cb575311fb3626b7393ffe78dd

-- 
					    Gilles.

