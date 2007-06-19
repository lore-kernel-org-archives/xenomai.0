From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AAA6EFD@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2AAA6EFD@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 10:50:55 +0200
Message-Id: <1182243055.6569.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and Busybox
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2007-06-19 at 08:23 +0200, Roderik_Wildenburg@domain.hid wrote:
> Does anyone use Busybox(www.busybox.net) on a xenomai-linux ?
> Or does anyone experience one of these problems with busybox on xenomai
> :
> - yes > /dev/null stalls system completely (yes is a little program
> returning 'y' continously; this does not happen using a normal bash
> shell)
> - "netstat -a" seems to delay realtime execution (periodic task produces
> overruns).

You mean the standard latency test?

>  I have no idea how this could happen, as I thought xenomai
> has highest priority and, as far as I have seen, netstat does not
> anything else than reading /proc/net/netstat.
> 
> We experienced these problems on a PPC 2.4 xenomai-linux.
> 

I-pipe 2.4.25/ppc 1.2-01? 
Which kind of board?
Which Xenomai version?

> Any suggestions/ideas/explanations ?
> 

Let's try a simple setup with your environment if it is not already the
case: Xenomai 2.3.1 stock + 2.4.25-ppc 1.2-01, standard latency test in
user-space. If you could also boot and run your current kernel on a
vanilla glibc-based ELDK setup (likely 3.1.1 with 2.4/ppc kernels), we
could check whether busybox raises new issues or not. The latest setup
works perfectly fine here on an Icecube for instance, "yes" and
"netstat" tests included.

> Many thanks in advance
> Roderik 
> 
> MAN Roland Druckmaschinen AG
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



