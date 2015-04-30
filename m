Date: Thu, 30 Apr 2015 16:41:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150430144105.GU1993@hermes.click-hack.org>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] Hang/Reboot when using
	CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 04:33:40PM +0200, Marc Strämke wrote:
> Hello everyone,
> 
> during migration to xenomai 3 we found in testing that enabling the kernel 
> config option CONFIG_CC_STACKPROTECTOR_REGULAR leads to hangs or reboots 
> (depends on the target platform we are testing on). 
> 
> This post: http://www.xenomai.org/pipermail/xenomai/2012-July/000511.html 
> shows that the old xenomai 2.6 triggered an error when the stack protector was 
> enabled.
> 
> I think this warning should be readded to the newer source or at least a 
> warning added to the kernel compile documentation.

No. At least ARM and x86 architectures are supposed to support the
stack protector. Maybe you could tell us on what architecture you
have this issue?

-- 
					    Gilles.

