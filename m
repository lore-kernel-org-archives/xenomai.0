Message-ID: <49FC89D3.6060504@domain.hid>
Date: Sat, 02 May 2009 19:58:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b6ad4ed70905021008x37c2afcbke75b69e7ffd02595@domain.hid>
In-Reply-To: <b6ad4ed70905021008x37c2afcbke75b69e7ffd02595@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Problem booting after installing Xenomai
 2.4.7/Adeos -	kernel 2.6.28-7
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: John Yamokoski <yamokosk@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

John Yamokoski wrote:
> Just finished compiling/installing Xenomai 2.4.7 using the adeos patch
> for the 2.6.28-7 kernel on an x86, SMP system. On boot, I get what
> looks like a function stack trace print out on the screen and nothing
> further happens. I would post here what the trace was but I am not
> sure how I grab the kernel messages from a prior boot attempt..
> anyone?

Use a serial console.

> 
> I have attached my .config from the compile.. pretty sure I turned off
> all of the problematic kernel options but maybe I missed something? I
> recently tried installing the same version of Xenomai/adeos/kernel on
> a 64-bit version on the same system and that install and subsequent
> boot was fine. (I had to go back this 32-bit attempt because of some
> 64-bit compatibility issues totally unrelated to anything real-time).

Please enable ACPI. Only ACPI_PROCESSOR must be disabled.
And disable CPUFREQ.

-- 
					    Gilles.

