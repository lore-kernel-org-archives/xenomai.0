Message-ID: <2ff1a98a0803070831w3e10022fx6b502e6bf0228bec@domain.hid>
Date: Fri, 7 Mar 2008 17:31:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

On Fri, Mar 7, 2008 at 5:19 PM, Richard Cochran
<richard.cochran@domain.hid> wrote:
> I posted this patch today on linux-arm-kernel, but I repeat it
>  here because there does not seem to be too much interest on that
>  list for the ARM FCSE.
>
>  I also tried to combine this patch with ipipe for kernel 2.6.20
>  running on the Intel IXDP465, but after booting I soon get a BUG.

Do you get a bug with I-pipe alone ? Or with Xenomai ? If with
Xenomai, you should probably change Xenomai context switch routine to
match Linux context switch routine (adding a call to set_pid, if I
understood your patch correctly).

>
>  Anyhow, perhaps the ARM people might take a look at combining
>  ipipe with FCSE...

I hope that others can test it: the machine with which I work at home
is an AT91RM9200, without FCSE support, and the IXP465 I have at work
runs more than 96 pids. There is something I did not understand in
your patch: do you reserve PIDs for shared libraries ? How do you
handle threads stacks ? The old FASS patch had problems with this.

Also, it is completely unrelated, did you see the recent post about
write buffer coalescence on the Linux arm kernel mailing list ? From
my test on IXP465 it seems that these machines are affected as well.

-- 
 Gilles Chanteperdrix

