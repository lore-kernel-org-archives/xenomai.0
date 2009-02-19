Message-ID: <499D324A.1040407@domain.hid>
Date: Thu, 19 Feb 2009 11:19:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
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
Cc: xenomai@xenomai.org

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

As Anders also said: Make it as concrete as possible. List concrete
changes and explain their motivations and benefits. Ideally, even
provide RFC patches (unless the effort is so huge that waiting for first
comments is more appropriate). Also, I would consider putting LKML on CC
when the kernel ABI is affected - to underline that this is targeting
the staging work.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

