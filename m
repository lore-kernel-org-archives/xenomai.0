From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 21 Nov 2014 10:11:24 -0500
Message-ID: <20141121151124.GR24110@csclub.uwaterloo.ca>
References: <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
 <20141119171204.GI24110@csclub.uwaterloo.ca>
 <20141119223848.GF7011@sisyphus.hd.free.fr>
 <20141120200133.GN24110@csclub.uwaterloo.ca>
 <20141120200639.GF4545@sisyphus.hd.free.fr>
 <20141120223817.GO24110@csclub.uwaterloo.ca>
 <20141121075900.GH4545@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141121075900.GH4545@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Nov 21, 2014 at 08:59:00AM +0100, Gilles Chanteperdrix wrote:
> Mainline TI code does, as I said, I just have a few issues, but
> fixing them look really doable. Alternatively, we could, with a
> #ifdef CONFIG_IPIPE define a few of the bits used in omap_hwmod to
> 0, so as to avoid the use of smart-idle.

Certainly an option.  I think I will get some feedback from the maintainer
of the driver to see what they think of the idea.

-- 
Len Sorense

