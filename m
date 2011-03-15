Message-ID: <4D7FA754.9010308@domain.hid>
Date: Tue, 15 Mar 2011 18:52:20 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4D7E6CAC.6010703@domain.hid>
In-Reply-To: <4D7E6CAC.6010703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Duplicate symbols in analogy
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On 2011-03-14 20.29, Anders Blomdell wrote:
> I think it would make sense to change the name conflicts between analogy and
> comedi (range_unknown is one of them), to make it possible to have comedi and
> analogy to coexist on the same machine, anybody in support of this?
Anybody against then? IMHO it's a bad idea to have name conflicts with drivers
in the kernel (even if they are still in the saging area). What prefix should I
add to all modified exported symbols, would this make sense (a4ld == "Analogy
for Linux Driver"):

  mite_unsetup -> a4ld_mite_unsetup
  etc...

Regards

Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

