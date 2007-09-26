Message-ID: <46FA26C0.5050606@domain.hid>
Date: Wed, 26 Sep 2007 11:30:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <353969d40709260127s1c7fb5c6necdcf3591abc90f4@domain.hid>
In-Reply-To: <353969d40709260127s1c7fb5c6necdcf3591abc90f4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] new features for 16550A driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Guillaume Gaudonville <guillaume.gaudonville@domain.hid>
Cc: Xenomai-core@domain.hid

Guillaume Gaudonville wrote:
> Hello,
> 
> I'm working on a project which aims at porting an application
> running under VxWorks to Linux. This application uses the serial
> port.
> 
> I would like to add an ioctl or a field in the config structure
> to permit to strip or not the parity bit of each byte on reception. This
> feature is implemented on Linux and VxWorks.
> 
> Is it something I can do and then submit to Xenomai or your driver is only
> an example and will never be improved?

The driver is far from being just an example, it's used in real 
applications.

If your feature is useful and doesn't turn the existing code upside 
down, it will surely be considered for merging.

> 
> I think that I will have more feature to add to the driver, that's why I'm
> asking this.

I don't want to exclude anything (specifically as long as I haven't seen 
some patch yet), but I also don't want to overload the driver over the 
time with corner-case features. We need a good balance.

But we first of all need more details about what you plan to add, what 
application scenario is behind it, why you need the driver to implement 
the feature, and what impact it may have on the code. You are welcome to 
elaborate on this or, even better, post some patch drafts here.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

