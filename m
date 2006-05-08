Message-ID: <445ED191.2070401@domain.hid>
Date: Mon, 08 May 2006 01:05:21 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] FYI - SMM interrupts and latency.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


found this relevant quote o NTP pages. 
It agrees with what we already know / have been told

*8.3.1.2.1. *How can SMM affect Interrupt Processing?

* *Let me quote an explanation written by Poul-Henning Kamp 
<http://www.ntp.org/ntpfaq/NTP-a-faq.htm#AU-PHK> from the newsgroup:

    I was gathering some data for Professor David L. Mills
    <http://www.ntp.org/ntpfaq/NTP-a-faq.htm#AU-DLM> today and they
    looked lousy to put it mildly, every 300-400 seconds I had a 40-50
    microsecond peak in my data. After some debugging I know know what
    it was: The SMM mode interrupts to the BIOS.

    This machine is brand new, and I had never put a PPS signal on it
    before, it uses the PIIX4 chip from Intel and appearantly the SMM
    BIOS gets called at regular (but not very precise) intervals to
    monitor temperatures and fans and whats not.

    Needless to say, this could not be disabled in the BIOS setup.

    I found out I could disable the SMI output from the PIIX4 to the CPU
    by clearing bit zero in the GLBCTL register in the third function of
    the 82371AB chip. You need to find the IO base address from register
    0x40 in the PCI header, and add the 0x28 to that address. For my
    motherboard that ended up being 0xe428, your milage will vary, and
    you should Do The Right Thing to find this location.

    Needless to say, the SMM BIOS will not be able to check if your CPU
    is able to make toast on if you disable it this way, so you'd better
    know what you're doing.




