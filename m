Message-ID: <4FB0BEB4.9000408@domain.hid>
Date: Mon, 14 May 2012 10:13:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <201205140945.34788.leo@domain.hid>
In-Reply-To: <201205140945.34788.leo@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on kernel 3.x and x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

On 05/14/2012 09:45 AM, Leopold Palomo-Avellaneda wrote:
> Hi,
>
> sorry if the question it's obvious but I have not understood the information
> that I have found. I have read the roadmap of Xenomai [1] and it's not clear
> to me what should I have to do if I would want to use xenomai in a kernel
> 3.x.
>
> As far as I understand the idea it's to go to Xenomai 3 with the prempt patch
> or a co-kernel option. Then xenomai will be the interface to the realtime
> kernel. From the user point of view, no matter if xenomai will use the rt-
> preemt or the co-kernel option. Also, the driver option will be the rtdm.
>
> But I don't understand if the Adeos patch will survive (at least in x86) or
> what will happen. I understand that the co-kernel option is the same that we
> have now (2.6) with the adeos patch, but I have not be able to find an Adeos
> patch for a x86 platform in a 3.x kernel.

The interrupt pipeline will be maintained for running the co-kernel 
incarnation of Xenomai 3, and for updating the 2.6.x maintenance branch 
as well. To run 3.2 kernels and above, using Xenomai 2.6.1 or later will 
be a requirement.

There is an upcoming patch for linux 3.2, which is the first of the new 
pipeline "core" series, a massive refactoring of the I-pipe 
implementation and API, aimed at a better integration with Xenomai:
http://git.denx.de/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/core-3.2

It currently supports powerpc, arm, x86 and blackfin, and can be used 
with Xenomai 2.6.1+ and Xenomai 3 systems in dual kernel mode. I will 
roll this patch out officially when Gilles and I are done with fixing 
the rough edges. The plan is to have it shipped with the upcoming 2.6.1.

To sum up: the interrupt pipeline for x86 is maintained, a release for 
3.x kernels is upcoming.

>
> Please, someone could clarify this.
>
> Thanks in advance,
>
> Leo
>
>
>
> [1] http://www.xenomai.org/index.php/Xenomai:Roadmap
>


-- 
Philippe.

