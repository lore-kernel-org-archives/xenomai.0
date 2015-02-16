Message-ID: <54E22D82.9020105@xenomai.org>
Date: Mon, 16 Feb 2015 18:48:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54E22A50.4070106@siemens.com>
In-Reply-To: <54E22A50.4070106@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] ipipe: fixes for 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/16/2015 06:35 PM, Jan Kiszka wrote:
> The following changes since commit 00d8a6f2e95453f61ae97b6587dba03bc91c7e1a:
> 
>   arm/ipipe: Resolve trival merge conflicts (2015-01-14 17:00:22 +0100)
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/ipipe-jki 
> 
> for you to fetch changes up to f982e48ce99e1bc9e71eac21830adac2db265c98:
> 
>   x86/ipipe: Restore invocation of ipipe_unlock_irq from startup_ioapic_irq (2015-02-16 18:22:21 +0100)
> 
> All patches apply to 3.16 as well but weren't tested there yet. Still
> analyzing strange
> 
> traps: (systemd)[1420] trap invalid opcode ip:7f4d138f612b sp:7fff4fd8f568 error:0 in libpthread-2.19.so[7f4d138e5000+18000]
> 
> on the target under 3.14...
> 

Register trashing on the fast call path (system_call_after_gs) maybe.
Forcing CONFIG_IPIPE_LEGACY there might help ruling this out.

-- 
Philippe.

