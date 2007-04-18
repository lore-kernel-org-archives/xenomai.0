From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17958.34248.814351.793771@domain.hid>
Date: Wed, 18 Apr 2007 22:55:36 +0200
In-Reply-To: <17958.30354.523869.820563@domain.hid>
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
	<461BC626.3070403@domain.hid>
	<305035a40704110201i1ea65f11j162eecc46858f5ca@domain.hid>
	<461CA604.4050809@domain.hid>
	<305035a40704110221u348611ebs8fb73b7ddb0f8bd3@domain.hid>
	<461CD163.1020500@domain.hid>
	<17957.16218.913465.449254@domain.hid>
	<305035a40704180251p41c58941l278e20d06af1991d@domain.hid>
	<17958.30354.523869.820563@domain.hid>
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: gclement@domain.hid, adeos-main <adeos-main@gna.org>

Gilles Chanteperdrix wrote:
 > Gregory CLEMENT wrote:
 >  > > >  #ifdef CONFIG_IPIPE
 >  > > > -#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
 >  > > > +#if defined(CONFIG_ARCH_AT91RM9200)
 >  > > > +     #define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
 >  > > > +#elif defined(CONFIG_ARCH_AT91SAM9260)
 >  > > > +     #define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9260_BASE_TCB0)
 >  > > > +#elif defined(CONFIG_ARCH_AT91SAM9261)
 >  > > > +     #define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9261_BASE_TCB0)
 >  > > > +#else
 >  > > > +#error "Unsupported AT91 processor"
 >  > > > +#endif
 >  > > >  #endif /* CONFIG_IPIPE */
 >  > >
 >  > > To reduce the ifdef hell, can not we define a unique AT91_BASE_TCB0 ?
 >  > 
 >  > Sure it would be better, but unfortunately the mainteners of AT91
 >  > choose to produce a define per architecture even if the register are
 >  > the same.
 > 
 > As far as I know, the AT91RM9200_BASE_TCB0 define is provided by the
 > I-pipe patch, so we may name it how we want.

No, it is not provided by the I-pipe patch.

 > 
 > 
 >  > We keep this line :
 >  > #define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
 >  > and it will work I don't like having an AT91RM9200 define for chip
 >  > which are not AT91RM9200. It adds confusion.
 >  > 
 >  > We also could define AT91_BASE_TCB0 as you suggest, but it mean we add
 >  > a new register definition just for ipipe and it adds a little
 >  > confusion also.
 >  > 
 >  > Choose the solution you prefer, or an other if you have a better idea.
 > 
 > I do not have a better idea, but I understood why the defines are
 > different: the CONFIG_ARCH_AT91RM9200, CONFIG_ARCH_AT91SAM9260 and
 > CONFIG_ARCH_AT91SAM9261 are not mutually exclusive, it is possible to
 > build a kernel that works for the three machines. So, this code can not
 > remain as is. Please, at least, forbid in Kconfig selecting several
 > machines when IPIPE is enabled.

On 2.6.20, the options ARE mutually exclusive.

-- 


					    Gilles Chanteperdrix.

