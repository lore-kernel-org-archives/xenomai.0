Message-ID: <2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
Date: Thu, 12 Jun 2008 11:08:55 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4850DC9D.4010607@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4850DC9D.4010607@domain.hid>
Subject: Re: [Xenomai-help] High latencies on Core2Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Jun 12, 2008 at 10:21 AM, Sebastian Smolorz
<smolorz@domain.hid> wrote:
> Hi,
>
> I'm observing high latencies when running the latency test on a Core2Duo.
> They appear sporadically and are mostly between 100 and 300 us. Sometimes
> they are about 800 us. I have attached two I-pipe trace outputs.
>
> Kernel is 2.6.25, Xenomai is 2.4.4, I-pipe is 2.0-08. ACPI, APM and CPU
> frequency scaling are all of, SMI workaround is enabled.
>
> Any idea anyone?

Enable ACPI, only disable ACPI processor module. Enable USB. You
should also look in the kernel log if the SMI workaround actually
worked or not.

-- 
 Gilles

