Date: Wed, 5 Nov 2014 19:42:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141105184232.GA24737@sisyphus.hd.free.fr>
References: <545A2CC1.3080909@selex-es.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545A2CC1.3080909@selex-es.com>
Subject: Re: [Xenomai] An explanation on cyclictest results and other...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pampolini Matteo <matteo.pampolini@selex-es.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 05, 2014 at 02:57:21PM +0100, Pampolini Matteo wrote:
> 2) Before realizing that Xenomai provides its own enhanced version of cyclictest (sigh!) I took
> the one from rt-tests package and recompiled it by using Xenomai POSIX skin. In my understanding
> they should give similar results, but while I get an average latency of 1 with the Xenomai provided
> one, I get 16 with the latter one! What am I doing wrong?

You are making the assumption, that recompiling an application to
use xenomai posix skin will magically get it working in primary mode
on Xenomai co-kernel. This assumption is generally wrong, see:

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/

-- 
					    Gilles.

