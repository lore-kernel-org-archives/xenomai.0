Message-ID: <50B783E9.5030903@xenomai.org>
Date: Thu, 29 Nov 2012 16:48:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <01f101cdce3c$5dd719f0$19854dd0$@mpl.com>
In-Reply-To: <01f101cdce3c$5dd719f0$19854dd0$@mpl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai in vmware smp crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <sseeger@mpl.com>
Cc: xenomai@xenomai.org

On 11/29/2012 03:18 PM, Steven Seeger wrote:
> Gentlemen,
> 
>  
> 
> Hello! It's been many years since I've been on the list. I still dabble in
> Xenomai when jobs come up. I wish I had more need to use it so I can
> contribute. I've missed my "friendly" back and forth emails with Gilles on
> geopolitical issues. 

I am not sure you are not mixing up with Philippe, what you used to
discuss with me was why Xenomai was slow on Geode GX1 and I understood
this very recently, I doubt it counts as a geopolitical issue, though.

> [   17.065610] kernel BUG at arch/x86/kernel/ipipe.c:592!

This is a known issue which has been fixed by the Siemens team in the
I-pipe patch for Linux 3.4 and should be backported to the I-pipe patch
for Linux 3.2 one of these days.

-- 
					    Gilles.

