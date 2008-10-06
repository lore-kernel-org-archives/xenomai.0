Message-ID: <48EA2E4B.3060206@domain.hid>
Date: Mon, 06 Oct 2008 17:27:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>	
	<48D176F0.7060805@domain.hid>	
	<894886ec0809181640t3d413a73h5c02da73dc3000c9@domain.hid>	
	<48D34936.7090206@domain.hid>	
	<894886ec0809191008m3b1eac19s45a1d67316eba626@domain.hid>	
	<48D62445.6090305@domain.hid>	
	<894886ec0810012245i679ab8f7o44ae6f50efcc853f@domain.hid>	
	<48E494BF.3030600@domain.hid>
	<894886ec0810030900w7ddee1enee8d12529ba910d8@domain.hid>
In-Reply-To: <894886ec0810030900w7ddee1enee8d12529ba910d8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: soa@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Rob Wheeler wrote:
> On Thu, Oct 2, 2008 at 2:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Please send the .config file, and confirm that we are still talking about the
>> adeos-ipipe-2.6.24-x86-2.0-07 patch over 2.6.24.3.
> 
> Philippe,
> 
> I've attached my config file and yes it is 2.0-07 over 2.6.24.3.  I'll
> try your suggested experiment of patching with ipipe and disabling
> xenomai and report the results soon.
> 

2.6.24 suffers the known problem of reading the PCI config inside critical
I-pipe paths, so could you try disabling CONFIG_PCI_MSI from your config and
boot without irqpoll? TIA,

-- 
Philippe.

