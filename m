Message-ID: <437A5E8E.3020100@domain.hid>
Date: Tue, 15 Nov 2005 23:17:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF79E2F845.408F45C4-ONC12570BA.005A85E4-C12570BA.005B6724@domain.hid>
In-Reply-To: <OF79E2F845.408F45C4-ONC12570BA.005A85E4-C12570BA.005B6724@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] Auto-allocation of minor values for pipe
	objects
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hello,
> 
> enclosed please find a patch that hopefully adds so desired 
> functionality. I have made various tests with it just now and it seems 
> to work fine.
> 

Sounds good.

> A size of the bitmap is dependent on XNPIPE_NDEVS parameter in the same 
> vein as xnpipe_states depends on it; so hopefully that is what you have 
> meant Philippe (?)
>

And NDEVS still does not depend on BITS_PER_LONG - yes, that's ok.

Two minor missing points :

- Doc update for rt_pipe_create() describing P_MINOR_AUTO
- ChangeLog frag

> A few comment later since I have to go now.
> 
> ---
> Best regards,
> Dmitry
> 
> /(See attached file: pipe.auto-minor-2.patch)/
> 


-- 

Philippe.

