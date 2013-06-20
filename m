Message-ID: <a865fc237fbd4956d65747012a333d91.squirrel@www.xenomai.org>
In-Reply-To: <1371694084.22285.YahooMailNeo@web161401.mail.bf1.yahoo.com>
References: <1371694084.22285.YahooMailNeo@web161401.mail.bf1.yahoo.com>
Date: Thu, 20 Jun 2013 15:26:44 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] alarms on multi-core systems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Tom Z wrote:
> Hi,
> Suppose I have two tasks bound to two cores, say CPU_0 and CPU_1, and each
> of them has an alarm (or timer), can I guarantee that both alarms are
> synchronized, say, they expire at the same time based on the same world
> clock? Or, does Xenomai utilize a global clock for all cores, which can be
> found in some modern multi-core architectures, to implement alarms?

The answer depends on the clock source provided by the hardware you use.

-- 
                    Gilles.


