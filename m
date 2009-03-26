Message-ID: <49CB9B2A.3080902@domain.hid>
Date: Thu, 26 Mar 2009 16:11:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF76CCC0C2.B49CD032-ON65257584.0013BB2C-65257584.0013BB3C@tcs.com>
In-Reply-To: <OF76CCC0C2.B49CD032-ON65257584.0013BB2C-65257584.0013BB3C@tcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error in adapter.cc during the "make" of xenosim
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Cc: xenomai@xenomai.org

Vandana Sasidharan wrote:
> 
> Hi,
> 
> First of all sorry for mailing to Xenomai-core.
> 
> Can you please tell me whether I should switch to the older distribution of
> xenosim, Linux or Tix, I am a bit confused regarding the same and it would
> be be really great if you you could clarify it. In case if
> it is Tix where can I get the download? Thanks in advance.
> 
> For those who dont know what error I am getting:-
> 
> an error occurs when I am trying to "MAKE" Xenosim- 2.4.7.
> I have already installed Xenomai- 2.4.7 along with libelf -0.8.10 , Tcl
> 8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an adeos patch that is adeos-ipipe
> -2.6.25-x86-2.0-08.patch on a linux kernel which we built which has a
> version Linux 2.6.25.11.
> after configuring Xenosim along with the gcc -2.95.3 tar .gz when I try to
> "make" the xenosim I'm getting an error :
> 
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 65: error :too few
> arguments
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 67: error :too few
> arguments

Hi,

I have some bad news about the simulator. It is currently a tool mainly
for the Xenomai project developer. As such:
- we only take care of making it work for trunk, not in the stable branches;
- we can not provide any support for it.

So, basically, you are on your own.

Regards.

-- 
                                                 Gilles.

