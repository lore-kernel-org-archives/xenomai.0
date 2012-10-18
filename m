Message-ID: <50803629.4070206@xenomai.org>
Date: Thu, 18 Oct 2012 19:02:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.94.1350341580.29827.xenomai@xenomai.org>
	<1350374085.35200.YahooMailNeo@web164604.mail.gq1.yahoo.com>
	<507D1EB8.3000406@xenomai.org>
	<1350578804.89380.YahooMailNeo@web164606.mail.gq1.yahoo.com>
In-Reply-To: <1350578804.89380.YahooMailNeo@web164606.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beagleboard-XM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ahmet Tekelioglu <vtam370@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/18/2012 06:46 PM, Ahmet Tekelioglu wrote:
> Thank you, Gilles. I am sorry for the delay in my reply but I only
> succeeded in cross-compiling a standard a kernel today and installed
> it on my BeagleBoard-XM. Until now I didn't feel ready for Xenomai.
> I'll try to compile for Xenomai tomorrow.

> I said:
> Also note that xenomai 2.6.1 does not support thumb kernels or thumb 
> user-space, so, if you are compiling with a toolchain which compiles
> for thumb by default (like, it seems, linaro cross toolchain), please
> add -mthumb to the cflags when compiling xenomai user-space. Also

add -marm to the cflags, the contrary of -mthumb, sorry.

-- 
					    Gilles.

