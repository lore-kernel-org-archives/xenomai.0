Message-ID: <512E8C10.8080707@ruggedcom.com>
Date: Wed, 27 Feb 2013 17:43:28 -0500
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Is CLOCK_HOST_REALTIME supported for powerpc?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I'm trying to use clock_gettime to read Linux time in my Xenomai task. I 
may be doing something wrong, but the call fails. The code is properly 
linked against the pthread_rt Xenomai library.

I'm running Linux 3.0.0, Xenomai 2.6.0 on powerpc MPC8360.

Can you pl comment if this is supported? While quickly going through the 
Xenomai code I had a feeling that it was supported only for x86 and arm.

Thanks for your time.

Rgds,
Makarand.

-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


