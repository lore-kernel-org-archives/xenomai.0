Message-ID: <517195B6.8020209@xenomai.org>
Date: Fri, 19 Apr 2013 21:06:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>
In-Reply-To: <201304191346.38739.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai <xenomai@xenomai.org>

On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:

> [1] 
> http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-April/006986.html


Hi,

that link does not tell us why you need this option. And that would be
the most important information.

If what you need to disable is TLS, then configuring xenomai with
--without-__thread is sufficient

If what you need is to avoid the main thread shadowing, we are not going
to configure xenomai with --enable-dlopen-skins as it breaks otherwise
conformant applications, but we can add an environment variable like
XENO_PTHREAD_NO_AUTO_SHADOW to allow supporting both situations.

-- 
                                                                Gilles.

