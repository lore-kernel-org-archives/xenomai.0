Message-ID: <506373F6.80406@xenomai.org>
Date: Wed, 26 Sep 2012 23:30:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5060AFD1.30303@gmail.com>
In-Reply-To: <5060AFD1.30303@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 2.6.37.6 + Xenomai 2.5.6 is ok,
 but with Xenomai 2.6.1 it won't boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jari Lietzen <jari.lietzen@gmail.com>
Cc: xenomai@xenomai.org

On 09/24/2012 09:09 PM, Jari Lietzen wrote:

> Hi!
> 
> Kernel 2.6.37.6 and Xenomai 2.5.6 boots ok, though displaying the error 
> message: "MP-BIOS bug: 8254 timer not connected to IO-APIC".
> 
> If I try to use Xenomai 2.6.1 the error message displayed is the same 
> and system just hangs after that. No other messages, keyboard doesn't 
> work, nothing. I started with the same kernel configuration, but I have 
> disabled a few options more (e.g. syscall auditing, shared interrupt 
> support).
> 
> I'm using Intel Core 2 Duo processor with Asus P5LD2-VM motherboard. 
> Obviously I'm missing something, but I can't figure that out. Here is 
> the kernel config file:


If you use one of the I-pipe patches whih ship with Xenomai 2.6.1, such
as the patch for linux 3.2, do you also have the issue?

-- 
                                                                Gilles.

