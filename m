Message-ID: <47F22E76.5020009@domain.hid>
Date: Tue, 01 Apr 2008 14:45:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <a7575bba0804010328v43bbc606oe1d0a26f7ea12be8@domain.hid>
In-Reply-To: <a7575bba0804010328v43bbc606oe1d0a26f7ea12be8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] When do I need to
 add	local_irq_disable_hw/local_irq_enable_hw in root domain?
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: adeos-main@gna.org

Josh Zhao wrote:
> Hi ,
>     When do I need to add  local_irq_disable_hw/local_irq_enable_hw in
> root domain?  I think every irq/event should not be disabled in root
> domain,but  why  i  have seen in some code ?

Because some serialization still needs to be enforced, even for the root domain,
particularly for code that may have an impact on the pipeline state.

>    thanks!
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.

