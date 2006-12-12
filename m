Message-ID: <457E6A01.4090500@domain.hid>
Date: Tue, 12 Dec 2006 09:36:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid>
	<1165778549.8255.17.camel@domain.hid>		<457CA36C.5060805@domain.hid>
	<1165828053.5025.8.camel@domain.hid> <457D23CA.0@domain.hid>
In-Reply-To: <457D23CA.0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>On Mon, 2006-12-11 at 01:16 +0100, Jan Kiszka wrote:
>>
>>>Philippe Gerum wrote:
>>>
>>>>On Sun, 2006-12-10 at 11:21 +0100, Jan Kiszka wrote:
>>>>
>>>>>The only part of the Xenomai user-space package not yet following
>>>>>standard installation rules is the testsuite. It gets installed to
>>>>>$prefix/testsuite, by default /usr/testsuite. The attached patch is an
>>>>>approach to overcome this unusual layout.
>>>>
>>>>Ack. Implementation-wise, we have to fix the following though:
>>>>
>>>>xeno-load.in needs to be fixed, so that passing a single dot as argument
>>>>correctly picks the default runinfo target in the current directory.
>>>>This currently does not work as expected.
>>>
>>>[obviously now fixed in svn]
>>>
>>>
>>>>The second patch works around a problem with sudo relying on the
>>>>contents of the user's PATH variable. This won't work for people using a
>>>>version of sudo compiled with the secure path option by their favourite
>>>>distro. In that case, /usr/xenomai/bin (or whatever the user picked to
>>>>install xenomai) won't appear in that secure path, so the binary program
>>>>given in the runinfo file won't be found. A possible option is to
>>>>provide a relative path to locate the binary program,
>>>>e.g. ../../../../bin/latency for the latency test, as the example patch
>>>>shows. Not pretty, but the other way would need to autoconfiscate the
>>>>runinfo files, or at least run them through sed before installing, so
>>>>that we could substitute some placeholder with $exec_prefix.
>>>
>>>Relative paths are not fully safe, 
>>
>>Why, provided the sudo sub-shell in xeno-load changes dir to the
>>target_dir variable contents?
>>
> 
> 
> Because exec_prefix (=>bindir) may be different from prefix
> (=>pkgdatadir), thus there is no fixed relation between the .runinfo
> location and the binaries until after the installation.

Since the testsuite scripts are supposed to be run on the target, I
think they should be installed under exec_prefix.

-- 
                                                 Gilles Chanteperdrix

