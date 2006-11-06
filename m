From: Thomas Necker <thomas.necker@domain.hid>
Subject: Re: [Xenomai-help] Xenomai v2.3-rc1
Date: Mon, 6 Nov 2006 18:34:10 +0100
References: <1162750381.7285.15.camel@domain.hid>
In-Reply-To: <1162750381.7285.15.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061834.10486.thomas.necker@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> 	[uvm]
>
> 	* Feature removed.
>

I see that there is no direct syscall interface for pSOS added.
We had a discussion about that a while ago. We're still thinking
about doing that ourselves but wanted to use the uvm for the
prototype. Why is the uvm support removed without having
an adequate substitute for the skins it still supports? This
means that there will be no way of supporting pSOS programs
in 2.3, right?

Thomas

