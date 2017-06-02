Date: Fri, 2 Jun 2017 16:46:07 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170602164607.37c91e63@md1em3qc>
In-Reply-To: <CAFUnMkkbtRuasbfiP2bZ_twJ1JZjQxq1EXeRDHBKL9LmiXdV5w@mail.gmail.com>
References: <CAFUnMkkbtRuasbfiP2bZ_twJ1JZjQxq1EXeRDHBKL9LmiXdV5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: xenomai@xenomai.org

Am Fri, 2 Jun 2017 19:38:14 +0530
schrieb Ashok kumar <ashokkumar.bb@gmail.com>:

> I am Ashok , I have installed the xenomai-2.6.21 patch with linux
> kernel 3.2.21  I am using Dell laptop core i3,x86_64 , after
> installation my wifi network is not working ,
> I have run the command
> 
> lspci | grep Network
> 
> 06:00.0 Network controller: Broadcom Corporation BCM43142 802.11b/g/n
> (rev 01)

Well these versions are pretty outdated. But your problem has nothing
to do with xenomai.
It could be that your kernel config does not enable the driver, or the
card is not even supported by that old kernel.

> but in ifconfig command wlan is not seen.

lspci -v should tell you whether any driver claimed the card, probably
not
 
> please provide me a solution to enable wifi with xenomai kernel.

Check whether the kernel supports that card and is configured correctly.
i.e. look for the pci device and vendor id in the kernel code.
You might be missing some ucode-/firmware- packages.

Henning

> Thank you
> from Ashok
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


