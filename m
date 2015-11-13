Date: Fri, 13 Nov 2015 14:19:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151113131931.GB1820@hermes.click-hack.org>
References: <9SlMMGR4S6RSaIBByUSWmfIigUV5A29DxyOlBMGFnrTkKHq5mREbgo1RRvCaeqM8_ajLTxHFA2V_5LHFIDjbjw==@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9SlMMGR4S6RSaIBByUSWmfIigUV5A29DxyOlBMGFnrTkKHq5mREbgo1RRvCaeqM8_ajLTxHFA2V_5LHFIDjbjw==@protonmail.ch>
Subject: Re: [Xenomai] [PATCH] Fix "xenomai configure error: possibly
 undefined macro: LT_SYS_SYMBOL_USCORE" error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "roberto.rigamonti" <roberto.rigamonti@protonmail.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Nov 12, 2015 at 03:54:01PM -0500, roberto.rigamonti wrote:
> When running the ./build/bootstrap script, at least in the xenomai-3.0.1.tar.bz2 archive, the autoconf stops with the error:
> xenomai configure error: possibly undefined macro: LT_SYS_SYMBOL_USCORE
> The added m4_pattern_allow() command solves the issue.
> 
> P.S.: this is my first patch ever, please be kind if I had make
> any mistake in the procedure to follow :)

If you download Xenomai 3.0.1 packaged sources from here:
http://xenomai.org/downloads/xenomai/stable/latest/

You do not need to run the "bootstrap" script.

But if you want to run the bootstrap script, you should make sure
that you are using the same versions of the autotools as the
maintainer, that is:
autoconf 2.69
automake 1.15
libtool 2.4.2

Are these the versions you use ?

-- 
					    Gilles.
https://click-hack.org

