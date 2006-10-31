Subject: Re: [Xenomai-help] Xenoami Kernel Configuration Description
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D625@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D625@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 13:47:59 +0100
Message-Id: <1162298879.4996.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 12:02 +0000, Daniel Schnell wrote:
> Hi,
>  
> I would like to contribute the Xenomai Kernel configuration help
> documentation and therefore will ask here a lot of annoying questions
> probably.
>  
> I am working to port an existing pSoS application to the POSIX Xenomai
> Skin. Unfortunately the application so far works much better on NPTL
> threads under a 2.6.17 based Kernel (without rt capability) than on
> the Xenomai enabled 2.4.25 Denx PPC Kernel for our MPC5200B based
> board where we have Kernel Oopses and lockups.

A good starting point would be to post those oops to the list, and also
some information about the exact configuration you are using
(kernel-based, UVM-based?). We cannot work on anything else than facts,
and the time spent collecting them may give you useful answers in
return, so this could be a good deal for everyone.

Please keep in mind that without bug reports, we are basically blind,
unless some core developers rely on the same software setup than you do,
which is pretty unlikely wrt using the pSOS skin in a production
environment.

-- 
Philippe.



