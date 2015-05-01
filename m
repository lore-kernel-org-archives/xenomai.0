Date: Fri, 1 May 2015 16:00:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150501140018.GF1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430212749.GB1993@hermes.click-hack.org>
 <20150501134547.GF24389@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150501134547.GF24389@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Fri, May 01, 2015 at 09:45:47AM -0400, Lennart Sorensen wrote:
> On Thu, Apr 30, 2015 at 11:27:49PM +0200, Gilles Chanteperdrix wrote:
> The exynos5420 has a 32bit timer at 24MHz.  It wraps every 178 seconds.
> Good thing we only use that as a build box.

Xenomai extends counters to 64 bits in software. So, if that counter
was used as a tsc by Xenomai, it would wrap in :

(1 << 64) / 24000000 = 768614336404 s

That is:

768614336404 / (365 * 24 * 3600) = 24372 years.

-- 
					    Gilles.

