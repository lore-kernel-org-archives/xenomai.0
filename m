From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Apr 2011 22:27:32 +0200
Message-ID: <1303849652.1961.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dietmar.schindler@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2011-04-26 at 11:48 +0200, dietmar.schindler@domain.hid
wrote:
> The documentation of rt_pipe_write() says: "rt_pipe_write() always
> preserves message boundaries, which means that all data sent through a
> single call of this service will be gathered in a single read(2)
> operation from the special device." Is this supposed to mean also that
> data sent through two calls of this service will be gathered in two
> read(2) operations, or would it be conforming that data sent through two
> calls of this service will be gathered in a single read(2) operation?

One read() per rt_pipe_write() operation, always.

> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



