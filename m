Message-ID: <53A4201D.8020507@xenomai.org>
Date: Fri, 20 Jun 2014 13:50:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
 <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>
In-Reply-To: <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Some Information About compilation Xenomai and RT
	Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/20/2014 11:02 AM, Stoidner, Christoph wrote:
> My pending problem which I hope to solve soon is the fast context
> switch extension (FCSE) that allows better latency times on ARM9. In
> "guaranteed" mode it crashs when using addresses above 32MB.

What do you mean it crashes? Normally, an mmap call that would return
addresses above 32MB simply fails, because you can not use addresses
above 32MB in guaranteed mode.

-- 
                                                                Gilles.

