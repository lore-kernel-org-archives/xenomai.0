MIME-Version: 1.0
In-Reply-To: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
References: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
Date: Wed, 23 Apr 2014 09:36:48 +0200
Message-ID: <CAPRPZsBUNopzbL5CdXKNdjePVm+Q4Qj+1S=dSmiXnutvhd_QuQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTDM: Ethernet driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Can someone suggest me any example code or useful links/docs
> which can help me to do so.

Have a good look at Linux drivers/net/ethernet/intel/e1000e and think
again about writing a network driver yourself. Note that the larger
part of a NIC driver is needed just to get a link reliably across the
large number of MAC/PHY combinations and revisions that are out there.

Also grep for 'workaround'...

Jeroen.

>
> --
> Regards,
> Yogesh Garg
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

