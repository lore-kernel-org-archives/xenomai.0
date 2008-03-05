Message-ID: <47CE4F46.5020307@domain.hid>
Date: Wed, 05 Mar 2008 08:44:06 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47CDA626.4010604@domain.hid>	<18381.44749.419005.112838@domain.hid>	<47CDB710.6030103@domain.hid>
	<18381.50641.786735.609323@domain.hid>
In-Reply-To: <18381.50641.786735.609323@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How should rt_task_delete(NULL)  be used?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Anders Blomdell wrote:
>  > >  > Why does the following program grow it's VMSIZE? This is the output I get:
>  > >  > 
>  > >  > [child =  0,  0] VmSize:            1912 kB
>  > >  > ...
>  > >  > [child = 19, 19] VmSize:            3204 kB
>  > > 
>  > > Could you dump /proc/self/maps at the beginning and the end, to see
>  > > where the reserved memory comes from ?
>  > > 
>  > 
>  > Sligtly modified program (being sloppy seems to be the better choice, just
>  > returning without trying to cleanup self is cheaper, weird)...
> 
> It looks like proper thread cleanup is needed to reclaim the threads
> stack. Could you try the attached patch ?
[child =  0,  0] VmSize:            1960 kB
...
[child = 19, 19] VmSize:            1960 kB

Looks like it did the trick, great thanks!

Stay tuned for more problems :-)

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


