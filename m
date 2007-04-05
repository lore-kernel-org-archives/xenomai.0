Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070405113420.0d2cc0ae@domain.hid>
References: <20070403143122.4ac4ffaf@domain.hid>
	<46124C61.3070107@domain.hid>
	<20070403162752.2d4a1ae6@domain.hid>
	<46126603.1050007@domain.hid>
	<20070403170416.6c3f7ded@domain.hid>
	<46126DC3.8070905@domain.hid>
	<20070403171828.2da9c6fa@domain.hid>
	<46127166.9040503@domain.hid>
	<20070403175535.7340cc06@domain.hid>
	<46127DD8.8060502@domain.hid>
	<20070404181558.0ba333da@domain.hid>
	<4613D7CC.2040703@domain.hid>
	<20070405092815.15bd1af1@domain.hid>
	<20070405101200.10084177@domain.hid>
	<4614BA29.3010609@domain.hid>
	<20070405113420.0d2cc0ae@domain.hid>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 11:51:22 +0200
Message-Id: <1175766682.7594.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-04-05 at 11:34 +0200, Daniel Simon wrote:
> On Thu, 05 Apr 2007 10:58:17 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> >Could you send us your .config ?
> in attachement

Try downgrading from SMP to UP, without IO-APIC support but still
keeping ACPI enabled, for the purpose of testing:

# CONFIG_SMP is not set
# CONFIG_X86_IOAPIC is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y

1) Does this work?
2) What does /proc/interrupts say?

-- 
Philippe.



