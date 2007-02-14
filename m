Message-ID: <e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
Date: Wed, 14 Feb 2007 11:27:48 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <45D192EB.9030608@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_91330_25074733.1171432668985"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D029B8.1030805@domain.hid>
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>
	<45D0666C.8070409@domain.hid>
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
	<45D192EB.9030608@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

------=_Part_91330_25074733.1171432668985
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,

Its working now .

But how do i set a scheduling policy say FIFO for a real time task . ?

On 2/13/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Preetam Joshi wrote:
> > I have taken the makefile from
> >
> > Using the one under test suite /xenomai/src/testsuite/switchbench/
> >
> > n modified for mytask jus replaced all the witchbench related statements
> > with mytask
> >
> > It works for switchbench or latency or switchsuite but not for my
> example.
>
> Unless you are planning to write an extension of the Xenomai user space
> part, you don't need to make your life that hard. Just follow my
> suggestions and use the makefiles from the examples repos.
>
> Jan
>
> PS: The CC, take care of it...
>
>
>

------=_Part_91330_25074733.1171432668985
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,<br><br>Its working now .<br><br>But how do i set a scheduling policy say FIFO for a real time task . ?<br><br><div><span class="gmail_quote">On 2/13/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">
jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Preetam Joshi wrote:<br>&gt; I have taken the makefile from
<br>&gt;<br>&gt; Using the one under test suite /xenomai/src/testsuite/switchbench/<br>&gt;<br>&gt; n modified for mytask jus replaced all the witchbench related statements<br>&gt; with mytask<br>&gt;<br>&gt; It works for switchbench or latency or switchsuite but not for my example.
<br><br>Unless you are planning to write an extension of the Xenomai user space<br>part, you don&#39;t need to make your life that hard. Just follow my<br>suggestions and use the makefiles from the examples repos.<br><br>
Jan<br><br>PS: The CC, take care of it...<br><br><br></blockquote></div><br>

------=_Part_91330_25074733.1171432668985--

