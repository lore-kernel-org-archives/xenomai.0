Message-ID: <51A64C6D.1000609@xenomai.org>
Date: Wed, 29 May 2013 20:43:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C4664F009CD@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664F009CD@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Sabre Lite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/29/2013 03:28 PM, Younes CHALABI wrote:

> Hi all,
> 
> I want to use Xenomai-2.6.2.1 with the Sabre Lite i.MX6Q. Which kernel and adeos-ipipe versions should I use ? 


The available versions are the I-pipe for Linux 3.0 (Freescale release),
3.2, 3.4, 3.5 with Xenomai 2.6.2.1
or 3.8 with Xenoami from git repository

> 
> And is there an installation procedure for this board ?


See README.INSTALL in xenomai sources, with a detour to
ksrc/arc/arm/patches/README  if you want to use the Freescale release.

-- 
                                                                Gilles.

