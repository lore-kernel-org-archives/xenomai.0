Message-ID: <51ACDEEF.5090302@xenomai.org>
Date: Mon, 03 Jun 2013 20:22:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
In-Reply-To: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gcc error: posix.wrappers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/03/2013 06:50 PM, Franz Engel wrote:

> Hi,
> 
> I've a little problem. When I try to compile my code with my new system (xenomai 2.6.2.1) I get the following error:
> gcc: error: ;-Wl,@/usr/xenomai/lib/posix.wrappers: No such file or directory


If the build-tool you use supports pkg-config, you may find it easier to
use the .pc files installed by xenomai. The posix skin library "package
name" is libxenomai_posix (so the .pc file is called libxenomai_posix.pc).


-- 
                                                                Gilles.

