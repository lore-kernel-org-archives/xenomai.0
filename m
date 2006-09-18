From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Odd behaviour of vxworks
Date: Mon, 18 Sep 2006 12:57:30 +0200
References: <eeevrh$rns$1@domain.hid> <1158512788.4979.38.camel@domain.hid>
In-Reply-To: <1158512788.4979.38.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181257.31760.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, rpm@xenomai.org
Cc: Niklaus.Giger@domain.hid

Am Sonntag, 17. September 2006 19:06 schrieb Philippe Gerum:
> On Fri, 2006-09-15 at 21:44 +0200, Niklaus Giger wrote:
> > Hi
<..>
>
> Maybe the example is misleading in that respect; the patch below makes
> the behaviour constant among all environments:
Thanks for your explanation and the fix. 

But I still have the second deviation from the behaviour under vxWorks and the 
skin behaviour under the xenomai simulator:
semGive returns -1 with an errno of 1441896 = S_semLib_INVALID_OPERATION.
See the output here:

__xeno_user_init: semMCreate 134 taskId 133
__xeno_user_init: semTake 134 status 0 0 taskId 133
__xeno_user_init: semGive 134 status -1 1441896 taskId 133
consumer_task: task 136 ConsumerTask
producer_task: task SEM_DELETE_SAFE 137 ProducerTask

Do you have an explanation for this difference?

Best regards
-- 
Niklaus Giger

