Date: Fri, 27 Feb 2015 21:27:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150227202724.GL434@hermes.click-hack.org>
References: <54F0CF9E.1040707@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F0CF9E.1040707@siemens.com>
Subject: Re: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86
 and ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Feb 27, 2015 at 09:12:14PM +0100, Jan Kiszka wrote:
> Hi,
> 
> just pushed a first implementation of the general model that I proposed
> for exception handling. You can find it at
> 
> http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework

Also, the clean way to pass virtual + physical flags is to use
arch_mangle_bits. Using two longs (potentially 128 bits then) is
completely useless since one of the longs simply has one significant
bit.

-- 
					    Gilles.

