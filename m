Message-ID: <4FFE8B7C.60506@xenomai.org>
Date: Thu, 12 Jul 2012 10:31:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/12/2012 10:16 AM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Thanks Gilles. Yes unfortunately I cant recompile this kernel so I
> was wondering about the system context of this fault within Xenomai. 
> BTW how come the stack frame is not printed by default.

Because it may not be safe to use show_stack() from RT context (for
instance, the print_symbol function to print symbol names need to take a
spinlock when a symbol is defined by a kernel module, and this spinlock
is not rt-safe). Anyway, the error message normally prints the PC of the
error.

Could you give us the exact error messsage? The version of Xenomai, the
Linux kernel, the version of the I-pipe patch you use?

-- 
					    Gilles.

