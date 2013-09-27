Message-ID: <5245DB72.9060603@xenomai.org>
Date: Fri, 27 Sep 2013 21:24:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>,
	<51DEF6FB.6080403@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F3724@MAIL-SINTERS-01.sinters-int.fr>
	<51E43CE5.5020103@xenomai.org> <52457550.2050501@axelsw.it>
	<979a2ecdb54e79afe900ef6a07f21ce9.squirrel@127.0.0.1>
	<52457ED1.8050509@axelsw.it>
In-Reply-To: <52457ED1.8050509@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : RE : No boot kernel with xenomai on
 i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/27/2013 02:49 PM, Roberto Bielli wrote:
> Hi,
> 
> my kernel working before applying adeos-ipipe-3.0.36-arm-1.18-11.patch + 
> adeos-ipipe-3.0.36-arm-1.18-11-post.patch,
> So is not a problem before installing ipipe.

I missed that part, 3.0.36 is not the latest version, please try 3.0.43
from xenomai git. Also, you have 3 patches to apply, not 2.

Finally, it is important to test the patched kernel without CONFIG_IPIPE
and CONFIG_XENOMAI.

-- 
                                                                Gilles.

