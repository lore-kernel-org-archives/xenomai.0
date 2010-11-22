From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D15010B2064@domain.hid>
References: <E2CAE7F7B064EA49B5CE7EE9A4BB167D15010B2064@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Nov 2010 16:45:15 +0100
Message-ID: <1290440715.1933.1827.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] GUI Debugging tool for Linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, 2010-11-22 at 20:26 +0530, Hemal C.Bavishi wrote:
> Dear Gilles,
> 
> I am trying to debug the application (native example provided along with Xenomai installation) on the same linux kernel where the Xenomai is patched through graphical debugger called DDD. I have attached two screen shots for your analysis. Hope it helps in identifying the issue. 
> 
> I am facing similar issues with other GUI debuggers like GPS and code light but I am not sure what the problem is? Have you used any GUI debugger to debug C code?
> 

Using a GUI or not is completely unrelated. Seeing "Operation not
permitted" in the snapshot you sent should ring a bell. Google has the
answer:

https://mail.gna.org/public/xenomai-help/2006-05/msg00074.html


> Best Regards,
> Hemal Bavishi
> 
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> Sent: Sunday, November 21, 2010 4:00 PM
> To: Hemal C.Bavishi
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] GUI Debugging tool for Linux
> 
> Hemal C.Bavishi wrote:
> > Dear All,
> > 
> > Do you have any idea of GUI C debugging tool for Linux works for
> > Xenomai patch? I tried to use DDD (Data Display Debugger) but when I
> > load my program compiled with xenomai kernel then it gives me an
> > error "xenomai binding failed". I also tried to use other debugger
> > program like GPS but I got almost similar issue(thread debugging
> > using libthead_db enabled - program exited with code 01). Please
> > help.
> 
> ddd is a gdb frontend. So, please try and load your program with gdb,
> and show us the error message.
> 
> Telling us which version of xenomai, on which architecture, and whether
> you are remote debugging would also help us reproduce the issue.
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



