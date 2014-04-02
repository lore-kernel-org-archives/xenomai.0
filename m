Message-ID: <533C496C.2020303@steinkuehler.net>
Date: Wed, 02 Apr 2014 12:31:24 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net> <533C3622.1030601@xenomai.org>
 <533C38FF.5050703@steinkuehler.net> <533C4093.6040106@xenomai.org>
In-Reply-To: <533C4093.6040106@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian Package Building Broken
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 4/2/2014 11:53 AM, Gilles Chanteperdrix wrote:
> 
> Actually, it is better if you start from Xenomai 2.6 git head instead of
> the v2.6.3 tag, as you will avoid the few issues (including the fact
> that it does not compile for armhf) which have been fixed since the
> 2.6.3 release.

Between commenting the rm configure and using 2.6 HEAD, I got packages
to successfully build.

Thanks for the help!

-- 
Charles Steinkuehler
charles@steinkuehler.net

