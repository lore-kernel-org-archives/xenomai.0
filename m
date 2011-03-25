Message-ID: <4D8C6AD3.8060402@domain.hid>
Date: Fri, 25 Mar 2011 11:13:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <27340542.1331151.1300980168620.JavaMail.root@domain.hid>
In-Reply-To: <27340542.1331151.1300980168620.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Kernel panic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: George Afonso <george.afonso@domain.hid>
Cc: xenomai@xenomai.org

George Afonso wrote:
> Spam detection software, running on the system "xenomai.org", has
> identified this incoming email as possible spam.  The original message
> has been attached to this so you can view it (if it isn't spam) or label
> similar future email.  If you have any questions, see
> the administrator of that system for details.
> (...)
> Hello, 

Hi,

Sorry for the late answer, your mail was treated as spam, due to the
fact that it is HTML, and that the .config were sent in plain text.

> 
> I was using xenomai and wanted to install it in a new computer, i follow the same steps as before, 
> I configure the kernel as advised in xenomai website using linux .config default file (see configxeno) 
> In order to test the configuration, I use the same config file for a simple kernel (without xenomai) (ie : avoiding ACPI processor, apm and cpufreq as advised in your web site) (see configlinux). 
> 
> I've no problem with the configlinux (it boots without problems) but i have a kernel panic with configxeno : 

The data you give us are quite insufficient. Your xenoconfig does not
follow the usual advices, I suggest you read:
http://www.xenomai.org/index.php/Configuring_x86_kernels

If you want us to help you, please send us the information asked here:
http://www.xenomai.org/index.php/Request_for_information

The most important thing being the full kernel logs, from the boot up to
the oops, and the full text of the oops, not just some partial piece of
it. I see here that you copied the oops text manually, this will not do.
What you should do is capture the full logs with a serial console, or
netconsole.


-- 
					    Gilles.

