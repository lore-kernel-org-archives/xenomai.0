Date: Wed, 2 Dec 2015 07:14:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151202061422.GB8279@hermes.click-hack.org>
References: <565DF501.8060805@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565DF501.8060805@mperpetuo.com>
Subject: Re: [Xenomai] [PATCH] cobalt: increase default system heap size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 01, 2015 at 11:29:05AM -0800, Dmitriy Cherkasov wrote:
> On arm64, running the included switchtest program hits the default 
> system heap limit of 256k.
> 
> The program creates 97 threads, each allocating space on the system heap 
> for struct cobalt_thread (3616 bytes on arm64). This adds up to a total 
> of 350725 bytes required.
> 
> This patch increases the default system heap size to 512k.

The number of threads depends on the number of cpus, so, if a
64 bits octo-core requires simply doubling the size, the patch looks
reasonable. Alternatively, we can keep 256 KiB for the !SMP case,
and simply change the default in the SMP case.

-- 
					    Gilles.
https://click-hack.org

