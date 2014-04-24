Message-ID: <535900C9.7@xenomai.org>
Date: Thu, 24 Apr 2014 14:17:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>	<534BD45B.8070402@xenomai.org>	<CAPRPZsDSg6Yb3w+UEktb+7AmdZ-7JngVQH4tBbxnk5EV04y0AA@mail.gmail.com>	<534D44CA.3000105@xenomai.org>	<CAPRPZsD6r6y6UpYsN544WeLxYEnruKzjoHH4e33NPKEDCswJqQ@mail.gmail.com>	<534E926F.9090706@xenomai.org>	<CAPRPZsAOCxCGYhNmasXpFAK1bU_9LL78W9ribuLWh-Y1xxs1RQ@mail.gmail.com>
 <CAPRPZsBOngBwdht7FsnaqVAJObuugr=TAGETcnF6ZKVajbPvgQ@mail.gmail.com>
In-Reply-To: <CAPRPZsBOngBwdht7FsnaqVAJObuugr=TAGETcnF6ZKVajbPvgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/24/2014 12:21 PM, Jeroen Van den Keybus wrote:
> Philippe,
>
>
> Disabling CONFIG_RCU_USER_QS ('General setup -> RCU Subsystem ->
> Consider userspace as in RCU extended quiescent state') at least
> avoids the warning.
>
> Further investigation shows that it is actually
> CONFIG_CONTEXT_TRACKING_FORCE ('General setup -> RCU Subsystem ->
> Force context tracking') that seems to cause the issue
> (CONFIG_RCU_USER_QS and CONFIG_CONTEXT_TRACKING still enabled in this
> case).
>

Ok, thanks for digging this. I'll switch back to investigating this 
issue in the coming days. Gilles has detected a breakage of the 
interrupt state on ARM which is caused by the context tracking feature, 
there is a possibility that such issue also concerns other archs. I 
still have to come up with a solution to this problem.

-- 
Philippe.

