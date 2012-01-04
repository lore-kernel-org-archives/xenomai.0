Message-ID: <4F0475E5.5030301@domain.hid>
Date: Wed, 04 Jan 2012 16:53:09 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4F04589A.5090404@domain.hid>
In-Reply-To: <4F04589A.5090404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai rtcan build issue on MPC5121 (kernel >=
 2.6.35)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

On 01/04/2012 02:48 PM, Fabrice Gasnier wrote:
> ---
>  ksrc/drivers/can/mscan/rtcan_mscan.c |   38
> ++++++++++++++++++++++++++++++++-
>  1 files changed, 36 insertions(+), 2 deletions(-)
> 

Unfortunately, this is not a proper patch. It should have:

- a descriptive subject line, e.g.:

  [PATCH] fix mscan init on mpc5121

- a short description of the patch. Why? What does it fix?

- your signed-off-by line.

Furthermore, the patch should be send *inline* (and not as attachment).
The best is to setup and use "git send-email" for that purpose.
Otherwise you need to tweak you mail clients somehow to avoid
white-space mangling.

Thanks,

Wolfgang.




