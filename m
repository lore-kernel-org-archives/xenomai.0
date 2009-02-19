Message-ID: <499D1699.4050101@domain.hid>
Date: Thu, 19 Feb 2009 09:21:45 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>	<200902170940.54910.peter.soetens@domain.hid>	<499A8636.5020100@domain.hid>	<200902171208.07297.peter.soetens@domain.hid>
	<87y6w4r167.fsf@domain.hid>	<499BBB08.5060801@domain.hid>
	<87iqn7qpj7.fsf@domain.hid>
In-Reply-To: <87iqn7qpj7.fsf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
 status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Alexis Berlemont wrote:
> Hi,
> 
>>> That was the reason why, I was really suprised to find Comedi
>>> integrated into the mainline kernel. What strikes me more is that
>>> Comedi seems to be left as is. Do you think, it will be cleaned up or
>>> reworked ?
>> Without rework Comedi will not make into mainline (I wouldn't call the
>> staging corner "mainline"). And when reading this
>> http://permalink.gmane.org/gmane.linux.kernel/793476, it is probably the
>> best time now to propose interface changes and contribute back
>> improvements made for the RTDM rework.
> 
> How would you proceed ? Maybe, the first step would be to ask on the
> Comedi mailing-list if someone is interested in discussing on the API
> rework. Maybe, someone will answer this time. 
If it is more informative than the mail from 06-04-09 and the presentation.txt
there is definitely a chance :-), I read through it then, found the goals
reasonably sound, and nothing to test, so I waited for some working code to show
up (having too much at my hands already), that time might have come now.

Features I would like to see in a Comedi/RTDM framework are:

1. Drivers should work in Linux, Xenomai (and possibly RTAI and/or RT-Linux)
2. It should be possible to write drivers that live in user-space (serial2002
driver is a big HACK).
3. Stackable drivers (e.g. put a force sensor driver on top of a analog input card).
4. A comedilib compatibilty library would be nice (but not necessary)

If all these pieces are in place, I'm more than happy to test/migrate the
drivers I use in my labs (JR3, NI M6221, DaqBoard 2000, ACPI 3106, serial)

Best regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

