Date: Thu, 30 Apr 2015 14:23:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150430122359.GQ1993@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
Subject: Re: [Xenomai] [PATCH] debian: remove xeno-config from
 libxenomai-dev package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 01:59:54PM +0200, Henning Schild wrote:
> Since 8871363fa57266af4c8d8a06965f2898b940fb48 the binary and its man-page
> are in the base package (xenomai-runtime). Remove the files from the -dev
> package to resolve the current package conflict.

I would rather do things the other way around: move xeno-config and
its man page to the -dev package and remove them from the runtime
package.

-- 
					    Gilles.

