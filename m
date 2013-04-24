Message-ID: <51778082.4060504@xenomai.org>
Date: Wed, 24 Apr 2013 08:49:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
In-Reply-To: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Srikanth C <srikanthc9@gmail.com>
Cc: Xenomai@xenomai.org

On 04/24/2013 08:29 AM, Srikanth C wrote:

> Hi,
> 
> Spurious interrupts are raised on 2.6.1 Xenomai patch
> with Linux Kernel version 3.2.34
> 
> for every pci interrupt raise  there is one spurious interrupt also getting
> raised.
> 
> Without Xenomai patch pci interrupts are working fine (Spurious interrupts
> are not raised).


What architecture? What kind of interrupt? Do you know the latest
version of Xenomai is 2.6.2.1, not 2.6.1? Where did you get an I-pipe
patch for 3.2.34 as the one we provide is for 3.2.21?

-- 
                                                                Gilles.

