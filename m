Date: Thu, 10 Mar 2016 21:44:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160310204458.GA19907@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A725B24@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A725B24@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] Read a file in rtdm module without mode switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 10, 2016 at 11:55:01AM +0000, Umair Ali wrote:
> Hello there,
> 
> How can I read file in the rtdm module without switching to
> secondary mode. There is mmap() in user space application
> therefore is there any similar function in rtdm. If yes then how
> can it be used. Or is there any other way.

Except for some exceptions, opening files in kernel-space is
generally frowned upon. You do not tell us what you want to do, so
proposing alternatives is hard. But passing data from user-space to
kernel-space is what RTDM drivers are good at.

-- 
					    Gilles.
https://click-hack.org

