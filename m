Message-ID: <50C7D38E.4000809@xenomai.org>
Date: Wed, 12 Dec 2012 01:45:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
In-Reply-To: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Poli <polimarco@gmail.com>
Cc: xenomai@xenomai.org

On 12/11/2012 09:32 PM, Marco Poli wrote:

> Hello all!
> 
> 
> 
> I would like to apologize if this is a somehow recurrent or
> previously addressed question, but all the answers I got on the topic
> were inconclusive, at least for someone with so far minimal
> experience with Xenomai.
> 
> Raspberry Pi patched kernels have GPIO and GPIO generated-interrupts
> working and exported to userland, but it is unclear to me if the
> in-kernel drivers are able to deal with RT applications in primary
> mode, or would it be necessary to make changes to the Linux Kernel
> Drivers or new GPIO RTDM drivers to be able to access GPIO from a RT
> application in primary mode? Maybe Analogy?
> 
> Is it possible to use these sort of Linux Kernel GPIO drivers and
> still be able to have my application not leave primary mode? Is there
> some source of documentation someone can point me to that might be of
> assistence?


It is unclear what interfaces you are talking about. The kernel gpiolib
interface may usually be used from drivers, if you are careful to get it
working, see:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs

If you are talking about the user-space interfaces, they are Linux
drivers, using Linux syscalls, and as such will cause any Xenomai
user-space thread running in primary mode to switch to secondary mode.

-- 
                                                                Gilles.

