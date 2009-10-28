Message-ID: <4AE82F22.6090203@domain.hid>
Date: Wed, 28 Oct 2009 12:46:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
In-Reply-To: <4AE82B39.5040301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTnet install problem: Xenomai configuration
	tool not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Biegel wrote:
> Hi
> 
> I follow the RTnet:Installation guide.
> 
> After saving in gconfig i get an error 'Checking for TR-extension... 
> configure: error: ***Xenomai configuration tool not found'

That Xenomai configuration tool is xeno-config, and it can be found in
the /bin directory into which you installed your Xenomai user space part.

Alternatively, if you are not interested in building the RTnet examples,
disable them. Then you do not need this part at all.

Jan

PS: If you feel the existing documentation is fuzzy about this or not
mentioning it at all, please do not hesitate to submit changes (write
access to the wiki can easily be granted, just drop Bruno Rouchouse a note).

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

