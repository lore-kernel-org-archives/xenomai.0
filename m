From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <c6fc15b891bca9854ca9e6f8f7d07960bfcec6a2.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
	<c6fc15b891bca9854ca9e6f8f7d07960bfcec6a2.1271672940.git.jan.kiszka@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Apr 2010 00:15:41 +0200
Message-ID: <1271715341.16659.170.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v4 02/25] RTDM: Add rtdm_rt_capable()
	service
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2010-04-19 at 12:28 +0200, Jan Kiszka wrote:
> This adds rtdm_rt_capable(), a function that can be used by drivers to
> detect callers that could issue a service request also from the
> (typically preferred) real-time context. If that is the case, the driver
> can trigger a restart of the request if the current context is not
> real-time.
> 
> CC: Philippe Gerum <rpm@xenomai.org>
> CC: Alexis Berlemont <berlemont.hauw@domain.hid>
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  include/rtdm/rtdm_driver.h |    6 ++++++
>  ksrc/skins/rtdm/drvlib.c   |   25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> index 0fc1496..d124157 100644
> --- a/include/rtdm/rtdm_driver.h
> +++ b/include/rtdm/rtdm_driver.h
> @@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
>  {
>  	return (rthal_current_domain != rthal_root_domain);
>  }
> +
> +static inline int rtdm_rt_capable(void)
> +{
> +	return (!xnpod_root_p() || xnshadow_thread(current) != NULL);
> +}
> +

This patch still has fundamental flaw, the service would not work
correctly and would actually return the wrong value, in case it is used
deeply buried into some helper code, traversed by asynchronous Xenomai
contexts. At the very least, you should avoid this by binding that
service to a valid rtdm_dev_context, so that you know that it is called
from a context that is correct in the first place, where a
rtdm_dev_context reference is available.

I.e. 
static inline int rtdm_rt_capable(struct rtdm_dev_context *context), and
extract the information from that context structure. That would avoid a
lot of headaches down the road to your user base.

-- 
Philippe.



