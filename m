Message-ID: <4551F9C5.3070803@domain.hid>
Date: Wed, 08 Nov 2006 16:37:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] LATENCIES > 100 us or CRASH WITH X
References: <4551F26A.8050209@domain.hid>
In-Reply-To: <4551F26A.8050209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Luc Pamart <jlpamart@domain.hid>
Cc: xenomai@xenomai.org

Jean-Luc Pamart wrote:
> Hello
> 
> I am a newbie with Xeno. My goal for the beginning of 2007 is to launch 
> a project for 4 french studiants : a box with Linux embedded and a usb 
> camera. The embedded application will analyse the movies in Real time 
> and lead a mobile machine with CAN-BUS.
> Now i play with Xeno for my knowledge (without specific hardware) :  a 
> little linux installed in a usb key with a little embedded distrib 
> - vanilla kernel 2.6.16 with patch for usb [.config is joint]
> - Xenomai 2.1.2

Just to be sure that you are not fighting bugs that were already
corrected, could you try with a more recent version ?


> - essentially BusyBox
> - for xenomai : only "latency" directory and libs in usr/libs
> I have checked "SMI woraround" for the kernel.
> In BIOS I have UNchecked  "legacy usb".

Please consult the TROUBLESHOOTING file for details, but you should
also disable the APM option and enable ACPI options except
ACPI_PROCESSOR.

> 
> 
> my Desktop PC (a AMD ATHLON) can boot with this little vanilla kernel and
> 1/ a little embedded distrib of my own

With the version of Xenomai you are using, you should select pentium
pro, and not AMD Athlon in the kernel configuration menu. Please do not
enable the local APIC either, since it is buggy on some Athlons.

> 
> OR
> 
> 2/ a complete mandrake 9.1 on a partition of a classic hard disk
> 
> I have 2 differents problems when I lauch this :
> 
> 1/ with the linux embedded directories on the usb key
> high latency > 100 us are ok ? perhaps usb work is not compatible with RT ?
> 
> 
> 2/ with the complete mandrake 9.1 :
> it crashes X after 1 or few minutes.
> What is the relation between X and Xenomai ?
> Is Xenomai compatible with X ?

If Xenomai crashes under X, you will not be able to see any console
message, so, you should try in text mode first, and see if you also
get the crash.

Now about X and Xenomai, there is also an entry in TROUBLESHOOTING,
but X-window for some hardware induces high latencies. If you are
among the unfortunates that have such hardware, you have to use
the option "NoAccel" in XF86Config.

-- 
                                                  Gilles Chanteperdrix

