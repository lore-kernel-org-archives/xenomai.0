Date: Thu, 7 May 2015 11:07:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150507090719.GC2099@hermes.click-hack.org>
References: <554B0C27.5010802@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <554B0C27.5010802@free.fr>
Subject: Re: [Xenomai] v3 heap mem-pool-size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?U3TDqXBoYW5l?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, May 07, 2015 at 08:54:31AM +0200, Stéphane ANCELOT wrote:
> Hi,
> 
> Is there a better way to raise mem-pool-size other than specifying in
> cmdline ?
> 
>    0"007.389| WARNING: [main] heapobj_init() failed for 470 bytes, raise
> --mem-pool-size?

A command line option is nice, it allows you to do basically
anything you want by calling your program from a script. What is it
you want to do that can not be achieved this way?

-- 
					    Gilles.

