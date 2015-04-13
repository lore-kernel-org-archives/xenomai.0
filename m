Date: Mon, 13 Apr 2015 14:38:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150413123846.GA14791@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC912342962C71@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962C71@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] Xeno3.0 latency no /dev/rtheap under 3.18 i.mx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Apr 13, 2015 at 12:27:08PM +0000, Hänel-Baas, Alexander wrote:
> Hi
> 
> when i start latency, i get the error:
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
> 
> dmesg | grep Xeno shows:
> [Xenomai] scheduling class idle registered.
> [Xenomai] scheduling class rt registered.
> I-pipe: head domain Xenomai registered.
> [Xenomai] Cobalt v3.0-rc4 (Exact Zero)
> 
> cat /sys/module/xenomai/parameters/state
> enabled

You are running Xenomai 2.6 latency test with Xenomai 3.x, this can
not work. Sorry.

-- 
					    Gilles.

