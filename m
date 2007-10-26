From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 26 Oct 2007 11:22:57 +0200
References: <200710251535.l9PFZYpF021256@domain.hid>
	<4721A4C8.4070406@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0DC1C37@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0DC1C37@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1IlLOF-0006Io-71@domain.hid>
Subject: Re: [Xenomai-help] Event flag from ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> >-----Original Message-----
> >From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> >Sent: vendredi 26 octobre 2007 10:27
> >There is already ongoing work toward FCSE for current Linux, which
>
> could
>
> >then be used by Xenomai as well, see linux-arm-kernel and xenomai-core
> >[1] archives. I guess anyone willing to join this effort is welcome.
>
> Thanks for the update Jan; great to see that there is some interest
> (BTW, I realized that I mix
> the FCSE with DACR feature which allows to share an address space;
> limitations of 32 MB process
> address space is bound to DACR ;-)).

No, this limitation is imposed by FCSE. You can use FCSE without domain access 
control which is for checking memory accesses.

-- 
Sebastian

