Message-ID: <51AF8424.40300@xenomai.org>
Date: Wed, 05 Jun 2013 20:32:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7EC33A2F-9868-4A32-A19F-9A7C70AF9EBB@mah.priv.at>
In-Reply-To: <7EC33A2F-9868-4A32-A19F-9A7C70AF9EBB@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beaglebone kernels - automated builds WIP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/05/2013 05:42 PM, Michael Haberler wrote:

> just letting you know I'm working with Robert Nelson to tack on a
> Xenomai kernel build to his automated build the thread is here:
> http://eewiki.net/display/linuxonarm/BeagleBone+Black+Comments (cant
> link to the actual post, search for xenomai)
> 
> this flow already produces the vanilla kernels which are in the BB
> Ubuntu and Debian images; the process is outlined here:
> http://tinyurl.com/n5ly89t ; the xenomai kernel(s) would be tacked
> onto this stream: http://rcn-ee.net/deb/wheezy-armhf/
> 
> for now I'll use the patches Stephan had forwarded me in private, and
> switch on next release (suggestions to do better than that welcome)


You should probably use the ipipe-next branch in ipipe git tree.

-- 
                                                                Gilles.

