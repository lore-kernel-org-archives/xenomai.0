Message-ID: <4AE812CF.6020201@domain.hid>
Date: Wed, 28 Oct 2009 10:45:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE7E36D.7040307@domain.hid>
In-Reply-To: <4AE7E36D.7040307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PC freezes on call to driver functions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Francois Touchard <francois.touchard@domain.hid>
Cc: xenomai@xenomai.org

Francois Touchard wrote:
> Hello,
> for teaching purposes, I have a very simple driver built with RTDM to catch 
> interrupts generated on the parallel port via a pulse generator. On receipt of a 
> command passed by ioctl, the driver measures the time interval between two 
> interrupts and stores the result (in fact, the sum of n time intervals, n being 
> passed as parameter of ioctl). The result is returned to the user by a read command.
> If I call ioctl immediatly after the open command, the machine freezes and only 
> the reset button is effective. If I insert a print command between open and 
> ioctl, everything works fine.
> I use Xenomai 2.4.9.1 and Linux 2.6.29.5. The processor is a Pentium 4. I attach 
> the sources of the driver and the user application.
> Any hint ? TIA

Switch on at least CONFIG_XENO_OPT_DEBUG_RTDM, but also
CONFIG_IPIPE_DEBUG_CONTEXT can be helpful while writing drivers. Those
will tell you which services you call from the wrong context (here:
rtdm_task_join_nrt from RT context).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

