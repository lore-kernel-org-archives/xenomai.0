From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189D54B57@domain.hid>
References: <065A7D06F7D4E546A18E80E08D066E181189D54B57@domain.hid>
Content-Type: text/plain
Date: Thu, 21 May 2009 11:38:04 +0200
Message-Id: <1242898684.18976.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai interferes with ethernet, crashes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2009-05-21 at 10:55 +0300, Landau, Bracha wrote:
> I am using a Xenomai-patched kernel on an MPC8272-based board.
>  
> When I run the plain kernel without activatine either Xenomai or
> CONFIG_IPIPE, the network interface works fine; I am able to ping
> other nodes on the network.
>  
> When I activate Xenomai, I don't get a reponse to ping (though I do
> see transmission of packets on the network), and evenetually the
> kernel crashes with the following
> (This phenomenon happens even when Xenomai is not active, but
> CONFIG_IPIPE is active)

Xenomai never got ported to that platform, so the interrupt pipeline is
likely not working at all for your board.

-- 
Philippe.



