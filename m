Message-ID: <526CF0DA.7060505@xenomai.org>
Date: Sun, 27 Oct 2013 11:54:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteVT-rzPSkN2CwY-neQHgyFOy4-DrfH6LuTE9RgF4puXA@mail.gmail.com>
In-Reply-To: <CAKKWdteVT-rzPSkN2CwY-neQHgyFOy4-DrfH6LuTE9RgF4puXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-2.6.3 installation failed !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 10/27/2013 11:51 AM, ali hagigat wrote:
> I am using Fedora 13, Intel: quad core:2.4GHZ, 32 bits machine:i686,
> Build kernel: 2.6.33.3-85 or linux kernel 3.5.7 with xenomai 2.6.2.1,

Xenomai 2.6.2.1 our Xenomai 2.6.3?

> binutils: 2.20.51.0.2, gcc: 4.4.4, motherboard: ASUS:commando
> 
> i patched kernel, 3.5.7 with ipipe-core-3.5.7 and then the make
> process is successful but after rebooting there is a long delay and
> unpleasant black screen and then it displays:
> 
> Welcome to Fedora 13
> Press "I" for interactive start-up
> 
> then some messages from udev, and then
> It stops forever!!

Does the same kernel configuration works, without CONFIG_XENOMAI and
CONFIG_IPIPE enabled.

> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
                                                                Gilles.

