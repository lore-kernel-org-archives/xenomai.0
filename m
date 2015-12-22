Date: Tue, 22 Dec 2015 08:37:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151222073747.GD29679@hermes.click-hack.org>
References: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
Subject: Re: [Xenomai] NVIDIA Drivers w/ Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eric Huang <ehuang@gatech.edu>
Cc: xenomai@xenomai.org

On Mon, Dec 21, 2015 at 07:22:26PM -0500, Eric Huang wrote:
> Hi,
> 
> The specific question I am trying to answer is whether it is possible (at
> all) to install an NVIDIA driver alongside Xenomai
> 
> My system is the following.
> 
> uname -a
> Linux robot-Z68X-UD3H-B3 3.2.21-xenomai-2.6.1 #1 SMP Thu Jul 26 11:46:23
> EDT 2012 x86_64 x86_64 x86_64 GNU/Linux
> 
> xeno-config --version
> 2.5.5.2

By the way, you have a mismatch between Xenomai user-space and
kernel-space, xenomai 2.5.5.2 user-space should not work with a
xenomai 2.6.1 kernel space. You need a xenomai 2.6.x user-space for
a xenomai 2.6.1 kernel space. And Xenomai on Linux 3.2 is broken.
So, I would say a general upgrade is in order.

-- 
					    Gilles.
https://click-hack.org

