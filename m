Subject: Re: [Adeos-main] Kernel 2.6.20.2
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <560b19a70703121502w10bedeb8o27114ccdcd7b57c@domain.hid>
References: <560b19a70703121100x2a4a751dt4fc87b0176c3d587@domain.hid>
	<17909.47427.625596.896918@domain.hid>
	<560b19a70703121502w10bedeb8o27114ccdcd7b57c@domain.hid>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 23:47:38 +0100
Message-Id: <1173739658.15636.35.camel@domain.hid>
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
To: Ze Manel <zemanel@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2007-03-12 at 22:02 +0000, Ze Manel wrote:
> Sorry I didn't post it a second time, I patched kernel 2.6.20 and got
> the error and then got the 2.6.20.2 (the latest stable version) I
> thought it could have something to do, and got the same error, it was
> not a repost, more like a clarification of the problem, or an update
> on the problem. 
> Sorry if it didn't seem so.

> My .config is attached
> Thanks for the help
> 

Switch on CONFIG_X86_PC instead of CONFIG_X86_GENERICARCH for now
(Processor type and features -> sub-architecture type = PC-Compatible).
This will work around the issue until it is solved in a later Adeos
patch, and might even be more appropriate for your hardware.

-- 
Philippe.



