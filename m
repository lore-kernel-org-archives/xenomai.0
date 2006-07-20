Message-ID: <44BFC5FA.6080608@domain.hid>
Date: Thu, 20 Jul 2006 20:05:46 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid> <44BE8ECF.2050608@domain.hid>
	<44BE943E.80302@domain.hid> <44BEA974.40708@domain.hid>
In-Reply-To: <44BEA974.40708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Hannes Mayer wrote:
>> ...out of curiosity and to test an older example, I compiled
>> in periodic timer support, recompiled and then it oopses
>> at boot. Screenshot:
>> http://www.captain.at/tmp/dsc05081.jpg
>> *shrugs*
> 
> .config please. And it would also be more helpful if you could switch on
> debug symbols so that the oopses tell us where they happened. So this
> happened during boot or when running your test?

debug symbols ? Can't find anything else the debug option in "kernel
hacking" and in "xeno->nucleus". Just enabled both, but no more info
at the oops. Oops at booting, BTW.
.config later

Thanks,
Hannes.


