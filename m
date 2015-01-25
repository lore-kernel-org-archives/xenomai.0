Message-ID: <54C53188.4020108@xenomai.org>
Date: Sun, 25 Jan 2015 19:10:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho> <1882941.jW5kVZFuDr@indiana>
 <20150123172739.GA12812@hermes.click-hack.org>
 <201501241756.28192.leo@alaxarxa.net> <54C4B411.3030307@xenomai.org>
 <2B26277C-0A61-4059-8776-994BFC297530@alaxarxa.net>
In-Reply-To: <2B26277C-0A61-4059-8776-994BFC297530@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/25/2015 12:14 PM, Leopold Palomo-Avellaneda wrote:
> But I was thinking in performance aspects comparing a system with cobalt
> vs a system with mercury.
> 

Yes, but the results are now outdated (2011). This said, such benchmark
hardly reflected a use case. It was more a Xenomai 2.6.x vs 3.x analysis
of basic mechanisms (event notification, serialization, buffer exchange
etc) for measuring the impact of moving most of the real-time API
implementation to user-space, only keeping the core resource management
in kernel space. It proved to be positive.

Mercury vs Cobalt was only a by-product of those tests, specifically on
x86_32.

-- 
Philippe.

