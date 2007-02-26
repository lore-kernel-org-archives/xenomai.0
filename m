Subject: Re: [Adeos-main] port 2.6.19 x86_64 to 2.6.20
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45E220D7.6060004@domain.hid>
References: <45E220D7.6060004@domain.hid>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 06:56:38 +0100
Message-Id: <1172469398.1764.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: trem <trem@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2007-02-26 at 00:50 +0100, trem wrote:
> Hi
> 
> I've tried to port the 2.6.19 x86_64 adeos patch to 2.6.20. you can find
> it here :
> http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-03-trem.patch

The good news is that moving to 2.6.20 does not seem to be too much of a
hell. Right?

> 
> I can apply it with with prepare_kernel.sh (from xenomai svn), but I haven't
> tested it yet (I mean run kernel).
> 
> I hope this patch is good enough to be used. Otherwise, I'd be pleased
> to fix it (maybe with a bit of help).
> 

We are hopefully close to have a reasonably good patch for 2.6.19. Once
we achieve this, porting to 2.6.20 should be the next step. Thanks.

-- 
Philippe.



