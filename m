Message-ID: <48593525.2040103@domain.hid>
Date: Wed, 18 Jun 2008 18:17:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid> <4857682B.8060900@domain.hid>
	<4857BBCD.6020902@domain.hid>
In-Reply-To: <4857BBCD.6020902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> Philippe Gerum wrote:
>> Steven A. Falco wrote:
>>   
>>> I am building kernel 2.6.25.4 from DENX with Xenomai 2.4.4 for PPC440EPx
>>> (sequoia development board).
>>>
>>> The kernel tries to use DHCP to obtain network settings.  With IPIPE
>>> disabled, this works perfectly.  However, when I enable IPIPE, the board
>>> sends packets ok, but does not receive packets - I can see the DHCP with
>>> a sniffer, but the development board does not receive them.
>>
>>   
>> External interrupts are probably locked out by the pipeline engine;
>> I've fixed a
>> similar issue in recent patches for other PICs. Which I-pipe patch
>> release are
>> you using?
> 
> 
> I am using the patch that came with Xenomai 2.4.4, namely:
> adeos-ipipe-2.6.25-powerpc-DENX-2.2-02.patch
> 

I can't reproduce this issue on a 440EP board, but I still have to to put my
hands on a 440EPX to check this. However, both should be using the common 44x
PIC support, so I don't expect big changes here.

Are you using the powerpc/ branch, or legacy ppc/ one for building the sequoia
kernel?

-- 
Philippe.

