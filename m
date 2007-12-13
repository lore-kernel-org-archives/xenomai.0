Message-ID: <2ff1a98a0712130732p2eafe787i5b9cb16bd9d86614@domain.hid>
Date: Thu, 13 Dec 2007 16:32:12 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <892997.84545.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <892997.84545.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

On Dec 13, 2007 4:27 PM, Michael Trimarchi <trimarchimichael@domain.hid> wrote:
>
>
> Hi,
>
> I think that the problem of the overruns are related to the latency
> introduced by adeos, and the
> serial buffer of the at91sam9260 ( length = 1 ).
>
>
> >Do you get the same behaviour if you apply
> >adeos-ipipe-2.6.20-arm-1.8-02.patch on a linux 2.6.20 ?
> >                                              Gilles Chanteperdrix
>
> I'll send soon my xeno-test. It is possible to serve an interrupt without
> pass
> throw the log system in the root domain?

If you do not want to test the I-pipe patch on the kernel for which it
is made, then I am afraid we can not conclude anything from any result
you obtain.

-- 
                                               Gilles Chanteperdrix

